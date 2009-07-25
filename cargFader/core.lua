--[[
	cargFader
]]

local LFX = LibStub and LibStub("LibFx-1.1", true)
local fadePlayer = LFX.New{
	frame = oUF_Player,
	anim = "Alpha",
	ramp = "Smooth",
	finish = 1,
	duration = 0.3,
}
local fadeTarget = LFX.New{
	frame = oUF_Target,
	anim = "Alpha",
	ramp = "Smooth",
	finish = 1,
	duration = 0.3,
}

local addon = CreateFrame("Frame", nil, UIParent)
local status = CreateFrame("Frame", nil, UIParent)

local mana, hp

addon:RegisterEvent("PLAYER_REGEN_ENABLED")  
addon:RegisterEvent("PLAYER_REGEN_DISABLED")  
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("PLAYER_TARGET_CHANGED")
addon:RegisterEvent("PLAYER_FOCUS_CHANGED")

status:RegisterEvent("UNIT_MANA")
status:RegisterEvent("UNIT_HEALTH")

function status:UpdateStatus(event, arg1)
	if(arg1~="player") then return nil end
	
	if(not self.Text) then
		local text = self:CreateFontString(nil, "OVERLAY")
		text:SetFont([[Fonts/FRIZQT__.TTF]], 16)
		text:SetShadowOffset(1, -1)
		text:SetTextColor(.9, .5, 0)
		text:SetPoint("BOTTOMLEFT", UIParent, "BOTTOMLEFT", 400, 5)
		self.Text = text
	end
	hp = UnitHealth("player")/UnitHealthMax("player")
	mana = UnitMana("player")/UnitManaMax("player")
	
	self.Text:SetFormattedText("%i|cffffffff - |r%i",
		hp*100,
		mana*100
	)
	self:SetAlpha(min(hp, mana) < 0.99 and 1 or 0)
end

function addon:ChangeAlpha()
	if(UnitAffectingCombat("player")) then
		fadePlayer:Stop()
		fadeTarget:Stop()
		oUF_Player:SetAlpha(1)
		oUF_Target:SetAlpha(1)
		status:Hide()
	elseif(UnitExists("target")) then
		fadePlayer.finish = 0.5
		fadePlayer()
		fadeTarget.finish = 0.5
		fadeTarget()
		status:Hide()
	else
		status:Show()
		status:UpdateStatus()
		fadePlayer.finish = 0
		fadePlayer()
		oUF_Target:SetAlpha(0)
	end
end

addon:SetScript("OnEvent", addon.ChangeAlpha)
addon:RegisterEvent("PLAYER_REGEN_ENABLED")  
addon:RegisterEvent("PLAYER_REGEN_DISABLED")  
addon:RegisterEvent("PLAYER_ENTERING_WORLD")
addon:RegisterEvent("PLAYER_TARGET_CHANGED")

status:SetScript("OnEvent", status.UpdateStatus)
status:RegisterEvent("UNIT_MANA")
status:RegisterEvent("UNIT_HEALTH")