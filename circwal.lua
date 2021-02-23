--  circwal.lua
--  © Zach Nielsen 2021
--

require("math")

local CircWal = {}

function CircWal.moveUp(cw, amount, limit)
    local wall_limit = limit -- + self.radius
    cw:setY(math.max(wall_limit, cw:getY() - amount))
end
function CircWal.moveDown(cw, amount, limit)
    local wall_limit = limit -- - self.radius
    cw:setY(math.min(wall_limit, cw:getY() + amount))
end
function CircWal.moveLeft(cw, amount, limit)
    local wall_limit = limit -- + self.radius
    cw:setX(math.max(wall_limit, cw:getX() - amount))
end
function CircWal.moveRight(cw, amount, limit)
    local wall_limit = limit -- radius
    cw:setX(math.min(wall_limit, cw:getX() + amount))
end


function CircWal.rotateLeft(cw, amount)
    cw:setAngle(cw:getAngle() - amount)
end
function CircWal.rotateRight(cw, amount)
    cw:setAngle(cw:getAngle() + amount)
end
function CircWal.moveForward(cw, amount)
	local xComp = amount * math.cos(cw:getAngle())
	local yComp = amount * math.sin(cw:getAngle())
    print(xComp)
    print(yComp)
    cw:setLinearVelocity(xComp, yComp)
end
function CircWal.moveBackward(cw, amount)
	local xComp = amount * math.cos(cw:getAngle() + math.pi)
	local yComp = amount * math.sin(cw:getAngle() + math.pi)
    print(xComp)
    print(yComp)
    cw:setLinearVelocity(xComp, yComp)
end


function CircWal.setBorders(window_width, window_height)
    box_body = love.physics.newBody(world, 0,0, "static")
    box_left = love.physics.newRectangleShape (-5,             window_height/2, 5, window_height)
    box_right = love.physics.newRectangleShape(window_width+5, window_height/2, 5, window_height)
    box_top = love.physics.newRectangleShape   (window_width/2, -5,              window_width, 5)
    box_bottom = love.physics.newRectangleShape(window_width/2, window_height+5, window_width, 5)
    box_fixture_left = love.physics.newFixture(box_body, box_left)
    box_fixture_right = love.physics.newFixture(box_body, box_right)
    box_fixture_top = love.physics.newFixture(box_body, box_top)
    box_fixture_bottom = love.physics.newFixture(box_body, box_bottom)
    box_fixture_left:setUserData("window_border")
    box_fixture_right:setUserData("window_border")
    box_fixture_top:setUserData("window_border")
    box_fixture_bottom:setUserData("window_border")
end


return CircWal
