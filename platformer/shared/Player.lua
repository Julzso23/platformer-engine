local class = include('middleclass')

local Collideable = include('shared.Collideable')

local Player = class('Player', Collideable)

function Player:initialize()
    Collideable.initialize(self, 64, 64)
end

return Player
