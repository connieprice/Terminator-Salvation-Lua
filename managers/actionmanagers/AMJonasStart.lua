require("managers/actionmanagers/AMNpcStart")
AMJonasStart = AMJonasStart or class(AMNpcStart)
AMJonasStart.unit_type = "jones"
function AMJonasStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMJonasStart.unit_type)
end
