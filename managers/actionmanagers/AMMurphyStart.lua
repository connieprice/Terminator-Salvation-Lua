require("managers/actionmanagers/AMNpcStart")
if not AMMurphyStart then
	AMMurphyStart = class(AMNpcStart)
end
AMMurphyStart.unit_type = "murphy"
AMMurphyStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMMurphyStart.unit_type)
end


