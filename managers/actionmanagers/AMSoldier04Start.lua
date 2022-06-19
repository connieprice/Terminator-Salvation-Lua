require("managers/actionmanagers/AMNpcStart")
if not AMSoldier04Start then
	AMSoldier04Start = class(AMNpcStart)
end
AMSoldier04Start.unit_type = "resistance_male_04"
AMSoldier04Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSoldier04Start.unit_type)
end


