  require'characters/player'

    anim8 = require 'libraries/anim8'
    camera = require 'libraries/camera'
  
    require 'map'
    local w = require 'world'
    local m = require 'menu/menu'
    local d = require 'dBug'
    local e = require 'enemy/enemy'
    local h = require 'hitbox'
    local u = require 'ui/ui'
    
    local cron = require'libraries/cron'
    local seconds = 0
    local timer = cron.every(0.75, function () seconds = seconds + 0.75 grounded = true world:setGravity(0,0) end)


function love.load()
    state = "startscreen"
    world = love.physics.newWorld(0,0)
    world:setCallbacks(beginContact,endContact)
    world_load()
    camera = require 'libraries/camera'
    cam = camera()
    love.graphics.setDefaultFilter("nearest","nearest")
    --love.window.setFullscreen(true, "exclusive")
    background = love.graphics.newImage('sprites/background.png')
    Player:load()
    menu_load()
    Enemy:load()
    UI_load()
end
   
       
    
function love.update(dt)

    menu_update(dt)

    if Player.grounded == false  then 
        timer:update(dt)
    end


    update_moves(dt)

    update_animations(dt)

    Player:update(dt)

    world_update(dt)  
    
    Enemy:updateAll(dt)

    UI_update(dt)

   Camera_setPosition()
    
   
end

function love.draw()

menu_draw()

cam:attach()


    Enemy:drawAll()



cam:detach()
debugDraw()
Enemy:print()
UI_draw()
end

function love.keypressed(key)
Player:jump(key)
Player:normal(key)
end

function love.keyreleased(key)
Player:normal(key)
end


function beginContact(a, b, collision,instanceOfEnemy)

    if Enemy:beginContact(a,b,collision) then return  end

    if Enemy:Hitbox_beginContact_PlayerToEnemy(a,b,collision) then return end

    if Hitbox.beginContact_EnemyToPlayer(a,b,collision) then Player:takeDamage() return end
    Player:beginContact(a, b, collision)
    
   
end
function endContact(a, b, collision)
    Player:endContact(a, b, collision)
    
end