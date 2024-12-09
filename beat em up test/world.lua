require 'libraries/windfield'
require 'libraries/camera'


function world_load()
    floor = {}
    floor.physics= {}
    floor.physics.body =love.physics.newBody(world,0,1225,"static")
    floor.physics.shape =love.physics.newRectangleShape(8000,love.graphics.getHeight())
    floor.physics.fixture = love.physics.newFixture(floor.physics.body,floor.physics.shape)
    floor.physics.fixture:setSensor(true)
end

function world_update(dt)
    
world:update(dt)

end

function world_draw()

end