require("ai/machines/MachineAiSetup")
require("ai/machines/spider/SpiderAiData")
require("ai/machines/spider/SpiderAiThreatTracking")
SpiderAiSetup = SpiderAiSetup or class(MachineAiSetup)
function SpiderAiSetup.init(A0_0)
	MachineAiSetup.init(A0_0)
	managers.aihivebrain:register_logicfunctions(SpiderAiThreatTracking)
end
