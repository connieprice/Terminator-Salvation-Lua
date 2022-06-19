ControllerWrapperGamepad = ControllerWrapperGamepad or class(CoreControllerWrapperGamepad)
function ControllerWrapperGamepad.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	if A5_5 then
		A0_0._sensivity = 0
	else
		A0_0._sensivity = 0.1
	end
	CoreControllerWrapperGamepad.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
end
function ControllerWrapperGamepad.virtual_connect(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12)
	local L6_13
	if A3_10 == "down" then
		if A2_9:has_axis("pov 0") then
			A0_7._virtual_controller:connect(A2_9, "axis", "pov 0", 1, "range", A0_7._sensivity, 1, "button", A4_11)
		else
			A0_7._connection_map[A4_11] = nil
		end
		return
	elseif A3_10 == "up" then
		if A2_9:has_axis("pov 0") then
			A0_7._virtual_controller:connect(A2_9, "axis", "pov 0", 1, "range", -A0_7._sensivity, -1, "button", A4_11)
		else
			A0_7._connection_map[A4_11] = nil
		end
		return
	elseif A3_10 == "left" then
		if A2_9:has_axis("pov 0") then
			A0_7._virtual_controller:connect(A2_9, "axis", "pov 0", 0, "range", -A0_7._sensivity, -1, "button", A4_11)
		else
			A0_7._connection_map[A4_11] = nil
		end
		return
	elseif A3_10 == "right" then
		if A2_9:has_axis("pov 0") then
			A0_7._virtual_controller:connect(A2_9, "axis", "pov 0", 0, "range", A0_7._sensivity, 1, "button", A4_11)
		else
			A0_7._connection_map[A4_11] = nil
		end
		return
	end
	CoreControllerWrapperGamepad.virtual_connect(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12)
end
function ControllerWrapperGamepad.virtual_connect2(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19)
	if A2_16:has_button(A3_17) or A2_16:has_axis(A3_17) then
		CoreControllerWrapper.virtual_connect2(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19)
	else
		return false
	end
end
