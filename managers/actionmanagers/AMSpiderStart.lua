require("managers/actionmanagers/AiMachineSpawn")
AMSpiderStart = AMSpiderStart or class(AiMachineSpawn)
function AMSpiderStart.init(A0_0, A1_1, A2_2)
	AiUnitSpawn.init(A0_0, A1_1, A2_2)
	A0_0:setup("spider")
end
function AMSpiderStart._setup_ai(A0_3, A1_4)
	local L2_5, L3_6
	L3_6 = A1_4
	L2_5 = A1_4.ai_data
	L2_5 = L2_5(L3_6)
	L3_6 = A0_3.brain_name
	L3_6 = L3_6 or SpiderStartHubElementData.brain_names[1]
	A1_4:ai_nerve_system():setup(L3_6)
	if not A0_3.units then
		return
	end
	A0_3:_apply_behavior_options(A1_4)
	AiMachineSpawn._setup_ai(A0_3, A1_4)
end
