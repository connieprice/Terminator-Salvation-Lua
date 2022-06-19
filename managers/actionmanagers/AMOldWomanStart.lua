require("managers/actionmanagers/AMNpcStart")
if not AMOldWomanStart then
	AMOldWomanStart = class(AMNpcStart)
end
AMOldWomanStart.unit_type = "old_woman"
AMOldWomanStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMOldWomanStart.unit_type)
end


