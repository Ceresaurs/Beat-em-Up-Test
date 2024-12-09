


function rory_load()
--pink character
rory={
    sprite=love.graphics.newImage('sprites/rory/rory.png')
}

rory.portrait = love.graphics.newImage('sprites/rory/rory-portrait.png')
rory.idleSheet = love.graphics.newImage('sprites/rory/rory-idle.png')
rory.forwardSheet = love.graphics.newImage('sprites/rory/rory-walk.png')
rory.forwardgrid=anim8.newGrid(160,160,rory.forwardSheet:getWidth(),rory.forwardSheet:getHeight())
rory.grid = anim8.newGrid(160,160,rory.idleSheet:getWidth(),rory.idleSheet:getHeight())
rory.forwardNormalSheet = love.graphics.newImage('sprites/rory/rory-side-normal-Sheet.png')
rory.forwardNormalGrid = anim8.newGrid(160,160,rory.forwardNormalSheet:getWidth(),rory.forwardNormalSheet:getHeight())
rory.healthbar = love.graphics.newImage('sprites/rory/rory-healthbar.png')
rory.max_health = 300
rory.health = 300

rory.animations = {}
rory.animations.forward = anim8.newAnimation(rory.forwardgrid('1-4',1),0.1)
rory.animations.idle = anim8.newAnimation(rory.grid('1-5',1),0.1)
rory.animations.forwardspecial = love.graphics.newImage('sprites/rory/rory-slide.png')
rory.animations.forwardNormal = anim8.newAnimation(rory.forwardNormalGrid('1-7',1),0.08)

 rorySideSpecialCD = 0 

end
 
function rory_animations_update(dt)
    rory.animations.forward:update(dt)
    rory.animations.idle:update(dt)
    rory.animations.forwardNormal:update(dt)
end

function rory_moves_update(dt)
    rory_sidespecial(dt)
end






function rory_sidespecial(dt)

   
    
    rorySideSpecialCD = rorySideSpecialCD- 60 *dt

    if rorySideSpecialCD < 0 then
        rorySideSpecialCD = 0
    end

    if love.keyboard.isDown('d','right') and love.keyboard.isDown('f') and rorySideSpecialCD == 0  then

        Player.state = "rightspecial"
        rorySideSpecialCD = rorySideSpecialCD + 1000 * dt

    end

    if love.keyboard.isDown('a','left') and love.keyboard.isDown('f') and rorySideSpecialCD == 0  then

        Player.state = "leftspecial"
        rorySideSpecialCD = rorySideSpecialCD + 1000 * dt

    end

    if Player.state == "rightspecial" and Player.character[1] == rory and Player.active == 1 or 
    Player.state == "rightspecial" and Player.character[2] == rory and Player.active == 2 or 
    Player.state == "rightspecial" and Player.character[3] == rory and Player.active ==3 then 

        Player.velX = 2000 

    end

    if Player.state == "leftspecial" and Player.character[1] == rory and Player.active == 1 or 
    Player.state == "leftspecial" and Player.character[2] == rory and Player.active == 2 or 
    Player.state == "leftspecial" and Player.character[3] == rory and Player.active ==3 then 

        Player.velX = -2000 

    end



end