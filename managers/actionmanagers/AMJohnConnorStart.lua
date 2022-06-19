require("managers/actionmanagers/AMNpcStart")
if not AMJohnConnorStart then
	AMJohnConnorStart = class(AMNpcStart)
end
AMJohnConnorStart.unit_type = "john_connor"
AMJohnConnorStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMJohnConnorStart.unit_type)
end


