    require 'libraries/anim8'
    require 'world'
    require 'characters/justice'
    require 'characters/valery'
    require 'characters/rory'
    require 'characters/nightshine'
    require 'dBug'
    require 'camera'
    Player = {}
    
   function Player:load()
    errorImg = love.graphics.newImage('sprites/error.png')
   
    
    switchCD=0
    self.active = 1
    self.x = 400
    self.y = 900
    self.w = 160
    self.h = 160
    self.velX = 100
    self.velY = 100
    self.maxSpeed = 1000
    self.acceleration = 8000
    self.friction = 2000

    self.character = {}



    self.jumping = false
    self.grounded = true
    self.health = 5
    self.state = "still"
    self.facing = "right"
    self.damage = 1
    self.doublejump = true
    self.jump_amount = -3500
    self.gravity = 10000
    self.physics = {}

    self.physics.body = love.physics.newBody(world,self.x,self.y-20,"dynamic")
    self.physics.shape = love.physics.newRectangleShape(150,300)
    self.physics.fixture = love.physics.newFixture(self.physics.body,self.physics.shape)
    self.physics.body:setFixedRotation(true)
    
    justice_load()

    valery_load()

    rory_load()

    nightshine_load()

    sebastian_load()
    --green character
    beetle={
        sprite=love.graphics.newImage('sprites/beetle/beetle.png')
    }
    beetle.portrait = love.graphics.newImage('sprites/beetle/beetle-portrait.png')

    beetle.animations = {}

    beetle.animations.forward = love.graphics.newImage('sprites/error.png')
    beetle.animations.idle = love.graphics.newImage('sprites/error.png')
    --puppet character
    puppet={
        sprite=love.graphics.newImage('sprites/puppet/puppet.png')
    }
    puppet.portrait = love.graphics.newImage('sprites/puppet/puppet-portrait.png')
    --powertool character
    dennis={
        sprite=love.graphics.newImage('sprites/dennis/dennis.png')
    }
    dennis.portrait = love.graphics.newImage('sprites/dennis/dennis-portrait.png')
    
    GPressed = false

end

function Player:update(dt)
self:controls(dt)
self:applyGravity(dt)
self:applyFriction(dt)

end

function update_animations(dt)

justice_animations_update(dt)

valery_animations_update(dt)

rory_animations_update(dt)

nightshine_animations_update(dt)
end

function update_moves(dt)

    justice_moves_update(dt)
    valery_moves_update(dt)
    rory_moves_update(dt)
    

end

function Player:controls(dt)
    switchCD = switchCD-70 * dt
    
    

   self.x, self.y = self.physics.body:getPosition()
    self.physics.body:setLinearVelocity(self.velX,self.velY)
   
    
   if
    switchCD < 0 then switchCD = 0
    end
   if love.keyboard.isDown("q") and switchCD == 0 then
      self.active=self.active+1
   switchCD = switchCD + 1000 * dt
   end

   
   if self.active > 3 then
       self.active = 1
   end
   
   if love.keyboard.isDown("right","d") and not love.keyboard.isDown('f') and not love.keyboard.isDown('g') and GPressed== false then
    self.state = "right"
    self.facing = "right"
        if self.velX < self.maxSpeed then
            if self.velX + self.acceleration *dt < self.maxSpeed then
            self.velX = self.velX + self.acceleration * dt
                else

                    self.velX = self.maxSpeed
                
                end
        
            end 
        
    elseif love.keyboard.isDown("left","a") and not love.keyboard.isDown('f')and not love.keyboard.isDown('g') and GPressed == false then
        self.state = "left"
        self.facing = "left"
        if self.velX > -self.maxSpeed then
            if self.velX - self.acceleration *dt > -self.maxSpeed then
            self.velX = self.velX - self.acceleration * dt
                else

                    self.velX = -self.maxSpeed
                end
        end
        
        

    elseif love.keyboard.isDown("down","s") and not love.keyboard.isDown('f')and not love.keyboard.isDown('g') and  self.y < 1200 and GPressed == false then
        self.state = "right"
        if self.velY < self.maxSpeed then
            if self.velY + self.acceleration *dt < self.maxSpeed then
            self.velY = self.velY + self.acceleration * dt
                else

                self.velY = self.maxSpeed
                
            end
        
        end 


    elseif love.keyboard.isDown("up","w") and not love.keyboard.isDown('f')and not love.keyboard.isDown('g') and self.y > 750 and GPressed == false then
        self.state = "right"
        if self.velY > -self.maxSpeed then
            if self.velY - self.acceleration *dt > -self.maxSpeed then
            self.velY = self.velY - self.acceleration * dt
                else

                    self.velY = -self.maxSpeed
                
            end
        end
    
    else
        self:applyFriction(dt)
    end
    if not love.keyboard.isDown("left","right","up","down","a","d","w","s","f","g") and GPressed == false then
        self.state = "still"
    end
