local class = include('middleclass')

local Collideable = include('shared.Collideable')

local Player = class('Player', Collideable)

function Player:initialize()
    Collideable.initialize(self, 64, 64)

    self.velocity = {}
    self.velocity.x = 200
    self.velocity.y = 0

    self.grounded = false
end

function Player:update(dt)
    self.velocity.y = self.velocity.y + config.gravity * dt
    if self.velocity.y > config.terminalVelocity then
        self.velocity.y = config.terminalVelocity
    end

    self.grounded = false

    self:move(0, self.velocity.y * dt)
end

function Player:collisionEvent(side)
    if (side == 'top') or (side == 'bottom') then
        self.velocity.y = 0
        if side == 'bottom' then
            self.grounded = true
        end
    end
end

function Player:moveDir(direction, dt)
    self:move(direction * self.velocity.x * dt, 0)
end

function Player:jump()
    if self.grounded then
        self.velocity.y = -400
    end
end

return Player
