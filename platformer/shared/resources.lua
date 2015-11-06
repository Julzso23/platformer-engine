local resources = {}

resources.images = {}
resources.audio = {}

function addResource(category, path, name)
    if category == 'image' then
        resources.images[name] = love.graphics.newImage('images/' .. path)
    end

    if category == 'audio' then
        resources.audio[name] = love.audio.newSource('audio/' .. path)
    end
end

function getResource(category, name)
    return resources[category][name]
end

return resources
