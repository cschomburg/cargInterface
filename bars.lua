--[[####################
		cargBars
	   by Cargor
		based on:
			lolBars from Lolzen
			rActionBarStyler from Roth
####################]]--

local addonPath = debugstack():match("(.+\\).-\.lua:")
local path = addonPath.."textures\\"

if false then return end
local dummy = function() end

local ActionBarFrame = CreateFrame("Frame", "cargBarsToggle", UIParent)
ActionBarFrame:SetWidth(498)
ActionBarFrame:SetHeight(38)
ActionBarFrame:ClearAllPoints()
ActionBarFrame:SetPoint("BOTTOM", 0, 300)
ActionBarFrame:Hide()
for i = 1, 12, 1 do
	_G["ActionButton"..i]:SetParent(ActionBarFrame)
end
ActionButton1:ClearAllPoints()
ActionButton1:SetPoint("TOPLEFT")

PetActionBarFrame:ClearAllPoints()
PetActionBarFrame:SetPoint("TOP", UIParent, "TOP", 0, -50)
PetActionBarFrame.ClearAllPoints = dummy
PetActionBarFrame.SetPoint = dummy

local anchoredFrames = {
	MultiBarBottomLeft,
	MultiBarBottomRight,
	MultiBarLeft,
}
local hiddenForever = {
	MainMenuBar,
	ShapeshiftBarFrame,
	MultiBarRight,
	BonusActionBarFrame,
	ShapeshiftBarFrame,
}

local prev
for i=1, 5 do
	local button = _G["VehicleMenuBarActionButton"..i]
	button:ClearAllPoints()
	button:SetScale(0.5)
	if(i == 1) then
		button:SetPoint("BOTTOM", UIParent, "BOTTOM", -85, 5)
	else
		button:SetPoint("LEFT", prev, "RIGHT", 5, 0)
	end
	prev = button
end

for i=1, 6 do
	local button = _G["MultiBarRightButton"..i+6]
	button:ClearAllPoints()
	if(i == 1) then
		button:SetPoint("TOP", UIParent, "TOP", -80, -10)
	else
		button:SetPoint("LEFT", prev, "RIGHT", i == 4 and 15 or 5, 0)
	end
	button.Desaturated = true
	button:SetScale(0.7 - abs(3.5-i) * 0.08)
	prev = button
end

-- Something else
MultiBarLeftButton1:ClearAllPoints()
MultiBarLeftButton1:SetPoint("LEFT", ActionBarFrame, "RIGHT", 20, 0)
for i=2, 12 do
	local b = _G["MultiBarLeftButton"..i]
	b:ClearAllPoints()
	if(i%4 == 1) then
		b:SetPoint("BOTTOM", _G["MultiBarLeftButton"..i-4], "TOP", 0, 5)
	else
		b:SetPoint("LEFT", _G["MultiBarLeftButton"..i-1], "RIGHT", 5, 0)
	end
end


local prev = ActionBarFrame
for _, frame in pairs(anchoredFrames) do
	frame:SetParent(ActionBarFrame)
	frame:ClearAllPoints()
	if(frame ~= MultiBarLeft) then
		frame:SetPoint("BOTTOM", prev, "TOP", 0, 5)
		prev = frame
	end
	frame:Show()
	frame.ClearAllPoints = dummy
	frame.SetPoint = dummy
	frame.Hide = dummy
end

local shown
SlashCmdList["CARGBARS"] = function()
	if(shown) then
		ActionBarFrame:Hide()
	else
		ActionBarFrame:Show()
	end
	shown = not shown
end
SLASH_CARGBARS1 = "/cargbars"
SLASH_CARGBARS2 = "/cb"

BonusActionBarTexture0:Hide()
BonusActionBarTexture1:Hide()
for _, frame in pairs(hiddenForever) do
	frame:ClearAllPoints()
	frame:SetPoint("TOPRIGHT", UIParent, "BOTTOMLEFT", -500, -500)
	frame.SetPoint = dummy
	frame.SetAllPoints = dummy
	frame.ClearAllPoints = dummy
end

--RANGE_INDICATOR = ""

local color_rn = 0.37
local color_gn = 0.3
local color_bn = 0.3

local color_re = 0
local color_ge = 0.5
local color_be = 0

function AB_style(self)
	local action = self.action
	local name = self:GetName()
	local bu  = _G[name]
	local ic  = _G[name.."Icon"]
	local co  = _G[name.."Count"]
	local bo  = _G[name.."Border"]
	local ho  = _G[name.."HotKey"]
	local cd  = _G[name.."Cooldown"]
	local na  = _G[name.."Name"]
	local fl  = _G[name.."Flash"]
	local nt  = _G[name.."NormalTexture"]

	nt:SetHeight(bu:GetHeight())
	nt:SetWidth(bu:GetWidth())
	nt:SetPoint("Center", 0, 0)
	bo:Hide()

	ho:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	co:SetFont("Fonts\\FRIZQT__.TTF", 18, "OUTLINE")
	na:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	ho:Hide()
	na:Hide()

	fl:SetTexture(path.."flash")
	bu:SetHighlightTexture(path.."hover")
	bu:SetPushedTexture(path.."pushed")
	bu:SetCheckedTexture(path.."checked")
	bu:SetNormalTexture(path.."gloss")
	
	cd:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
	cd:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)

	ic:SetTexCoord(0.1,0.9,0.1,0.9)
	ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
	ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)

	if ( IsEquippedAction(action) ) then
		bu:SetNormalTexture(path.."gloss_grey");
		nt:SetVertexColor(color_re,color_ge,color_be,1)
	else
		bu:SetNormalTexture(path.."gloss");
		nt:SetVertexColor(color_rn,color_gn,color_bn,1)
	end

	if(bu.Desaturated or bu:GetParent().Desaturated) then
		ic:SetDesaturated(1)
	end
