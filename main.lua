
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
    p2 = {}
    p1.name = "P1"
    p2.name = "P2"
    p1.initial_pos = {x=(window_width - radius*2), y=(window_height - radius*2), angle=math.pi*5/4}
    p2.initial_pos = {x=(radius*2), y=(radius*2), angle=math.pi*1/4}

    -- Construct the bodies
    for _,player in pairs({p1, p2}) do
        player.body = love.physics.newBody(world, 0,0, "dynamic")
        player.body:setMass(100)
        player.body:setAngularDamping(1)
        player.body:setUserData(player.name .. " body")
        player.circle = love.physics.newFixture(player.body, circle)
        player.circle:setUserData(player.name .. " circle")
        player.butt = love.physics.newFixture(player.body, butt)
        player.butt:setUserData(player.name .. " butt")
        player.horn = love.physics.newFixture(player.body, horn)
        player.horn:setUserData(player.name .. " horn")
        player.horn:setRestitution(0.5)
        -- Move + rotate now that the bodies are constructed
        player.body:setPosition(player.initial_pos.x, player.initial_pos.y)
        player.body:setAngle(player.initial_pos.angle)
        world:update(0)
    end

    -- Set colors - body, horn/butt
    p1.colors = {{0, 1, 0}, {1, 0, 1}}
    p2.colors = {{1, 0, 0}, {0, 1, 1}}

    -- Set controls
    p1.controls = {up="up", down="down", left="left", right="right"}
    p2.controls = {up="f",  down="s",    left="r",    right="t"}

    -- Draw a box around the window to keep the players penned in
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

function love.resize(width, height)
    -- Resize the box around the players
end

function love.update(dt)
    -- move_amount is velocity, so we don't need to factor in dt
    local move_amount = 500
    local rotate_amount = math.pi*3 * dt

    window_width, window_height = love.graphics.getDimensions()

    -- Adjust controls for each player
    for _,player in pairs({p1, p2}) do
        if love.keyboard.isDown(player.controls.up) then
            cw.moveForward(player.body, move_amount)
            local x, y = player.body:getPosition()
            print(player.name .. " position: " .. x .. "," .. y)
        elseif love.keyboard.isDown(player.controls.down) then
            cw.moveBackward(player.body, move_amount)
            local x, y = player.body:getPosition()
            print(player.name .. " position: " .. x .. "," .. y)
        else
            player.body:setLinearVelocity(0,0)
        end
        if love.keyboard.isDown(player.controls.left) then
            cw.rotateLeft(player.body, rotate_amount)
        end
        if love.keyboard.isDown(player.controls.right) then
            cw.rotateRight(player.body, rotate_amount)
        end
    end

    world:update(dt)
end

function love.draw()
    for id, body in pairs(world:getBodies()) do
        -- Set body colors
        local colors = {}
        if body:getUserData() == "P1 body" then
            colors = p1.colors
        else
            colors = p2.colors
        end

        -- Draw all shapes
        for idx, fixture in pairs(body:getFixtures()) do
            if fixture:getUserData() == "window_border" then break end
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
