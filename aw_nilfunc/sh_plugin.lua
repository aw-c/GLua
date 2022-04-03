local PLUGIN = PLUGIN

PLUGIN.name = "nilfunc"
PLUGIN.author = "Alan Wake"
PLUGIN.description = "Adds a small tool for devs."

//
// Usage:
// (unknownvariable or nilfunc)() -- will do nothing, because unknownvariable is nil and nilfunc does also nothing.
// (unknownpanel or nilfunc("->SetVisible")):SetVisible(true) -- will do nothing if we havevn't any panel in unknownpanel.
//

function nilfunc(name)

    if isstring(name) and name:sub(1,2) == "->" then

        return {[name:sub(3,#name)] = nilfunc}
    
    end

end
