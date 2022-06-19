require("managers/actionmanagers/AMNpcStart")
if not AMSurvivor02Start then
	AMSurvivor02Start = class(AMNpcStart)
end
AMSurvivor02Start.unit_type = "survivor_02"
AMSurvivor02Start.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSurvivor02Start.unit_type)
end


