Rectangle = Rectangle or class()
function Rectangle.init(A0_0)
	local L1_1
	A0_0.left = 0
	A0_0.bottom = 0
	A0_0.right = 0
	A0_0.top = 0
end
function Rectangle.height(A0_2)
	return A0_2.bottom - A0_2.top
end
function Rectangle.width(A0_3)
	return A0_3.right - A0_3.left
end
function Rectangle.move(A0_4, A1_5, A2_6)
	local L3_7
	L3_7 = A0_4.left
	L3_7 = L3_7 + A1_5
	A0_4.left = L3_7
	L3_7 = A0_4.top
	L3_7 = L3_7 + A2_6
	A0_4.top = L3_7
	L3_7 = A0_4.right
	L3_7 = L3_7 + A1_5
	A0_4.right = L3_7
	L3_7 = A0_4.bottom
	L3_7 = L3_7 + A2_6
	A0_4.bottom = L3_7
end
function Rectangle.set_position(A0_8, A1_9, A2_10)
	A0_8.left = A1_9
	A0_8.top = A2_10
	A0_8.bottom = A0_8.top + A0_8:height()
	A0_8.right = A0_8.left + A0_8:width()
end
