function table.ClearShit(tbl)
    local newtable = {}
    for k,v in pairs(tbl)do
        if istable(v) then
            newtable[k] = table.ClearShit(v)
            continue 
        end
        if ispanel(v) then
            newtable[k] = table.ClearShit(v:GetTable())
            continue
        end
        if isfunction(v) then
            newtable[k] = type(v)
            continue
        end
        newtable[k] = v
    end
    return newtable
end
