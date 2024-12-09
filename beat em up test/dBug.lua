
function debug_load()
--debug

end

function debug_update(dt)
--debug update
end

function debugDraw()
    --debug draw
    love.graphics.print(Player.state,500,1000)
  
    love.graphics.print(tostring(love.timer.getFPS( )), 1700, 10)
    

    local mouseX, mouseY = love.mouse.getPosition()
    love.graphics.print(mouseX .. " " .. mouseY, 1300,10)





end

function hitBoxesDraw()

    for _, body in pairs(world:getBodies()) do
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()
    
            if shape:typeOf("CircleShape") then
                local cx, cy = body:getWorldPoints(shape:getPoint())
                love.graphics.circle("line", cx, cy, shape:getRadius())
            elseif shape:typeOf("PolygonShape") then
                love.graphics.polygon("line", body:getWorldPoints(shape:getPoints()))
            else
                love.graphics.line(body:getWorldPoints(shape:getPoints()))
            end
        end
    end
end