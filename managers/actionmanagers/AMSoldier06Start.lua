require("managers/actionmanagers/AMNpcStart")
if not AMSoldier06Start then
	AMSoldier06Start = class(AMNpcStart)
end
AMSoldier06Start.unit_type = "resistance_male_06"
AMSoldier06Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSoldier06Start.unit_type)
end


