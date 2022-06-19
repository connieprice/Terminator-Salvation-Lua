if not Rectangle then
	Rectangle = class()
end
Rectangle.init = function(l_1_0)
	l_1_0.left = 0
	l_1_0.bottom = 0
	l_1_0.right = 0
	l_1_0.top = 0
end

Rectangle.height = function(l_2_0)
	return l_2_0.bottom - l_2_0.top
end

Rectangle.width = function(l_3_0)
	return l_3_0.right - l_3_0.left
end

Rectangle.move = function(l_4_0, l_4_1, l_4_2)
	l_4_0.left = l_4_0.left + l_4_1
	l_4_0.top = l_4_0.top + l_4_2
	l_4_0.right = l_4_0.right + l_4_1
	l_4_0.bottom = l_4_0.bottom + l_4_2
end

Rectangle.set_position = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_0:width()
	local l_5_4 = l_5_0:height()
	l_5_0.left = l_5_1
	l_5_0.top = l_5_2
	l_5_0.bottom = l_5_0.top + l_5_4
	l_5_0.right = l_5_0.left + l_5_3
end


