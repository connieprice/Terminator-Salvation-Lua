require("managers/actionmanagers/AiMachineSpawn")
AMFlyerStart = AMFlyerStart or class(AiMachineSpawn)
function AMFlyerStart.init(A0_0, A1_1, A2_2)
	AiUnitSpawn.init(A0_0, A1_1, A2_2)
	A0_0:setup("flyer")
end
function AMFlyerStart._setup_ai(A0_3, A1_4)
	local L2_5
	L2_5 = A0_3.brain_name
	if L2_5 == "rail" then
		L2_5 = A0_3.setup_rail_flier
		L2_5(A0_3, A1_4)
	else
		L2_5 = A1_4.ai_data
		L2_5 = L2_5(A1_4)
		L2_5.default_speed = A0_3.speed
	end
	L2_5 = A0_3.brain_name
	L2_5 = L2_5 or FlyerStartHubElementData.brain_names[1]
	A1_4:ai_nerve_system():setup(L2_5)
	if not A0_3.units then
		return
	end
	A0_3:_apply_behavior_options(A1_4)
	A1_4:base():set_search_light_enabled(A0_3.search_lights)
	AiMachineSpawn._setup_ai(A0_3, A1_4)
end
function AMFlyerStart.setup_rail_flier(A0_6, A1_7)
	A1_7:ai_data().default_speed = A0_6.speed or 3
	A1_7:ai_data().input.enemy_slot_mask = "rail_vehicles"
	if A0_6.target_range == nil then
		A0_6.target_range = 40
	end
	A1_7:ai_data().input.target_range = A0_6.target_range * 100
end
