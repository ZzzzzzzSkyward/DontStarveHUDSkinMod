local SKINID = "LUNAR"
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
package.loaded["scripts/img_override_data"] = nil
local CONVERTION_DATA = require("img_override_data")
local function AddRules(ret)
    -- DST Wendy(This will be removed)
    ret["images/dstui.xml"] = ret["images/ui.xml"]
    ret["images/dst_global_redux.xml"] = ret["images/global_redux.xml"]
    ret["images/sisturn_slot_petals.xml"] = {
        ["sisturn_slot_petals.tex"] = ret["images/hud.xml"]["sisturn_slot_petals.tex"]
    }
    -- Map
    ret["images/hud_porkland.xml"] = {["map_hamlet.tex"] = ret["images/hud.xml"]["map.tex"]}
    ret["images/hud_shipwrecked.xml"] = {["map_shipwrecked.tex"] = ret["images/hud.xml"]["map.tex"]}
    -- Combined Status(Included)
    -- ret["images/status_bgs.xml"] = {["status_bgs.tex"] = "status_bgs.tex"}
    -- Xiao Qiang's Skin Mod
    -- ret["images/lines_up.xml"] = {["lines_up.tex"] = "lines_up.tex"}
    -- ret["images/lines_down.xml"] = {["lines_down.tex"] = "lines_down.tex"}
end
AddRules(CONVERTION_DATA)

local function StatusPostConstruct(self)
    if self.tempbadge then self.tempbadge.headframe:SetTint(1, 1, 1, 1) end
    if self.worldtempbadge then self.worldtempbadge.headframe:SetTint(1, 1, 1, 1) end
end
env.AddClassPostConstruct("widgets/statusdisplays", StatusPostConstruct)
-- Generate Assets
if not env.Assets then env.Assets = {} end
local Assets = env.Assets
local CachedAssets = {}
for _, v in pairs(CONVERTION_DATA) do for _, data in pairs(v) do CachedAssets[data[1]] = true end end

for asset, _ in pairs(CachedAssets) do
    table.insert(Assets, Asset("ATLAS", resolvefilepath(asset)))
    local img_name = asset:sub(0, -5) .. ".tex"
    table.insert(Assets, Asset("IMAGE", resolvefilepath(img_name)))
end

skinroot[SKINID] = {atlas = CachedAssets, rule = CONVERTION_DATA}
CachedAssets = nil
