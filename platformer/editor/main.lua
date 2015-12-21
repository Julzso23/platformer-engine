function love.load(args)
    love.window.setTitle('Platformer engine - editor')

    local World = include('shared.World')
    world = World:new()

    local Brush = include('editor.Brush')
    brush = Brush:new()
    brush.onStop = function(self, rectangle)
        if rectangle.w ~= 0 and rectangle.h ~= 0 then
            world:addTile(rectangle.x, rectangle.y, rectangle.w, rectangle.h)
        end
    end

    editorPosition = {
        x = 0,
        y = 0
    }

    local KeyCommand = include('shared.KeyCommand')
    keyCommands = {}

    require('libraries.loveframes')

    -- Save
    saveGui = include('editor.SaveGui'):new()

    keyCommands.saveCommand = KeyCommand:new({'lctrl', 's'}, function()
        saveGui:open()
    end)

    -- Load
    loadGui = include('editor.LoadGui'):new()

    keyCommands.loadCommand = KeyCommand:new({'lctrl', 'o'}, function()
        loadGui:open()
    end)
end

function love.update(dt)
    loveframes.update(dt)

    if love.keyboard.isDown('a') then
        editorPosition.x = editorPosition.x + 200 * dt
    end
    if love.keyboard.isDown('d') then
        editorPosition.x = editorPosition.x - 200 * dt
    end
    if love.keyboard.isDown('w') then
        editorPosition.y = editorPosition.y + 200 * dt
    end
    if love.keyboard.isDown('s') then
        editorPosition.y = editorPosition.y - 200 * dt
    end
end

function love.draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('line', brush:getRectangle().x * config.tileSize, brush:getRectangle().y * config.tileSize, brush:getRectangle().w * config.tileSize, brush:getRectangle().h * config.tileSize)

    love.graphics.push()
    love.graphics.translate(editorPosition.x, editorPosition.y)

    love.graphics.setColor(255, 255, 255, 128)
    love.graphics.line(0, -10, 0, 10)
    love.graphics.line(-10, 0, 10, 0)

    for k, v in pairs(world.tiles) do
        love.graphics.setColor(255, 0, 0, 255)
        love.graphics.rectangle('fill', v.position.x, v.position.y, v.width, v.height)
    end

    love.graphics.pop()

    love.graphics.setColor(50, 50, 50, 200)
    love.graphics.rectangle('fill', 0, 0, love.window.getWidth(), 26)

    loveframes.draw()
end

function love.mousepressed(x, y, button)
    if button == 'l' and y > 26 and not saveGui:isOpen() and not loadGui:isOpen() then
        brush:start()
        local x = (x - x % config.tileSize) / config.tileSize
        local y = (y - y % config.tileSize) / config.tileSize
        brush:setPosition(1, x, y)
        brush:setPosition(2, x, y)
    end

    loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    if y > 26 and not saveGui:isOpen() and not loadGui:isOpen() then
        if button == 'l' then
            brush:stop()
        end

        if button == 'r' then
            world:removeTile(x, y)
        end
    end

    loveframes.mousereleased(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    if love.mouse.isDown('l') then
        local x = (x - x % config.tileSize) / config.tileSize
        local y = (y - y % config.tileSize) / config.tileSize
        brush:setPosition(2, x, y)
    end
end

function love.keypressed(key, isRepeat)
    loveframes.keypressed(key, isRepeat)

    for k, v in pairs(keyCommands) do
        v:keyDown(key)
    end
end

function love.keyreleased(key)
    loveframes.keyreleased(key)

    for k, v in pairs(keyCommands) do
        v:keyUp(key)
    end
end

function love.textinput(text)
    loveframes.textinput(text)
end
