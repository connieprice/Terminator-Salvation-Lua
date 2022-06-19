require("managers/actionmanagers/AMNpcStart")
AMJohnConnorStart = AMJohnConnorStart or class(AMNpcStart)
AMJohnConnorStart.unit_type = "john_connor"
function AMJohnConnorStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMJohnConnorStart.unit_type)
end
