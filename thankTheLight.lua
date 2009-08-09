local addon = CreateFrame("Frame", nil, UIParent)
local active

addon:SetAllPoints()
addon:SetAlpha(0)
local tex = addon:CreateTexture(nil, "BACKGROUND")
tex:SetTexture([[Interface\FullScreenTextures\LowHealth]])
tex:SetBlendMode("ADD")
tex:SetAllPoints()

addon:SetScript("OnEvent", function(self, event)
	if(arg3 ~= UnitGUID("player") or arg12 ~= "BUFF") then return nil end
	
	if(arg2:match("AURA_APPLIED") and not active) then
		local name = GetSpellInfo(33151)
		if(UnitAura("player", name)) then
			active = true
			UIFrameFadeIn(self, 0.2, 0, 1)
		end
	elseif(arg2:match("AURA_REMOVED")) then
		local name = GetSpellInfo(33151)
		if(active and not UnitAura("player", name)) then
			active = nil
			UIFrameFadeOut(self, 0.2, 1, 0)
		end
	end
end)
addon:RegisterEvent"COMBAT_LOG_EVENT_UNFILTERED"