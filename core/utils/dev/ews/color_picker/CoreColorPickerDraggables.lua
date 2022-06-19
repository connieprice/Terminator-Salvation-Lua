core:module("CoreColorPickerDraggables")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreMath")
if not ColorPickerDraggables then
	ColorPickerDraggables = CoreClass.mixin(CoreClass.class(), CoreEvent.BasicEventHandling)
end
ColorPickerDraggables.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0:_create_panel(l_1_1, l_1_2, l_1_3)
	l_1_0:set_color(Color.white)
end

ColorPickerDraggables.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = EWS:MouseEvent("EVT_MOTION")
	l_2_0._previous_mouse_event = l_2_0._previous_mouse_event or l_2_3
	if l_2_0._dragged_control and l_2_3:get_position() ~= l_2_0._previous_mouse_event:get_position() then
		l_2_0:_on_dragging(l_2_0._dragged_control, l_2_3)
	end
	if l_2_0._dragged_control and l_2_3:left_is_down() == false and l_2_0._previous_mouse_event:left_is_down() == true then
		l_2_0:_on_drag_stop(l_2_0._dragged_control, l_2_3)
	end
	l_2_0._previous_mouse_event = l_2_3
end

ColorPickerDraggables.panel = function(l_3_0)
	return l_3_0._panel
end

ColorPickerDraggables.color = function(l_4_0)
	if not l_4_0._alpha_slider and not l_4_0._value_slider then
		local l_4_1, l_4_2 = l_4_0._spectrum:color, l_4_0._spectrum
		return l_4_1(l_4_2)
	end
end

ColorPickerDraggables.set_color = function(l_5_0, l_5_1)
	hue = CoreMath.rgb_to_hsv(l_5_1.red, l_5_1.green, l_5_1.blue)
	l_5_0._spectrum:set_hue(hue)
	l_5_0._spectrum:set_saturation(saturation)
	l_5_0._spectrum:set_value(value)
	if l_5_0._value_slider then
		l_5_0._value_slider:set_value(value)
	end
	if l_5_0._alpha_slider then
		l_5_0._alpha_slider:set_value(l_5_1.alpha)
	end
	l_5_0:_update_ui_except(l_5_0._spectrum)
end

ColorPickerDraggables._create_panel = function(l_6_0, l_6_1, l_6_2, l_6_3)
	l_6_0 = l_6_2 == nil and (l_6_0)
	l_6_2 = true
	l_6_0 = l_6_3 == nil and (l_6_0)
	l_6_3 = true
	l_6_0._panel = EWS:Panel(l_6_1)
	l_6_0._panel:set_min_size(Vector3(180, 134, 0))
	local l_6_4 = EWS:BoxSizer("HORIZONTAL")
	l_6_0._panel:set_sizer(l_6_4)
	local l_6_5 = 20
	local l_6_6 = 3
	l_6_0._spectrum = EWS:ColorSpectrum(l_6_0._panel, "")
	l_6_4:add(l_6_0._spectrum, 0, l_6_6, "ALL")
	l_6_0._spectrum:connect("EVT_LEFT_DOWN", CoreEvent.callback(l_6_0, l_6_0, "_on_drag_start"), l_6_0._spectrum)
	local l_6_7 = l_6_0._spectrum:get_min_size()
	if l_6_3 then
		l_6_0._value_slider = EWS:ColorSlider(l_6_0._panel, "")
		l_6_4:add(l_6_0._value_slider, 0, 0, "EXPAND")
		l_6_0._value_slider:connect("EVT_LEFT_DOWN", CoreEvent.callback(l_6_0, l_6_0, "_on_drag_start"), l_6_0._value_slider)
	else
		l_6_7 = l_6_7:with_x(l_6_7.x + l_6_5 + l_6_6)
	end
	if l_6_2 then
		l_6_0._alpha_slider = EWS:ColorSlider(l_6_0._panel, "")
		l_6_4:add(l_6_0._alpha_slider, 0, l_6_6, "LEFT,RIGHT,EXPAND")
		l_6_0._alpha_slider:connect("EVT_LEFT_DOWN", CoreEvent.callback(l_6_0, l_6_0, "_on_drag_start"), l_6_0._alpha_slider)
	else
		l_6_7 = l_6_7:with_x(l_6_7.x + l_6_5 + l_6_6)
	end
	l_6_0._spectrum:set_min_size(l_6_7)
end

ColorPickerDraggables._update_ui_except = function(l_7_0, l_7_1)
	if l_7_0._value_slider ~= nil then
		if l_7_1 ~= l_7_0._spectrum then
			l_7_0._spectrum:set_value(l_7_0._value_slider:value())
		end
	if l_7_1 ~= l_7_0._value_slider then
		end
		l_7_0._value_slider:set_top_color(l_7_0._spectrum:unscaled_color())
	end
	if l_7_1 ~= l_7_0._alpha_slider and l_7_0._alpha_slider ~= nil then
		if not l_7_0._value_slider then
			local l_7_2 = l_7_0._spectrum:color()
			l_7_0._alpha_slider:set_top_color(l_7_2)
			l_7_0._alpha_slider:set_bottom_color(l_7_2:with_alpha(0))
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 32 
end

ColorPickerDraggables._process_color_update_event = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_2:get_position(l_8_1)
	if l_8_1 == l_8_0._spectrum then
		l_8_1:set_hue(l_8_1:point_to_hue(l_8_3))
		l_8_1:set_saturation(l_8_1:point_to_saturation(l_8_3))
	else
		l_8_1:set_value(l_8_1:point_to_value(l_8_3))
	end
	l_8_0:_update_ui_except(l_8_1)
	l_8_0:_send_event("EVT_COLOR_UPDATED", l_8_0:color())
end

ColorPickerDraggables._process_color_change_event = function(l_9_0, l_9_1, l_9_2)
	l_9_0:_process_color_update_event(l_9_1, l_9_2)
	l_9_0:_send_event("EVT_COLOR_CHANGED", l_9_0:color())
end

ColorPickerDraggables._on_drag_start = function(l_10_0, l_10_1, l_10_2)
	l_10_0._previous_mouse_event = EWS:MouseEvent("EVT_LEFT_DOWN")
	l_10_0._dragged_control = l_10_1
	l_10_0:_process_color_update_event(l_10_1, l_10_2)
end

ColorPickerDraggables._on_dragging = function(l_11_0, l_11_1, l_11_2)
	l_11_0:_process_color_update_event(l_11_1, l_11_2)
end

ColorPickerDraggables._on_drag_stop = function(l_12_0, l_12_1, l_12_2)
	l_12_0:_process_color_change_event(l_12_1, l_12_2)
	l_12_0._dragged_control = nil
end


