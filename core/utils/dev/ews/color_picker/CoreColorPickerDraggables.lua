core:module("CoreColorPickerDraggables")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreMath")
ColorPickerDraggables = ColorPickerDraggables or CoreClass.mixin(CoreClass.class(), CoreEvent.BasicEventHandling)
function ColorPickerDraggables.init(A0_0, A1_1, A2_2, A3_3)
	A0_0:_create_panel(A1_1, A2_2, A3_3)
	A0_0:set_color(Color.white)
end
function ColorPickerDraggables.update(A0_4, A1_5, A2_6)
	local L3_7
	L3_7 = EWS
	L3_7 = L3_7.MouseEvent
	L3_7 = L3_7(L3_7, "EVT_MOTION")
	A0_4._previous_mouse_event = A0_4._previous_mouse_event or L3_7
	if A0_4._dragged_control and L3_7:get_position() ~= A0_4._previous_mouse_event:get_position() then
		A0_4:_on_dragging(A0_4._dragged_control, L3_7)
	end
	if A0_4._dragged_control and L3_7:left_is_down() == false and A0_4._previous_mouse_event:left_is_down() == true then
		A0_4:_on_drag_stop(A0_4._dragged_control, L3_7)
	end
	A0_4._previous_mouse_event = L3_7
end
function ColorPickerDraggables.panel(A0_8)
	local L1_9
	L1_9 = A0_8._panel
	return L1_9
end
function ColorPickerDraggables.color(A0_10)
	return (A0_10._alpha_slider or A0_10._value_slider or A0_10._spectrum):color()
end
function ColorPickerDraggables.set_color(A0_11, A1_12)
	hue, saturation, value = CoreMath.rgb_to_hsv(A1_12.red, A1_12.green, A1_12.blue)
	A0_11._spectrum:set_hue(hue)
	A0_11._spectrum:set_saturation(saturation)
	A0_11._spectrum:set_value(value)
	if A0_11._value_slider then
		A0_11._value_slider:set_value(value)
	end
	if A0_11._alpha_slider then
		A0_11._alpha_slider:set_value(A1_12.alpha)
	end
	A0_11:_update_ui_except(A0_11._spectrum)
end
function ColorPickerDraggables._create_panel(A0_13, A1_14, A2_15, A3_16)
	local L4_17, L5_18, L6_19, L7_20
	if A2_15 == nil then
		A2_15 = true or A2_15
	end
	if A3_16 == nil then
		A3_16 = true or A3_16
	end
	L4_17 = EWS
	L5_18 = L4_17
	L4_17 = L4_17.Panel
	L6_19 = A1_14
	L4_17 = L4_17(L5_18, L6_19)
	A0_13._panel = L4_17
	L4_17 = A0_13._panel
	L5_18 = L4_17
	L4_17 = L4_17.set_min_size
	L6_19 = Vector3
	L7_20 = 180
	L7_20 = L6_19(L7_20, 134, 0)
	L4_17(L5_18, L6_19, L7_20, L6_19(L7_20, 134, 0))
	L4_17 = EWS
	L5_18 = L4_17
	L4_17 = L4_17.BoxSizer
	L6_19 = "HORIZONTAL"
	L4_17 = L4_17(L5_18, L6_19)
	L5_18 = A0_13._panel
	L6_19 = L5_18
	L5_18 = L5_18.set_sizer
	L7_20 = L4_17
	L5_18(L6_19, L7_20)
	L5_18 = 20
	L6_19 = 3
	L7_20 = EWS
	L7_20 = L7_20.ColorSpectrum
	L7_20 = L7_20(L7_20, A0_13._panel, "")
	A0_13._spectrum = L7_20
	L7_20 = L4_17.add
	L7_20(L4_17, A0_13._spectrum, 0, L6_19, "ALL")
	L7_20 = A0_13._spectrum
	L7_20 = L7_20.connect
	L7_20(L7_20, "EVT_LEFT_DOWN", CoreEvent.callback(A0_13, A0_13, "_on_drag_start"), A0_13._spectrum)
	L7_20 = A0_13._spectrum
	L7_20 = L7_20.get_min_size
	L7_20 = L7_20(L7_20)
	if A3_16 then
		A0_13._value_slider = EWS:ColorSlider(A0_13._panel, "")
		L4_17:add(A0_13._value_slider, 0, 0, "EXPAND")
		A0_13._value_slider:connect("EVT_LEFT_DOWN", CoreEvent.callback(A0_13, A0_13, "_on_drag_start"), A0_13._value_slider)
	else
		L7_20 = L7_20:with_x(L7_20.x + L5_18 + L6_19)
	end
	if A2_15 then
		A0_13._alpha_slider = EWS:ColorSlider(A0_13._panel, "")
		L4_17:add(A0_13._alpha_slider, 0, L6_19, "LEFT,RIGHT,EXPAND")
		A0_13._alpha_slider:connect("EVT_LEFT_DOWN", CoreEvent.callback(A0_13, A0_13, "_on_drag_start"), A0_13._alpha_slider)
	else
		L7_20 = L7_20:with_x(L7_20.x + L5_18 + L6_19)
	end
	A0_13._spectrum:set_min_size(L7_20)
