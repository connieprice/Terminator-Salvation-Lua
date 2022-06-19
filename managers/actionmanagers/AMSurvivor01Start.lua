require("managers/actionmanagers/AMNpcStart")
if not AMSurvivor01Start then
	AMSurvivor01Start = class(AMNpcStart)
end
AMSurvivor01Start.unit_type = "survivor_01"
AMSurvivor01Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivor01Start.unit_type)
end


