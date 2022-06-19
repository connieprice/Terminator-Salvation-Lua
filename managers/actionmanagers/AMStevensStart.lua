require("managers/actionmanagers/AMNpcStart")
AMStevensStart = AMStevensStart or class(AMNpcStart)
AMStevensStart.unit_type = "stevens"
function AMStevensStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMStevensStart.unit_type)
end
