require("managers/actionmanagers/AMNpcStart")
if not AMKlempStart then
	AMKlempStart = class(AMNpcStart)
end
AMKlempStart.unit_type = "klemp"
AMKlempStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMKlempStart.unit_type)
end


