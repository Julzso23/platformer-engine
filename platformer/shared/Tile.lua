local class = include('middleclass')

local Collideable = include('shared.Collideable')

local Tile = class('Tile', Collideable)

function Tile:initialize(x, y, w, h)
    Collideable.initialize(self, w * config.tileSize, h * config.tileSize)
    self:teleportTo(x * config.tileSize, y * config.tileSize)
end

return Tile
