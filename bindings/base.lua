local _, bindings = ...

bindings.base = {
	B = "OPENALLBAGS",
	H = "TOGGLECHARACTER4",
	Y = "TOGGLESHEATH",
	T= "TARGETFOCUS",

	NUMPADDIVIDE = "TOGGLEAUTORUN",
	['<'] = "TOGGLERUN",
	['^'] = "LUACONSOLE",

	[';'] = "TOGGLESPELLBOOK",

	shift = {
		T = "FOCUSTARGET",
		E = "INQUIRO_MOUSEOVER",
		V = "m|/cast Traveler's Tundra Mammoth"
	},

	F5 = "m|/run ReloadUI()",
}
