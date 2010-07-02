local name, ns = ...

ns.RegisterSlash("/rl", ReloadUI)

ns.RegisterSlash({"/count", "/ic"}, function(link)
	link = link:trim()
	local count = GetItemCount(link)
	local stack = select(8, GetItemInfo(link))
	printf("%dx %s (%.0f stacks)", count, link, count/stack)
end)

ns.RegisterSlash("/xp", function()
	local min, max, rest = UnitXP("player"), UnitXPMax("player"), GetXPExhaustion() or 0
	ns.printf("XP: |cffffaa00%.1f%%|r - |cffffaa00%.1f%%|r rested", min/max*100, rest/max*100)
end)
