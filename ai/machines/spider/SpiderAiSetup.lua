require("ai/machines/MachineAiSetup")
require("ai/machines/spider/SpiderAiData")
require("ai/machines/spider/SpiderAiThreatTracking")
if not SpiderAiSetup then
	SpiderAiSetup = class(MachineAiSetup)
end
SpiderAiSetup.init = function(l_1_0)
	MachineAiSetup.init(l_1_0)
	managers.aihivebrain:register_logicfunctions(SpiderAiThreatTracking)
end


