require("managers/actionmanagers/AMNpcStart")
if not AMCrazyResistanceStart then
	AMCrazyResistanceStart = class(AMNpcStart)
end
AMCrazyResistanceStart.unit_type = "crazy_resistance_soldier"
AMCrazyResistanceStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMCrazyResistanceStart.unit_type)
end


