require("ai/machines/rail_flyer/RailFlyerAiData")
require("ai/machines/rail_flyer/RailFlyerAiMove")
require("ai/machines/rail_flyer/RailFlyerAiCombat")
if not RailFlyerAiSetup then
	RailFlyerAiSetup = class()
end
RailFlyerAiSetup.init = function(l_1_0)
	managers.aihivebrain:register_logicfunctions(RailFlyerAiMove)
	managers.aihivebrain:register_logicfunctions(RailFlyerAiCombat)
end


