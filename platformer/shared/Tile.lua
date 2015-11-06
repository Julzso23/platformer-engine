local class = include('middleclass')

local Collideable = include('shared.Collideable')

local Tile = class('Tile', Collideable)

function Tile:initialize(x, y)
    Collideable.initialize(self, 64, 64)
    self:teleportTo(x, y)
end

return Tile
