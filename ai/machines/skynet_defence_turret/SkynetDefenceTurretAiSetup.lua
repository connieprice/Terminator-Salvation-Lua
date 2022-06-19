require("ai/machines/skynet_defence_turret/SkynetDefenceTurretAiData")
require("ai/machines/skynet_defence_turret/SkynetDefenceTurretAiCombat")
SkynetDefenceTurretAiSetup = SkynetDefenceTurretAiSetup or class()
function SkynetDefenceTurretAiSetup.init(A0_0)
	managers.aihivebrain:register_logicfunctions(SkynetDefenceTurretAiCombat)
end
