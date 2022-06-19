require("managers/actionmanagers/AMNpcStart")
AMResistanceSoldier15Start = AMResistanceSoldier15Start or class(AMNpcStart)
AMResistanceSoldier15Start.unit_type = "resistance_soldier_15"
function AMResistanceSoldier15Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceSoldier15Start.unit_type)
end
