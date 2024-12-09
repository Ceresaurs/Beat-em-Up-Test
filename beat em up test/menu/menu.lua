require 'characters/player'
require 'characters/justice'
require 'characters/valery'
require 'characters/rory'
require 'characters/nightshine'
require 'characters/sebastian'
function menu_load()
started = false
hovering = false
mouseOn = ""
hoverSFX = love.audio.newSource('sounds/hover.mp3','static')
hoverSFX:setVolume(0.2)
selectSFX = love.audio.newSource('sounds/select.mp3','static')
selectSFX:setVolume(0.2)
font = love.graphics.newFont('fonts/verminvibes.ttf',30)
love.graphics.setNewFont('fonts/verminvibes.ttf',90)

character_selection_fullscreen = love.graphics.newImage('ui/character-select-fullscreen.png')
music = {}
music.song = love.audio.newSource('sounds/song1.mp3',"stream")
music.song:setLooping(true)
music.song:play()
music.song:setVolume(0.05)
music.justiceTheme = love.audio.newSource('sounds/justice-theme.mp3',"stream")
end

function menu_update(dt)

playSounds()
menuReset()

end

function menu_draw()
    
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local leftDistance = screenWidth * 0.245 --distance to left corner of left collumn from screenWidth
    local rightDistance = screenWidth * 0.165 --distance to left corner of right collumn from screenWidth
    local upDistance = 100 --distance to left corner of both collumns from 0
    local gutter = 22 -- space between portraits
    local size = 128 -- size of portraits
    if state == "startscreen" then
       displayCharacters()
       

        love.graphics.setBackgroundColor(0.3,0.8,0.8)
        love.graphics.print("Choose Your Characters!",10,0)
           

        --character portraits
        love.graphics.draw(justice.portrait,screenWidth - leftDistance,upDistance,nil,2,nil)
        love.graphics.draw(valery.portrait,screenWidth - leftDistance+size+gutter,upDistance,nil,2,nil)
        love.graphics.draw(rory.portrait,screenWidth - leftDistance,upDistance+size+gutter,nil,2,nil)
        love.graphics.setColor(0.05,0.05,0.05)
        love.graphics.draw(beetle.portrait,screenWidth - leftDistance+size+gutter,upDistance+size+gutter,nil,2,nil)
        love.graphics.draw(puppet.portrait,screenWidth - leftDistance,upDistance + 2*size + 2*gutter,nil,2,nil)
        love.graphics.draw(dennis.portrait,screenWidth - leftDistance+size+gutter,upDistance + 2*size + 2*gutter,nil,2,nil)
        love.graphics.draw(nightshine.portrait,screenWidth - leftDistance,upDistance + 3*size + 3*gutter,nil,2,nil)
        love.graphics.draw(sebastian.portrait,screenWidth - leftDistance+size+gutter,upDistance + 3*size + 3*gutter,nil,2,nil)
        love.graphics.draw(justice.portrait,screenWidth - leftDistance,upDistance + 4*size + 4*gutter,nil,2,nil)
        love.graphics.draw(justice.portrait,screenWidth - leftDistance+size+gutter,upDistance + 4*size + 4*gutter,nil,2,nil)
        love.graphics.setColor(1,1,1)
        love.graphics.rectangle('fill',screenWidth - leftDistance+10,upDistance + 5*size + 5*gutter,256,100)
     
        local blue = {0,0,1}
        
            if Player.character[3] ~= nil then
            love.graphics.print({blue, "START"}, screenWidth - leftDistance + 10, upDistance + 5*size + 5*gutter)
            end
        
        portraitBorder()
        portraitBorderSelected()
    else
    Player:draw()
    world_draw()
    end
end

function menuReset()
    if love.keyboard.isDown("escape") then
        state = "startscreen"
        for i = 1,3 do
        Player.character[i] = nil
        end
        Enemy:spawn()
    end
end

