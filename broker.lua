local name, ns = ...

local LCS = LibStub("LibCargoShip-2.1")

LCS{
	name = "picoFriends",
	scale = 1.5,
	noIcon = true,
}:SetPoint("TOPLEFT", 5, -5)

LCS("Attrition"):SetPoint("LEFT", LCS:GetFirst("picoFriends"), "RIGHT", 15, 0)
LCS("picoFPS"):SetPoint("LEFT", LCS:GetFirst("Attrition"), "RIGHT", 15, 0)


local bottomDisplay = LCS{
	scale = 1.5,
	fontStyle = "OUTLINE",
}
bottomDisplay:SetPoint("BOTTOM", 0, 5)

ns.RegisterEvent("broker", "PLAYER_ENTERING_WORLD", function()
	if(select(2, IsInInstance()) == "pvp") then
		bottomDisplay:SetDataObject("cargoHonor")
	else
		bottomDisplay:SetDataObject("TourGuide")
	end
end)
