local class = include('middleclass')

local Transformable = class('Transformable')

function Transformable:initialize()
    self.position = {}
    self.position.x = 0
    self.position.y = 0
end

function Transformable:setPosition(x, y)
    self.position.x = x
    self.position.y = y
end

function Transformable:getPosition()
    return self.position
end

function Transformable:move(x, y)
    self.position.x = self.position.x + x
    self.position.y = self.position.y + y
end

return Transformable
