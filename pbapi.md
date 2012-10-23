## PointBatch

 `PointBatch`es provide a way to access vertex buffer functionality  from LOVE. Specifically, they make it possible to set color and  texture coordinate information on a per-vertex basis. As a side-

 effect, they can be drawn with a single call like simple shapes,  making them quite efficient. If it weren't obvious due to their  name, `PointBatch`es are similar to `SpriteBatch`es; in fact, they   are a superset of `SpriteBatch` functionality. They are more   powerful, but this comes at the cost of being more difficult to  use! 
***
### Create a new `PointBatch`.

`love.graphics.newPointBatch (image, maxpoints, mode)`

Create a new `PointBatch` with the specified image and maximum number of points. 
##### Params

* `image` __(`Image`):__ Image to use. `nil` specifies no image.

* `maxpoints` __(`number`):__ Maximum number of points to allow.

* `mode` __(`string`):__ Draw mode of `PointBatch`. Note that this affects how many indices need to be provided for a given element! Can be "fill" (3 indices/element), "line" (2 indices/element) or "point" (1 index/element). Default is "fill". NOTE: maybe allow more eg for line strips?

##### Returns

* __(`PointBatch`):__ New `Pointbatch`.


***
### Extended love.graphics.draw

`love.graphics.draw(pb, ...)`

Can now draw `PointBatch`es. 
##### Params

* `pb` __(`PointBatch`):__ `PointBatch` to draw.

* `...` __(`number...`):__ The other arguments i'm too lazy to list because they haven't changed at all.


***
## Point Data Management

 `PointBatch`es are not much use without points! Points can be   added individually or in groups via shapes. Points, along  with their position, also contain color and texture coordinate  data. 
***
### Add a single point to the `PointBatch`.

`PointBatch:add (x, y, r, g, b, a, s, t)`


##### Params

* `x` __(`number`):__ X position of point.

* `y` __(`number`):__ Y position of point.

* `r` __(`number`):__ Red component of vertex color. Default is Red component of current color.

* `g` __(`number`):__ Green component of vertex color. Default is Green component of current color.

* `b` __(`number`):__ Blue component of vertex color. Default is Blue component of current color.

* `a` __(`number`):__ Alpha component of vertex color. Default is Alpha component of current color.

* `s` __(`number`):__ X position of texture coordinate. Float in range 0.0-1.0, inclusive. Default is 0.

* `t` __(`number`):__ Y position of texture coordinate. Float in range 0.0-1.0, inclusive. Default is 0.

##### Returns

* __(`number`):__ id of added point. NOTE: Currently a number, may later become lightuserdata.


***
### TODO. For `SpriteBatch`es, this allows you to define a sprite with a `Quad` instead of the whole image. 

`PointBatch:addq ()`


***
### TODO. Only imports sprites; doesn't change the image.

`PointBatch:addSpriteBatch ()`


***
### TODO. Only imports points and indices; doesn't change the image. Draw modes must be the same.

`PointBatch:addPointBatch ()`


***
### Add a single point to the `PointBatch`.

`PointBatch:addPoint (id)`

This simply just adds an index for the given point. Points are only visible in `"point"` mode. 
##### Params

* `id` __(`number`):__ ID of point.

##### Returns

* __(`number`):__ ID of point.


***
### Add a line or polyline.

`PointBatch:addLine (id1, id2, ...)`

Add a line or connected chain of lines to the `PointBatch`. Lines are only visible in `"line"` mode. 
##### Params

* `id1` __(`number`):__ ID of first point.

* `id2` __(`number`):__ ID of second point.

* `...` __(`number...`):__ IDs of additional points, to create a polyline.

##### Returns

* __(`number`):__ ID of first point.


***
### Add a triangle.

`PointBatch:addTriangle (id1, id2, id3)`


##### Params

* `id1` __(`number`):__ ID of first point.

* `id2` __(`number`):__ ID of second point.

* `id3` __(`number`):__ ID of third point.

##### Returns

* __(`number`):__ ID of first point.


***
### Add a quadrilateral. Not the same as a Quad.

`PointBatch:addQuad (id1, id2, id3, id4)`


##### Params

* `id1` __(`number`):__ ID of first point.

* `id2` __(`number`):__ ID of second point.

* `id3` __(`number`):__ ID of third point.

* `id4` __(`number`):__ ID of fourth point.

##### Returns

* __(`number`):__ ID of first point.


***
### Add a rectangle to the `PointBatch`.

`PointBatch:addRectangle (x, y, w, h, ...)`

Adds points and indices for a rectangle. 
##### Params

* `x` __(`number`):__ X position of upper-left point of rectangle.

* `y` __(`number`):__ Y position of upper-left point of rectangle.

* `w` __(`number`):__ Width of rectangle.

* `h` __(`number`):__ Height of rectangle.

* `...` __(`number... or table`):__ A list of numbers, or a table of numbers, of the ids for up to 4 points to use. Only the color and texcoord information will be used, starting at the upper-left corner and going counter-clockwise. Defaults to current color and texcoord (0, 0) for missing points.


