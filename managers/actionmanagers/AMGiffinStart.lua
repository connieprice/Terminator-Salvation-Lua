require("managers/actionmanagers/AMNpcStart")
AMGiffinStart = AMGiffinStart or class(AMNpcStart)
AMGiffinStart.unit_type = "giffin"
function AMGiffinStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMGiffinStart.unit_type)
end
