require("managers/actionmanagers/AMNpcStart")
if not AMOgradyStart then
	AMOgradyStart = class(AMNpcStart)
end
AMOgradyStart.unit_type = "ogrady"
AMOgradyStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMOgradyStart.unit_type)
end