***
### Add a circle to the `PointBatch`.

`PointBatch:addCircle (x, y, r, n, ...)`

Adds points and indices for a circle. Or regular polygons, if you have few enough points... 
##### Params

* `x` __(`number`):__ X position of center of circle.

* `y` __(`number`):__ Y position of center of circle.

* `r` __(`number`):__ Radius of circle.

* `n` __(`number`):__ Number of segments. If `nil`, it will create as many segments as there are points provided to the next argument. If a number, it will create as many segments as specified, using as many points provided to the next argument as possible; missing points will be created with the current color and (0, 0) texcoord.

* `...` __(`number... or table`):__ A list of numbers, or a table of numbers, of at least 3 point ids to use. Only the color and texcoord information will be used, starting at the top-most point and going counter-clockwise.


***
### Add an arc to the `PointBatch`.

`PointBatch:addArc (x, y, r, angle1, angle2, n, ...)`


##### Params

* `x` __(`number`):__ X position of center of arc center.

* `y` __(`number`):__ Y position of center of arc center.

* `r` __(`number`):__ Radius of arc.

* `angle1` __(`number`):__ Angle of first leg.

* `angle2` __(`number`):__ Angle of second leg.

* `n` __(`number`):__ Number of segments. If `nil`, it will create as many segments as there are points provided to the next argument, minus 1. If a number, it will create as many segments as specified, using as many points provided to the next argument as possible, minus 1; missing points will be created with the current color and (0, 0) texcoord.

* `...` __(`number... or table`):__ A list of numbers, or a table of numbers, of at least 3 point ids to use. Only the color and texcoord information will be used, starting with the center point and going along the sweep direction.


***
### Get a point from its id (see above NOTE).

`PointBatch:get (id)`


##### Params

* `id` __(`number`):__ ID of point.

##### Returns

* __(`number...`):__ X, Y, R, G, B, A, S and T values of point.


***
### Set a point's data.

`PointBatch:set (id, x, y, r, g, b, a, s, t)`


##### Params

* `id` __(`number`):__ ID of point.

* `x` __(`number`):__ New X position of point.

* `y` __(`number`):__ New Y position of point.

* `r` __(`number`):__ New Red component of vertex color.

* `g` __(`number`):__ New Green component of vertex color.

* `b` __(`number`):__ New Blue component of vertex color.

* `a` __(`number`):__ New Alpha component of vertex color.

* `s` __(`number`):__ New X position of texture coordinate. Float in range 0.0-1.0, inclusive.

* `t` __(`number`):__ New Y position of texture coordinate. Float in range 0.0-1.0, inclusive.


***
### Clear all points from PointBatch.

`PointBatch:clear ()`


***
### Set texcoords of all points.

`PointBatch:setTexcoords ()`

Sets the texcoords of each point to its relative position in  the bounding box defined by the group of all points. 
***
### Get number of points currently used.

`PointBatch:getPointCount ()`

##### Returns

* __(`number`):__ Number of points.


***
## Index Management

 Indices tell the graphics card which points actually make   up triangles. Points will not have any visible effect until  they are added to the index list. A given point can be  added more than once, and in fact this is necessary if you  want interpolation across a shape. This is advanced   functionality, so it is recommended to use the basic shapes  unless you really need this flexibility. 
***
### Add one or more indices to the index list.

`PointBatch:addIndices (...)`

Indices are used in conjunction with `GL_TRIANGLES`, `GL_LINES`, or `GL_POINTS`, depending on the `PointBatch`'s draw mode. 
##### Params

* `...` __(`number... or table`):__ A list of or a table containing point ids.


***
### Get a table containing the index list entries.

`PointBatch:getIndices ()`


***
### Clear all indices.

`PointBatch:clearIndices ()`


***
### Get number of indices currently used.

`PointBatch:getIndexCount ()`

##### Returns

* __(`number`):__ Number of indices.


***
### Get draw mode.

`PointBatch:getDrawMode ()`

The draw mode specifies how the `PointBatch` should be drawn. The draw mode cannot be changed, as a set of indices are only meaningful for one draw mode type. ##### Returns

* __(`string`):__ Draw mode of this `PointBatch`.


***
## Image Management

 A `PointBatch` can carry an optional image. 
***
### Set the current `PointBatch` image, or remove it by passing `nil`.

`PointBatch:setImage (image)`


##### Params

* `image` __(`Image`):__ New image to use.


***
### Get the current `PointBatch` image, or nil if none.

`PointBatch:getImage ()`

##### Returns

* __(`Image`):__ Current image.


***
## Binding/Unbinding

 These work exactly like they do in `SpriteBatche`s: `bind`   causes further modifications to the `PointBatch`'s GPU data  to be delayed until a matching call to `unbind`. This is   recommended if you will be performing a lot of updates in  a short time (eg. adding points in a loop). 
***
### Bind `PointBatch` and delay updates to GPU.

`PointBatch:bind ()`

Note: changes will not be visible until `unbind` is called! 
***
### Unbind `PointBatch` and send updates to GPU.

`PointBatch:unbind ()`


***
