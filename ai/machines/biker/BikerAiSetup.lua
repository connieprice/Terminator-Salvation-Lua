require("ai/machines/biker/BikerAiData")
require("ai/machines/biker/BikerAiCombat")
require("ai/machines/biker/BikerAiMove")
BikerAiSetup = BikerAiSetup or class()
function BikerAiSetup.init(A0_0)
	managers.aihivebrain:register_logicfunctions(BikerAiCombat)
	managers.aihivebrain:register_logicfunctions(BikerAiMove)
end
