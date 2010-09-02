if(select(2, UnitClass'player') ~= 'DRUID') then return end

local _, bindings = ...

local druidMisc = {
	[1] = "s|Regrowth",
	[2] = "s|Wrath",
	[3] = "s|Nourish",
	[4] = "s|Rejuvenation",
	[5] = "s|Moonfire",

	[6] = "s|Healing Touch",
	[7] = "s|Wild Growth", -- Resto
	[8] = nil,
	[9] = "s|Revive",

	NUMPAD1 = "s|Abolish Poison",
	NUMPAD2 = "s|Remove Curse",
	NUMPAD3 = "s|Hibernate",

	NUMPAD4 = "s|Barkskin",
	NUMPAD5 = "s|Tranquility",
	NUMPAD6 = "s|Survival Instincts",

	NUMPAD7 = "s|Nature's Swiftness", -- Resto
	NUMPAD8 = "s|War Stomp",
	NUMPAD9 = nil,

	F = "s|Dire Bear Form",
	V = "s|Cat Form",
	G = "s|Travel Form",
	T = "s|Tree of Life", -- Resto

	shift = {
		[1] = "m|/cast [form:1] Feral Charge - Bear; [form:3] Feral Charge - Cat; Hurricane",
		[2] = "m|/cast [form:1/3] Faerie Fire (Feral); Faerie Fire",
		[3] = "s|Swiftmend", -- Resto
		[4] = "m|/cast [form:3] Savage Roar; Lifebloom",
		[5] = "m|/cast [form:3] Rip; Innervate",

		[6] = "s|Entangling Roots",

		[9] = "s|Rebirth",

		W = "s|Swift Flight Form",
	},

	ctrl = {
		[1] = "s|Mark of the Wild",
		[2] = "s|Thorns",
		[3] = "s|Nature's Grasp",

		W = [[m|/cast [form:3] Dash; [swimming] Aquatic Form; Swift Zhevra]],
	},

	cat = {
		[1] = "s|Prowl",
		[2] = "s|Mangle (Cat)", -- Feral
		[3] = "s|Ferocious Bite",
		[4] = [[m|/cast [stealth] Pounce; Rake]],
		[5] = [[m|/cast [stealth] Ravage; Shred]],

		NUMPAD5 = "s|Tiger's Fury",
		NUMPAD9 = "s|Cower",
	},

	bear = {
		[1] = "m|/cast Lacerate\n/cast !Maul\n/startattack [harm]",
		[2] = "m|/cast Mangle (Bear)\n/cast !Maul\n/startattack [harm]",
		[3] = "s|Swipe (Bear)\n/cast !Maul\n/startattack [harm]",
		[4] = "s|Demoralizing Roar",
		[5] = "s|Maul",

		NUMPAD5 = "s|Enrage",
		NUMPAD8 = "s|Bash",
		NUMPAD9 = "s|Frenzied Regeneration",

	},
}

oBindings:RegisterKeyBindings("Feral Combat", bindings.base, druidMisc)
oBindings:RegisterKeyBindings("Restoration", bindings.base, druidMisc)
