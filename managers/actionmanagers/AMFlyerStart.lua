require("managers/actionmanagers/AiMachineSpawn")
if not AMFlyerStart then
	AMFlyerStart = class(AiMachineSpawn)
end
AMFlyerStart.init = function(l_1_0, l_1_1, l_1_2)
	AiUnitSpawn.init(l_1_0, l_1_1, l_1_2)
	l_1_0:setup("flyer")
end

AMFlyerStart._setup_ai = function(l_2_0, l_2_1)
	if l_2_0.brain_name == "rail" then
		l_2_0:setup_rail_flier(l_2_1)
	else
		l_2_1:ai_data().default_speed = l_2_0.speed
	end
	if not l_2_0.brain_name then
		local l_2_2, l_2_3, l_2_4, l_2_5, l_2_6 = FlyerStartHubElementData.brain_names[1]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_2_1:ai_nerve_system():setup(l_2_2)
	if not l_2_0.units then
		return 
	end
	l_2_0:_apply_behavior_options(l_2_1)
	l_2_1:base():set_search_light_enabled(l_2_0.search_lights)
	AiMachineSpawn._setup_ai(l_2_0, l_2_1)
end

AMFlyerStart.setup_rail_flier = function(l_3_0, l_3_1)
	local l_3_2 = l_3_1:ai_data()
	l_3_2.default_speed = l_3_0.speed or 3
	l_3_2.input.enemy_slot_mask = "rail_vehicles"
	if l_3_0.target_range == nil then
		l_3_0.target_range = 40
	end
	l_3_2.input.target_range = l_3_0.target_range * 100
end


