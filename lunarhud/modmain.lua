Assets =
{
	Asset("ANIM", "anim/status_meter.zip"),
	--Asset("ATLAS", "images/ba.xml"),
	--Asset("IMAGE", "images/ba.tex"),
}
GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})
modimport "apis.lua"
modimport "main.lua"
modimport "scripts/hud_skins.lua"
