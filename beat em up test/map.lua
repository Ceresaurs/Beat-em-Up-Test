
function Map_load()
    STI = require'libraries/sti'
    Map = STI('map/1.lua',{"box2d"})
    Map:box2d_init(world)
end

function Map_update(dt)

end

function Map_draw()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.push()
    love.graphics.translate(-player.x+screenWidth/2,-player.y+screenHeight/2)
    love.graphics.scale(4.0,4.0)
    if state == "playing" then
    Map:drawLayer(Map.layers["Tile Layer 1"])
    end
    love.graphics.pop()
end