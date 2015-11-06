local class = include('middleclass')

local Transformable = include('shared.Transformable')

local Player = class('Player', Transformable)

function Player:initialize()
    Transformable.initialize(self)
end

return Player
