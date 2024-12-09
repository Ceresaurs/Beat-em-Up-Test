Hitbox = {}
Hitbox.__index = Hitbox
ActiveHitboxes = {}
function Hitbox.new(x,y,w,h,typeOf)
    local instance = setmetatable({},Hitbox)
    instance.x = x
    instance.y = y
    instance.w = w
    instance.h = h
    instance.id = typeOf

    
    instance.toBeRemoved = false
   
    
   
   
    love.graphics.setDefaultFilter('nearest','nearest')
    instance.physics = {}
    instance.physics.body = love.physics.newBody(world,instance.x,instance.y,"static")
    instance.physics.body:setFixedRotation(true)
    instance.physics.shape = love.physics.newRectangleShape(instance.w,instance.h)
    instance.physics.fixture = love.physics.newFixture(instance.physics.body,instance.physics.shape)
    instance.physics.fixture:setSensor(true)
    
    table.insert(ActiveHitboxes, instance)
    
    end
    
    
   
    
    
    function Hitbox:load()
        
        
    end
    
    function Hitbox:update(dt)
        self:checkRemove()
        self:syncPhysics()
    end
    
    function Hitbox:updateAll(dt)
        for i,instance in ipairs(ActiveHitboxes) do
            instance:update(dt)
    
    
        end
    end
    
    function Hitbox:checkRemove(typeOf)
        if self.toBeRemoved then
            self:remove(typeOf)
            
        end
    
    end
    
    function Hitbox:remove(typeOf)
        for i,instance in ipairs(ActiveHitboxes) do
            
                instance.physics.body:destroy()
                table.remove(ActiveHitboxes,i)
       
        end
    
    end
    
    function Hitbox:syncPhysics()
        
    
        
    end
    
    
    
    
    
    function Hitbox:draw()
        
    end
    
    function Hitbox.drawAll()
    
        for i,instance in ipairs(ActiveHitboxes) do
            instance:draw()
    
    
        end
    end
    


   
    
    function Hitbox:beginContact_EnemyToPlayer(a,b,collision,typeOf)
        for i,instance in ipairs(ActiveHitboxes) do
            if a == instance.physics.fixture or b == instance.physics.fixture then
                if a == Player.physics.fixture or b == Player.physics.fixture then
                        Player:takeDamage()
                        return true

                    
                end
            end
        end
    end