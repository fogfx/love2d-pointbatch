-- NOTES:
-- * methods starting with an underscore would not be exposed to the API
-- * does setMode trash the buffers?
-- * spritebatch :add[q]() returns -1 if there was no room for a new point. undocumented. probably should ask if this is supposed to happen or if it's really supposed to throw.
-- * spritebatches have a setColor method, should this have that too?

-- IDEAS:
-- * should probably fallback to VAs if VBOs aren't supported
-- * use userdata as ids instead of numbers. this would allow for moving points around without messing with existing ids. also, they could support something like pointer arithmetic for addition

-- TODOs:
-- * gc buffers
-- * make sure all getters/setters are paired

assert(jit and jit.version_num >= 20000)

local ffi = require 'ffi'
local glf = require "ufo.ffi.OpenGL"

-- testing only
local function anal (f) 
	return function (...) 
		local r = f(...)
		local e = glf.glGetError()
		if e ~= 0 then
			local fargs = { n = select("#", ...), ... }
			for i = 1, fargs.n do
				if type(fargs[i]) == "cdata" then
					fargs[i] = ("%s (%s)"):format(tostring(fargs[i]), tostring(tonumber(fargs[i]) or "N/A"))
				else
					fargs[i] = tostring(fargs[i])
				end
			end
			error("GL Error: " .. ("0x%x\nARGS: %s"):format(e, table.concat(fargs, ", ")), 2)
		end
		return r
	end
end

local gl = setmetatable({ }, { 
	__index = function (self, key)
		if key ~= "glGetError" and key:sub(1, 2) ~= "GL" then
			rawset(self, key, anal(glf[key]))
		else
			rawset(self, key, glf[key])
		end
		return rawget(self, key)
	end,
})

