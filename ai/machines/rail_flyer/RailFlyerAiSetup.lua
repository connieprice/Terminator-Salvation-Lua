require("ai/machines/rail_flyer/RailFlyerAiData")
require("ai/machines/rail_flyer/RailFlyerAiMove")
require("ai/machines/rail_flyer/RailFlyerAiCombat")
RailFlyerAiSetup = RailFlyerAiSetup or class()
function RailFlyerAiSetup.init(A0_0)
	managers.aihivebrain:register_logicfunctions(RailFlyerAiMove)
	managers.aihivebrain:register_logicfunctions(RailFlyerAiCombat)
end
