require("managers/actionmanagers/AMNpcStart")
AMXiaoLinStart = AMXiaoLinStart or class(AMNpcStart)
AMXiaoLinStart.unit_type = "xiao_lin"
function AMXiaoLinStart.init(A0_0, A1_1, A2_2)
	AMNpcStart.init(A0_0, A1_1, A2_2, AMXiaoLinStart.unit_type)
end
