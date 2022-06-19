require("managers/actionmanagers/AiUnitSpawn")
if not AMNpcStart then
	AMNpcStart = class(AiUnitSpawn)
end
AMNpcStart.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4)
	AiUnitSpawn.init(l_1_0, l_1_1, l_1_2, l_1_4)
	l_1_0:setup(l_1_3)
	l_1_0._is_persistent = true
end

AMNpcStart._setup_ai = function(l_2_0, l_2_1)
	local l_2_2 = l_2_1:ai_data()
	if not l_2_0.brain_name then
		local l_2_3, l_2_4, l_2_5, l_2_6 = NpcStartHubElementData.brain_names[1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1:ai_nerve_system():setup(l_2_3)
	if not l_2_0.units then
		return 
	end
	managers.drama_scene:set_unit_name_to_script_name(l_2_1:name(), l_2_0._name)
	AiUnitSpawn._setup_ai(l_2_0, l_2_1)
end

AMNpcStart._spawn = function(l_3_0)
	AiUnitSpawn._spawn(l_3_0)
end


