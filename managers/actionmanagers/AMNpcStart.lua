require("managers/actionmanagers/AiUnitSpawn")
AMNpcStart = AMNpcStart or class(AiUnitSpawn)
function AMNpcStart.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	AiUnitSpawn.init(A0_0, A1_1, A2_2, A4_4)
	A0_0:setup(A3_3)
	A0_0._is_persistent = true
end
function AMNpcStart._setup_ai(A0_5, A1_6)
	local L2_7, L3_8
	L3_8 = A1_6
	L2_7 = A1_6.ai_data
	L2_7 = L2_7(L3_8)
	L3_8 = A0_5.brain_name
	L3_8 = L3_8 or NpcStartHubElementData.brain_names[1]
	A1_6:ai_nerve_system():setup(L3_8)
	if not A0_5.units then
		return
	end
	managers.drama_scene:set_unit_name_to_script_name(A1_6:name(), A0_5._name)
	AiUnitSpawn._setup_ai(A0_5, A1_6)
end
function AMNpcStart._spawn(A0_9)
	AiUnitSpawn._spawn(A0_9)
end
