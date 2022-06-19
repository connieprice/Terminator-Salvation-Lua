require("ai/common/CommonAiLod")
require("ai/common/CommonAiSensoryEventsHandler")
require("ai/common/CommonAiThreatTracking")
require("ai/common/CommonAiTargeting")
require("ai/common/CommonAiBehavior")
require("ai/common/CommonAiMovement")
require("ai/common/CommonAiCombat")
require("ai/common/CommonAiFindCover")
require("ai/common/CommonAiSelfDestroy")
if not CommonAiSetup then
	CommonAiSetup = class()
end
CommonAiSetup.init = function(l_1_0)
	managers.aihivebrain:register_logicfunctions(CommonAiLod)
	managers.aihivebrain:register_logicfunctions(CommonAiSensoryEventsHandler)
	managers.aihivebrain:register_logicfunctions(CommonAiThreatTracking)
	managers.aihivebrain:register_logicfunctions(CommonAiTargeting)
	managers.aihivebrain:register_logicfunctions(CommonAiFindCover)
	managers.aihivebrain:register_logicfunctions(CommonAiBehavior)
	managers.aihivebrain:register_logicfunctions(CommonAiMovement)
	managers.aihivebrain:register_logicfunctions(CommonAiCombat)
	managers.aihivebrain:register_logicfunctions(CommonAiSelfDestroy)
end


