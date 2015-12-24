local class = include('middleclass')

local textures = include('shared.textures')

local SelectTileGui = class('SelectTileGui')

function SelectTileGui:initialize()
    self.isClosed = true

    local button = loveframes.Create('button')
    button:SetPos(160, 0)
    button:SetText('Select tile')
    button.parentClass = self
    button.OnClick = function(self)
        if not guis.anyOpen() then
            self.parentClass:open()
        end
    end

    local tooltip = loveframes.Create('tooltip')
    tooltip:SetObject(button)
    tooltip:SetText('tab')
    tooltip:SetFollowCursor(false)
    tooltip:SetFollowObject(true)
    tooltip:SetOffsets(button:GetWidth() / 4, button:GetHeight())
end

function SelectTileGui:isOpen()
    return not self.isClosed
end

function SelectTileGui:open()
    self.isClosed = false

    local frame = loveframes.Create('frame')
    frame:SetName('Select tile')
    frame:SetDraggable(false)
    frame:SetSize(388, 512)
    frame:CenterWithinArea(0, 0, love.window.getWidth(), love.window.getHeight())
    frame.parentClass = self
    frame.OnClose = function(self)
        self.parentClass.isClosed = true
    end

    local textureNames = {'grass', 'dirt', 'sand', 'snow', 'stone'}
    for k, v in pairs(textureNames) do
        local button = loveframes.Create('imagebutton', frame)
        button:SetPos(((k - 1) % 3) * 128 + 2, 30 + math.floor((k - 1) / 3) * 128)
        button:SetImage(textures[v]:getSurface())
        button:SizeToImage()
        button:SetText('')
        button.textureName = v
        button.OnClick = function(self)
            brush:setTexture(self.textureName)
            self:GetParent():OnClose()
            self:GetParent():Remove()
        end
    end
end

return SelectTileGui
