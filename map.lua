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
hooksecurefunc("WorldMap_ToggleSizeUp", tweak)
tweak()