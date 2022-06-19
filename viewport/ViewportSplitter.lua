require("shared/Interpolator")
ViewportSplitter = ViewportSplitter or class()
function ViewportSplitter.init(A0_0)
	A0_0._left_viewports = {}
	A0_0._right_viewports = {}
	A0_0._position = Interpolator:new(0, 0.5)
	A0_0._spacing = 0.01
end
function ViewportSplitter.update(A0_1, A1_2)
	A0_1._position:update(A1_2)
	A0_1:update_viewports()
end
function ViewportSplitter.add_left_viewport(A0_3, A1_4)
	assert(A1_4.rectangle:width() > 0)
	A0_3._left_viewports[#A0_3._left_viewports + 1] = A1_4
end
function ViewportSplitter.add_right_viewport(A0_5, A1_6)
	assert(A1_6.rectangle:width() > 0)
	A0_5._right_viewports[#A0_5._right_viewports + 1] = A1_6
end
function ViewportSplitter.remove_if_found(A0_7, A1_8)
	for 