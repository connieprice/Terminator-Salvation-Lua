require("managers/actionmanagers/AMNpcStart")
AMMurphyStart = AMMurphyStart or class(AMNpcStart)
AMMurphyStart.unit_type = "murphy"
function AMMurphyStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMMurphyStart.unit_type)
end
