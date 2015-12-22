local class = include('middleclass')

local TileTexture = class('TileTexture')

function TileTexture:initialize(name)
    self.name = name
    self.imagePaths = {}
    self.images = {}
end

function TileTexture:load()
    for k, v in pairs(self.imagePaths) do
        self.images[k] = love.graphics.newImage('assets/images/tiles/' .. v)
    end
end

function TileTexture:setBody(path)
    self.imagePaths.body = path
end

function TileTexture:getBody()
    return self.images.body
end

function TileTexture:setSurface(path)
    self.imagePaths.surface = path
end

function TileTexture:getSurface()
    return self.images.surface
end

function TileTexture:hasSurface()
    return self.images.surface ~= nil
end

return TileTexture
