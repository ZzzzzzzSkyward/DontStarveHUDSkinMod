local SKINID = "ROSE"
local HUDATLAS = "images/rose_hud.xml"
if not TUNING.HUDSKIN then
    -- This is the first time a HUD mod loads
    TUNING.HUDSKIN = {current = SKINID}
    utils.sim(function()
        local w = GetWorld()
        if w then w:PushEvent("hudskin") end
    end)
    -- author:Cunning Fox
    local function InstallImageLib()
        local Image = require("widgets/image")
        local _SetTexture = Image.SetTexture
        Image.SetTexture = function(self, atlas, tex, ...)
            local hudskin = TUNING.HUDSKIN
            local rule = hudskin[hudskin.current].rule
            if rule and rule[atlas] and rule[atlas][tex] then atlas, tex = unpack(rule[atlas][tex]) end
            return _SetTexture(self, atlas, tex, ...)
        end
    end
    InstallImageLib()
end
local skinroot = TUNING.HUDSKIN
if skinroot[SKINID] then return end
local function MakeTable(arr)
    local ret = {}
    for i in pairs(arr) do
        ret[i] = {}
        for _, j in pairs(arr[i]) do ret[i][j] = j end
    end
    return ret
end
local function ConvertToDualTable(t)
    for k, v in pairs(t) do for k2, v2 in pairs(v) do if type(v2) == "string" then t[k][k2] = {HUDATLAS, v2} end end end
end
local function readjson(path)
    local f = MakeFile(nil, nil, "json")
    local name = f:resolve(path)
    if not name then return nil end
    return MakeTable(f:decode(name))
end
local CONVERTION_DATA = readjson("mapping.json")
if not CONVERTION_DATA then return end
local function AddRules(ret)
    -- Map
    ret["images/hud_porkland.xml"] = {["map_hamlet.tex"] = ret["images/hud.xml"]["map.tex"]}
    ret["images/hud_shipwrecked.xml"] = {["map_shipwrecked.tex"] = ret["images/hud.xml"]["map.tex"]}
    -- Combined Status
    ret["images/status_bgs.xml"] = {["status_bgs.tex"] = "status_bgs.tex"}
    -- Xiao Qiang's Skin Mod
    ret["images/lines_up.xml"] = {["lines_up.tex"] = "crafting_inventory_arrow_r_idle.tex"}
    ret["images/lines_down.xml"] = {["lines_down.tex"] = "crafting_inventory_arrow_l_idle.tex"}
end
AddRules(CONVERTION_DATA)
-- must do this after
ConvertToDualTable(CONVERTION_DATA)
skinroot[SKINID] = {atlas = {HUDATLAS}, rule = CONVERTION_DATA}