function love.mousepressed(x,y,button,istouch)
    local mouseX, mouseY = love.mouse.getPosition()
    
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local leftDistance = screenWidth * 0.245 --distance to left corner of left collumn from screenWidth
    local rightDistance = screenWidth * 0.165 --distance to left corner of right collumn from screenWidth
    local upDistance = 100 --distance to left corner of both collumns from 0
    local gutter =  22 -- space between portraits
    local size = 128 -- size of portraits

    if state == "startscreen" then
       
            if button == 1 and  mouseX > screenWidth-leftDistance and mouseX < screenWidth - leftDistance + size and mouseY > upDistance and mouseY < upDistance+size 
            and Player.character[1] ~= justice and Player.character[2] ~= justice and Player.character[3] ~= justice then
            table.insert(Player.character,justice)
            selectSFX:play()
            
            end

            if button == 1 and mouseX > screenWidth - leftDistance+size+gutter and mouseX < screenWidth - leftDistance+size+gutter + size and mouseY > upDistance and mouseY < upDistance + size 
            and Player.character[1] ~= valery and Player.character[2] ~= valery and Player.character[3] ~= valery then
            table.insert(Player.character,valery)
            selectSFX:play()
            
            end

            if button == 1 and mouseX > screenWidth-leftDistance and mouseX < screenWidth-leftDistance+size and mouseY > upDistance + size + gutter and mouseY < upDistance + size + gutter + size
            and Player.character[1] ~= rory and Player.character[2] ~= rory and Player.character[3] ~= rory  then
            table.insert(Player.character,rory)
            selectSFX:play()
        
            end

            if button == 1 and mouseX > screenWidth - leftDistance+size+gutter and mouseX < screenWidth - leftDistance+size+gutter +size and mouseY > upDistance + size + gutter and mouseY < upDistance + size + gutter + size then
            table.insert(Player.character,beetle)
            selectSFX:play()
            
            end

            if button == 1 and mouseX > screenWidth-leftDistance  and mouseX < screenWidth-leftDistance +size and mouseY > 2*size + 2*gutter + upDistance and mouseY < 2*size + 2*gutter + upDistance + size then
            table.insert(Player.character,puppet)
           selectSFX:play()
           
            end

            if button == 1 and mouseX > screenWidth - leftDistance+size+gutter  and mouseX < screenWidth - leftDistance+size+gutter +size and mouseY > 2*size + 2*gutter + upDistance and mouseY < 2*size + 2*gutter + upDistance + size then
            table.insert(Player.character,dennis)
            selectSFX:play()
           
            end

            if button == 1 and mouseX > screenWidth-leftDistance  and mouseX < screenWidth-leftDistance +size and mouseY > 3*size + 3*gutter + upDistance and mouseY < 3*size + 3*gutter + upDistance + size then
            table.insert(Player.character,nightshine)
            selectSFX:play()

           
            end

    end
    
    if button ==1 and mouseX > screenWidth - leftDistance + 10 and mouseX < screenWidth - screenWidth * 0.1 and mouseY > upDistance + 5*size + 5*gutter and mouseY < upDistance + 6*size + 6*gutter - 50 
    and Player.character[1] ~= nil and Player.character[2] ~= nil and Player.character[3] ~= nil then
        state = "playing"
        selectSFX:play()
    end
    
end

function displayCharacters()
    local mouseX, mouseY = love.mouse.getPosition()
    
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local leftDistance = screenWidth * 0.245 --distance to left corner of left collumn from screenWidth
    local rightDistance = screenWidth * 0.165 --distance to left corner of right collumn from screenWidth
    local upDistance = 100 --distance to left corner of both collumns from 0
    local gutter =  22 -- space between portraits
    local size = 128 -- size of portraits
    love.graphics.draw(character_selection_fullscreen,0,0,nil,8.0,nil)
    love.graphics.rectangle('fill',screenWidth - 480 ,upDistance-10,300,750)

    debugDraw()

    --1440 90 1750 840
    if  mouseX > screenWidth-leftDistance and mouseX < screenWidth - leftDistance + size and mouseY > upDistance and mouseY < upDistance+size then
           
        justice.animations.idle:draw(justice.idleSheet,screenWidth/2-320,screenHeight/2 - 240,nil,3.0)
        love.graphics.printf("Justice",font,screenWidth/2.75,750,400,"center")
           
       
       
    end

        if  mouseX > screenWidth - leftDistance+size+gutter and mouseX < screenWidth - leftDistance+size+gutter + size and mouseY > upDistance and mouseY < upDistance + size  then
            valery.animations.idle:draw(valery.idleSheet,screenWidth/2-320,screenHeight/2 - 240,nil,3.0)
            love.graphics.printf("Valery",font,screenWidth/2.75,750,400,"center")
           
        end

        if  mouseX > screenWidth-leftDistance and mouseX < screenWidth-leftDistance+size and mouseY > upDistance + size + gutter and mouseY < upDistance + size + gutter + size  then
            rory.animations.idle:draw(rory.idleSheet,screenWidth/2-320,screenHeight/2 - 240,nil,3.0)
            love.graphics.printf("Rory",font,screenWidth/2.75,750,400,"center")
          
        end

        if mouseX > screenWidth - leftDistance+size+gutter and mouseX < screenWidth - leftDistance+size+gutter+size and mouseY > upDistance + size + gutter and mouseY < upDistance + size + gutter + size then
            love.graphics.draw(beetle.sprite,screenWidth/2-320,screenHeight/2 - 240,nil,3.0)
            love.graphics.printf("Beetle",font,screenWidth/2.75,750,400,"center")
           
        end

        if mouseX > screenWidth-leftDistance  and mouseX < screenWidth-leftDistance +size and mouseY > 2*size + 2*gutter + upDistance and mouseY < 2*size + 2*gutter + upDistance + size then
            love.graphics.draw(puppet.sprite,screenWidth/2-320,screenHeight/2 - 240,nil,3.0)
            love.graphics.printf("Alice",font,screenWidth/2.75,750,400,"center")
          
        end

        if mouseX > screenWidth - leftDistance+size+gutter  and mouseX < screenWidth - leftDistance+size+gutter +size and mouseY > 2*size + 2*gutter + upDistance and mouseY < 2*size + 2*gutter + upDistance + size then
            love.graphics.draw(dennis.sprite,screenWidth/2-320,screenHeight/2 - 240,nil,3.0)
            love.graphics.printf("Dennis",font,screenWidth/2.75,750,400,"center")
            
        end

        if mouseX > screenWidth-leftDistance  and mouseX < screenWidth-leftDistance +size and mouseY > 3*size + 3*gutter + upDistance and mouseY < 3*size + 3*gutter + upDistance + size then
            nightshine.animations.idle:draw(nightshine.idleSheet,screenWidth/2-320,screenHeight/2 - 240,nil,3.0)
            love.graphics.printf("Nightshine",font,screenWidth/2.75,750,400,"center")
            
        end
