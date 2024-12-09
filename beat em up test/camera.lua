 Camera = {
    x = 0,
    y = 400,
    scale = 1
}


function Camera:apply()
    love.graphics.push() --attach camera to Player and background
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    love.graphics.translate(self.x,self.y)
    love.graphics.scale(self.scale,self.scale)
end
function Camera:clear()
    love.graphics.pop()
end

function Camera_setPosition()
    
    cam:lookAt(Player.x,Player.y)
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    
    if cam.y < 200 then 
        cam.y = 200
    end

    if cam.x < screenWidth/2 then
        cam.x = screenWidth/2
    end

    local mapWidth = love.graphics.getWidth(background)
    local mapHeight = love.graphics.getHeight(background)

    if cam.x > mapWidth -screenWidth/4 then
        cam.x = mapWidth - screenWidth/4
    end

    if cam.y > mapHeight -screenHeight/4 then
        cam.y = mapHeight - screenHeight/4
    end

end 