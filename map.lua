--[[
	cargMap
]]

local function tweak()
	WorldMapFrame:SetScale(0.75)
	WorldMapFrame:EnableKeyboard(false)
	BlackoutWorld:Hide()
	WorldMapFrame:EnableMouse(false)
	UIPanelWindows["WorldMapFrame"].area = "center"
	WorldMapFrame:SetAttribute("UIPanelLayout-defined", false);
end

hooksecurefunc(WorldMapFrame, "Show", tweak)

if(select(4, GetBuildInfo()) >= 30300) then
	hooksecurefunc("WorldMap_ToggleSizeUp", tweak)
end

tweak()