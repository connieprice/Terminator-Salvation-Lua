require("core/managers/controller/CoreControllerWrapper")
CoreControllerWrapperGamepad = CoreControllerWrapperGamepad or class(CoreControllerWrapper)
CoreControllerWrapperGamepad.TYPE = "gamepad"
CoreControllerWrapperGamepad.CONTROLLER_TYPE_LIST = {
	"win32_game_controller"
}
function CoreControllerWrapperGamepad.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	local L7_7
	L7_7 = {}
	L7_7.up = callback(A0_0, A0_0, "virtual_connect_up")
	L7_7.down = callback(A0_0, A0_0, "virtual_connect_down")
	L7_7.right = callback(A0_0, A0_0, "virtual_connect_right")
	L7_7.left = callback(A0_0, A0_0, "virtual_connect_left")
	L7_7.confirm = callback(A0_0, A0_0, "virtual_connect_confirm")
	L7_7.cancel = callback(A0_0, A0_0, "virtual_connect_cancel")
	L7_7.axis1 = callback(A0_0, A0_0, "virtual_connect_axis1")
	L7_7.axis2 = callback(A0_0, A0_0, "virtual_connect_axis2")
	get_core_or_local("ControllerWrapper").init(A0_0, A1_1, A2_2, {gamepad = A3_3}, "gamepad", A4_4, A5_5, A6_6, {gamepad = L7_7})
end
function CoreControllerWrapperGamepad.virtual_connect_up(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13)
	if A2_10:has_axis("pov 0") then
		A0_8._virtual_controller:connect(A2_10, "axis", "pov 0", 1, "range", 0, -1, "button", A4_12)
	else
		A0_8._connection_map[A4_12] = nil
	end
end
function CoreControllerWrapperGamepad.virtual_connect_down(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19)
	if A2_16:has_axis("pov 0") then
		A0_14._virtual_controller:connect(A2_16, "axis", "pov 0", 1, "range", 0, 1, "button", A4_18)
	else
		A0_14._connection_map[A4_18] = nil
	end
end
function CoreControllerWrapperGamepad.virtual_connect_right(A0_20, A1_21, A2_22, A3_23, A4_24, A5_25)
	if A2_22:has_axis("pov 0") then
		A0_20._virtual_controller:connect(A2_22, "axis", "pov 0", 0, "range", 0, 1, "button", A4_24)
	else
		A0_20._connection_map[A4_24] = nil
	end
end
function CoreControllerWrapperGamepad.virtual_connect_left(A0_26, A1_27, A2_28, A3_29, A4_30, A5_31)
	if A2_28:has_axis("pov 0") then
		A0_26._virtual_controller:connect(A2_28, "axis", "pov 0", 0, "range", 0, -1, "button", A4_30)
	else
		A0_26._connection_map[A4_30] = nil
	end
end
function CoreControllerWrapperGamepad.virtual_connect_confirm(A0_32, A1_33, A2_34, A3_35, A4_36, A5_37)
	A0_32:virtual_connect2(A1_33, A2_34, "0", A4_36, A5_37)
end
function CoreControllerWrapperGamepad.virtual_connect_cancel(A0_38, A1_39, A2_40, A3_41, A4_42, A5_43)
	A0_38:virtual_connect2(A1_39, A2_40, "1", A4_42, A5_43)
end
function CoreControllerWrapperGamepad.virtual_connect_cancel(A0_44, A1_45, A2_46, A3_47, A4_48, A5_49)
	A0_44:virtual_connect2(A1_45, A2_46, "1", A4_48, A5_49)
end
function CoreControllerWrapperGamepad.virtual_connect_axis1(A0_50, A1_51, A2_52, A3_53, A4_54, A5_55)
	A3_53 = "direction"
	if not A2_52:has_axis("direction") and A2_52:num_axes() > 0 then
		A3_53 = A2_52:axis_name(0)
		if A2_52:num_axes() > 1 and A3_53 == "rotation" then
			A3_53 = A2_52:axis_name(1)
		end
	end
	A0_50:virtual_connect2(A1_51, A2_52, A3_53, A4_54, A5_55)
end
function CoreControllerWrapperGamepad.virtual_connect_axis2(A0_56, A1_57, A2_58, A3_59, A4_60, A5_61)
	A3_59 = "rotation"
	if not A2_58:has_axis("rotation") and A2_58:num_axes() > 0 then
		A3_59 = A2_58:axis_name(0)
		if A2_58:num_axes() > 1 and A3_59 == "direction" then
			A3_59 = A2_58:axis_name(1)
		end
	end
	A0_56:virtual_connect2(A1_57, A2_58, A3_59, A4_60, A5_61)
end
function CoreControllerWrapperGamepad.virtual_connect2(A0_62, A1_63, A2_64, A3_65, A4_66, A5_67)
	local L6_68, L7_69
	L6_68 = true
	L7_69 = "Button "
	L7_69 = L7_69 .. A3_65
	if A2_64:has_button(L7_69) then
		A3_65 = L7_69
	elseif not A2_64:has_axis(A3_65) then
		L6_68 = false
	end
	if L6_68 then
		CoreControllerWrapper.virtual_connect2(A0_62, A1_63, A2_64, A3_65, A4_66, A5_67)
	else
		return false
	end
end
