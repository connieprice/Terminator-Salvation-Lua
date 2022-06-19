require("managers/actionmanagers/AiUnitSpawn")
if not AiMachineSpawn then
	AiMachineSpawn = class(AiUnitSpawn)
end
AiMachineSpawn._apply_behavior_options = function(l_1_0, l_1_1)
	l_1_1:ai_data().startup_mode = l_1_0.startup_mode
end

AiMachineSpawn._setup_ai = function(l_2_0, l_2_1)
	AiUnitSpawn._setup_ai(l_2_0, l_2_1)
end


