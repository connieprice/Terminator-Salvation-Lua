require("managers/actionmanagers/AiUnitSpawn")
AMMetalWalkerStart = AMMetalWalkerStart or class(AiUnitSpawn)
function AMMetalWalkerStart.init(A0_0, A1_1, A2_2)
	AiUnitSpawn.init(A0_0, A1_1, A2_2)
	A0_0:setup(A0_0.model or "metal_walker")
end
function AMMetalWalkerStart._setup_ai(A0_3, A1_4)
	local L2_5, L3_6
	L3_6 = A1_4
	L2_5 = A1_4.ai_data
	L2_5 = L2_5(L3_6)
	L3_6 = A0_3.brain_name
	L3_6 = L3_6 or WalkerStartHubElementData.brain_names[1]
	A1_4:ai_nerve_system():setup(L3_6)
	if not A0_3.units then
		return
	end
	AiUnitSpawn._setup_ai(A0_3, A1_4)
end
