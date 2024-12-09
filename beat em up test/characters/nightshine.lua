function nightshine_load()
--nightshine character
nightshine = {
    sprite=love.graphics.newImage('sprites/nightshine/nightshine.png')
}
nightshine.portrait = love.graphics.newImage('sprites/nightshine/nightshine-portrait.png')
nightshine.forwardSheet = love.graphics.newImage('sprites/nightshine/nightshine-idle-Sheet.png')
nightshine.forwardgrid=anim8.newGrid(160,160,nightshine.forwardSheet:getWidth(),nightshine.forwardSheet:getHeight())
nightshine.idleSheet = love.graphics.newImage('sprites/nightshine/nightshine-idle-Sheet.png')
nightshine.grid = anim8.newGrid(160,160,nightshine.idleSheet:getWidth(),nightshine.idleSheet:getHeight())


nightshine.animations = {}

nightshine.animations.forward = anim8.newAnimation(nightshine.grid('1-4',1),0.1)
nightshine.animations.idle = anim8.newAnimation(nightshine.grid('1-4',1),0.1)
end

function nightshine_animations_update(dt)
    nightshine.animations.forward:update(dt)
    nightshine.animations.idle:update(dt)
end

function nightshine_moves_update(dt)
    
end






