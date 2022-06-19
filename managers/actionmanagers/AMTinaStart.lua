require("managers/actionmanagers/AMNpcStart")
AMTinaStart = AMTinaStart or class(AMNpcStart)
AMTinaStart.unit_type = "tina"
function AMTinaStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMTinaStart.unit_type)
end
