if not ControllerWrapperGamepad then
	ControllerWrapperGamepad = class(CoreControllerWrapperGamepad)
end
ControllerWrapperGamepad.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	if l_1_5 then
		l_1_0._sensivity = 0
	else
		l_1_0._sensivity = 0.1
	end
	CoreControllerWrapperGamepad.init(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
end

ControllerWrapperGamepad.virtual_connect = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5)
	local l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13, l_2_14 = nil
	if l_2_3 == "down" then
		if l_2_2:has_axis("pov 0") then
			l_2_0._virtual_controller:connect(l_2_2, "axis", "pov 0", 1, "range", l_2_0._sensivity, 1, "button", l_2_4)
		else
			l_2_0._connection_map[l_2_4] = nil
		end
		return 
	elseif l_2_3 == "up" then
		if l_2_2:has_axis("pov 0") then
			l_2_0._virtual_controller:connect(l_2_2, "axis", "pov 0", 1, "range", -l_2_0._sensivity, -1, "button", l_2_4)
		else
			l_2_0._connection_map[l_2_4] = nil
		end
		return 
	elseif l_2_3 == "left" then
		if l_2_2:has_axis("pov 0") then
			l_2_0._virtual_controller:connect(l_2_2, "axis", "pov 0", 0, "range", -l_2_0._sensivity, -1, "button", l_2_4)
		else
			l_2_0._connection_map[l_2_4] = nil
		end
		return 
	elseif l_2_3 == "right" then
		if l_2_2:has_axis("pov 0") then
			l_2_0._virtual_controller:connect(l_2_2, "axis", "pov 0", 0, "range", l_2_0._sensivity, 1, "button", l_2_4)
		else
			l_2_0._connection_map[l_2_4] = nil
			return 
		end
		CoreControllerWrapperGamepad.virtual_connect(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5)
		 -- WARNING: missing end command somewhere! Added here
	end
end

ControllerWrapperGamepad.virtual_connect2 = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5)
	if not l_3_2:has_button(l_3_3) then
		local l_3_6 = l_3_2:has_axis(l_3_3)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_3_6 then
		CoreControllerWrapper.virtual_connect2(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5)
	else
		return false
	end
end


