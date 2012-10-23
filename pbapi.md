## PointBatch

 `PointBatch`es provide a way to access vertex buffer functionality  from LOVE. Specifically, they make it possible to set color and  texture coordinate information on a per-vertex basis. As a side- effect, they can be drawn with a single call like simple shapes,  making them quite efficient. If it weren't obvious due to their  name, `PointBatch`es are similar to `SpriteBatch`es; in fact, they   are a superset of `SpriteBatch` functionality. They are more   powerful, but this comes at the cost of being more difficult to  use! 
### Create a new `PointBatch`.

`love.graphics.newPointBatch (image, maxpoints, mode)`

#### Params

* `image` (`Image`): Image to use. `nil` specifies no image.

* `maxpoints` (`number`): Maximum number of points to allow.

* `mode` (`string`): Draw mode of `PointBatch`. Note that this affects how many indices need to be provided for a given element! Can be "fill" (3 indices/element), "line" (2 indices/element) or "point" (1 index/element). Default is "fill". NOTE: maybe allow more eg for line strips?

#### Returns

* (`PointBatch`): New `Pointbatch`.


### Extended love.graphics.draw

`love.graphics.draw(pb, ...)`

#### Params

* `pb` (`PointBatch`): `PointBatch` to draw.

* `...` (`number...`): The other arguments i'm too lazy to list because they haven't changed at all.


## Point Data Management

 `PointBatch`es are not much use without points! Points can be   added individually or in groups via shapes. Points, along  with their position, also contain color and texture coordinate  data. 
### Add a single point to the `PointBatch`.

`PointBatch:add (x, y, r, g, b, a, s, t)`

#### Params

* `x` (`number`): X position of point.

* `y` (`number`): Y position of point.

* `r` (`number`): Red component of vertex color. Default is Red component of current color.

* `g` (`number`): Green component of vertex color. Default is Green component of current color.

* `b` (`number`): Blue component of vertex color. Default is Blue component of current color.

* `a` (`number`): Alpha component of vertex color. Default is Alpha component of current color.

* `s` (`number`): X position of texture coordinate. Float in range 0.0-1.0, inclusive. Default is 0.

* `t` (`number`): Y position of texture coordinate. Float in range 0.0-1.0, inclusive. Default is 0.

#### Returns

* (`number`): id of added point. NOTE: Currently a number, may later become lightuserdata.


### TODO. For `SpriteBatch`es, this allows you to define a sprite with a `Quad` instead of the whole image. 

`PointBatch:addq ()`


### TODO. Only imports sprites; doesn't change the image.

`PointBatch:addSpriteBatch ()`


### TODO. Only imports points and indices; doesn't change the image. Draw modes must be the same.

`PointBatch:addPointBatch ()`


### Add a rectangle to the `PointBatch`.

`PointBatch:addRectangle (x, y, w, h, ...)`

#### Params

* `x` (`number`): X position of upper-left point of rectangle.

* `y` (`number`): Y position of upper-left point of rectangle.

* `w` (`number`): Width of rectangle.

* `h` (`number`): Height of rectangle.

* `...` (`number... or table`): A list of numbers, or a table of numbers, of the ids for up to 4 points to use. Only the color and texcoord information will be used, starting at the upper-left corner and going counter-clockwise. Defaults to current color and texcoord (0, 0) for missing points.


### Add a circle to the `PointBatch`.

`PointBatch:addCircle (x, y, r, n, ...)`

#### Params

* `x` (`number`): X position of center of circle.

* `y` (`number`): Y position of center of circle.

* `r` (`number`): Radius of circle

* `n` (`number`): Number of segments. If nil, it will create as many segments as there are points provided to the next argument. If a number, it will create as many segments as specified, using as many points provided to the next argument as possible; missing points will be created with the current color and (0, 0) texcoord.

* `...` (`number... or table`): A list of numbers, or a table of numbers, of at least 3 point ids to use. Only the color and texcoord information will be used, starting at the top-most point and going counter-clockwise.


### Get a point from its id (see above NOTE).

`PointBatch:get (id)`

#### Params

* `id` (`number`): ID of point.

#### Returns

* (`number...`): X, Y, R, G, B, A, S and T values of point.


### Set a point's data.

`PointBatch:set (id, x, y, r, g, b, a, s, t)`

#### Params

* `id` (`number`): ID of point.

* `x` (`number`): New X position of point.

* `y` (`number`): New Y position of point.

* `r` (`number`): New Red component of vertex color.

* `g` (`number`): New Green component of vertex color.

* `b` (`number`): New Blue component of vertex color.

* `a` (`number`): New Alpha component of vertex color.

* `s` (`number`): New X position of texture coordinate. Float in range 0.0-1.0, inclusive.

* `t` (`number`): New Y position of texture coordinate. Float in range 0.0-1.0, inclusive.


### Clear all points from PointBatch.

`PointBatch:clear ()`


### Set texcoords of all points.

`PointBatch:setTexcoords ()`


### Get number of points currently used.

`PointBatch:getPointCount ()`

#### Returns

* (`number`): Number of points.


## Index Management

 Indices tell the graphics card which points actually make   up triangles. Points will not have any visible effect until  they are added to the index list. A given point can be  added more than once, and in fact this is necessary if you  want interpolation across a shape. This is advanced   functionality, so it is recommended to use the basic shapes  unless you really need this flexibility. 
### Add one or more indices to the index list.

`PointBatch:addIndices (...)`

#### Params

* `...` (`number... or table`): A list of or a table containing point ids.


### Get a table containing the index list entries.

`PointBatch:getIndices ()`


### Clear all indices.

`PointBatch:clearIndices ()`


### Get number of indices currently used.

`PointBatch:getIndexCount ()`

#### Returns

* (`number`): Number of indices.


### Get draw mode.

`PointBatch:getDrawMode ()`

#### Returns

* (`string`): Draw mode of this `PointBatch`.


## Image Management

 A `PointBatch` can carry an optional image. 
### Set the current `PointBatch` image, or remove it by passing `nil`.

`PointBatch:setImage (image)`

#### Params

* `image` (`Image`): New image to use.


### Get the current `PointBatch` image, or nil if none.

`PointBatch:getImage ()`

#### Returns

* (`Image`): Current image.


## Binding/Unbinding

 These work exactly like they do in `SpriteBatche`s: `bind`   causes further modifications to the `PointBatch`'s GPU data  to be delayed until a matching call to `unbind`. This is   recommended if you will be performing a lot of updates in  a short time (eg. adding points in a loop). 
### Bind `PointBatch` and delay updates to GPU.

`PointBatch:bind ()`


### Unbind `PointBatch` and send updates to GPU.

`PointBatch:unbind ()`


