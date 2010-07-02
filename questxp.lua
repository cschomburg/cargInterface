-- Display XP reward procentual
function QuestInfoXPFramePoints:SetText(text)
	local points = tonumber(text)
	if(points) then
		self:SetFormattedText("%.1f%%  -  %d", points/UnitXPMax("player")*100, points)
	else
		self:SetFormattedText(text)
	end
end
