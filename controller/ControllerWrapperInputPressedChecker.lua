if not ControllerWrapperInputPressedChecker then
	ControllerWrapperInputPressedChecker = class()
end
ControllerWrapperInputPressedChecker._BUTTON_DOWN_THRESHOLD = 0.5
ControllerWrapperInputPressedChecker._AXIS_DOWN_THRESHOLD = 0.5
ControllerWrapperInputPressedChecker.init = function(l_1_0, l_1_1)
	assert(l_1_1)
	l_1_0._controller_map = l_1_1:get_controller_map()
	l_1_0._input_infos = l_1_0:_get_input_infos()
	l_1_0._pressed_inputs = {}
end

ControllerWrapperInputPressedChecker.pressed_inputs = function(l_2_0)
	return l_2_0._pressed_inputs
end

ControllerWrapperInputPressedChecker.update = function(l_3_0)
	local l_3_1 = l_3_0:_get_input_infos()
	l_3_0:_update_pressed_inputs(l_3_1)
	l_3_0._input_infos = l_3_1
end

ControllerWrapperInputPressedChecker._update_pressed_inputs = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12, l_4_13, l_4_14, l_4_15 = nil
	l_4_0._pressed_inputs = {}
	for i_0,i_1 in ipairs(l_4_1) do
		if i_1.is_down and not l_4_0._input_infos[l_4_16].is_down then
			local l_4_18 = nil
			local l_4_19 = i_1.is_button
			local l_4_20 = l_4_17.controller_id
			table.insert(l_4_0._pressed_inputs, {is_button = l_4_19, controller_id = l_4_20, input_name = l_4_17.input_name})
		end
	end
end

ControllerWrapperInputPressedChecker._get_input_infos = function(l_5_0)
	local l_5_6, l_5_7, l_5_8, l_5_9 = nil
	local l_5_1 = {}
	local l_5_2 = l_5_0._controller_map
	for i_0,i_1 in pairs(l_5_2) do
		for l_5_14 = 0, i_1:num_buttons() - 1 do
			local l_5_12 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_5_20 = nil
			table.insert(l_5_1, {is_button = true, controller_id = l_5_10, input_name = l_5_11:button_name(R12_PC13), is_down = l_5_0._BUTTON_DOWN_THRESHOLD <= l_5_11:button(R12_PC13)})
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_5_21 = nil
		for l_5_25 = 0, l_5_11:num_axes() - 1 do
			local l_5_22, l_5_23 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_5_28 = nil
			local l_5_32 = l_5_21:axis_name(l_5_20)
			table.insert(l_5_1, {is_button = false, controller_id = l_5_10, input_name = l_5_32, is_down = l_5_0._AXIS_DOWN_THRESHOLD <= l_5_21:axis(l_5_20):length()})
		end
	end
	return l_5_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


