
CircWal = require("circwal")

function love.load()
    local radius = 20
    width, height = love.graphics.getDimensions()
    p1 = CircWal:new()
    p1.position.x = width - radius*2
    p1.position.y = height - radius*2
    p1.radius = radius
    p2 = CircWal:new()
    p2.position.x = radius*2
    p2.position.y = radius *2
    p2.radius = radius
end

function love.update(dt)
    local move_amount = 500 * dt
    width, height = love.graphics.getDimensions()

    if love.keyboard.isDown("up") then
        p1:moveUp(move_amount, 0)
    end
    if love.keyboard.isDown("down") then
        p1:moveDown(move_amount, height)
    end
    if love.keyboard.isDown("left") then
        p1:moveLeft(move_amount, 0)
    end
    if love.keyboard.isDown("right") then
        p1:moveRight(move_amount, width)
    end
    if love.keyboard.isDown("f") then
        p2:moveUp(move_amount, 0)
    end
    if love.keyboard.isDown("s") then
        p2:moveDown(move_amount, height)
    end
    if love.keyboard.isDown("r") then
        p2:moveLeft(move_amount, 0)
    end
    if love.keyboard.isDown("t") then
        p2:moveRight(move_amount, width)
    end
end

function love.draw()
    local num_sides = 100
    love.graphics.setColor(0, 1, 0)
    love.graphics.circle("fill", p1.position.x, p1.position.y, p1.radius, num_sides)
    love.graphics.setColor(1, 0, 0)
    love.graphics.circle("fill", p2.position.x, p2.position.y, p1.radius, num_sides)
end
