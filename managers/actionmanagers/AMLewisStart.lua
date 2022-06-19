require("managers/actionmanagers/AMNpcStart")
if not AMLewisStart then
	AMLewisStart = class(AMNpcStart)
end
AMLewisStart.unit_type = "lewis"
AMLewisStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMLewisStart.unit_type)
end


