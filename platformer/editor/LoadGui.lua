local class = include('middleclass')

local LoadGui = class('LoadGui')

function LoadGui:initialize()
    local loadButton = loveframes.Create('button')
    loadButton:SetText('Load')
    loadButton:SetX(80)
    loadButton.OnClick = function()
        world:load('test')
    end

    local loadButtonTooltip = loveframes.Create('tooltip')
    loadButtonTooltip:SetObject(loadButton)
    loadButtonTooltip:SetText('ctrl+o')
    loadButtonTooltip:SetFollowCursor(false)
    loadButtonTooltip:SetFollowObject(true)
    loadButtonTooltip:SetOffsets(loadButton:GetWidth() / 4, loadButton:GetHeight())
end

return LoadGui
