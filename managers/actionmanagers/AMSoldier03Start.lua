require("managers/actionmanagers/AMNpcStart")
if not AMSoldier03Start then
	AMSoldier03Start = class(AMNpcStart)
end
AMSoldier03Start.unit_type = "resistance_male_03"
AMSoldier03Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSoldier03Start.unit_type)
end


