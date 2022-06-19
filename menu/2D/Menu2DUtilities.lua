if not Menu2DUtilities then
	Menu2DUtilities = {}
end
Menu2DUtilities.is_position_over_gui_object = function(l_1_0, l_1_1)
	local l_1_2, l_1_3, l_1_4, l_1_5 = l_1_1:world_shape()
	local l_1_6 = Menu2DUtilities.is_position_over_rect
	local l_1_7 = l_1_0
	local l_1_8 = l_1_2
	local l_1_9 = l_1_3
	local l_1_10 = l_1_4
	local l_1_11 = l_1_5
	return l_1_6(l_1_7, l_1_8, l_1_9, l_1_10, l_1_11)
end

Menu2DUtilities.is_position_over_rect = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4)
	return l_2_1 <= l_2_0.x and l_2_0.x <= l_2_1 + l_2_3 and l_2_2 <= l_2_0.y and l_2_0.y <= l_2_2 + l_2_4
end

Menu2DUtilities.position_over_gui_object = function(l_3_0, l_3_1)
	local l_3_2, l_3_3, l_3_4, l_3_5 = l_3_1:world_shape()
	local l_3_6 = Menu2DUtilities.position_over_rect
	local l_3_7 = l_3_0
	local l_3_8 = l_3_2
	local l_3_9 = l_3_3
	local l_3_10 = l_3_4
	local l_3_11 = l_3_5
	return l_3_6(l_3_7, l_3_8, l_3_9, l_3_10, l_3_11)
end

Menu2DUtilities.position_over_rect = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
	if not Menu2DUtilities.is_position_over_rect(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4) then
		return nil, nil
	end
	return (l_4_0.x - l_4_1) / l_4_3, (l_4_0.y - l_4_2) / l_4_4
end