end

function playSounds()
    local mouseX, mouseY = love.mouse.getPosition()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local leftDistance = screenWidth * 0.245 --distance to left corner of left collumn from screenWidth
    local rightDistance = screenWidth * 0.165 --distance to left corner of right collumn from screenWidth
    local upDistance = 100 --distance to left corner of both collumns from 0
    local gutter =  22 -- space between portraits
    local size = 128 -- size of portraits
    if state == "startscreen" then
    if  mouseX > screenWidth-leftDistance and mouseX < screenWidth - leftDistance + size and mouseY > upDistance and mouseY < upDistance+size and hovering ~= "Justice" then
        hoverSFX:play()
        hovering = "Justice"
    end
    if  mouseX > screenWidth - leftDistance+size+gutter and mouseX < screenWidth - leftDistance+size+gutter + size and mouseY > upDistance and mouseY < upDistance + size and hovering ~= "Valery"   then
         hoverSFX:play()
        hovering = "Valery"
       
    end

    if  mouseX > screenWidth-leftDistance and mouseX < screenWidth-leftDistance+size and mouseY > upDistance + size + gutter and mouseY < upDistance + size + gutter + size and hovering ~= "Rory" then
         hoverSFX:play()
        hovering = "Rory"
      
    end

    if mouseX > screenWidth - leftDistance+size+gutter and mouseX < screenWidth - leftDistance+size+gutter+size and mouseY > upDistance + size + gutter and mouseY < upDistance + size + gutter + size and hovering ~= "Beetle" then
    
        hoverSFX:play()
        hovering = "Beetle"
    end

    if mouseX > screenWidth-leftDistance  and mouseX < screenWidth-leftDistance +size and mouseY > 2*size + 2*gutter + upDistance and mouseY < 2*size + 2*gutter + upDistance + size and hovering ~= "Alice" then
         hoverSFX:play()
        hovering = "Alice"
      
    end

    if mouseX > screenWidth - leftDistance+size+gutter  and mouseX < screenWidth - leftDistance+size+gutter +size and mouseY > 2*size + 2*gutter + upDistance and mouseY < 2*size + 2*gutter + upDistance + size and hovering ~= "Dennis" then
        hoverSFX:play()
        hovering = "Dennis"
        
    end

    if mouseX > screenWidth-leftDistance  and mouseX < screenWidth-leftDistance +size and mouseY > 3*size + 3*gutter + upDistance and mouseY < 3*size + 3*gutter + upDistance + size and hovering ~= "Nightshine" then
         hoverSFX:play()
        hovering = "Nightshine"
    end
    elseif state == "playing" then
    music.song:setVolume(0)
    music.justiceTheme:play()
    music.justiceTheme:setLooping(true)
    music.justiceTheme:setVolume(0.1)
    end
end

