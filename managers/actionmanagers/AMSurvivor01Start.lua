require("managers/actionmanagers/AMNpcStart")
AMSurvivor01Start = AMSurvivor01Start or class(AMNpcStart)
AMSurvivor01Start.unit_type = "survivor_01"
function AMSurvivor01Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivor01Start.unit_type)
end
