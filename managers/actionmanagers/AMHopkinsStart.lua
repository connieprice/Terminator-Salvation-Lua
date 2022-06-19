require("managers/actionmanagers/AMNpcStart")
AMHopkinsStart = AMHopkinsStart or class(AMNpcStart)
AMHopkinsStart.unit_type = "hopkins"
function AMHopkinsStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMHopkinsStart.unit_type)
end
