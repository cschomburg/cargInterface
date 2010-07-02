local who = {}

local function filter(self, event, msg, author, ...)
	if(who[author]) then return end

	who[author] = true
	SendWho(author)
end

ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
