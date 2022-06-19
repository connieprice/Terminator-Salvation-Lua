require("managers/actionmanagers/AMNpcStart")
if not AMAvaStart then
	AMAvaStart = class(AMNpcStart)
end
AMAvaStart.unit_type = "ava"
AMAvaStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMAvaStart.unit_type)
end


