local class = include('middleclass')

local Brush = class('Brush')

function Brush:initialize()
    self.positions = {}

    self:reset()

    self.drawing = false
end

function Brush:reset()
    for i = 1, 2 do
        self.positions[i] = {
            x = 0,
            y = 0
        }
    end

    self.output = {
        x = 0,
        y = 0,
        w = 0,
        h = 0
    }
end

function Brush:setPosition(index, x, y)
    if not self.drawing then
        return
    end

    self.positions[index] = {
        x = x,
        y = y
    }
end

function Brush:createRectangle()
    local w = self.positions[2].x - self.positions[1].x + 1

    if w > 0 then
        self.output.x = self.positions[1].x
        self.output.w = w
    elseif w <= 0 then
        self.output.x = self.positions[2].x
        self.output.w = self.positions[1].x - self.positions[2].x + 1
    end

    local h = self.positions[2].y - self.positions[1].y + 1

    if h > 0 then
        self.output.y = self.positions[1].y
        self.output.h = h
    elseif h <= 0 then
        self.output.y = self.positions[2].y
        self.output.h = self.positions[1].y - self.positions[2].y + 1
    end
end

function Brush:getRectangle()
    if self.drawing then
        self:createRectangle()
    end
    return self.output
end

function Brush:start()
    self.drawing = true
    self:reset()
end

function Brush:stop()
    self.drawing = false
    self:onStop(self.output)
    self:reset()
end

function Brush:onStop(rectangle)
end

return Brush
