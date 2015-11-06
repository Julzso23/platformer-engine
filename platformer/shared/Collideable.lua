local class = include('middleclass')

local collision = include('shared.collision')

local Transformable = include('shared.Transformable')

local Collideable = class('Collideable', Transformable)

function Collideable:initialize(width, height)
    Transformable.initialize(self)
    self.width = width
    self.height = height
    local pos = self:getPosition()
    collision.world:add(self, pos.x, pos.y, width, height)
end

function Collideable:moveTo(x, y)
    local newX, newY, cols, len = collision.world:move(self, x, y)
    self:setPosition(newX, newY)
end

function Collideable:move(x, y)
    local pos = self:getPosition()
    self:moveTo(pos.x + x, pos.y + y)
end

return Collideable
