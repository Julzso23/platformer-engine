local class = include('middleclass')

local msgpack = include('MessagePack')

local Tile = include('shared.Tile')

local World = class('World')

function World:initialize()
    self.tiles = {}
end

function World:addTile(x, y, w, h)
    table.insert(self.tiles, Tile:new(x, y, w, h))
end

function World:removeTile(x, y)
    for k, v in pairs(self.tiles) do
        if (x >= v.position.x) and (x < v.position.x + v.width) and (y >= v.position.y) and (y < v.position.y + v.height) then
            table.remove(self.tiles, k)
        end
    end
end

function World:save(path)
    local data = {}
    for k, v in pairs(self.tiles) do
        local pos = v:getPosition()
        table.insert(data, {
            x = (pos.x - pos.x % config.tileSize) / config.tileSize,
            y = (pos.y - pos.y % config.tileSize) / config.tileSize,
            w = v.width / config.tileSize,
            h = v.height / config.tileSize
        })
    end
    data = msgpack.pack(data)
    if not love.filesystem.exists('maps') then
        love.filesystem.createDirectory('maps')
    end
    love.filesystem.write('maps/' .. path, data)
end

function World:load(path)
    local data = msgpack.unpack(love.filesystem.read('maps/' .. path))
    for k, v in pairs(data) do
        self:addTile(v.x, v.y, v.w, v.h)
    end
end

return World
