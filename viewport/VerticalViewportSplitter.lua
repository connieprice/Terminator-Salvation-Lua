require("viewport/ViewportSplitter")
if not VerticalViewportSplitter then
	VerticalViewportSplitter = class(ViewportSplitter)
end
VerticalViewportSplitter.update_viewports = function(l_1_0)
	local l_1_6, l_1_7, l_1_8, l_1_9, l_1_10, l_1_11, l_1_12, l_1_13 = nil
	ViewportSplitter.update_viewports(l_1_0)
	local l_1_1 = l_1_0:position()
	local l_1_2 = 0
	for i_0,i_1 in pairs(l_1_0._left_viewports) do
		i_1.rectangle.right = l_1_1 - l_1_2
	end
	for i_0,i_1 in pairs(l_1_0._right_viewports) do
		i_1.rectangle.left = l_1_1 + l_1_2
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


