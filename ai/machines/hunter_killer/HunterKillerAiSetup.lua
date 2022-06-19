require("ai/machines/hunter_killer/HunterKillerAiData")
require("ai/machines/hunter_killer/HunterKillerAiCombat")
require("ai/machines/hunter_killer/HunterKillerAiDefence")
if not HunterKillerAiSetup then
	HunterKillerAiSetup = class()
end
HunterKillerAiSetup.init = function(l_1_0)
	managers.aihivebrain:register_logicfunctions(HunterKillerAiCombat)
	managers.aihivebrain:register_logicfunctions(HunterKillerAiDefence)
end


