
cw = require("circwal")

function love.load()
    -- Create the world
    world = love.physics.newWorld(0,0,true)
    world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    -- Create the shapes for the players
    local radius = 20
    circle = love.physics.newCircleShape(radius)
    horn = love.physics.newPolygonShape(radius*2, 0, 0, -(radius/2), 0, (radius/2))
    butt = love.physics.newRectangleShape(-radius, 0, 10, radius*2/3)

    -- Create the two player bodies
    window_width, window_height = love.graphics.getDimensions()
    p1 = {}
    p1.body = love.physics.newBody(world, 0,0, "dynamic")
    p1.body:setMass(100)
    p1.circle = love.physics.newFixture(p1.body, circle)
    p1.circle:setUserData("P1 circle")
    -- p1.circle:setCategory(1)
    -- p1.circle:setMask(1)
    p1.butt = love.physics.newFixture(p1.body, butt)
    p1.butt:setUserData("P1 butt")
    -- p1.butt:setCategory(1)
    -- p1.butt:setMask(1)
    p1.horn = love.physics.newFixture(p1.body, horn)
    p1.horn:setUserData("P1 horn")
    -- p1.horn:setCategory(1)
    -- p1.horn:setMask(1)
    p1.horn:setRestitution(0.5)
    -- Move + rotate now that the body is constructed
    p1.body:setPosition(window_width - radius*2, window_height - radius*2)
    p1.body:setAngle(math.pi*5/4)

    p2 = {}
    p2.body = love.physics.newBody(world, 0,0, "dynamic")
    p2.body:setMass(100)
    p2.circle = love.physics.newFixture(p2.body, circle)
    p2.circle:setUserData("P2 circle")
    -- p2.circle:setCategory(1)
    -- p2.circle:setMask(1)
    p2.butt = love.physics.newFixture(p2.body, butt)
    p2.butt:setUserData("P2 butt")
    -- p2.butt:setCategory(1)
    -- p2.butt:setMask(1)
    p2.horn = love.physics.newFixture(p2.body, horn)
    p2.horn:setUserData("P2 horn")
    -- p2.horn:setCategory(1)
    -- p2.horn:setMask(1)
    p2.horn:setRestitution(0.5)
    -- Move + rotate now that the body is constructed
    p2.body:setPosition(radius*2, radius*2)
    p2.body:setAngle(math.pi*1/4)
end

function love.update(dt)
    -- local move_amount = 500 * dt
    local move_amount = 500
    local rotate_amount = math.pi*3 * dt

    window_width, window_height = love.graphics.getDimensions()

    -- Player 1
    if love.keyboard.isDown("up") then
        cw.moveForward(p1.body, move_amount)
    elseif love.keyboard.isDown("down") then
        cw.moveBackward(p1.body, move_amount)
    else
        p1.body:setLinearVelocity(0,0)
    end

    if love.keyboard.isDown("left") then
        cw.rotateLeft(p1.body, rotate_amount)
    end

    if love.keyboard.isDown("right") then
        cw.rotateRight(p1.body, rotate_amount)
    end

    -- Player 2
    if love.keyboard.isDown("f") then
        cw.moveForward(p2.body, move_amount)
    elseif love.keyboard.isDown("s") then
        cw.moveBackward(p2.body, move_amount)
    else
        p2.body:setLinearVelocity(0,0)
    end

    if love.keyboard.isDown("r") then
        cw.rotateLeft(p2.body, rotate_amount)
    end

    if love.keyboard.isDown("t") then
        cw.rotateRight(p2.body, rotate_amount)
    end

    world:update(dt)
end

function love.draw()
    for id, body in pairs(world:getBodies()) do
        -- Set body colors
        local colors = {}
        if id == 1 then
            colors = {{0, 1, 0}, {1, 0, 1}}
        else
            colors = {{1, 0, 0}, {0, 1, 1}}
        end

        -- Draw all shapes
        for _, fixture in pairs(body:getFixtures()) do
            local shape = fixture:getShape()

            if shape:typeOf("CircleShape") then
                love.graphics.setColor(colors[1][1], colors[1][2], colors[1][3])
                local cx, cy = body:getWorldPoints(shape:getPoint())
                love.graphics.circle("fill", cx, cy, shape:getRadius())
            elseif shape:typeOf("PolygonShape") then
                love.graphics.setColor(colors[2][1], colors[2][2], colors[2][3])
                love.graphics.polygon("fill", body:getWorldPoints(shape:getPoints()))
            else
                love.graphics.line(body:getWorldPoints(shape:getPoints()))
            end
        end
    end
end

function beginContact(f1, f2, coll)
    print("Contact between " .. f1:getUserData() .. " and " .. f2:getUserData())
end

function endContact(f1, f2, coll)
    -- print("in endContact")
end

function preSolve(f1, f2, coll)
    -- print("in preSolve")
end

function postSolve(f1, f2, coll, normalimpulse, tangentimpulse)
    -- print("in postSolve")
end
