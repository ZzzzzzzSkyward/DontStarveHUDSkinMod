-- This file contains compatibility code for Item Skins mod
local function HideCraftTab(self)
    if self.bg_cover then self.bg_cover:Hide() end
end
local function HideInventoryBar(self)
    if self.bgcover then self.bgcover:Hide() end
end
local function HackRefresh(self)
    -- without Item Skins you should never modify anything
    if not self.skins then return false end
    if self.ItemSkinsBackingImage then return true end
    local Image = require("widgets/image")
    self.ItemSkinsBackingImage = self.contents:AddChild(Image("images/crafting_menu.xml", "skins_backing.tex"))
    self.ItemSkinsBackingImage:SetScale(1, 1, 1)
    self.ItemSkinsBackingImage:SetPosition(317, -40)
    self.ItemSkinsBackingImage:Hide()
    --self.skins.up:SetPosition(400,-28,0)
    local old = self.Refresh
    function self:Refresh()
        old(self)
            if self.recipe and self.recipe.skins then
                self.skins.up:SetScale(0.65,0.65,0.65)
                self.skins.up:SetPosition(400, -35, 0)
                self.skins.down:SetScale(0.65,0.65,0.65)
                self.skins.down:SetPosition(235, -35, 0)
                self.skins.skins:SetScale(0.8,0.8,0.8)
                self.ItemSkinsBackingImage:Show()
                local oldbuttonup=self.skins.up.onclick
    
                if self.skins.cndesc then
                    self.skins.cndesc:SetSize(28)
                    --self.skins.cndesc:SetColour(158,177,109,1)
                    self.skins.cndesc:SetPosition(320, -70, 0)
                end
    
                self.skins.up:SetOnClick(function()
                    oldbuttonup()
                    self.skins.skins:SetScale(0.8,0.8,0.8)
    
                    if self.skins.cndesc then
                    self.skins.cndesc:SetSize(28)
                    --self.skins.cndesc:SetColour(158,177,109,1)
                    self.skins.cndesc:SetPosition(320, -70, 0)
                    end
    
                end
                )
                local oldbuttondown=self.skins.down.onclick
                self.skins.down:SetOnClick(function()
                    oldbuttondown()
                    self.skins.skins:SetScale(0.8,0.8,0.8)
    
                    if self.skins.cndesc then
                        self.skins.cndesc:SetSize(28)
                        --self.skins.cndesc:SetColour(158,177,109,1)
                        self.skins.cndesc:SetPosition(320, -70, 0)
                    end
    
                end
                )
            else
                self.ItemSkinsBackingImage:Hide()
            end
        end
    return true
end
local function RecipePopupPostInit(self)
    return self.skins and HackRefresh(self) or self.inst:DoTaskInTime(0, function()
        HackRefresh(self)
    end)
end
if GetModConfigData("Crafting_Menu_BG")=="TRUE" then
AddClassPostConstruct("widgets/recipepopup", RecipePopupPostInit)
end
AddClassPostConstruct("widgets/crafttabs", HideCraftTab)
AddClassPostConstruct("widgets/inventorybar",HideInventoryBar)
