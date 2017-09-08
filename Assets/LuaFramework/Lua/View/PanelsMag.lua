
require "Common/define"

PanelsMag = {}

local this = PanelsMag

function PanelsMag.FindGameObjectByName(go,name)

    local newgo = go.transform:Find(name).gameObject

    return newgo;
end