Enemy = {}

Enemy.__index = Enemy

ActiveEnemys = {}


enemyCounter = 1
 require 'characters/player'
 require 'hitbox'
function Enemy.new(x,y,typeOf,id)
local instance = setmetatable({},Enemy)
instance.x = x
instance.y = y
instance.type = typeOf
instance.id = id
instance.id = 1
instance.id = instance.id+1

instance.speed = 10000
instance.state = "still"
instance.health = 3

instance.rx = 800
instance.ry = 800

instance.aTimer = 1000

instance.toBeRemoved = false
instance.toSpawnNew = false
instance.toHaveIntent = false
instance.intentRecieved = false
instance.toTakeDamage = false
instance.toRetreat = false
instance.coordinatesRecieved = false


instance.velX = instance.speed
instance.velY = instance.speed
instance.img = love.graphics.newImage('sprites/enemy/enemy1.png')
instance.width = instance.img:getWidth()
instance.height = instance.img:getHeight()
instance.intent = 0

love.graphics.setDefaultFilter('nearest','nearest')

instance.physics = {}
instance.physics.body = love.physics.newBody(world,instance.x,instance.y,"dynamic")
instance.physics.body:setFixedRotation(true)
instance.physics.shape = love.physics.newRectangleShape(instance.width,instance.height*2)
instance.physics.fixture = love.physics.newFixture(instance.physics.body,instance.physics.shape)
instance.physics.fixture:setSensor(true)


instance.forwardSheet = love.graphics.newImage('sprites/enemy/enemy1-walk.png')
instance.forwardgrid=anim8.newGrid(160,160,instance.forwardSheet:getWidth(),instance.forwardSheet:getHeight())


instance.animations = {}
instance.animations.forward = anim8.newAnimation(instance.forwardgrid('1-2',1),0.1)

table.insert(ActiveEnemys, instance)

end


