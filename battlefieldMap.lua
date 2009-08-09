LoadAddOn("Blizzard_BattlefieldMinimap")

BattlefieldMinimapTab:Hide()
BattlefieldMinimapTab.Show = function() end
BattlefieldMinimapCorner:Hide()
BattlefieldMinimapBackground:Hide()
BattlefieldMinimapCloseButton:Hide()
BattlefieldMinimap.resizing = true
BattlefieldMinimap:SetHeight(BattlefieldMinimap:GetHeight()*4)
BattlefieldMinimap:SetWidth(BattlefieldMinimap:GetWidth()*4)
for i=1, 12 do
	_G["BattlefieldMinimap"..i]:Hide()
end

hooksecurefunc("BattlefieldMinimap_Update", function()
	local right, bottom = BattlefieldMinimap:GetRight(), BattlefieldMinimap:GetBottom()
	local i = 1
	local maxRight, maxBottom = 0, 200
	while(_G['BattlefieldMinimapOverlay'..i]) do
		maxRight = max(maxRight, _G['BattlefieldMinimapOverlay'..i]:GetRight())
		maxBottom = min(maxBottom, _G['BattlefieldMinimapOverlay'..i]:GetBottom())
		i = i + 1
	end
	BattlefieldMinimap:ClearAllPoints()
	BattlefieldMinimap:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", right - maxRight, bottom -maxBottom)
end)
ToggleBattlefieldMinimap = function()
	bFixed = not bFixed
	if(bFixed) then
		BattlefieldMinimap:Show()
	else
		BattlefieldMinimap:Hide()
	end
end