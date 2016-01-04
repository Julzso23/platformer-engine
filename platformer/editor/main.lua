function love.load(args)
    mouseButtons = {'l', 'r', 'm'}

    love.window.setTitle('Platformer engine - editor')

    local textures = include('shared.textures')
    textures.loadAll()

    local World = include('shared.World')
    world = World:new()

    local Brush = include('editor.Brush')
    brush = Brush:new()
    brush.onStop = function(self, rectangle)
        if rectangle.w ~= 0 and rectangle.h ~= 0 then
            world:addTile(rectangle.x, rectangle.y, rectangle.w, rectangle.h, textures[rectangle.texture])
        end
    end
    brush:setTexture('grass')

    editorPosition = {
        x = 0,
        y = 0
    }

    local KeyCommand = include('shared.KeyCommand')
    keyCommands = {}

    require('libraries.loveframes')

    guis = {}
    guis.anyOpen = function()
        for k, v in pairs(guis) do
            if type(v) == 'table' and v:isOpen() then
                return true
            end
        end
        return false
    end

    -- Save
    guis.save = include('editor.SaveGui'):new()

    keyCommands.saveCommand = KeyCommand:new({'lctrl', 's'}, function()
        if not guis.anyOpen() then
            guis.save:open()
        end
    end)

    -- Load
    guis.load = include('editor.LoadGui'):new()

    keyCommands.loadCommand = KeyCommand:new({'lctrl', 'o'}, function()
        if not guis.anyOpen() then
            guis.load:open()
        end
    end)

    -- Select tile
    guis.selectTile = include('editor.SelectTileGui'):new()

    keyCommands.selectTileCommand = KeyCommand:new({'tab'}, function()
        if not guis.anyOpen() then
            guis.selectTile:open()
        end
    end)

    local minimiseButton = loveframes.Create('button')
    minimiseButton:SetText('-')
    minimiseButton:SetWidth(minimiseButton:GetHeight())
    minimiseButton:SetPos(love.graphics.getWidth() - minimiseButton:GetWidth() * 2, 0)
    minimiseButton.OnClick = function(self, link)
        love.window.minimize()
    end
    local closeButton = loveframes.Create('button')
    closeButton:SetText('X')
    closeButton:SetWidth(closeButton:GetHeight())
    closeButton:SetPos(love.graphics.getWidth() - closeButton:GetWidth(), 0)
    closeButton.OnClick = function(self, link)
        love.event.quit()
    end
end

function love.update(dt)
    loveframes.update(dt)

    if not guis.anyOpen() then
        if love.keyboard.isDown('left') then
            editorPosition.x = editorPosition.x + 200 * dt
        end
        if love.keyboard.isDown('right') then
            editorPosition.x = editorPosition.x - 200 * dt
        end
        if love.keyboard.isDown('up') then
            editorPosition.y = editorPosition.y + 200 * dt
        end
        if love.keyboard.isDown('down') then
            editorPosition.y = editorPosition.y - 200 * dt
        end
    end
end

function love.draw()
    love.graphics.push()
    love.graphics.translate(editorPosition.x, editorPosition.y)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('line', brush:getRectangle().x * config.tileSize, brush:getRectangle().y * config.tileSize, brush:getRectangle().w * config.tileSize, brush:getRectangle().h * config.tileSize)

    world:draw()

    love.graphics.setColor(255, 255, 255, 128)
    love.graphics.line(0, -10, 0, 10)
    love.graphics.line(-10, 0, 10, 0)

    love.graphics.pop()

    love.graphics.setColor(50, 50, 50, 200)
    love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), 26)

    loveframes.draw()
end

function love.mousepressed(x, y, button)
    button = mouseButtons[button]
    if button == 'l' and y > 26 and not guis.anyOpen() then
        brush:start()
        local x = x - editorPosition.x
        x = (x - x % config.tileSize) / config.tileSize
        local y = y - editorPosition.y
        y = (y - y % config.tileSize) / config.tileSize
        brush:setPosition(1, x, y)
        brush:setPosition(2, x, y)
    end

    loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
    button = mouseButtons[button]
    if y > 26 and not guis.anyOpen() then
        if button == 'l' then
            brush:stop()
        end

        if button == 'r' then
            world:removeTile(x - editorPosition.x, y - editorPosition.y)
        end
    end

    loveframes.mousereleased(x, y, button)
end

function love.mousemoved(x, y, dx, dy)
    if love.mouse.isDown(1) then
        local x = x - editorPosition.x
        x = (x - x % config.tileSize) / config.tileSize
        local y = y - editorPosition.y
        y = (y - y % config.tileSize) / config.tileSize
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