function portraitBorder()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local leftDistance = screenWidth * 0.245 --distance to left corner of left collumn from screenWidth
    
    local upDistance = 100 --distance to left corner of both collumns from 0
    local gutter =  22 -- space between portraits
    local size = 128 -- size of portraits
    local border = love.graphics.newImage('ui/portrait-border.png')
    local borderSelected = love.graphics.newImage('ui/selected.png')
    local   jbx, jby = screenWidth - leftDistance,upDistance --justice border x, justice border y
    local    vbx, vby = screenWidth - leftDistance+size+gutter,upDistance
    local    rbx, rby = screenWidth - leftDistance,upDistance+size+gutter
    local  bbx, bby = screenWidth - leftDistance+size+gutter,upDistance+size+gutter
    local  abx, aby = screenWidth - leftDistance,upDistance + 2*size + 2*gutter
    local    dbx, dby = screenWidth - leftDistance+size+gutter,upDistance + 2*size + 2*gutter
    local   nbx, nby = screenWidth - leftDistance,upDistance + 3*size + 3*gutter
    local   sbx, sby = screenWidth - leftDistance+size+gutter,upDistance + 3*size + 3*gutter
    --local   _bx, _by = screenWidth - leftDistance,upDistance + 4*size + 4*gutter
    --local    _bx, _by = screenWidth - leftDistance+size+gutter,upDistance + 4*size + 4*gutter
        
    if hovering == "Justice" then
        love.graphics.draw(border,jbx,jby)
    end

    if hovering == "Valery" then
        love.graphics.draw(border,vbx,vby)
    end

    if hovering == "Rory" then
        love.graphics.draw(border,rbx,rby)
    end

    if hovering == "Beetle" then
        love.graphics.draw(border,bbx,bby)
    end

    if hovering == "Alice" then
        love.graphics.draw(border,abx,aby)
    end

    if hovering == "Dennis" then
        love.graphics.draw(border,dbx,dby)
    end

    if hovering == "Nightshine" then
        love.graphics.draw(border,nbx,nby)
    end 

    if hovering == "Sebastian" then
        love.graphics.draw(border,sbx,sby)
    end

end

function portraitBorderSelected()
    local screenWidth = love.graphics.getWidth()
    local screenHeight = love.graphics.getHeight()
    local leftDistance = screenWidth * 0.245 --distance to left corner of left collumn from screenWidth
    
    local upDistance = 100 --distance to left corner of both collumns from 0
    local gutter =  22 -- space between portraits
    local size = 128 -- size of portraits
    local border = love.graphics.newImage('ui/portrait-border.png')
    local borderSelected = love.graphics.newImage('ui/selected.png')
    local   jbx, jby = screenWidth - leftDistance,upDistance --justice border x, justice border y
    local    vbx, vby = screenWidth - leftDistance+size+gutter,upDistance
    local    rbx, rby = screenWidth - leftDistance,upDistance+size+gutter
    local  bbx, bby = screenWidth - leftDistance+size+gutter,upDistance+size+gutter
    local  abx, aby = screenWidth - leftDistance,upDistance + 2*size + 2*gutter
    local    dbx, dby = screenWidth - leftDistance+size+gutter,upDistance + 2*size + 2*gutter
    local   nbx, nby = screenWidth - leftDistance,upDistance + 3*size + 3*gutter
    local   sbx, sby = screenWidth - leftDistance+size+gutter,upDistance + 3*size + 3*gutter

    if Player.character[1] == justice then
        love.graphics.setColor(1,0.8,0)
        love.graphics.draw(borderSelected,jbx,jby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("01",font,jbx+15,jby+15,100)
    elseif Player.character[2] == justice then
        love.graphics.setColor(0,1,0)
        love.graphics.draw(borderSelected,jbx,jby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("02",font,jbx+10,jby+15,100)
    elseif Player.character[3] == justice then
        love.graphics.setColor(1,0,0.6)
        love.graphics.draw(borderSelected,jbx,jby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("03",font,jbx+10,jby+15,100)
    end

    if Player.character[1] == valery then
        love.graphics.setColor(1,0.8,0)
        love.graphics.draw(borderSelected,vbx,vby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("01",font,vbx+15,vby+15,100)
    elseif Player.character[2] == valery then
        love.graphics.setColor(0,1,0)
        love.graphics.draw(borderSelected,vbx,vby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("02",font,vbx+10,vby+15,100)
    elseif Player.character[3] == valery then
        love.graphics.setColor(1,0,0.6)
        love.graphics.draw(borderSelected,vbx,vby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("03",font,vbx+10,vby+15,100)
    end

    if Player.character[1] == rory then
        love.graphics.setColor(1,0.8,0)
        love.graphics.draw(borderSelected,rbx,rby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("01",font,rbx+15,rby+15,100)
    elseif Player.character[2] == rory then
        love.graphics.setColor(0,1,0)
        love.graphics.draw(borderSelected,rbx,rby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("02",font,rbx+10,rby+15,100)
    elseif Player.character[3] == rory then
        love.graphics.setColor(1,0,0.6)
        love.graphics.draw(borderSelected,rbx,rby)
        love.graphics.setColor(1,1,1)
        love.graphics.printf("03",font,rbx+10,rby+15,100)
    end
end