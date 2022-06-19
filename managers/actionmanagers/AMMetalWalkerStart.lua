require("managers/actionmanagers/AiUnitSpawn")
if not AMMetalWalkerStart then
	AMMetalWalkerStart = class(AiUnitSpawn)
end
AMMetalWalkerStart.init = function(l_1_0, l_1_1, l_1_2)
	AiUnitSpawn.init(l_1_0, l_1_1, l_1_2)
	l_1_0:setup(l_1_0.model or "metal_walker")
end

AMMetalWalkerStart._setup_ai = function(l_2_0, l_2_1)
	local l_2_2 = l_2_1:ai_data()
	if not l_2_0.brain_name then
		local l_2_3, l_2_4, l_2_5 = WalkerStartHubElementData.brain_names[1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1:ai_nerve_system():setup(l_2_3)
	if not l_2_0.units then
		return 
	end
	AiUnitSpawn._setup_ai(l_2_0, l_2_1)
end


