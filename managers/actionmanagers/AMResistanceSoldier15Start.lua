require("managers/actionmanagers/AMNpcStart")
if not AMResistanceSoldier15Start then
	AMResistanceSoldier15Start = class(AMNpcStart)
end
AMResistanceSoldier15Start.unit_type = "resistance_soldier_15"
AMResistanceSoldier15Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceSoldier15Start.unit_type)
end


