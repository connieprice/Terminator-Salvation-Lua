require("managers/actionmanagers/AMNpcStart")
AMOgradyStart = AMOgradyStart or class(AMNpcStart)
AMOgradyStart.unit_type = "ogrady"
function AMOgradyStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMOgradyStart.unit_type)
end
