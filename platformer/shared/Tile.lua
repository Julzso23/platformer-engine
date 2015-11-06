local class = include('middleclass')

local Collideable = include('shared.Collideable')

local Tile = class('Tile', Collideable)

function Tile:initialize()
    Collideable.initialize(self, 64, 64)
end

return Tile
