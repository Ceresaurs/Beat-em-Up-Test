require 'hitbox'
function valery_load()
--valery character
valery={
    sprite=love.graphics.newImage('sprites/valery/valery.png')
}
valery.portrait = love.graphics.newImage('sprites/valery/valery-portrait.png')
valery.forwardSheet = love.graphics.newImage('sprites/valery/valery-walk.png')
valery.forwardgrid=anim8.newGrid(160,160,valery.forwardSheet:getWidth(),valery.forwardSheet:getHeight())
valery.idleSheet = love.graphics.newImage('sprites/valery/valery-idle.png')
valery.idlegrid=anim8.newGrid(160,160,valery.idleSheet:getWidth(),valery.idleSheet:getHeight())
valery.forwardNormalSheet = love.graphics.newImage('sprites/valery/valery-side-normal-Sheet.png')
valery.forwardNormalGrid = anim8.newGrid(320,160,valery.forwardNormalSheet:getWidth(),valery.forwardNormalSheet:getHeight())
valery.healthbar = love.graphics.newImage('sprites/valery/valery-healthbar.png')

valery.health = 300
valery.max_health = 300

valery.animations = {}
valery.animations.forward = anim8.newAnimation(valery.forwardgrid('1-8',1),0.1)
valery.animations.idle = anim8.newAnimation(valery.idlegrid('1-5',1),0.1)
valery.animations.forwardNormal = anim8.newAnimation(valery.forwardNormalGrid('1-9',1),0.08)



valerySideNormalCD = 0
valerySideNormalDuration = 4000
end

function valery_animations_update(dt)
    valery.animations.forward:update(dt)
    valery.animations.idle:update(dt)
    valery.animations.forwardNormal:update(dt)
end

function valery_moves_update(dt)
  
local SNFrame = valery.animations.forwardNormal.position
     
        if GPressed == true and Player.character[1] == valery and Player.active == 1 or Player.character[2] == valery and Player.active == 2 or Player.character[3] == valery and Player.active == 3 then

            valery_sidenormal(dt)

            if SNFrame == 9 then
                GPressed = false
                SNFrame = 1
            end
        end 
    
end


function valery_sidenormal(dt)
    
    valerySideNormalCD = valerySideNormalCD - 60 *dt

    if valerySideNormalCD < 0 then
        valerySideNormalCD = 0
    
    end

       if GPressed == true and Player.state == "right" and valerySideNormalCD == 0 then
      
         Player.state = "rightnormal"
      
         valery.animations.forwardNormal:gotoFrame(1)
         
         
        
         
        
        end
        Hitbox:ValeryRightNormal()
   
 

    if  GPressed == true and Player.state == "left" and valerySideNormalCD == 0  then

        Player.state = "leftnormal"
      
        valery.animations.forwardNormal:gotoFrame(1)

    end
    Hitbox:ValeryLeftNormal()
end
    function Hitbox:ValeryRightNormal()

        local SNFrame = valery.animations.forwardNormal.position
     
        local hitboxCreated = false
        
        if Player.state == "rightnormal" and Player.character[1] == valery and Player.active == 1  or 
        Player.state == "rightnormal" and Player.character[2] == valery and Player.active == 2  or 
        Player.state == "rightnormal" and Player.character[3] == valery and Player.active ==3 then
             
             
                if  SNFrame == 5 and hitboxCreated == false then
                
                self.new(Player.x+350,Player.y-100,600,50)

                hitboxCreated = true

              elseif SNFrame >= 8 then
                
                self.toBeRemoved = true
                self:checkRemove("ValerySideNormal")
                hitboxCreated = false
            
             
            end
              
        end
        

    end

    function Hitbox:ValeryLeftNormal()

        local SNFrame = valery.animations.forwardNormal.position

    if Player.state == "leftnormal" and Player.character[1] == valery and Player.active == 1 or 
    Player.state == "leftnormal" and Player.character[2] == valery and Player.active == 2 or 
    Player.state == "leftnormal" and Player.character[3] == valery and Player.active ==3 then 

        if SNFrame ==5 then
            self.new(Player.x-350,Player.y-100,600,50)
        elseif SNFrame >= 8 then
            self.toBeRemoved = true
            self:checkRemove(ValerySideNormal)

        end

    end

end
