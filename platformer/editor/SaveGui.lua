local class = include('middleclass')

local SaveGui = class('SaveGui')

function SaveGui:initialize()
    self.isClosed = true

    local button = loveframes.Create('button')
    button:SetText('Save')
    button.parentClass = self
    button.OnClick = function(self)
        self.parentClass:open()
    end

    local tooltip = loveframes.Create('tooltip')
    tooltip:SetObject(button)
    tooltip:SetText('ctrl+s')
    tooltip:SetFollowCursor(false)
    tooltip:SetFollowObject(true)
    tooltip:SetOffsets(button:GetWidth() / 4, button:GetHeight())
end

function SaveGui:isOpen()
    return not self.isClosed
end

function SaveGui:open()
    self.isClosed = false

    local frame = loveframes.Create('frame')
    frame:SetName('Save map')
    frame:SetDraggable(false)
    frame:SetSize(256, 128)
    frame:CenterWithinArea(0, 0, love.window.getWidth(), love.window.getHeight())
    frame.parentClass = self
    frame.OnClose = function(self)
        self.parentClass.isClosed = true
    end

    local textBox = loveframes.Create('textinput', frame)
    textBox:SetPos(0, 30)
    textBox:SetWidth(frame:GetWidth())
    textBox:SetPlaceholderText('Map name')
    textBox.parentClass = self
    textBox.OnEnter = function(self, text)
        world:save(text)
        self:GetParent():OnClose()
        self:GetParent():Remove()
    end
    textBox:SetFocus(true)
end

return SaveGui
