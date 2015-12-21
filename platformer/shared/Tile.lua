local class = include('middleclass')

local Collideable = include('shared.Collideable')

local Tile = class('Tile', Collideable)

function Tile:initialize(x, y, w, h, texture)
    Collideable.initialize(self, w * config.tileSize, h * config.tileSize)
    self:teleportTo(x * config.tileSize, y * config.tileSize)

    self.texture = texture
end

function Tile:draw()
    love.graphics.setColor(255, 255, 255, 255)
    for x = 0, self.width / config.tileSize - 1 do
        for y = 0, self.height / config.tileSize - 1 do
            love.graphics.draw(getResource('images', self.texture), self:getPosition().x + x * config.tileSize, self:getPosition().y + y * config.tileSize, 0, 0.5, 0.5)
        end
    end
end

return Tile
