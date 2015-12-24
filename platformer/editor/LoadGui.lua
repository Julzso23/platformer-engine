local class = include('middleclass')

local LoadGui = class('LoadGui')

function LoadGui:initialize()
    self.isClosed = true

    local button = loveframes.Create('button')
    button:SetPos(80, 0)
    button:SetText('Load')
    button.parentClass = self
    button.OnClick = function(self)
        if not guis.anyOpen() then
            self.parentClass:open()
        end
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

    local list = loveframes.Create('columnlist', frame)
    list:SetPos(0, 30)
    list:SetSize(list:GetParent():GetWidth(), list:GetParent():GetHeight() - 30)
    list:AddColumn('Map name')
    list.OnRowClicked = function(self, row, rowData)
        world:load(rowData[1])
        self:GetParent():OnClose()
        self:GetParent():Remove()
    end
    list.OnRowRightClicked = function(self, row, rowData)
        local contextMenu = loveframes.Create('menu', row)
        contextMenu:AddOption('Load', false, function()
            world:load(rowData[1])
            self:GetParent():OnClose()
            self:GetParent():Remove()
        end)
        contextMenu:AddOption('Delete', false, function()
            love.filesystem.remove('maps/' .. rowData[1])
            self:GetParent().parentClass:open()
            self:GetParent():Remove()
        end)
        contextMenu:SetPos(love.mouse.getX(), love.mouse.getY())
    end

    for k, v in pairs(love.filesystem.getDirectoryItems('maps')) do
        list:AddRow(v)
    end
end

return LoadGui
