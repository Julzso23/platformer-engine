local class = include('middleclass')

local Transformable = include('shared.Transformable')

local Tile = class('Tile', Transformable)

function Tile:initialize()
    Transformable.initialize(self)
end

return Tile
