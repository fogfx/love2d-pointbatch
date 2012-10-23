require 'pointbatch'

local lovelogo = require 'lovelogo'

local w, h = love.graphics.getMode()
local x, y = w / 2, h / 2
local a = 0
local s = 128

local points 

local function color (angle)
	local v, s = 1, 1
	local h = (angle / 60) % 6
	local c = v * s
	local x = c * (1 - math.abs(h % 2 - 1))

	local r1, g1, b1 = 0, 0, 0

	if h >= 0 and h < 1 then
		r1, g1, b1 = c, x, 0
	elseif h >= 1 and h < 2 then
		r1, g1, b1 = x, c, 0
	elseif h >= 2 and h < 3 then
		r1, g1, b1 = 0, c, x
	elseif h >= 3 and h < 4 then
		r1, g1, b1 = 0, x, c
	elseif h >= 4 and h < 5 then
		r1, g1, b1 = x, 0, c
	elseif h >= 5 and h < 6 then
		r1, g1, b1 = c, 0, x
	end

	return r1 * 255, g1 * 255, b1 * 255
end

function love.load ()
	points = lovelogo:getPoints() 
	
	for i, v in ipairs(points) do
		local x, y = lovelogo:get(v)
		points[i] = { id = v, x = x, y = y, a = math.rad(math.random(360)) }
	end
	
	--error(tostring(points[1].x .. " " .. points[1].y))
end

function love.update (dt)
	local mx, my = love.mouse.getPosition()
	a = a + .02
	
	lovelogo:bind()
	for _, pd in ipairs(points) do
		local na = pd.a + a
		local md = math.min(1, math.max(0, (255 - math.sqrt((x+(pd.x*s) - mx)^2 + (y+(pd.y*s) - my)^2)) / 255))
		lovelogo:set(pd.id, pd.x + math.cos(na) * .04, pd.y + math.sin(na) * .04, color(360 * md + math.deg(pd.a) / 10))
	end
	lovelogo:unbind()
end

function love.draw ()
	love.graphics.draw(lovelogo, x, y, 0, s, s)
end