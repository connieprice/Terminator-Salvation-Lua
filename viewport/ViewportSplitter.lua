require("shared/Interpolator")
if not ViewportSplitter then
	ViewportSplitter = class()
end
ViewportSplitter.init = function(l_1_0)
	l_1_0._left_viewports = {}
	l_1_0._right_viewports = {}
	l_1_0._position = Interpolator:new(0, 0.5)
	l_1_0._spacing = 0.01
end

ViewportSplitter.update = function(l_2_0, l_2_1)
	l_2_0._position:update(l_2_1)
	l_2_0:update_viewports()
end

ViewportSplitter.add_left_viewport = function(l_3_0, l_3_1)
	local l_3_2 = assert
	l_3_2(l_3_1.rectangle:width() > 0)
	l_3_2 = l_3_0._left_viewports
	l_3_2 = #l_3_2
	l_3_2 = l_3_2 + 1
	l_3_0._left_viewports[l_3_2] = l_3_1
end

ViewportSplitter.add_right_viewport = function(l_4_0, l_4_1)
	local l_4_2 = assert
	l_4_2(l_4_1.rectangle:width() > 0)
	l_4_2 = l_4_0._right_viewports
	l_4_2 = #l_4_2
	l_4_2 = l_4_2 + 1
	l_4_0._right_viewports[l_4_2] = l_4_1
end

ViewportSplitter.remove_if_found = function(l_5_0, l_5_1)
	local l_5_5, l_5_6, l_5_7 = nil
	for i_0,i_1 in ipairs(l_5_0) do
		if i_1 == l_5_1 then
			l_5_0[i_0] = nil
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ViewportSplitter.remove_viewport = function(l_6_0, l_6_1)
	local l_6_2 = ViewportSplitter.remove_if_found(l_6_0._left_viewports, l_6_1)
	if l_6_2 then
		l_6_0:set_target_position(0)
		return 
	end
	local l_6_3 = ViewportSplitter.remove_if_found(l_6_0._right_viewports, l_6_1)
	if l_6_3 then
		l_6_0:set_target_position(1)
	end
end

ViewportSplitter.set_position = function(l_7_0, l_7_1)
	l_7_0._position:set_value(l_7_1)
end

ViewportSplitter.set_target_position = function(l_8_0, l_8_1)
	l_8_0._position:set_target(l_8_1)
	l_8_0._position:set_value(l_8_1)
end

ViewportSplitter.position = function(l_9_0)
	local l_9_1, l_9_2 = l_9_0._position:value, l_9_0._position
	return l_9_1(l_9_2)
end

ViewportSplitter.update_viewports = function(l_10_0)
end

ViewportSplitter.viewport_count = function(l_11_0)
	return TableAlgorithms.count(l_11_0._right_viewports) + TableAlgorithms.count(l_11_0._left_viewports)
end


