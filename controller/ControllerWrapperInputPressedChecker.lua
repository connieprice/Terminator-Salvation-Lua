ControllerWrapperInputPressedChecker = ControllerWrapperInputPressedChecker or class()
ControllerWrapperInputPressedChecker._BUTTON_DOWN_THRESHOLD = 0.5
ControllerWrapperInputPressedChecker._AXIS_DOWN_THRESHOLD = 0.5
function ControllerWrapperInputPressedChecker.init(A0_0, A1_1)
	assert(A1_1)
	A0_0._controller_map = A1_1:get_controller_map()
	A0_0._input_infos = A0_0:_get_input_infos()
	A0_0._pressed_inputs = {}
end
function ControllerWrapperInputPressedChecker.pressed_inputs(A0_2)
	local L1_3
	L1_3 = A0_2._pressed_inputs
	return L1_3
end
function ControllerWrapperInputPressedChecker.update(A0_4)
	local L1_5
	L1_5 = A0_4._get_input_infos
	L1_5 = L1_5(A0_4)
	A0_4:_update_pressed_inputs(L1_5)
	A0_4._input_infos = L1_5
end
function ControllerWrapperInputPressedChecker._update_pressed_inputs(A0_6, A1_7)
	local L2_8, L3_9, L4_10, L5_11, L6_12, L7_13, L8_14, L9_15, L10_16, L11_17
	A0_6._pressed_inputs = L2_8
	for L5_11, L6_12 in L2_8(L3_9) do
		L7_13 = L6_12.is_down
		if L7_13 then
			L8_14 = A0_6._input_infos
			L8_14 = L8_14[L5_11]
			L8_14 = L8_14.is_down
			if not L8_14 then
				L8_14 = L6_12.is_button
				L9_15 = L6_12.controller_id
				L10_16 = L6_12.input_name
				L11_17 = {}
				L11_17.is_button = L8_14
				L11_17.controller_id = L9_15
				L11_17.input_name = L10_16
				table.insert(A0_6._pressed_inputs, L11_17)
			end
		end
	end
end
function ControllerWrapperInputPressedChecker._get_input_infos(A0_18)
	local L1_19, L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L11_29, L12_30, L13_31, L14_32, L15_33, L16_34, L17_35, L18_36
	L1_19 = {}
	L2_20 = A0_18._controller_map
	for L6_24, L7_25 in L3_21(L4_22) do
		L8_26 = L7_25.num_buttons
		L8_26 = L8_26(L9_27)
		for L12_30 = 0, L8_26 - 1 do
			L14_32 = L7_25
			L13_31 = L7_25.button
			L15_33 = L12_30
			L13_31 = L13_31(L14_32, L15_33)
			L15_33 = L7_25
			L14_32 = L7_25.button_name
			L16_34 = L12_30
			L14_32 = L14_32(L15_33, L16_34)
			L15_33 = A0_18._BUTTON_DOWN_THRESHOLD
			L15_33 = L13_31 >= L15_33
			L16_34 = {}
			L16_34.is_button = true
			L16_34.controller_id = L6_24
			L16_34.input_name = L14_32
			L16_34.is_down = L15_33
			L17_35 = table
			L17_35 = L17_35.insert
			L18_36 = L1_19
			L17_35(L18_36, L16_34)
		end
		for L13_31 = 0, L9_27 - 1 do
			L15_33 = L7_25
			L14_32 = L7_25.axis
			L16_34 = L13_31
			L14_32 = L14_32(L15_33, L16_34)
			L16_34 = L7_25
			L15_33 = L7_25.axis_name
			L17_35 = L13_31
			L15_33 = L15_33(L16_34, L17_35)
			L17_35 = L14_32
			L16_34 = L14_32.length
			L16_34 = L16_34(L17_35)
			L17_35 = A0_18._AXIS_DOWN_THRESHOLD
			L17_35 = L16_34 >= L17_35
			L18_36 = {}
			L18_36.is_button = false
			L18_36.controller_id = L6_24
			L18_36.input_name = L15_33
			L18_36.is_down = L17_35
			table.insert(L1_19, L18_36)
		end
	end
	return L1_19
end
