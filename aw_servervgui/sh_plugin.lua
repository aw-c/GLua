local PLUGIN = PLUGIN

PLUGIN.name = "Server VGUI"
PLUGIN.author = "Alan Wake"
PLUGIN.description = "Adds a control on client derma to server"

ix.svgui = ix.svgui or {}
ix.svgui.stored = ix.svgui.stored or {}

ix.util.Include("sv_plugin.lua")

if CLIENT then
    local function ClearShit(data)
        for k, v in pairs(data) do
            if istable(v) then
                data[k] = ClearShit(v)
            elseif isfunction(v) or ispanel(v) then
                data[k] = tostring(v)
            end
        end

        return data
    end

    netstream.Hook("aw_svgui::create", function(data)
        ix.svgui.stored[data] = vgui.Create(data)
    end)

    netstream.Hook("aw_svgui::call", function(panel, method, ...)
        ix.svgui.stored[panel][method](ix.svgui.stored[panel], ...)
    end)

    netstream.Hook("aw_svgui::get",function(name)
        local data = ClearShit(ix.svgui.stored[name]:GetTable())

        netstream.Start("aw_svgui::get" .. LocalPlayer():UniqueID(), name, data)
    end)
end
