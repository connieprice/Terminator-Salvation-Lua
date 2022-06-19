require("managers/actionmanagers/AMNpcStart")
AMCarsonStart = AMCarsonStart or class(AMNpcStart)
AMCarsonStart.unit_type = "carson"
function AMCarsonStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMCarsonStart.unit_type)
end
