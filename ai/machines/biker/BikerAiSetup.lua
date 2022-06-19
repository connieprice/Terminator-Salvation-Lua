require("ai/machines/biker/BikerAiData")
require("ai/machines/biker/BikerAiCombat")
require("ai/machines/biker/BikerAiMove")
if not BikerAiSetup then
	BikerAiSetup = class()
end
BikerAiSetup.init = function(l_1_0)
	managers.aihivebrain:register_logicfunctions(BikerAiCombat)
	managers.aihivebrain:register_logicfunctions(BikerAiMove)
end


