local class = include('middleclass')

local collision = include('shared.collision')

local Transformable = include('shared.Transformable')

local Collideable = class('Collideable', Transformable)

function Collideable:initialize(width, height)
    Transformable.initialize(self)
    self.width = width
    self.height = height
    self:worldAdd()
end

function Collideable:collisionEvent(side)
end

function Collideable:moveTo(x, y)
    local newX, newY, cols, len = collision.world:move(self, x, y)
    self:setPosition(newX, newY)

    for k, v in pairs(cols) do
        if v.move.x > 0 then
            self:collisionEvent('right')
        end
        if v.move.x < 0 then
            self:collisionEvent('left')
        end
        if v.move.y > 0 then
            self:collisionEvent('bottom')
        end
        if v.move.y < 0 then
            self:collisionEvent('top')
        end
    end
end

function Collideable:move(x, y)
    local pos = self:getPosition()
    self:moveTo(pos.x + x, pos.y + y)
end

function Collideable:teleportTo(x, y)
    self:setPosition(x, y)
    collision.world:update(self, x, y)
end

function Collideable:worldAdd()
    local pos = self:getPosition()
    collision.world:add(self, pos.x, pos.y, self.width, self.height)
end

function Collideable:worldRemove()
    collision.world:remove(self)
end

return Collideable