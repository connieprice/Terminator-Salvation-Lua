require("managers/actionmanagers/AMNpcStart")
AMResistanceSoldier13Start = AMResistanceSoldier13Start or class(AMNpcStart)
AMResistanceSoldier13Start.unit_type = "resistance_soldier_13"
function AMResistanceSoldier13Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMResistanceSoldier13Start.unit_type)
end