end
function ColorPickerDraggables._update_ui_except(A0_21, A1_22)
	local L2_23
	L2_23 = A0_21._value_slider
	if L2_23 ~= nil then
		L2_23 = A0_21._spectrum
		if A1_22 ~= L2_23 then
			L2_23 = A0_21._spectrum
			L2_23 = L2_23.set_value
			L2_23(L2_23, A0_21._value_slider:value())
		end
		L2_23 = A0_21._value_slider
		if A1_22 ~= L2_23 then
			L2_23 = A0_21._value_slider
			L2_23 = L2_23.set_top_color
			L2_23(L2_23, A0_21._spectrum:unscaled_color())
		end
	end
	L2_23 = A0_21._alpha_slider
	if A1_22 ~= L2_23 then
		L2_23 = A0_21._alpha_slider
		if L2_23 ~= nil then
			L2_23 = A0_21._value_slider
			L2_23 = L2_23 or A0_21._spectrum
			L2_23 = L2_23.color
			L2_23 = L2_23(L2_23)
			A0_21._alpha_slider:set_top_color(L2_23)
			A0_21._alpha_slider:set_bottom_color(L2_23:with_alpha(0))
		end
	end
end
function ColorPickerDraggables._process_color_update_event(A0_24, A1_25, A2_26)
	local L3_27
	L3_27 = A2_26.get_position
	L3_27 = L3_27(A2_26, A1_25)
	if A1_25 == A0_24._spectrum then
		A1_25:set_hue(A1_25:point_to_hue(L3_27))
		A1_25:set_saturation(A1_25:point_to_saturation(L3_27))
	else
		A1_25:set_value(A1_25:point_to_value(L3_27))
	end
	A0_24:_update_ui_except(A1_25)
	A0_24:_send_event("EVT_COLOR_UPDATED", A0_24:color())
end
function ColorPickerDraggables._process_color_change_event(A0_28, A1_29, A2_30)
	A0_28:_process_color_update_event(A1_29, A2_30)
	A0_28:_send_event("EVT_COLOR_CHANGED", A0_28:color())
end
function ColorPickerDraggables._on_drag_start(A0_31, A1_32, A2_33)
	A0_31._previous_mouse_event = EWS:MouseEvent("EVT_LEFT_DOWN")
	A0_31._dragged_control = A1_32
	A0_31:_process_color_update_event(A1_32, A2_33)
end
function ColorPickerDraggables._on_dragging(A0_34, A1_35, A2_36)
	A0_34:_process_color_update_event(A1_35, A2_36)
end
function ColorPickerDraggables._on_drag_stop(A0_37, A1_38, A2_39)
	A0_37:_process_color_change_event(A1_38, A2_39)
	A0_37._dragged_control = nil
end
