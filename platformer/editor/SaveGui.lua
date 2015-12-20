local class = include('middleclass')

local SaveGui = class('SaveGui')

function SaveGui:initialize()
    self.isClosed = false

    local saveButton = loveframes.Create('button')
    saveButton:SetText('Save')
    saveButton.parentClass = self
    saveButton.OnClick = function(self)
        self.parentClass:open()
    end

    local saveButtonTooltip = loveframes.Create('tooltip')
    saveButtonTooltip:SetObject(saveButton)
    saveButtonTooltip:SetText('ctrl+s')
    saveButtonTooltip:SetFollowCursor(false)
    saveButtonTooltip:SetFollowObject(true)
    saveButtonTooltip:SetOffsets(saveButton:GetWidth() / 4, saveButton:GetHeight())
end

function SaveGui:isOpen()
    return self.isClosed
end

function SaveGui:open()
    self.isClosed = true

    local frame = loveframes.Create('frame')
    frame:SetName('Save map')
    frame:SetDraggable(false)
    frame:SetSize(256, 128)
    frame:CenterWithinArea(0, 0, love.window.getWidth(), love.window.getHeight())
    frame.parentClass = self
    frame.OnClose = function(self)
        self.parentClass.isClosed = false
    end

    local textBox = loveframes.Create('textinput', frame)
    textBox:SetPos(0, 30)
    textBox:SetWidth(frame:GetWidth())
    textBox:SetPlaceholderText('Map name')
    textBox.parentClass = self
    textBox.OnEnter = function(self, text)
        world:save(text)
        self.parentClass.isClosed = true
    end
end

return SaveGui
