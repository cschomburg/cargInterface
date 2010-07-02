local data = {}

local function filter(self, event, msg, author)
	if(data[author] and data[author] == msg) then
		return true
	else
		data[author] = msg
		return false
	end
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", filter)
