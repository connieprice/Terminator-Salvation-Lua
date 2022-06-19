require("managers/actionmanagers/AMNpcStart")
AMAvaStart = AMAvaStart or class(AMNpcStart)
AMAvaStart.unit_type = "ava"
function AMAvaStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMAvaStart.unit_type)
end
