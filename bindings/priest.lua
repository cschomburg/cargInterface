if(select(2, UnitClass'player') ~= 'PRIEST') then return end

local _, bindings = ...

local priestBase = {
	[1] = "s|Shoot",
	[2] = "s|Smite",
	[3] = "s|Flash Heal",
	[4] = "s|Renew",
	[5] = "s|Shadow Word: Pain",
	[6] = "s|Power Word: Shield",
	[7] = "s|Greater Heal",
	[8] = "s|Binding Heal",
	[9] = "s|Resurrection",
	[0] = "s|Mind Control",

	NUMPAD0 = [[m|/use Rocket Boots Xtreme Lite; /cast Levitate]],
	NUMPAD1 = "s|Pain Suppression",
	NUMPAD2 = "s|Power Infusion",
	NUMPAD3 = "s|Devouring Plague",
	NUMPAD4 = "s|Prayer of Mending",
	NUMPAD5 = "s|Shadowfiend",
	NUMPAD6 = "s|Desperate Prayer",
	NUMPAD7 = "s|Inner Focus",
	NUMPAD8 = "s|Arcane Torrent",
	NUMPAD9 = "s|Fade",
	NUMPADMINUS = "s|Lifeblood",
	NUMPADPLUS = "s|Mind Vision",

	F = "s|Dispel Magic",
	H = "s|Abolish Disease",
	V = "s|Levitate",

	shift = {
		[1] = "s|Holy Nova",
		[2] = "s|Holy Fire",
		[3] = "s|Mana Burn",
		[4] = "s|Psychic Scream",
		[5] = "s|Shadow Word: Death",
		[6] = "s|Mind Sear",
		[7] = "s|Shackle Undead",

		F = "s|Mass Dispel",
		V = [[m|/cancelaura Levitate]],
		W = "s|Magnificent Flying Carpet",
	},

	ctrl = {
		[1] = "s|Power Word: Fortitude",
		[2] = "s|Divine Spirit",
		[3] = "s|Shadow Protection",
		[4] = "s|Inner Fire",
		[5] = "s|Fear Ward",

		R = "s|Mind Blast",
		W = [[m|/cast [swimming] Sea Turtle; White War Talbuk]],
	},
}

oBindings:RegisterKeyBindings("Discipline", bindings.base, priestBase)
