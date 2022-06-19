require("managers/actionmanagers/AMNpcStart")
AMOldWomanStart = AMOldWomanStart or class(AMNpcStart)
AMOldWomanStart.unit_type = "old_woman"
function AMOldWomanStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMOldWomanStart.unit_type)
end
