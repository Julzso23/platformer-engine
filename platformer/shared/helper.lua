local includeLocations = {
    'libraries',
    'platformer'
}

function include(resource)
    for k, v in pairs(includeLocations) do
        if love.filesystem.exists(v .. '/' .. resource:gsub('%.', '/') .. '.lua') then
            return require(v:gsub('/', '.') .. '.' .. resource)
        end
    end
    error('Attempt to include non-indexed resource.')
end
