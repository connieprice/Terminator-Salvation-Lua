require("managers/actionmanagers/AMNpcStart")
AMKlempStart = AMKlempStart or class(AMNpcStart)
AMKlempStart.unit_type = "klemp"
function AMKlempStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMKlempStart.unit_type)
end
