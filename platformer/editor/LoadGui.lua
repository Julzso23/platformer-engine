local class = include('middleclass')

local LoadGui = class('LoadGui')

function LoadGui:initialize()
    self.isClosed = true

    local button = loveframes.Create('button')
    button:SetPos(80, 0)
    button:SetText('Load')
    button.parentClass = self
    button.OnClick = function(self)
        self.parentClass:open()
    end

    local tooltip = loveframes.Create('tooltip')
    tooltip:SetObject(button)
    tooltip:SetText('ctrl+o')
    tooltip:SetFollowCursor(false)
    tooltip:SetFollowObject(true)
    tooltip:SetOffsets(button:GetWidth() / 4, button:GetHeight())
end

function LoadGui:isOpen()
    return not self.isClosed
end

function LoadGui:open()
    self.isClosed = false

    local frame = loveframes.Create('frame')
    frame:SetName('Load map')
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
        world:load(text)
        self:GetParent():Remove()
    end
    textBox:SetFocus(true)
end

return LoadGui
