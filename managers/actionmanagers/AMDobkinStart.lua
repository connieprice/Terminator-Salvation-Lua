require("managers/actionmanagers/AMNpcStart")
AMDobkinStart = AMDobkinStart or class(AMNpcStart)
AMDobkinStart.unit_type = "dobkin"
function AMDobkinStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMDobkinStart.unit_type)
end
