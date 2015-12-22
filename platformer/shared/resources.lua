local resources = {}

resources.images = {}
resources.audio = {}

function addResource(category, path, name)
    if category == 'images' then
        resources.images[name] = love.graphics.newImage('assets/images/' .. path)
    end

    if category == 'audio' then
        resources.audio[name] = love.audio.newSource('assets/audio/' .. path)
    end
end

function getResource(category, name)
    return resources[category][name]
end

return resources
