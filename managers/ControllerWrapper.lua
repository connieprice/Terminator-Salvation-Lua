ControllerWrapper = ControllerWrapper or class(CoreControllerWrapper)
function CoreControllerWrapper.get_modified_axis(A0_0, A1_1, A2_2, A3_3)
	local L4_4, L5_5, L6_6, L7_7
	L4_4 = A2_2.get_multiplier
	if L4_4 then
		L5_5 = A2_2
		L4_4 = A2_2.get_multiplier
		L4_4 = L4_4(L5_5)
	end
	if L4_4 then
		L5_5 = Vector3
		L6_6 = A3_3.x
		L7_7 = L4_4.x
		L6_6 = L6_6 * L7_7
		L7_7 = A3_3.y
		L7_7 = L7_7 * L4_4.y
		L5_5 = L5_5(L6_6, L7_7, A3_3.z * L4_4.z)
		A3_3 = L5_5
	end
	L5_5 = A2_2.IS_AXIS
	if L5_5 then
		L6_6 = A2_2
		L5_5 = A2_2.get_no_limit
		L5_5 = L5_5(L6_6)
		if not L5_5 then
			L6_6 = A2_2
			L5_5 = A2_2.get_pad_bottom
			L5_5 = L5_5(L6_6)
			L5_5 = L5_5 or 0
			L7_7 = A2_2
			L6_6 = A2_2.get_pad_top
			L6_6 = L6_6(L7_7)
			L6_6 = L6_6 or 0
			L7_7 = math
			L7_7 = L7_7.clamp
			L7_7 = L7_7(1 - L6_6 - L5_5, 0.1, 1)
			if not (L5_5 > A3_3:length()) or not 0 then
			end
			A3_3 = A3_3:normalized() * math.clamp((A3_3:length() - L5_5) / L7_7, 0, 1)
		end
	end
	L5_5 = A2_2.get_inversion
	if L5_5 then
		L6_6 = A2_2
		L5_5 = A2_2.get_inversion
		L5_5 = L5_5(L6_6)
	end
	if L5_5 then
		L6_6 = Vector3
		L7_7 = A3_3.x
		L7_7 = L7_7 * L5_5.x
		L6_6 = L6_6(L7_7, A3_3.y * L5_5.y, A3_3.z * L5_5.z)
		A3_3 = L6_6
	end
	L7_7 = A0_0
	L6_6 = A0_0.rescale_x_axis
	L6_6 = L6_6(L7_7, A1_1, A2_2, A3_3.x)
	L7_7 = A0_0.rescale_y_axis
	L7_7 = L7_7(A0_0, A1_1, A2_2, A3_3.y)
	A3_3 = Vector3(L6_6, L7_7, 0)
	return A0_0:lerp_axis(A1_1, A2_2, A3_3)
end
function CoreControllerWrapper.get_virtual_controller(A0_8)
	local L1_9
	L1_9 = A0_8._virtual_controller
	return L1_9
end
function CoreControllerWrapper.get_any_button_pressed_including_unconnected(A0_10)
	local L1_11
	L1_11 = A0_10.enabled
	L1_11 = L1_11(A0_10)
	if not L1_11 then
		L1_11 = false
		return L1_11
	end
	L1_11 = A0_10._controller_map
	for 