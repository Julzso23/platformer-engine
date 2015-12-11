local class = include('middleclass')

local KeyCommand = class('KeyCommand')

function KeyCommand:initialize(keys, callback)
    self.keys = keys
    self.callback = callback
    self.keysDown = {}
end

function KeyCommand:keyDown(key)
    if table.contains(self.keys, key) then
        self.keysDown[key] = true
    end
end

function KeyCommand:keyUp(key)
    if table.contains(self.keys, key) then
        local down = true
        for k, v in pairs(self.keys) do
            if not self.keysDown[v] then
                down = false
            end
        end
        if down then
            self.callback()
        end
    end
    self.keysDown[key] = nil
end

return KeyCommand
