local function printf(...) print(format(...)) end

SlashCmdList["RELOAD_UI"] = function() ReloadUI() end
SLASH_RELOAD_UI1 = "/rl"

SlashCmdList["DOM_TOGGLE"] = function()
	Dominos:ToggleFrames("all")
	Dominos:ShowFrames("3")
end
SLASH_DOM_TOGGLE1 = "/dt"

SlashCmdList["ITEMCOUNT"] = function(link)
	link = link:trim()
	local count = GetItemCount(link)
	local stack = select(8, GetItemInfo(link))
	printf("%dx %s (%.0f stacks)", count, link, count/stack)
end
SLASH_ITEMCOUNT1 = "/count"
SLASH_ITEMCOUNT2 = "/ic"

SlashCmdList["XP"] = function()
	local min, max, rest = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion() or 0
	printf("XP: |cffffaa00%.1f%%|r - |cffffaa00%.1f%%|r rested", min/max*100, rest/max*100)
end
SLASH_XP1 = "/xp"


local toggledAddons = { "Gatherer", "Routes" }
SlashCmdList["GATHER"] = function(msg)
	for i=1, GetNumAddOns() do
		if(toggledAddons[GetAddOnInfo(i)]) then
			if(msg == "off") then
				DisableAddOn(i)
			else
				EnableAddOn(i)
			end
		end
	end
	ReloadUI()
end
SLASH_GATHER1 = "/gath"