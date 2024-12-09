--several UI Assets by @Nightquota
require 'characters/justice'
require 'characters/valery'
require 'characters/rory'
function UI_load()
    healthbars_zlist = {}
healthbars = {
    justice.healthbar,
    valery.healthbar,
    rory.healthbar
}

end

function UI_update(dt)
   
    
    
end

function UI_draw()

local screenWidth = love.graphics.getWidth()
local screenHeight = love.graphics.getHeight()

love.graphics.print("Health: " .. Player.health,screenWidth-500,100)

UI_Healthbars() 

end

function UI_Healthbars()
  if state=="startscreen" or state == "playing" then

   if Player.character[1] ~= nil then
       local c = Player.character[1].health
   end



    local color = {2-2*1,2*1,0}
        for i,v in ipairs(healthbars) do
            if Player.character[3] then

                local  hx3 = 475
                local px3 = 410
                if Player.active == 1 then
                    hx3 =  475
                    px3 =  410
                elseif Player.active == 2 then
                    hx3 =  275
                    px3 =  210
                elseif Player.active == 3 then
                    hx3 = 100
                    px3 = 10
                end
                love.graphics.setColor(0.2,0.2,0.2)
                love.graphics.rectangle('fill',hx3,135,Player.character[3].max_health-18,35)
                love.graphics.setColor(color)
                love.graphics.rectangle('fill',hx3,135,Player.character[3].health-18,35)
                love.graphics.setColor(1,1,1)
                love.graphics.draw(healthbars[3],px3,20,nil,3.0,3.0,nil,nil)

                
            end
            if Player.character[2] then

                local hx2 = 275
                local px2 = 210
                if Player.active == 1 then
                    hx2 = 275
                    px2 = 210
                elseif Player.active == 2 then
                    hx2 = 100
                    px2 = 10
                elseif Player.active == 3 then
                    hx2=475
                    px2= 410
                end
                love.graphics.setColor(0.2,0.2,0.2)
                love.graphics.rectangle('fill',hx2,135,Player.character[2].max_health-18,35)
                love.graphics.setColor(color)
                love.graphics.rectangle('fill',hx2,135,Player.character[2].health-18,35)
                love.graphics.setColor(1,1,1)
                love.graphics.draw(healthbars[2],px2,20,nil,3.0,3.0,nil,nil)

                --table.sort(healthbars,UI_XOrder)
            end
            if Player.character[1] then
                local hx1 =100 --healthbar x1
                local px1 = 10 --plate x1
                if Player.active == 1 then
                    hx1 = 100
                    px1 = 10
                elseif Player.active == 2 then
                    hx1 = 475
                    px1 = 410
                elseif Player.active == 3 then
                    hx1=275
                    px1=210
                end
                love.graphics.setColor(0.2,0.2,0.2)
                love.graphics.rectangle('fill',hx1,135,Player.character[1].max_health-18,35)
                love.graphics.setColor(color)
                love.graphics.rectangle('fill',hx1,135,Player.character[1].health-18,35)
                love.graphics.setColor(1,1,1)
                love.graphics.draw(healthbars[1],px1,20,nil,3.0,3.0,nil,nil)
            
                --table.sort(healthbars,UI_XOrder)

            end
        end

    end
end



 


 
 