------------------------------------------------------------------------------
-- /!\ HACK
------------------------------------------------------------------------------
-- need existing gl texture id from image, but there's no way to get that through the API, or directly since it's not a POD c++ class :(
local oldnewimage = love.graphics.newImage 
local imageinfo = setmetatable({ }, { __mode = "k" })

function love.graphics.newImage (source)
	local i = oldnewimage(source)
	
	local texid = ffi.new "GLuint[1]"
	gl.glGetIntegerv(gl.GL_TEXTURE_BINDING_2D, texid)
	
	imageinfo[i] = { texid = texid[0] } -- separate texture id for primitive
	
	return i
end

------------------------------------------------------------------------------
-- Extensions :(
------------------------------------------------------------------------------
-- not supposed to localize cdata function references but don't have much choice here
local glGenBuffers, glDeleteBuffers, glBindBuffer, glBufferData, glGetBufferSubData
if ffi.os == "Windows" then -- extensions argh
	ffi.cdef [[
		void *wglGetProcAddress(const char *name);
		typedef void (*PFNGLGENBUFFERSPROC)    (GLsizei n, GLuint *buffers);
		typedef void (*PFNGLDELETEBUFFERPROC)  (GLsizei n, const GLuint *buffers);
		typedef void (*PFNGLBINDBUFFERPROC)    (GLenum target, GLuint buffer);
		typedef void (*PFNGLBUFFERDATAPROC)    (GLenum target, GLsizeiptr size, const GLvoid *data, GLenum usage);
		typedef void (*PFNGLBUFFERSUBDATAPROC) (GLenum target, GLintptr offset, GLsizeiptr size, const GLvoid *data);
	]]
	
	glGenBuffers    = anal(ffi.cast("PFNGLGENBUFFERSPROC",    gl.wglGetProcAddress "glGenBuffers"))
	glDeleteBuffer  = anal(ffi.cast("PFNGLDELETEBUFFERPROC",  gl.wglGetProcAddress "glDeleteBuffer"))
	glBindBuffer    = anal(ffi.cast("PFNGLBINDBUFFERPROC",    gl.wglGetProcAddress "glBindBuffer"))
	glBufferData    = anal(ffi.cast("PFNGLBUFFERDATAPROC",    gl.wglGetProcAddress "glBufferData"))
	glBufferSubData = anal(ffi.cast("PFNGLBUFFERSUBDATAPROC", gl.wglGetProcAddress "glBufferSubData"))
else
	local function idkwhattodoifthisfails (name) assert(pcall(function () return gl[name] end), name .. " is probably an extension function which i don't know how to access on this platform :(") return anal(gl[name]) end
	glGenBuffers    = idkwhattodoifthisfails "glGenBuffers"
	glDeleteBuffer  = idkwhattodoifthisfails "glDeleteBuffer"
	glBindBuffer    = idkwhattodoifthisfails "glBindBuffer"
	glBufferData    = idkwhattodoifthisfails "glBufferData"
	glBufferSubData = idkwhattodoifthisfails "glBufferSubData"
end

------------------------------------------------------------------------------
-- FFI/Object lists
------------------------------------------------------------------------------
ffi.cdef [[
	typedef GLuint love_Index;
	
	typedef struct { 
		GLfloat x, y;
		GLfloat s, t;
		GLubyte r, g, b, a;
		GLfloat _pad[3]; // apparently AMD suggests vertices should be a multiple of 32 bytes. w/e
	} love_Point;
	
	typedef struct {
		GLsizei     vbuffer;
		GLsizei     ibuffer;
		bool        bound;
		bool        vbufferdirty;
		bool        ibufferdirty;
		int         mode;
		int         maxpoints;
		int         npoints;
		int         nindices;
		love_Point *points;
		love_Index *indices;
	} love_PointBatch;
]]

local Point     = ffi.typeof "love_Point"
local pointsize = ffi.sizeof "love_Point"
local indexsize = ffi.sizeof "love_Index"

-- handle cases where a table or varargs is accepted, return table + length
-- doesn't check for holes since they aren't allowed in these cases anyway
local function getargs (...) 
	if type((...)) == "table" then
		return ..., #...
	end
	
	return { ... }, select("#", ...)
end

-- shamelessly copied from LOVE's source
local TransformMatrix = ffi.metatype("struct { GLfloat elements[16]; }", { 
	__index = {
		setTransform = function (self, x, y, r, sx, sy, ox, oy, kx, ky)
			local e = self.elements
			local c, s = math.cos(r), math.sin(r)
			
			e[10] = 1
			e[15] = 1
			e[0]  = c * sx - ky * s * sy
			e[1]  = s * sx + ky * c * sy
			e[4]  = kx * c * sx - s * sy
			e[5]  = kx * s * sx + c * sy
			e[12] = x - ox * e[0] - oy * e[4]
			e[13] = y - ox * e[1] - oy * e[5]
			
			return self
		end,
		
		transform = function (self, vertices, size)
			local e = self.elements
			local newvertices = ffi.new("love_Point[?]", size)
			
			for i = 0, size - 1 do
				newvertices[i].x = e[0] * vertices[i].x + e[4] * vertices[i].y + e[12]
				newvertices[i].y = e[1] * vertices[i].x + e[5] * vertices[i].y + e[13]
			end
			
			return newvertices
		end,
	}
})

local pointbatches = setmetatable({ }, { __mode = "k" })

------------------------------------------------------------------------------
-- PointBatch
------------------------------------------------------------------------------
local PointBatch
local pointbatch = { }

-- public
function pointbatch:add (x, y, r, g, b, a, s, t)
	local id, pointdata
	
	if self.npoints >= self.maxpoints then return nil end --TODO: dunno what spritebatches do if you exceed this
	
	if not (r and g and b and a) then
		local currcol = ffi.new("GLfloat[4]")
		gl.glGetFloatv(gl.GL_CURRENT_COLOR, currcol)
		
		r = r or currcol[0] * 255
		g = g or currcol[1] * 255
		b = b or currcol[2] * 255
		a = a or currcol[3] * 255
	end
	
	id, pointdata = self:_addpoint(x, y, r, g, b, a, s or 0, t or 0)
	
	self:_updateVertexBuffer(id, pointdata, 1) 
	
	return id
end

function pointbatch:addq (q, x, y, r, sx, sy, ox, oy, kx, ky) 
	local transform = TransformMatrix():setTransform(x, y, r or 0, sx or 1, sy or sx or 1, ox or 0, oy or 0, kx or 0, ky or 0)
	
	-- this is kinda gross lol
	local points = ffi.new "love_Point[4]"
	local qx, qy, qw, qh = q:getViewport()
	points[0].x, points[0].y = qx, qy
	points[1].x, points[1].y = qx, qy + qh
	points[2].x, points[2].y = qx + qw, qy + qh
	points[3].x, points[3].y = qx + qw, qy
	
	transform:transform(points, 4)
	
	local p1 = self:add(points[0].x, points[0].y)
	local p2 = self:add(points[1].x, points[1].y)
	local p3 = self:add(points[2].x, points[2].y)
	local p4 = self:add(points[3].x, points[3].y)
	return self:addQuad(p1, p2, p3, p4)
end

function pointbatch:addPointBatch (pointbatch, x, y, r, sx, sy, ox, oy, kx, ky) --TODO
	if self.npoints + pointbatch:getPointCount() > self.maxpoints then return nil end --TODO: ditto
end

function pointbatch:addSpriteBatch ()
	error("SpriteBatches are not supported by this prototype", 2)
end

function pointbatch:addPoint (p) -- this is kinda redundant, but... also not sure what this and addLine should do outside of their respective draw modes, since they would mess up the index alignment (maybe add dummy indices?)
	return assert(self:addIndices(p), "need a point")
end

function pointbatch:addLine (p1, p2, ...)
	assert(p1 and p2, "need at least 2 points")
	self:addIndices(p1, p2)
	
	local points, npoints = getargs(...)
	if npoints > 0 then
		local indices = { p2 }
		
		for i = 1, npoints - 1 do
			local nindices = #indices
			indices[nindices+1] = points[i]
			indices[nindices+2] = points[i+1]
		end
		
		self:addIndices(indices)
	end
	return p1
end

function pointbatch:addRectangle(x, y, w, h, sw, sh, ...)
	local points, npoints = getargs(...)
	if npoints > 0 then
		if npoints ~= 4 then
			error("need exactly 4 points", 2)
		end
	else
		self:bind()
		points[1] = self:add(x,     y,     255, 255, 255, 255, x / sw,       y / sh)
		points[2] = self:add(x,     y + h, 255, 255, 255, 255, x / sw,       (y + h) / sh)
		points[3] = self:add(x + w, y + h, 255, 255, 255, 255, (x + w) / sw, (y + h) / sh)
		points[4] = self:add(x + w, y,     255, 255, 255, 255, (x + w) / sw, y / sh)
		self:unbind()
	end
	
	return self:addQuad(unpack(points))
end

function pointbatch:addQuad (p1, p2, p3, p4) -- analogous to love.graphics.quad. NOT a Quad!
	assert(p1 and p2 and p3 and p4, "must provide 4 points to add a quad.")
	
	return self:addIndices(p1, p2, p3, p1, p3, p4)
end

function pointbatch:addTriangle (p1, p2, p3) 
	assert(p1 and p2 and p3, "must provide 3 points to add a triangle.")
	return self:addIndices(p1, p2, p3)
end

function pointbatch:addCircle (x, y, r, n, ...) 
	local points, npoints = getargs(...)
	
	if n and n > 0 then
		npoints = n
	end
	
	assert(npoints >= 3, "must provide at least 3 points")
	
	local newpoints = { }
	local indices   = { }
	self:bind()
	for i = 1, npoints do
		local angle = (i-1) / npoints * 2 * math.pi
		newpoints[i] = self:add(
			x + math.cos(angle) * r, 
			y + math.sin(angle) * r, 
			select(3, self:_getpoint(points[i]))
		)
	end
	self:unbind()
	
	for i = 1, npoints - 2 do
		local nindices = #indices
		indices[nindices+1] = newpoints[1]
		indices[nindices+2] = newpoints[i+1]
		indices[nindices+3] = newpoints[i+2]
	end
	
	return self:addIndices(indices)
end

function pointbatch:addArc (x, y, r, angle1, angle2, n, ...) --NOTE: unlike lg.arc, doesn't convert to circle if arc does full sweep
	local points, npoints = getargs(...)
	
	if n and n > 0 then
		npoints = n + 2 -- center point + extra point for segment
	end
	
	assert(npoints >= 3, "must provide at least 3 points")
	
	local diff = (angle2 - angle1) / (npoints - 2)
	
	local angle = angle1
	
	-- center point is first
	local newpoints = { self:add(x, y, select(3, self:_getpoint(points[1]))) }
	local indices   = { }
	self:bind()
	for i = 1, npoints do
		newpoints[i+1] = self:add(
			x + math.cos(angle) * r,
			y + math.sin(angle) * r,
			select(3, self:_getpoint(points[i+1]))
		)
		angle = angle + diff
	end
	self:unbind()
	
	for i = 1, npoints - 2 do
		local nindices = #indices
		indices[nindices+1] = newpoints[1]
		indices[nindices+2] = newpoints[i+1]
		indices[nindices+3] = newpoints[i+2]
	end
	
	return self:addIndices(indices)
end

function pointbatch:get (id)
	if id < 0 or id > self.npoints - 1 then return nil end
	return self:_getpoint(id)
end

function pointbatch:getPoints ()
	local pointlist = { }
	
	for i = 0, self.npoints - 1 do
		pointlist[i+1] = i
	end
	
	return pointlist
end

function pointbatch:clear ()
	self.npoints  = 0
	
	ffi.fill(self.points, 0, self.maxpoints * pointsize)
	
	self:_updateVertexBuffer(0, self.points, self.maxpoints)
end

function pointbatch:set (id, x, y, r, g, b, a, s, t)
	if id < 0 or id > self.npoints - 1 then return end
	
	local p = self.points[id]
	
	if x then p.x = x end
	if y then p.y = y end
	if r then p.r = r end
	if g then p.g = g end
	if b then p.b = b end
	if a then p.a = a end
	if s then p.s = s end
	if t then p.t = t end
	

	self:_updateVertexBuffer(id, p, 1) 
end

function pointbatch:getPointCount ()
	return self.npoints
end

function pointbatch:addIndices (...) -- FIXME: for some reason, when i called this with a table, all of the fields were apparently tables too (???)
	local newindices, nnewindices = getargs(...)
	
	if nnewindices > 0 then
		newindices = ffi.new("love_Index[?]", nnewindices, newindices)
		
		local newdata = ffi.new("love_Index[?]", self.nindices + nnewindices)
		ffi.copy(newdata, self.indices, self.nindices * indexsize)
		ffi.copy(newdata + self.nindices, newindices, nnewindices * indexsize)
		
		self.indices = newdata
		pointbatches[self].indexdata = newdata
		
		self:_updateIndexBuffer(0, newdata, self.nindices + nnewindices)
		
		self.nindices = self.nindices + nnewindices
		
		return newindices[0]
	end
end

function pointbatch:getIndices (first, last)
	first, last = first or 1, last or self.nindices
	
	assert(first <= last, "starting index exceeds ending index")
	assert(first >= 1, "starting index out of range")
	assert(last <= self.maxindices, "ending index out of range")
	
	local indexlist = { }
	local indices = self.indices
	
	for i = first, last do
		indexlist[#indexlist+1] = indices[i-1]
	end
	
	return indexlist
end

function pointbatch:clearIndices ()
	self.nindices  = 0
	
	ffi.fill(self.indices, 0, self.maxindices * indexsize)
	
	self:_updateIndexBuffer(0, self.indices, self.maxindices)
end

function pointbatch:getIndexCount ()
	return self.nindices
end

function pointbatch:getImage ()
	return pointbatches[self].image
end

function pointbatch:setImage (image)
	pointbatches[self].image = image
end

function pointbatch:setTexcoords (tx, ty, tw, th, sw, sh)
	local x, y, w, h = self:_getAabb()
	
	if tx and ty and tw and th then
		x, y, w, h = x + tx, y + ty, w / tw * sw, h / th * sh
	end
	
	local pointdata = self.points
	for i = 0, self.npoints - 1 do
		local point = pointdata[i]
		
		point.s = (point.x - x) / w
		point.t = (point.y - y) / h
	end
	
	self:_updateVertexBuffer(0, pointdata, self.npoints)
end

function pointbatch:bind ()
	self.bound = true
end

function pointbatch:unbind ()
	self.bound = false
	
	-- ideally this should only update parts of the buffers that actually changed, but too lazy to keep track of that
	self:_updateVertexBuffer(0, self.points, self.npoints) 
	self:_updateIndexBuffer(0, self.indices, self.nindices) 
end

-- "inherited" (at least they would be in the actual impl)
function pointbatch:type () 
	return "SpriteBatch"
end

local typeofs = { PointBatch = true, Drawable = true, Object = true }
function pointbatch:typeOf (t) 
	return typeofs[t] == true
end

-- private
function pointbatch:_addpoint (x, y, r, g, b, a, s, t)
	local id = self.npoints
	local point = Point(x, y, s, t, r, g, b, a)
	
	self.points[id] = point
	
	self.npoints = self.npoints + 1
	
	return id, point
end

function pointbatch:_getpoint (id)
	if not id then return nil end
	local p = self.points[id]
	return p.x, p.y, p.r, p.g, p.b, p.a, p.s, p.t
end

function pointbatch:_updateVertexBuffer (start, newdata, nelements)
	if self.bound then
		self.vbufferdirty = true
		return
	end
	
	if not self.bound or self.vbufferdirty then
		glBindBuffer(gl.GL_ARRAY_BUFFER, self.vbuffer)
		glBufferSubData(gl.GL_ARRAY_BUFFER, start * pointsize, ffi.cast("GLsizeiptr", nelements * pointsize), ffi.cast("const GLvoid *", newdata))
		glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
		
		self.vbufferdirty = false
	end
end

function pointbatch:_updateIndexBuffer (_, newdata, nelements)
	if self.bound then
		self.ibufferdirty = true
		return
	end
	
	if not self.bound or self.ibufferdirty then
		glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, self.ibuffer)
		glBufferData(gl.GL_ELEMENT_ARRAY_BUFFER, ffi.cast("GLsizeiptr", nelements * indexsize), newdata, gl.GL_DYNAMIC_DRAW)
		glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, 0)
		
		self.ibufferdirty = false
	end
end

function pointbatch:_getAabb ()
	local xmin, ymin, xmax, ymax = math.huge, math.huge, 0, 0
	
	local pointdata = self.points
	for i = 0, self.npoints - 1 do
		local point = pointdata[i]
		
		if point.x < xmin then xmin = point.x end
		if point.x > xmax then xmax = point.x end
		if point.y < ymin then ymin = point.y end
		if point.y > ymax then ymax = point.y end
	end
	
	return xmin, ymin, xmax - xmin, ymax - ymin
end

PointBatch = ffi.metatype("love_PointBatch", { 
	__index = pointbatch, 
	__gc    = function (self)
		glDeleteBuffer(self.vbuffer)
		glDeleteBuffer(self.ibuffer)
	end,
})

------------------------------------------------------------------------------
-- API
------------------------------------------------------------------------------
-- seriously why didn't opengl just use regular numeric offsets from the beginning. wtf is this :(
local offsets = { 
	position = ffi.cast("const GLvoid *", ffi.offsetof(Point, "x")),
	texcoord = ffi.cast("const GLvoid *", ffi.offsetof(Point, "s")),
	color    = ffi.cast("const GLvoid *", ffi.offsetof(Point, "r")),
}

function love.graphics.newPointBatch (image, maxsize, mode)
	local buffers = ffi.new "int[2]"
	glGenBuffers(2, buffers)
	
	local indicesperpoint = 3 -- TODO: should actually use `mode'
	
	assert(buffers[0] ~= 0 and buffers[1] ~= 0, "could not generate a buffer")
	
	local pointdata = ffi.new("love_Point[?]", maxsize) -- FIXME: shouldn't actually be allocated at max size, but it'll work for now lol
	local indexdata = ffi.new("love_Index[?]", maxsize * indicesperpoint) -- FIXME: ditto
	local p = PointBatch {
		vbuffer      = buffers[0],
		ibuffer      = buffers[1],
		maxpoints    = maxsize,
		bound        = false,
		vbufferdirty = true,
		ibufferdirty = true,
		mode         = 0,
		npoints      = 0,
		nindices     = 0,
		points       = pointdata, 
		indices      = indexdata,
	}
	
	glBindBuffer(gl.GL_ARRAY_BUFFER, p.vbuffer)
	glBufferData(gl.GL_ARRAY_BUFFER, ffi.cast("GLsizeiptr", p.maxpoints * pointsize), ffi.cast("const GLvoid *", p.points), gl.GL_DYNAMIC_DRAW) -- FIXME: same as above, shouldn't have maxpoints
	glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
	
	pointbatches[p] = { buffers = buffers, image = image, pointdata = pointdata, indexdata = indexdata } -- keep these around so they don't get collected while still in use, which would be bad
	
	return p
end

local function drawpointbatch (p, x, y, r, sx, sy, ox, oy, kx, ky)
	assert(p:typeOf "PointBatch", "not a PointBatch")
	if p.npoints == 0 then return end
	
	local transform = TransformMatrix():setTransform(x, y, r or 0, sx or 1, sy or sx or 1, ox or 0, oy or 0, kx or 0, ky or 0)
	
	local c = ffi.new "GLfloat[4]"
	gl.glGetFloatv(gl.GL_CURRENT_COLOR, c) -- apparently you're supposed to save this if you're going to use COLOR_ARRAY but idk 
	
	local currenttexture 
	local t = p:getImage()
	if t then 
		gl.glBindTexture(gl.GL_TEXTURE_2D, imageinfo[t].texid) 
	else
		currenttexture = ffi.new "GLint[1]"
		gl.glGetIntegerv(gl.GL_TEXTURE_BINDING_2D, currenttexture) -- only because i can't access LOVE internals to mess with the texture id myself
		gl.glBindTexture(gl.GL_TEXTURE_2D, 0) 
	end
	
	gl.glPushMatrix()
	gl.glMultMatrixf(ffi.cast("const GLfloat *", transform))
	
	gl.glEnableClientState(gl.GL_VERTEX_ARRAY)
	gl.glEnableClientState(gl.GL_COLOR_ARRAY)
	gl.glEnableClientState(gl.GL_TEXTURE_COORD_ARRAY)
	
	glBindBuffer(gl.GL_ARRAY_BUFFER, p.vbuffer)
	glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, p.ibuffer)
	
	gl.glTexCoordPointer(2, gl.GL_FLOAT,         pointsize, offsets.texcoord)
	gl.glColorPointer   (4, gl.GL_UNSIGNED_BYTE, pointsize, offsets.color)
	gl.glVertexPointer  (2, gl.GL_FLOAT,         pointsize, offsets.position)
	
	gl.glDrawElements(gl.GL_TRIANGLES, p.nindices, gl.GL_UNSIGNED_INT, ffi.cast("const GLvoid *", p.ibuffer))
	
	glBindBuffer(gl.GL_ARRAY_BUFFER, 0)
	glBindBuffer(gl.GL_ELEMENT_ARRAY_BUFFER, 0)
	
	gl.glDisableClientState(gl.GL_TEXTURE_COORD_ARRAY)
	gl.glDisableClientState(gl.GL_COLOR_ARRAY)
	gl.glDisableClientState(gl.GL_VERTEX_ARRAY)
	
	gl.glPopMatrix()
	
	if not t then 
		gl.glBindTexture(gl.GL_TEXTURE_2D, currenttexture[0]) 
	end
	
	gl.glColor4fv(c) 
end

local olddraw = love.graphics.draw
function love.graphics.draw (...)
	if (...):typeOf "PointBatch" then
		drawpointbatch(...)
	else
		olddraw(...)
	end
end