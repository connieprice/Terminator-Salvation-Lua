core:module("CoreColorPickerFields")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreTable")
core:require_module("CoreEws")
core:require_module("CoreMath")
ColorPickerFields = ColorPickerFields or CoreClass.mixin(CoreClass.class(), CoreEvent.BasicEventHandling)
function ColorPickerFields.init(A0_0, A1_1, A2_2, A3_3)
	A0_0:_create_panel(A1_1, A2_2, A3_3)
	A0_0:set_color(Color.white)
end
function ColorPickerFields.update(A0_4, A1_5, A2_6)
	local L3_7, L4_8, L5_9
	L3_7 = A0_4._is_picking_color_from_screen
	if L3_7 then
		L3_7 = EWS
		L4_8 = L3_7
		L3_7 = L3_7.MouseEvent
		L5_9 = "EVT_MOTION"
		L3_7 = L3_7(L4_8, L5_9)
		L4_8 = A0_4._previous_mouse_event
		L4_8 = L4_8 or L3_7
		A0_4._previous_mouse_event = L4_8
		L5_9 = L3_7
		L4_8 = L3_7.get_position
		L4_8 = L4_8(L5_9)
		L5_9 = A0_4._previous_mouse_event
		L5_9 = L5_9.get_position
		L5_9 = L5_9(L5_9)
		if L4_8 ~= L5_9 then
			L4_8 = EWS
			L5_9 = L4_8
			L4_8 = L4_8.get_screen_pixel
			L4_8 = L4_8(L5_9, L3_7:get_position_on_screen())
			L4_8 = L4_8 / 255
			L5_9 = Color
			L5_9 = L5_9(L4_8.x, L4_8.y, L4_8.z)
			A0_4:set_color(L5_9)
			A0_4:_send_event("EVT_COLOR_UPDATED", L5_9)
		end
		L5_9 = L3_7
		L4_8 = L3_7.left_is_down
		L4_8 = L4_8(L5_9)
		if L4_8 == true then
			L4_8 = A0_4._previous_mouse_event
			L5_9 = L4_8
			L4_8 = L4_8.left_is_down
			L4_8 = L4_8(L5_9)
			if L4_8 == false then
				L5_9 = A0_4
				L4_8 = A0_4._on_exit_eyedropper_mode
				L4_8(L5_9, nil, L3_7)
				L3_7 = nil
			end
		end
		A0_4._previous_mouse_event = L3_7
	end
end
function ColorPickerFields.panel(A0_10)
	local L1_11
	L1_11 = A0_10._panel
	return L1_11
end
function ColorPickerFields.color(A0_12)
	return Color((A0_12:_field_value("Alpha") or 255) / 255, (A0_12:_field_value("Red") or 0) / 255, (A0_12:_field_value("Green") or 0) / 255, (A0_12:_field_value("Blue") or 0) / 255)
end
function ColorPickerFields.set_color(A0_13, A1_14)
	A0_13:_set_field_values_except(nil, A1_14)
end
function ColorPickerFields._field_value(A0_15, A1_16)
	local L2_17
	L2_17 = A0_15._field_groups
	if L2_17 then
		L2_17 = assert
		L2_17 = L2_17(A0_15._field_groups[A1_16], "Invalid field.")
	else
		L2_17 = L2_17 or {}
	end
	for 