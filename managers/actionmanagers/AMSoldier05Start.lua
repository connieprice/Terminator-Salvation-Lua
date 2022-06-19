require("managers/actionmanagers/AMNpcStart")
if not AMSoldier05Start then
	AMSoldier05Start = class(AMNpcStart)
end
AMSoldier05Start.unit_type = "resistance_male_05"
AMSoldier05Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSoldier05Start.unit_type)
end