function Enemy:print()
    local screenWidth = love.graphics.getWidth()
    love.graphics.print("Enemys: " .. #ActiveEnemys,screenWidth-500,50)
end


function Enemy:load() 
    
    Enemy.new(math.random(-3000,-1000),800)
    Enemy.new(math.random(-3000,-1000),800)
    Enemy.new(math.random(-3000,-1000),800)
    Enemy.new(math.random(3000,5000),800)
    Enemy.new(math.random(3000,5000),800)
    Enemy.new(math.random(3000,5000),800)

end

function Enemy:update(dt)
    self:checkRemove(dt)
    self:checkSpawn(dt)
    self:checkHealth(dt)
    self:syncPhysics(dt)
    self:checkIntent(dt)
    self:checkAttack(dt)
    self:checkRetreat(dt)
    self:checkDamage(dt)
    self:attackTimer(dt)
    self:retreat(dt)
    self:debug(dt)
    self:updateAnimations(dt)
end

function Enemy:updateAll(dt)
    for i,instance in ipairs(ActiveEnemys) do
        instance:update(dt)


    end
end

function Enemy:updateAnimations(dt)
    self.animations.forward:update(dt)
end

function Enemy:syncPhysics(dt)
    
    if state == "playing" then
        for i,instance in ipairs(ActiveEnemys) do
            if instance == self then
            self.x, self.y = self.physics.body:getPosition()
            self.physics.body:setLinearVelocity(self.velX,self.velY)

                if self.x < Player.x and self.state ~= "attackingRight" and self.state ~= "attackingLeft" and self.state ~= "retreating" then

            self.velX = self.speed * dt
            self.state = "right"

            elseif self.x > Player.x and self.state ~= "attackingRight" and self.state ~= "attackingLeft" and self.state ~= "retreating" then

            self.velX = -self.speed * dt
            self.state = "left"

            elseif self.x == Player.x and self.state ~= "retreating" or self.state == "attackingRight" or self.state == "attackingLeft" then
                
            self.velX = 0
        
            end

            if self.y > Player.y and self.state ~= "retreating" then
            
            self.velY = -self.speed * dt

            elseif self.y < Player.y and self.state ~= "retreating" then

            self.velY = self.speed * dt
            elseif self.y == Player.y and self.state ~= "retreating" or self.state == "attackingRight" or self.state == "attackingLeft" then
            self.velY = 0

            
                end
            end

        end
    end
end





function Enemy:draw()
    if state == "playing" then
        
            if self.state == "left" or self.state == "attackingLeft" then
                self.animations.forward:draw(self.forwardSheet,self.x,self.y,nil,3.0,3.0,80,90)
            elseif self.state == "right" or self.state == "attackingRightx" then
                self.animations.forward:draw(self.forwardSheet,self.x,self.y,nil,-3.0,3.0,80,90)
            end
        
    end
end

function Enemy.drawAll()

    for i,instance in ipairs(ActiveEnemys) do

        instance:draw()


    end
end



function Enemy:beginContact(a,b,collision)
    for i,instance in ipairs(ActiveEnemys) do
        if a == instance.physics.fixture or b == instance.physics.fixture then
            if a == Player.physics.fixture or b == Player.physics.fixture then
               instance.toHaveIntent = true
                return true
            end
        end
    end
end

function Enemy:Hitbox_beginContact_PlayerToEnemy(a,b,collision)
    for i,instance in ipairs(ActiveEnemys) do
        if a == instance.physics.fixture or b == instance.physics.fixture then
            for v, Hitboxes in ipairs(ActiveHitboxes) do
                if a == Hitboxes.physics.fixture or b == Hitboxes.physics.fixture then
                    instance.toTakeDamage = true
                    return true
                end
            end
        end
    end
end

function Enemy:checkDamage()
    if self.toTakeDamage then
        self:takeDamage()
    end
end

function Enemy:takeDamage()
    for i,instance in ipairs(ActiveEnemys) do
        if instance == self then
            self.health = self.health - 3
            self.toTakeDamage = false
            hoverSFX:play()
        end
    end
end

function Enemy:checkHealth()
    if self.health <= 0 then
        self.toBeRemoved = true
    end
end

function Enemy:checkRemove()

        
       if self.toBeRemoved == true then
        self:remove()
    end
    
end

function Enemy:remove()
    for i, instance in ipairs(ActiveEnemys) do
        if instance == self then 
       
            self.toSpawnNew = true

            self.physics.body:destroy()


        table.remove(ActiveEnemys,i)

            return true
        else
            return false
            
        end
    end
end


function Enemy:checkSpawn()
    
    if self.toSpawnNew == true then
        Enemy:spawn()
    end
end 

function Enemy:spawn()
   
    
            self.toSpawnNew = false
            self.new(math.random(-3000,-1000),800)
            self.new(math.random(3000,5000),800)
        
   

end 

function Enemy:checkIntent()
 if self.toHaveIntent then
    self:getIntent()
     
 end
end

function Enemy:rollIntent()

    self.intent = math.random(0,800)   

end

function Enemy:getIntent()
     if self.intentRecieved == false then
        self:rollIntent() 
        self.intentRecieved = true
     end
        for i, instance in ipairs(ActiveEnemys) do
            if instance == self then
                
                if self.intent > 100 and self.state == "right" then
                    self.state = "attackingRight"
                    self.toRetreat = false
                elseif  self.intent > 100 and self.state == "left" then
                    self.state = "attackingLeft"
                    self.toRetreat = false
                elseif self.intent <= 100 then
                    self.state = "retreating"
                    self.toRetreat = true
            end
        end
    end
end

function Enemy:checkAttack()
   
        
        if self.state == "attackingRight" then
            
            self:Attack()
            hoverSFX:play()
           
        elseif self.state == "attackingLeft" then

            self:Attack()
            hoverSFX:play()
            
        end
end

function Enemy:Attack()
    local hitBoxCreated = false
   

            if self.state == "attackingRight" and self.aTimer > 0 then

                Hitbox.new(self.x+200,self.y,100,100,"Enemy")

                hitboxCreated = true

            elseif self.state == "attackingLeft" and self.aTimer > 0 then

                Hitbox.new(self.x-200,self.y,100,100,"Enemy")

                hitboxCreated = true

            end
            
            if hitboxCreated == true then
                Hitbox.toBeRemoved = true
                Hitbox:checkRemove("Enemy")
               -- self.state = "left"
                hitboxCreated = false
            end
        
    
end

function Enemy:attackTimer(dt)
    if self.state == "attacking" then
            self.aTimer = self.aTimer - 1000 * dt
        if self.aTimer < 0 then
            self.aTimer = 0
        end
    end
end


function Enemy:checkRetreat(dt)

    if self.toRetreat == true then

    
        self:retreat(dt)
    end

end

function Enemy:retreat(dt)
    if self.coordinatesRecieved == false then
        self:retreatCoordinates()
        self.coordinatesRecieved = true
    end
    for i,instance in ipairs(ActiveEnemys) do
        if instance == self then
            if self.toRetreat == true then
                
                self.x, self.y = self.physics.body:getPosition()
                self.physics.body:setLinearVelocity(self.velX,self.velY)

                if self.x < self.rx and self.toRetreat == true then

                    self.velX = self.speed * dt

                elseif self.x > self.rx  and self.toRetreat == true then

                    self.velX = -self.speed * dt
       
                elseif self.y > self.ry and self.toRetreat == true  then
        
                    self.velY = -self.speed * dt
                
                elseif self.y < self.ry and self.toRetreat == true  then

                    self.velY = self.speed * dt
                else 
                    self:syncPhysics()
                    self.toRetreat = false
                    self.state = "left"
                    
                
                end
            end
        end
    end
end

function Enemy:retreatCoordinates()
    for i, instance in ipairs(ActiveEnemys) do
        if instance == self then
            local screenWidth = love.graphics.getWidth()

            local screenHeight = love.graphics.getHeight()
           
            self.rx =  math.random(0,1920)
            self.ry = math.random(800,1000)
        end
    end
end


function Enemy:debug()
    for i, instance in ipairs(ActiveEnemys) do

    end
end