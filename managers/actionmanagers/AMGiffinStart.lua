require("managers/actionmanagers/AMNpcStart")
if not AMGiffinStart then
	AMGiffinStart = class(AMNpcStart)
end
AMGiffinStart.unit_type = "giffin"
AMGiffinStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMGiffinStart.unit_type)
end


