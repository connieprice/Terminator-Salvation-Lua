require("managers/actionmanagers/AMNpcStart")
AMCommanderStart = AMCommanderStart or class(AMNpcStart)
AMCommanderStart.unit_type = "murphy"
function AMCommanderStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMCommanderStart.unit_type)
end
