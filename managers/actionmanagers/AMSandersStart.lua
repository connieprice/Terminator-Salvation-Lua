require("managers/actionmanagers/AMNpcStart")
if not AMSandersStart then
	AMSandersStart = class(AMNpcStart)
end
AMSandersStart.unit_type = "sanders"
AMSandersStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMSandersStart.unit_type)
end


