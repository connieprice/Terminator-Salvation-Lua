require("managers/actionmanagers/AiUnitSpawn")
AiMachineSpawn = AiMachineSpawn or class(AiUnitSpawn)
function AiMachineSpawn._apply_behavior_options(A0_0, A1_1)
	A1_1:ai_data().startup_mode = A0_0.startup_mode
end
function AiMachineSpawn._setup_ai(A0_2, A1_3)
	AiUnitSpawn._setup_ai(A0_2, A1_3)
end
