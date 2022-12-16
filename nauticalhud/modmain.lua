Assets = {
	Asset("ANIM", "anim/status_meter.zip"),
	Asset("IMAGE", "images/nautical_hud.tex"),
	Asset("ATLAS", "images/nautical_hud.xml"),
}
GLOBAL.setmetatable(env, {
    __index = function(t, k)
        return GLOBAL.rawget(GLOBAL, k)
    end
})
modimport("apis.lua")
modimport("main.lua")
modimport("hudskin.lua")
modimport("skinmod.lua")