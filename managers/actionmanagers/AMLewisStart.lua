require("managers/actionmanagers/AMNpcStart")
AMLewisStart = AMLewisStart or class(AMNpcStart)
AMLewisStart.unit_type = "lewis"
function AMLewisStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMLewisStart.unit_type)
end
