local TileTexture = include('shared.TileTexture')

local textures = {}

textures.grass = TileTexture:new()
textures.grass:setBody('grassCenter.png')
textures.grass:setSurface('grassMid.png')

function textures.loadAll()
    for k, v in pairs(textures) do
        if type(v) == 'table' then
            v:load()
        end
    end
end

return textures
