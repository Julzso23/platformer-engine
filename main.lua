require('platformer.shared.helper')
config = require('platformer.config')

function love.load(args)
    for k, v in pairs(args) do
        if v == '--editor' then
            require('platformer.editor.main')
            love.load(args)
            return
        end
    end
    require('platformer.game.main')
    love.load(args)
end
