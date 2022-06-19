require("managers/actionmanagers/AMNpcStart")
AMResistanceSoldier07Start = AMResistanceSoldier07Start or class(AMNpcStart)
AMResistanceSoldier07Start.unit_type = "resistance_soldier_07"
function AMResistanceSoldier07Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceSoldier07Start.unit_type)
end
