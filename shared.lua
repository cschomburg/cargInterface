local name, ns = ...

ns.cata = select(4, GetBuildInfo()) >= 4e3

ns.RegisterEvent = LibStub("LibCargEvents-1.0").RegisterEvent
ns.FX = LibStub("LibFx-1.1")
ns.texturePath = ([[Interface\AddOns\%s\textures\]]):format(name)

local callbacks = {}
function ns.OnLoad(func)
	table.insert(callbacks, func)

	if(#callbacks == 1) then
		ns:RegisterEvent("ADDON_LOADED", function(self, event, addon)
			if(addon == name) then
				for k,func in pairs(callbacks) do
					func()
				end
			end
		end)
	end
end

local num
function ns.RegisterSlash(slash, func)
	num = (num or 0) + 1

	local name = ("%s%d_"):format(name:upper(), num)

	SlashCmdList[name] = func

	if(type(slash) == "table") then
		for i, cmd in pairs(slash) do
			_G["SLASH_"..name..i] = cmd
		end
	else
		_G["SLASH_"..name.."1"] = slash
	end
end

function ns.printf(f, ...) print(f:format(...)) end
