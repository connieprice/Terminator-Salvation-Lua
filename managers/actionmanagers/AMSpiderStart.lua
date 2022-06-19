require("managers/actionmanagers/AiMachineSpawn")
if not AMSpiderStart then
	AMSpiderStart = class(AiMachineSpawn)
end
AMSpiderStart.init = function(l_1_0, l_1_1, l_1_2)
	AiUnitSpawn.init(l_1_0, l_1_1, l_1_2)
	l_1_0:setup("spider")
end

AMSpiderStart._setup_ai = function(l_2_0, l_2_1)
	local l_2_2 = l_2_1:ai_data()
	if not l_2_0.brain_name then
		local l_2_3, l_2_4, l_2_5, l_2_6 = SpiderStartHubElementData.brain_names[1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1:ai_nerve_system():setup(l_2_3)
	if not l_2_0.units then
		return 
	end
	l_2_0:_apply_behavior_options(l_2_1)
	AiMachineSpawn._setup_ai(l_2_0, l_2_1)
end