end


function AB_stylepet()
	for i=1, NUM_PET_ACTION_SLOTS do
		local name = "PetActionButton"..i
		local bu  = _G[name]
		local ic  = _G[name.."Icon"]
		local fl  = _G[name.."Flash"]
		local nt  = _G[name.."NormalTexture2"]
		
		nt:SetHeight(bu:GetHeight())
		nt:SetWidth(bu:GetWidth())
		nt:SetPoint("Center", 0, 0)
		nt:SetVertexColor(color_rn,color_gn,color_bn,1)
		
		fl:SetTexture(path.."flash")
		bu:SetHighlightTexture(path.."hover")
		bu:SetPushedTexture(path.."pushed")
		bu:SetCheckedTexture(path.."checked")
		bu:SetNormalTexture(path.."gloss")
		
		ic:SetTexCoord(0.1,0.9,0.1,0.9)
		ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
		ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)

		if(bu.Desaturated or bu:GetParent().Desaturated) then
			ic:SetDesaturated(1)
		end
	end
end


function AB_fixgrid(button)
	local name = button:GetName()
	local action = button.action
	local nt  = _G[name.."NormalTexture"]

	if(IsEquippedAction(action)) then
		nt:SetVertexColor(color_re,color_ge,color_be,1)
	else
		nt:SetVertexColor(color_rn,color_gn,color_bn,1)
	end
end

function AB_styleshapeshift()
	for i=1, NUM_SHAPESHIFT_SLOTS do
		local name = "ShapeshiftButton"..i
		local bu  = _G[name]
		local ic  = _G[name.."Icon"]
		local fl  = _G[name.."Flash"]
		local nt  = _G[name.."NormalTexture"]

		nt:ClearAllPoints()
		nt:SetPoint("TOPLEFT", bu, "TOPLEFT", 0, 0)
		nt:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", 0, 0)

		nt:SetVertexColor(color_rn,color_gn,color_bn,1)

		fl:SetTexture(path.."flash")
		bu:SetHighlightTexture(path.."hover")
		bu:SetPushedTexture(path.."pushed")
		bu:SetCheckedTexture(path.."checked")
		bu:SetNormalTexture(path.."gloss")

		ic:SetTexCoord(0.1,0.9,0.1,0.9)
		ic:SetPoint("TOPLEFT", bu, "TOPLEFT", 2, -2)
		ic:SetPoint("BOTTOMRIGHT", bu, "BOTTOMRIGHT", -2, 2)

		if(bu.Desaturated or bu:GetParent().Desaturated) then
			ic:SetDesaturated(1)
		end
	end
end

hooksecurefunc("ActionButton_Update", AB_style)
hooksecurefunc("ActionButton_ShowGrid", AB_fixgrid)
hooksecurefunc("ActionButton_OnUpdate", AB_fixgrid)

hooksecurefunc("ShapeshiftBar_OnLoad", AB_styleshapeshift)
hooksecurefunc("ShapeshiftBar_Update", AB_styleshapeshift)
hooksecurefunc("ShapeshiftBar_UpdateState", AB_styleshapeshift)

hooksecurefunc("PetActionBar_Update", AB_stylepet)