end





   function Player:applyFriction(dt)
        if self.velX > 0 then
            if self.velX - self.friction * dt > 0 then
                self.velX = self.velX - self.friction * dt 
            else 
                self.velX = 0
            end
        elseif self.velX < 0 then
            if self.velX + self.friction * dt < 0 then
                self.velX = self.velX + self.friction * dt
            else
                self.velX = 0
            end
        end

        if self.velY > 0 then
            if self.velY - self.friction * dt > 0 then
                self.velY = self.velY - self.friction * dt 
            else 
                self.velY = 0
            end
        elseif self.velY < 0 then
            if self.velY + self.friction * dt < 0 then
                self.velY = self.velY + self.friction * dt
            else
                self.velY = 0
            end
        end
   end
   

   



function Player:jump(key)

    if (key == 'space') then
        if self.grounded == true then
            self.grounded = false
             self.velY = self.jump_amount
            elseif self.doublejump == true then
                
                self.doublejump = false
                self.velY = self.jump_amount * 0.8
            
        end
    end

end

function Player:normal(key)
     if (key == 'g') then
        GPressed = true
    end
end



function temp_jumpcheck(dt) --get rid of this as soon as u find a way to check for Z axis

    if self.y < 600 then
    self.grounded = false
    self:applyGravity()

    end

end



function Player:applyGravity(dt)
    if self.y < 600 then -- temp if statement
    self.velY = self.velY + self.gravity * dt
    end
end

function Player:draw()
     
    cam:attach()
   
    love.graphics.draw(background,0,-400,nil,4.0,4.0)
    
    
   
    for i = 1,3 do

        if self.active == i and self.state == "right" then
       self.character[i].animations.forward:draw(self.character[i].forwardSheet,self.x,self.y,nil,3.0,nil,80,90)

        elseif self.active == i and self.state == "left" then

        self.character[i].animations.forward:draw(self.character[i].forwardSheet,self.x,self.y,nil,-3.0,3.0,80,90)


        elseif self.active == i and self.state == "rightspecial" then

        love.graphics.draw(errorImg,self.x,self.y,nil,1.0,nil,80,90)

        elseif self.active == i and self.state == "leftspecial" then

        love.graphics.draw(errorImg,self.x,self.y,nil,1.0,nil,80,90)

        elseif self.active == i and self.state == "rightnormal" then

        self.character[i].animations.forwardNormal:draw(self.character[i].forwardNormalSheet,self.x,self.y,nil,3.0,3.0,80,90)

        elseif self.active == i and self.state == "leftnormal" then

        self.character[i].animations.forwardNormal:draw(self.character[i].forwardNormalSheet,self.x,self.y,nil,-3.0,3.0,80,90)

        elseif self.active ==i and self.facing == "right" then
            
            
        self.character[i].animations.idle:draw(self.character[i].idleSheet,self.x,self.y,nil,3.0,nil,80,90)
    
        elseif self.active ==i and self.facing == "left" then
            
            
        self.character[i].animations.idle:draw(self.character[i].idleSheet,self.x,self.y,nil,-3.0,3.0,80,90)
    
            
        end
    end
    
    hitBoxesDraw()
    cam:detach()
   
    
end


function Player:beginContact(a, b, collision)
        if a == floor.physics.fixture or b == floor.physics.fixture then
            if a == Player.physics.fixture or b == Player.physics.fixture then
                self:land(collision)
                return true
           
            end
        end
end
function Player:endContact(a, b, collision)
       if a == self.physics.fixture or b == self.physics.fixture then
           if self.currentGroundCollision == collision then
               self.grounded = false
           end 
       end
end

function Player:land(collision)
    self.currentGroundCollision = collision
    self.velY = 0
    self.grounded = true
    self.doublejump = true
end
function Player:takeDamage()
    if Player.character[1] and self.active == 1 then

        Player.character[1].health =Player.character[1].health -1 

    elseif Player.character[2] and self.active == 2 then

        Player.character[2].health =Player.character[2].health -1

    elseif Player.character[3] and self.active == 3 then

        Player.character[3].health =Player.character[3].health -1

    end
end