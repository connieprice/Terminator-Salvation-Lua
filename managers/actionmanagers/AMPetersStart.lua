require("managers/actionmanagers/AMNpcStart")
AMPetersStart = AMPetersStart or class(AMNpcStart)
AMPetersStart.unit_type = "peters"
function AMPetersStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMPetersStart.unit_type)
end
