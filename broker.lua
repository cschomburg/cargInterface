local friends = cargoShip{
	name = "picoFriends",
	noIcon = true
}
friends:SetPoint("BOTTOMRIGHT", cargUI2, "BOTTOMRIGHT", -5, 2)

local durability = cargoShip{
	name = "Attrition",
	noIcon = true,
}
durability:SetPoint("RIGHT", friends, "LEFT", -15, 0)

local fps = cargoShip("picoFPS")
fps:SetPoint("RIGHT", durability, "LEFT", -15, 0)

local bugs = cargoShip("BugSack")
bugs:SetPoint("RIGHT", durability, "LEFT", -90, 0)

local honor = cargoShip{
	name = "cargoHonor",
	scale = 1.7,
	fontStyle = "OUTLINE",
}
honor:SetPoint("BOTTOM", 0, 10)

local tourGuide = cargoShip{
	name = "TourGuide",
	scale = 1.5,
	fontStyle = "OUTLINE",
}
tourGuide:SetPoint("BOTTOM", 0, 10)

local f = CreateFrame"Frame"
f:SetScript("OnEvent", function(self, event)
	if(select(2, IsInInstance()) == "pvp") then
		honor:Show()
		tourGuide:Hide()
	else
		honor:Hide()
		tourGuide:Show()
	end
end)
f:RegisterEvent"PLAYER_ENTERING_WORLD"
