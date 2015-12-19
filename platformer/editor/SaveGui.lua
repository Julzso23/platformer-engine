local class = include('middleclass')

local SaveGui = class('SaveGui')

function SaveGui:initialize()
    local saveButton = loveframes.Create('button')
    saveButton:SetText('Save')
    saveButton.OnClick = function()
        world:save('test')
    end

    local saveButtonTooltip = loveframes.Create('tooltip')
    saveButtonTooltip:SetObject(saveButton)
    saveButtonTooltip:SetText('ctrl+s')
    saveButtonTooltip:SetFollowCursor(false)
    saveButtonTooltip:SetFollowObject(true)
    saveButtonTooltip:SetOffsets(saveButton:GetWidth() / 4, saveButton:GetHeight())
end

return SaveGui
