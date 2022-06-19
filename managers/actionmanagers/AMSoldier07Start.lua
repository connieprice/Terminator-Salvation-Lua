require("managers/actionmanagers/AMNpcStart")
if not AMSoldier07Start then
	AMSoldier07Start = class(AMNpcStart)
end
AMSoldier07Start.unit_type = "resistance_male_07"
AMSoldier07Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSoldier07Start.unit_type)
end


