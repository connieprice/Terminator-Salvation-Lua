require("core/managers/controller/CoreControllerWrapper")
CoreControllerWrapperPC = CoreControllerWrapperPC or class(CoreControllerWrapper)
CoreControllerWrapperPC.TYPE = "pc"
CoreControllerWrapperPC.CONTROLLER_TYPE_LIST = {
	"win32_keyboard",
	"win32_mouse"
}
function CoreControllerWrapperPC.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	local L8_8
	L8_8 = {}
	L8_8.keyboard_axis_1 = callback(A0_0, A0_0, "virtual_connect_keyboard_axis_1")
	L8_8.keyboard_axis_2 = callback(A0_0, A0_0, "virtual_connect_keyboard_axis_2")
	L8_8.confirm = callback(A0_0, A0_0, "virtual_connect_confirm")
	L8_8.cancel = callback(A0_0, A0_0, "virtual_connect_cancel")
	get_core_or_local("ControllerWrapper").init(A0_0, A1_1, A2_2, {
		keyboard = Input:keyboard(),
		mouse = Input:mouse(),
		gamepads = A7_7
	}, "keyboard", A4_4, A5_5, A6_6, {keyboard = L8_8})
end
function CoreControllerWrapperPC.virtual_connect_keyboard_axis_1(A0_9, A1_10, A2_11, A3_12, A4_13, A5_14)
	A0_9._virtual_controller:add_axis(A4_13)
	A0_9._virtual_controller:connect(A2_11, "button", "a", "axis", A4_13, 0, "range", 0, -1)
	A0_9._virtual_controller:connect(A2_11, "button", "d", "axis", A4_13, 0, "range", 0, 1)
	A0_9._virtual_controller:connect(A2_11, "button", "w", "axis", A4_13, 1, "range", 0, 1)
	A0_9._virtual_controller:connect(A2_11, "button", "s", "axis", A4_13, 1, "range", 0, -1)
end
function CoreControllerWrapperPC.virtual_connect_keyboard_axis_2(A0_15, A1_16, A2_17, A3_18, A4_19, A5_20)
	A0_15._virtual_controller:add_axis(A4_19)
	A0_15._virtual_controller:connect(A2_17, "button", "left", "axis", A4_19, 0, "range", 0, -1)
	A0_15._virtual_controller:connect(A2_17, "button", "right", "axis", A4_19, 0, "range", 0, 1)
	A0_15._virtual_controller:connect(A2_17, "button", "up", "axis", A4_19, 1, "range", 0, 1)
	A0_15._virtual_controller:connect(A2_17, "button", "down", "axis", A4_19, 1, "range", 0, -1)
end
function CoreControllerWrapperPC.virtual_connect_confirm(A0_21, A1_22, A2_23, A3_24, A4_25, A5_26)
	A0_21:virtual_connect2(A1_22, A2_23, "enter", A4_25, A5_26)
end
function CoreControllerWrapperPC.virtual_connect_cancel(A0_27, A1_28, A2_29, A3_30, A4_31, A5_32)
	A0_27:virtual_connect2(A1_28, A2_29, "esc", A4_31, A5_32)
end
function CoreControllerWrapperPC.virtual_connect2(A0_33, A1_34, A2_35, A3_36, A4_37, A5_38)
	local L6_39, L7_40, L8_41, L9_42, L10_43, L11_44, L12_45, L13_46, L14_47, L15_48, L16_49, L17_50, L18_51
	L7_40 = A5_38
	L6_39 = A5_38.get_range
	L9_42 = L6_39(L7_40)
	L11_44 = A5_38
	L10_43 = A5_38.get_connect_src_type
	L10_43 = L10_43(L11_44)
	L12_45 = A5_38
	L11_44 = A5_38.get_connect_dest_type
	L11_44 = L11_44(L12_45)
	L12_45 = A5_38._btn_connections
	if L12_45 and A3_36 == "buttons" then
		L12_45 = {}
		L16_49 = 1
		L12_45.up = L13_46
		L16_49 = -1
		L12_45.down = L13_46
		L16_49 = -1
		L12_45.left = L13_46
		L16_49 = 1
		L12_45.right = L13_46
		if not L13_46 then
			L13_46(L14_47, L15_48)
		end
		for L16_49, L17_50 in L13_46(L14_47) do
			L18_51 = A0_33._controller_map
			L18_51 = L18_51.keyboard
			if (not L18_51:has_button(L17_50.name) or L17_50.type ~= "button") and (not L18_51:has_axis(L17_50.name) or L17_50.type ~= "axis") then
				L18_51 = A0_33._controller_map.gamepads
			end
			if L18_51:has_button(L17_50.name) and L17_50.type == "button" or L18_51:has_axis(L17_50.name) and L17_50.type == "axis" then
				if L17_50.type == "axis" then
					A0_33._virtual_controller:connect(L18_51, "axis", L17_50.name, tonumber(L17_50.dir), "range", tonumber(L17_50.range1), tonumber(L17_50.range2), "axis", A4_37, L12_45[L16_49][1], "range", L12_45[L16_49][2], L12_45[L16_49][3])
				else
					A0_33._virtual_controller:connect(L18_51, "button", L17_50.name, "axis", A4_37, L12_45[L16_49][1], "range", L12_45[L16_49][2], L12_45[L16_49][3])
				end
			end
		end
	else
		L12_45 = A0_33._controller_map
		L12_45 = L12_45.gamepads
		L12_45 = L12_45.has_button
		L12_45 = L12_45(L13_46, L14_47)
		if not L12_45 then
			L12_45 = A0_33._controller_map
			L12_45 = L12_45.gamepads
			L12_45 = L12_45.has_axis
			L12_45 = L12_45(L13_46, L14_47)
		elseif L12_45 then
			L12_45 = A0_33._controller_map
			A2_35 = L12_45.gamepads
		end
		L12_45 = A2_35.has_button
		L12_45 = L12_45(L13_46, L14_47)
		if not L12_45 then
			L12_45 = A2_35.has_axis
			L12_45 = L12_45(L13_46, L14_47)
		elseif L12_45 then
			L12_45 = A0_33._virtual_controller
			L12_45 = L12_45.connect
			L16_49 = A3_36
			L17_50 = "range"
			L18_51 = L6_39
			L12_45(L13_46, L14_47, L15_48, L16_49, L17_50, L18_51, L7_40, L11_44, A4_37, "range", L8_41, L9_42)
		end
	end
end
