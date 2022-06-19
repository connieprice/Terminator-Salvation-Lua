require("viewport/ViewportSplitter")
if not HorizontalViewportSplitter then
	HorizontalViewportSplitter = class(ViewportSplitter)
end
HorizontalViewportSplitter.init = function(l_1_0)
	ViewportSplitter.init(l_1_0)
	l_1_0._offset = 0
	l_1_0._spacing = 0
end

HorizontalViewportSplitter.update_viewports = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17, l_2_18, l_2_19, l_2_20, l_2_21, l_2_22, l_2_23, l_2_24, l_2_25, l_2_26, l_2_27, l_2_28 = nil
	ViewportSplitter.update_viewports(l_2_0)
	local l_2_1 = l_2_0:position()
	for i_0,i_1 in pairs(l_2_0._left_viewports) do
		i_1.rectangle.bottom = l_2_1 - l_2_0._spacing
		i_1.rectangle.right = 1 - l_2_0._offset
		i_1.rectangle.left = 0
	end
	for i_0,i_1 in pairs(l_2_0._right_viewports) do
		i_1.rectangle.top = l_2_1 + l_2_0._spacing
		i_1.rectangle.left = l_2_0._offset
		i_1.rectangle.right = 1
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

HorizontalViewportSplitter.set_offset = function(l_3_0, l_3_1)
	l_3_0._offset = l_3_1
end

HorizontalViewportSplitter.set_spacing = function(l_4_0, l_4_1)
	l_4_0._spacing = l_4_1
end


