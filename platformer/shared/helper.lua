local includeLocations = {
    'libraries',
    'platformer'
}

function include(resource)
    for k, v in pairs(includeLocations) do
        if love.filesystem.exists(v .. '/' .. resource:gsub('%.', '/') .. '.lua') or love.filesystem.isDirectory(v .. '/' .. resource:gsub('%.', '/')) then
            return require(v:gsub('/', '.') .. '.' .. resource)
        end
    end
    error('Attempt to include non-indexed resource.')
end

function table.contains(table, value)
    for k, v in pairs(table) do
        if v == value then
            return true
        end
    end
    return false
end
