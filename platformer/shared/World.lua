local class = include('middleclass')

local World = class('World')

function World:initialize()
    self.tiles = {}
end

return World
