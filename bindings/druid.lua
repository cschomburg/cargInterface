if(select(2, UnitClass'player') ~= 'DRUID') then return end

local _, bindings = ...

local druidBase = {
	[1] = "s|Attack",
	[2] = "s|Wrath",
	[3] = "s|Healing Touch",
	[4] = "s|Rejuvenation",
	[5] = "s|Moonfire",
	[6] = "s|Regrowth",
	[7] = "s|Entangling Roots",
	[8] = nil,
	[9] = "s|Revive",

	NUMPAD1 = "s|Abolish Poison",
	NUMPAD2 = "s|Remove Curse",
	NUMPAD3 = nil,
	NUMPAD4 = "s|Hurricane",
	NUMPAD5 = "s|Innervate",
	NUMPAD6 = nil,
	NUMPAD7 = nil,
	NUMPAD8 = "s|War Stomp",
	NUMPAD9 = "s|Barkskin",

	F = "s|Dire Bear Form",
	V = "s|Cat Form",
	G = "s|Travel Form",

	shift = {
		[1] = "s|Tranquility",
		[2] = "s|Starfire",
		[4] = "s|Lifebloom",

		[9] = "s|Rebirth",

		W = "s|Flight Form",
	},

	ctrl = {
		W = [[m|/cast [stance:3] Dash; [swimming] Aqua Form; Swift Zhevra]],
	},

	cat = {
		[1] = "s|Prowl",
		[2] = "s|Mangle (Cat)",
		[3] = "s|Ferocious Bite",
		[4] = [[m|/cast [stealth] Pounce; Rake]],
		[5] = [[m|/cast [stealth] Ravage; Shred]],
		[6] = "s|Feral Charge - Cat",
		[7] = "s|Faerie Fire (Feral)",
		[8] = "s|Cower",
		[9] = "s|Rip",
		[0] = "s|Moonfire",

		NUMPAD3 = "s|Tiger's Fury",
	},

	bear = {
		[1] = "s|Growl",
		[2] = "s|Maul",
		[3] = "s|Swipe (Bear)",
		[4] = "s|Bash",
		[5] = "s|Demoralizing Roar",
		[6] = "s|Feral Charge - Bear",
		[7] = "s|Faerie Fire (Feral)",
		[8] = "s|Enrage",
	},
}

oBindings:RegisterKeyBindings("Feral Combat", bindings.base, druidBase)
