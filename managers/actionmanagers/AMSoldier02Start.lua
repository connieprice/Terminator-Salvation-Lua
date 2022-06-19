require("managers/actionmanagers/AMNpcStart")
if not AMSoldier02Start then
	AMSoldier02Start = class(AMNpcStart)
end
AMSoldier02Start.unit_type = "resistance_male_02"
AMSoldier02Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSoldier02Start.unit_type)
end


