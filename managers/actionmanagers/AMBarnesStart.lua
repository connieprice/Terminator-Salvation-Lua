require("managers/actionmanagers/AMNpcStart")
AMBarnesStart = AMBarnesStart or class(AMNpcStart)
AMBarnesStart.unit_type = "barnes"
function AMBarnesStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMBarnesStart.unit_type)
end
