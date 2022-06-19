Menu2DPulseAnimation = Menu2DPulseAnimation or class({})
function Menu2DPulseAnimation.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5)
	local L6_6
	A0_0._object = A1_1
	L6_6 = A2_2 or 0
	A0_0._pulse_time = L6_6
	L6_6 = A5_5 or 0
	A0_0._wait_time = L6_6
	A0_0._min_alpha = A3_3
	L6_6 = A4_4 - A3_3
	A0_0._alpha_diff = L6_6
	A0_0._fade_down = true
	A0_0._pulse_timer = 0
	A0_0._wait_timer = 0
end
function Menu2DPulseAnimation.update(A0_7, A1_8)
	local L2_9, L3_10, L4_11, L5_12
	L2_9 = A0_7._pulse_timer
	if L2_9 ~= 0 then
		L2_9 = A0_7._wait_timer
		L2_9 = L2_9 + A1_8
		A0_7._wait_timer = L2_9
		L2_9 = A0_7._wait_time
		L3_10 = A0_7._wait_timer
		if L2_9 > L3_10 then
			return
		end
	end
	L2_9 = A0_7._pulse_timer
	L2_9 = L2_9 + A1_8
	A0_7._pulse_timer = L2_9
	L2_9 = nil
	L3_10 = A0_7._pulse_timer
	L4_11 = A0_7._pulse_time
	L3_10 = L3_10 / L4_11
	if L3_10 > 1 then
		L3_10 = 1
	end
	L4_11 = A0_7._fade_down
	if L4_11 == true then
		L4_11 = 1 - L3_10
		L5_12 = A0_7._alpha_diff
		L4_11 = L4_11 * L5_12
		L5_12 = A0_7._min_alpha
		L2_9 = L4_11 + L5_12
	else
		L4_11 = A0_7._fade_down
		if L4_11 == false then
			L4_11 = A0_7._alpha_diff
			L4_11 = L3_10 * L4_11
			L5_12 = A0_7._min_alpha
			L2_9 = L4_11 + L5_12
		end
	end
	L4_11 = A0_7._object
	if L4_11 then
		L4_11 = A0_7._object
		L5_12 = L4_11
		L4_11 = L4_11.set_color
		L4_11(L5_12, A0_7._object:color():with_alpha(L2_9))
		if L3_10 == 1 then
			A0_7._pulse_timer = 0
			L4_11 = A0_7._fade_down
			L4_11 = not L4_11
			A0_7._fade_down = L4_11
		end
	end
	L4_11 = false
	return L4_11
end
