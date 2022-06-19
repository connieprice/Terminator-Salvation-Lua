Menu2DFadeOutAnimation = Menu2DFadeOutAnimation or class({})
function Menu2DFadeOutAnimation.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	A0_0._object = A1_1
	A0_0._fade_speed = A3_3
	A0_0._wait_time = A2_2 or 0
	A0_0._end_alpha = A4_4 or 0
	A0_0._alpha_diff = A1_1:color().alpha - A4_4
	A0_0._fade_speed_timer = 0
	A0_0._wait_timer = 0
end
function Menu2DFadeOutAnimation.update(A0_5, A1_6)
	local L2_7, L3_8
	L2_7 = A0_5._fade_speed_timer
	if L2_7 ~= 0 then
		L2_7 = A0_5._wait_timer
		L2_7 = L2_7 + A1_6
		A0_5._wait_timer = L2_7
		L2_7 = A0_5._wait_time
		L3_8 = A0_5._wait_timer
		if L2_7 > L3_8 then
			return
		end
	end
	L2_7 = A0_5._fade_speed_timer
	L2_7 = L2_7 + A1_6
	A0_5._fade_speed_timer = L2_7
	L2_7 = A0_5._fade_speed_timer
	L3_8 = A0_5._fade_speed
	L2_7 = L2_7 / L3_8
	if L2_7 > 1 then
		L2_7 = 1
	end
	L3_8 = 1 - L2_7
	L3_8 = L3_8 * A0_5._alpha_diff
	L3_8 = L3_8 + A0_5._end_alpha
	if A0_5._object then
		A0_5._object:set_color(A0_5._object:color():with_alpha(L3_8))
		if A0_5._object:color().alpha == A0_5._end_alpha then
			return true
		end
	end
	return false
end
