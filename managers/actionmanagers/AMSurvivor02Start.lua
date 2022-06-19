require("managers/actionmanagers/AMNpcStart")
AMSurvivor02Start = AMSurvivor02Start or class(AMNpcStart)
AMSurvivor02Start.unit_type = "survivor_02"
function AMSurvivor02Start.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSurvivor02Start.unit_type)
end
