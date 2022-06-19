require("ai/machines/hunter_killer/HunterKillerAiData")
require("ai/machines/hunter_killer/HunterKillerAiCombat")
require("ai/machines/hunter_killer/HunterKillerAiDefence")
HunterKillerAiSetup = HunterKillerAiSetup or class()
function HunterKillerAiSetup.init(A0_0)
	managers.aihivebrain:register_logicfunctions(HunterKillerAiCombat)
	managers.aihivebrain:register_logicfunctions(HunterKillerAiDefence)
end
