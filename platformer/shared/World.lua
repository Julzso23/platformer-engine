local class = include('middleclass')

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

return World
