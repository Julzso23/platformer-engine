local TileTexture = include('shared.TileTexture')

local textures = {}

textures.grass = TileTexture:new('grass')
textures.grass:setBody('grassCenter.png')
textures.grass:setSurface('grassMid.png')

textures.dirt = TileTexture:new('dirt')
textures.dirt:setBody('dirtCenter.png')
textures.dirt:setSurface('dirtMid.png')

textures.sand = TileTexture:new('sand')
textures.sand:setBody('sandCenter.png')
textures.sand:setSurface('sandMid.png')

textures.snow = TileTexture:new('snow')
textures.snow:setBody('snowCenter.png')
textures.snow:setSurface('snowMid.png')

textures.stone = TileTexture:new('stone')
textures.stone:setBody('stoneCenter.png')
textures.stone:setSurface('stoneMid.png')

function textures.loadAll()
    for k, v in pairs(textures) do
        if type(v) == 'table' then
            v:load()
        end
    end
end

return textures
