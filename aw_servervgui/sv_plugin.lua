local PLUGIN = PLUGIN

//
    -- Meta
//
local PlayerMeta = FindMetaTable("Player")

function PlayerMeta:SVGUICreate(name)
    ix.svgui.Create(self,name)
end

function PlayerMeta:SVGUICall(name,method,...)
    ix.svgui.Call(self,name,method,...)
end


function PlayerMeta:SVGUIGet(name,callback)
    ix.svgui.Get(self,name,callback)
end

//
    -- Functional
//

// Demonstrate: 
-- ix.svgui.Create(Player(2),"aw_AcceptSearch")
-- It will create VGUI with name "aw_AcceptSearch"
function ix.svgui.Create(client,name)
    netstream.Start(client,"aw_svgui::create",name)
end

// Demonstrate: 
-- ix.svgui.Call(Player(2),"aw_AcceptSearch","SetData",Player(2))
-- It will call method "SetData" on exists VGUI panel with name "aw_AcceptSearch" with argument player
function ix.svgui.Call(player,name,method,...)
    netstream.Start(player,"aw_svgui::call",name,method,...)
end

// Demonstrate: 
-- ix.svgui.Get(Player(2),"aw_AcceptSearch",function(panel) PrintTable(panel) end)
-- It will send to player request on send his exists panel "aw_AcceptSearch" and prints content of it's panel table.
function ix.svgui.Get(player,name,callback)
    netstream.Hook("aw_svgui::get"..player:UniqueID(),function(client,panel,table)
        ix.svgui.stored[client] = ix.svgui.stored[client] or {}
        ix.svgui.stored[client][panel] = table
    end)

    netstream.Start(player,"aw_svgui::get",name)

    local ident = "aw_svgui::get::"..CurTime()
    timer.Create(ident,0.1,5,function()
        if timer.RepsLeft(ident) == 0 or (ix.svgui.stored[player] and ix.svgui.stored[player][name]) then
            timer.Remove(ident)

            netstream.stored["aw_svgui::get"..player:UniqueID()] = nil

            if callback then
                callback(ix.svgui.stored[player] and ix.svgui.stored[player][name] or nil)
            end
        end
    end)
end