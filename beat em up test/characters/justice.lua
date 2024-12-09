require 'hitbox'
function justice_load()

    
--justice character

justiceSideNormalCD = 0

justice = {}
justice.speed = 1000
justice.sprite = love.graphics.newImage('sprites/justice/justice.png')
justice.forwardSheet = love.graphics.newImage('sprites/justice/justice-walk.png')
justice.idleSheet = love.graphics.newImage('sprites/justice/justice-idle.png')
justice.forwardNormalSheet = love.graphics.newImage('sprites/justice/justice-side-special.png')
justice.forwardgrid = anim8.newGrid(160,160,justice.forwardSheet:getWidth(),justice.forwardSheet:getHeight() )
justice.idlegrid = anim8.newGrid(160,160,justice.idleSheet:getWidth(),justice.idleSheet:getHeight())
justice.forwardNormalgrid = anim8.newGrid(160,160,justice.forwardNormalSheet:getWidth(),justice.forwardNormalSheet:getHeight())
justice.portrait = love.graphics.newImage('sprites/justice/justice-portrait.png')
justice.healthbar = love.graphics.newImage('sprites/justice/justice-healthbar.png')
justice.max_health = 300
justice.health = 300



justice.animations = {}
justice.animations.forward = anim8.newAnimation(justice.forwardgrid('1-8',1),0.055)
justice.animations.idle = anim8.newAnimation(justice.idlegrid('1-4',1),0.1)
justice.animations.forwardNormal=anim8.newAnimation(justice.forwardNormalgrid('1-15',1),0.1)



end

function justice_animations_update(dt)
    justice.animations.forward:update(dt)
    justice.animations.idle:update(dt)
    justice.animations.forwardNormal:update(dt)
end

function justice_moves_update(dt)

    local SNFrame = justice.animations.forwardNormal.position
   
        if GPressed == true and Player.character[1] == justice and Player.active == 1 or Player.character[2] == justice and Player.active == 2 or Player.character[3] == justice and Player.active == 3 then
        
            justice_sidenormal(dt)

            if SNFrame == 15 then
            GPressed = false
            SNFrame = 1
            end
        end  
   




end



function justice_sidenormal(dt)

   
    
    
    justiceSideNormalCD = justiceSideNormalCD - 60 *dt

    if justiceSideNormalCD < 0 then
        justiceSideNormalCD = 0
    
    end

       if GPressed == true and Player.state == "right" and justiceSideNormalCD == 0 then
      
         Player.state = "rightnormal"
      
         justice.animations.forwardNormal:gotoFrame(1)
         
         
        
         
        
        end
        Hitbox:JusticeRightNormal()
   
 

    if  GPressed == true and Player.state == "left" and justiceSideNormalCD == 0  then

        Player.state = "leftnormal"
      
        justice.animations.forwardNormal:gotoFrame(1)

    end
    Hitbox:JusticeLeftNormal()
end
    function Hitbox:JusticeRightNormal()

        local SNFrame = justice.animations.forwardNormal.position
     
        local hitboxCreated = false
        
        if Player.state == "rightnormal" and Player.character[1] == justice and Player.active == 1  or 
        Player.state == "rightnormal" and Player.character[2] == justice and Player.active == 2  or 
        Player.state == "rightnormal" and Player.character[3] == justice and Player.active ==3 then
             
             
            if  SNFrame == 5 and hitboxCreated == false then
                
                self.new(Player.x+250,Player.y-100,250,75)

                hitboxCreated = true

            elseif SNFrame == 8 then
                
                self.toBeRemoved = true
                self:checkRemove()
                hitboxCreated = false
            
            elseif SNFrame == 13 then
                self.new(Player.x+150,Player.y-100,300,350)
                hitboxCreated = true
            elseif SNFrame >= 14 then
                self.toBeRemoved = true
                self:checkRemove()
                hitboxCreated = false
            end
              
        end
        

    end

    function Hitbox:JusticeLeftNormal()

        local SNFrame = justice.animations.forwardNormal.position

    if Player.state == "leftnormal" and Player.character[1] == justice and Player.active == 1 or 
    Player.state == "leftnormal" and Player.character[2] == justice and Player.active == 2 or 
    Player.state == "leftnormal" and Player.character[3] == justice and Player.active ==3 then 

        if SNFrame ==5 then
            self.new(Player.x-250,Player.y-100,250,75)
        elseif SNFrame == 8 then
            self.toBeRemoved = true
            self:checkRemove()
        elseif SNFrame == 13 then
            self.new(Player.x-150,Player.y-100,300,350)
            hitboxCreated = true
        elseif SNFrame >= 14 then
            self.toBeRemoved = true
            self:checkRemove()
            hitboxCreated = false
        end

    end

end

