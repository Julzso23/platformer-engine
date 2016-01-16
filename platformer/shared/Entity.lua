local class = include('middleclass')

local Transformable = include('shared.Transformable')

local Entity = class('Entity', Transformable)

function Entity:initialize(name)
    Transformable.initialize(self)
    self.name = name
end

function Entity:draw()
    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('fill', self:getPosition().x, self:getPosition().y, config.tileSize, config.tileSize)
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print('Entity', self:getPosition().x, self:getPosition().y)
    love.graphics.print(name, self:getPosition().x, self:getPosition().y + 16)
end

function Entity:spawn()
end

return Entity
