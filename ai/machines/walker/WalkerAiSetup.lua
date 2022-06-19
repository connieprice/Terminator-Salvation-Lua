require("ai/machines/walker/WalkerAiBehavior")
require("ai/machines/walker/WalkerAiMovement")
require("ai/machines/walker/WalkerAiCombat")
require("ai/machines/walker/WalkerAiData")
if not WalkerAiSetup then
	WalkerAiSetup = class()
end
WalkerAiSetup.init = function(l_1_0)
	managers.aihivebrain:register_logicfunctions(WalkerAiBehavior)
	managers.aihivebrain:register_logicfunctions(WalkerAiMovement)
	managers.aihivebrain:register_logicfunctions(WalkerAiCombat)
end


