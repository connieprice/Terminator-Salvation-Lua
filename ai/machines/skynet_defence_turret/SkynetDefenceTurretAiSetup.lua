require("ai/machines/skynet_defence_turret/SkynetDefenceTurretAiData")
require("ai/machines/skynet_defence_turret/SkynetDefenceTurretAiCombat")
if not SkynetDefenceTurretAiSetup then
	SkynetDefenceTurretAiSetup = class()
end
SkynetDefenceTurretAiSetup.init = function(l_1_0)
	managers.aihivebrain:register_logicfunctions(SkynetDefenceTurretAiCombat)
end


