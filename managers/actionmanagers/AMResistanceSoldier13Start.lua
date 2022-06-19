require("managers/actionmanagers/AMNpcStart")
if not AMResistanceSoldier13Start then
	AMResistanceSoldier13Start = class(AMNpcStart)
end
AMResistanceSoldier13Start.unit_type = "resistance_soldier_13"
AMResistanceSoldier13Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceSoldier13Start.unit_type)
end


