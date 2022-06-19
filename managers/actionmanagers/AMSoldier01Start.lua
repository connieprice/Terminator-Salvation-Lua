require("managers/actionmanagers/AMNpcStart")
if not AMSoldier01Start then
	AMSoldier01Start = class(AMNpcStart)
end
AMSoldier01Start.unit_type = "resistance_male_01"
AMSoldier01Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSoldier01Start.unit_type)
end


