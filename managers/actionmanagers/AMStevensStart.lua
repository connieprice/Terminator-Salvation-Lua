require("managers/actionmanagers/AMNpcStart")
if not AMStevensStart then
	AMStevensStart = class(AMNpcStart)
end
AMStevensStart.unit_type = "stevens"
AMStevensStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMStevensStart.unit_type)
end


