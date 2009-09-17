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