require("managers/actionmanagers/AMNpcStart")
AMCrazyResistanceStart = AMCrazyResistanceStart or class(AMNpcStart)
AMCrazyResistanceStart.unit_type = "crazy_resistance_soldier"
function AMCrazyResistanceStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMCrazyResistanceStart.unit_type)
end
