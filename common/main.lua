local function CheckCombinedStatus(self)
    if self.bg then self.bg:MoveToFront() end
    if self.DSTframe then self.DSTframe:MoveToFront() end
    if self.num then self.num:MoveToFront() end
    if self.maxnum then self.maxnum:MoveToFront() end
end

local function AddDSTFrame(self)
    if self.DSTframe then return false end
    if self.circular_meter then return false end
    local root = self.underNumber or self
    self.DSTframe = root:AddChild(require("widgets/uianim")())
    local anim = self.DSTframe:GetAnimState()
    anim:SetBank("status_meter")
    anim:SetBuild("status_meter")
    anim:PlayAnimation("frame")
    self.DSTframe:SetClickable(false)
    for i, v in ipairs({"anim", "topperanim"}) do if self[v] then self[v]:GetAnimState():Hide("frame_circle") end end
    for i, v in ipairs({"anim", "topperanim"}) do if root[v] then root[v]:GetAnimState():Hide("frame_circle") end end
    timer.tick(CheckCombinedStatus, 0.1, self)
    return true
end

local function HackAnim(self)
    self.DSTframe:Hide()
    wrapperAfter(self, "Activate", function()
        self.DSTframe:Show()
    end)
    wrapperAfter(self, "Deactivate", function()
        self.DSTframe:Hide()
    end)
end

utils.class("widgets/badge", AddDSTFrame)
-- DLC
utils.klass("widgets/moisturemeter", function(self)
    return AddDSTFrame(self) and HackAnim(self)
end)
