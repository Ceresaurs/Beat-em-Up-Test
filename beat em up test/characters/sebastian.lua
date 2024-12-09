function sebastian_load()
    --sebastian character
    sebastian = {}
    
    sebastian.portrait = love.graphics.newImage('sprites/sebastian/sebastian-portrait.png')
    --sebastian.forwardSheet = love.graphics.newImage('sprites/sebastian/sebastian-idle-Sheet.png')
    --sebastian.forwardgrid=anim8.newGrid(160,160,sebastian.forwardSheet:getWidth(),sebastian.forwardSheet:getHeight())
    --sebastian.idleSheet = love.graphics.newImage('sprites/sebastian/sebastian-idle-Sheet.png')
    --sebastian.grid = anim8.newGrid(160,160,sebastian.idleSheet:getWidth(),sebastian.idleSheet:getHeight())
    
    
    --sebastian.animations = {}
    
    --sebastian.animations.forward = anim8.newAnimation(sebastian.grid('1-4',1),0.1)
    --sebastian.animations.idle = anim8.newAnimation(sebastian.grid('1-4',1),0.1)
    end
    
    function sebastian_animations_update(dt)
       -- sebastian.animations.forward:update(dt)
       -- sebastian.animations.idle:update(dt)
    end
    
    function sebastian_moves_update(dt)
        
    end