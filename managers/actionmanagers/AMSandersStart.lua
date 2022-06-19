require("managers/actionmanagers/AMNpcStart")
AMSandersStart = AMSandersStart or class(AMNpcStart)
AMSandersStart.unit_type = "sanders"
function AMSandersStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMSandersStart.unit_type)
end
