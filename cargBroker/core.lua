local friends = cargoShip("picoFriends", { noIcon = true, })
friends:SetPoint("BOTTOMRIGHT", cargUI2, "BOTTOMRIGHT", -5, 2)

local durability = cargoShip("Attrition", { noIcon = true, })
durability:SetPoint("RIGHT", friends, "LEFT", -15, 0)

local fps = cargoShip("picoFPS")
fps:SetPoint("RIGHT", durability, "LEFT", -15, 0)

local xp = cargoShip("picoEXP", {
	noIcon = true,
	scale = 1.4,
	fontStyle = "OUTLINE",
})
xp:SetPoint("RIGHT", durability, "LEFT", -60, 0)

local bugs = cargoShip("BugSack", {})
bugs:SetPoint("RIGHT", xp, "LEFT", -15, 0)

local honor = cargoShip("cargoHonor", {
	scale = 1.7,
	fontStyle = "OUTLINE",
})
honor:SetPoint("BOTTOM", 0, 10)

local f = CreateFrame"Frame"
f:SetScript("OnEvent", function(self, event)
	if(select(2, IsInInstance()) == "pvp") then
		honor:Show()
		xp:Hide()
	else
		honor:Hide()
		xp:Show()
	end
end)
f:RegisterEvent"PLAYER_ENTERING_WORLD"
