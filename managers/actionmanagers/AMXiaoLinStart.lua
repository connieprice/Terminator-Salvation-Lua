require("managers/actionmanagers/AMNpcStart")
if not AMXiaoLinStart then
	AMXiaoLinStart = class(AMNpcStart)
end
AMXiaoLinStart.unit_type = "xiao_lin"
AMXiaoLinStart.init = function(l_1_0, l_1_1, l_1_2)
	AMNpcStart.init(l_1_0, l_1_1, l_1_2, AMXiaoLinStart.unit_type)
end


