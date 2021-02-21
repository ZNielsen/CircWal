--  circwal.lua
--  © Zach Nielsen 2021
--
--  Modlue/Class Table

require("math")

local CircWal = {
    position = {x = nil, y = nil},
    radius = nil
}

function CircWal:moveUp(amount, limit)
    local wall_limit = limit + self.radius
    self.position.y = math.max(wall_limit, self.position.y - amount)
end
function CircWal:moveDown(amount, limit)
    local wall_limit = limit - self.radius
    self.position.y = math.min(wall_limit, self.position.y + amount)
end
function CircWal:moveLeft(amount, limit)
    local wall_limit = limit + self.radius
    self.position.x = math.max(wall_limit, self.position.x - amount)
end
function CircWal:moveRight(amount, limit)
    local wall_limit = limit - self.radius
    self.position.x = math.min(wall_limit, self.position.x + amount)
end

function CircWal:new(o)
    local o = o or {}
    setmetatable(o, {__index = self})
    o.position = {x = 0, y = 0}
    o.radius = 20
    return o
end

return CircWal
