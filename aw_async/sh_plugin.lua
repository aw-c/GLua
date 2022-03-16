local PLUGIN = PLUGIN

PLUGIN.name = "Pseudo Async"
PLUGIN.author = "Alan Wake"
PLUGIN.description = "Adds some features for async programming"

ix.async = ix.async or {}
ix.async.stored = ix.async.stored or {}

function ix.async.Run()
    local task = ix.async.stored[1]
    if task then
        table.remove(ix.async.stored,1)
        local result = task[1]()
        if task[2] then
            task[2](result)
        end
    end
end

function ix.async.Queue(func,callback)
    ix.async.stored[#ix.async.stored+1] = {func,callback}
end

function PLUGIN:Think()
    ix.async.Run()
end