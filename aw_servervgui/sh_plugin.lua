local PLUGIN = PLUGIN

PLUGIN.name = "Server VGUI"
PLUGIN.author = "Alan Wake"
PLUGIN.description = "Adds a control on client derma to server"

ix.svgui = ix.svgui or {}
ix.svgui.stored = ix.svgui.stored or {}

ix.util.Include("sv_plugin.lua")

if CLIENT then
    local function ClearShit(tbl)
        local newtable = {}
        for k,v in pairs(tbl)do
            if istable(v) then
                newtable[k] = ClearShit(v)
                continue 
            end
            if isfunction(v) or ispanel(v) then
                newtable[k] = type(v)
                continue
            end
            newtable[k] = v
        end
        return newtable
    end

    netstream.Hook("aw_svgui::create",function(data)
        ix.svgui.stored[data] = vgui.Create(data)
    end)

    netstream.Hook("aw_svgui::call",function(panel,method,...)
        ix.svgui.stored[panel][method](ix.svgui.stored[panel],...)
    end)

    netstream.Hook("aw_svgui::get",function(name)
        netstream.Start("aw_svgui::get"..LocalPlayer():UniqueID(),name,ClearShit(ix.svgui.stored[name]:GetTable()))
    end)
end