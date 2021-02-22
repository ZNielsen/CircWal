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


return CircWal
