if not ControllerWrapper then
	ControllerWrapper = class(CoreControllerWrapper)
end
CoreControllerWrapper.get_modified_axis = function(l_1_0, l_1_1, l_1_2, l_1_3)
	if l_1_2.get_multiplier then
		local l_1_4, l_1_5, l_1_6, l_1_7, l_1_9, l_1_14, l_1_16, l_1_18, l_1_20 = l_1_2:get_multiplier()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_1_4 then
		l_1_3 = Vector3(l_1_3.x * l_1_4.x, l_1_3.y * l_1_4.y, l_1_3.z * l_1_4.z)
	end
	if not l_1_2:get_pad_bottom() then
		local l_1_8, l_1_10 = , not l_1_2.IS_AXIS or l_1_2:get_no_limit() or 0
	end
	do
		local l_1_11 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_1_12 = nil
	do
		local l_1_13 = nil
		if l_1_3:length() >= l_1_13 or not 0 then
			l_1_3 = l_1_3:normalized() * math.clamp((l_1_3:length() - l_1_13) / math.clamp(1 - (l_1_2:get_pad_top() or 0) - l_1_10, 0.1, 1), 0, 1)
		end
		if l_1_2.get_inversion then
			local l_1_15, l_1_17, l_1_19, l_1_21 = , l_1_2:get_inversion()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_1_17 then
			l_1_3 = Vector3(l_1_3.x * l_1_17.x, l_1_3.y * l_1_17.y, l_1_3.z * l_1_17.z)
		end
		local l_1_22 = nil
		local l_1_23 = nil
		l_1_3 = Vector3(l_1_0:rescale_x_axis(l_1_1, l_1_2, l_1_3.x), l_1_0:rescale_y_axis(l_1_1, l_1_2, l_1_3.y), 0)
		local l_1_24, l_1_25 = nil
		local l_1_26 = l_1_0:lerp_axis
		local l_1_27 = l_1_0
		do
			local l_1_28 = l_1_1
			return l_1_26(l_1_27, l_1_28, l_1_2, l_1_3)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 58 
end

CoreControllerWrapper.get_virtual_controller = function(l_2_0)
	return l_2_0._virtual_controller
end

CoreControllerWrapper.get_any_button_pressed_including_unconnected = function(l_3_0)
	local l_3_5, l_3_6 = nil
	if not l_3_0:enabled() then
		return false
	end
	local l_3_1 = l_3_0._controller_map
	for i_0,i_1 in pairs(l_3_1) do
		if #i_1:pressed_list() > 0 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


