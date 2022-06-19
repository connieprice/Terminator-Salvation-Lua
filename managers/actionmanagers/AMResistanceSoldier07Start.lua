require("managers/actionmanagers/AMNpcStart")
if not AMResistanceSoldier07Start then
	AMResistanceSoldier07Start = class(AMNpcStart)
end
AMResistanceSoldier07Start.unit_type = "resistance_soldier_07"
AMResistanceSoldier07Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMResistanceSoldier07Start.unit_type)
end


