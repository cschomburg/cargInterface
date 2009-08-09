local authors = {
	["Sayskel"] = true,
}

local words = {
	"xD",
	"xd"
}

local lulz = {
	"roflkartofl",
	"roflcopter",
	"omgeez",
	"whut? lolz!",
	"lolzinglol",
	"ohmygawd",
	"roflzomgetf",
	"roufel",
	"lollikapolli",
	"omgwtfbbq",
	"kkthxbai",
	"OVER 9000",
	"lulz",
}

local function filter(self, event, msg, author, ...)
	if(not authors[author]) then return false, msg, author, ... end

	for _, word in pairs(words) do
		msg = msg:gsub(word, lulz[random(1, #lulz-1)])
	end
	return false, msg, author, ...
end
ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filter)