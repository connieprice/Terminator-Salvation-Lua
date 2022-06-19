core:module("CoreColorPickerFields")
core:require_module("CoreClass")
core:require_module("CoreEvent")
core:require_module("CoreTable")
core:require_module("CoreEws")
core:require_module("CoreMath")
if not ColorPickerFields then
	ColorPickerFields = CoreClass.mixin(CoreClass.class(), CoreEvent.BasicEventHandling)
end
ColorPickerFields.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	l_1_0:_create_panel(l_1_1, l_1_2, l_1_3)
	l_1_0:set_color(Color.white)
end

ColorPickerFields.update = function(l_2_0, l_2_1, l_2_2)
	if l_2_0._is_picking_color_from_screen then
		local l_2_3 = EWS:MouseEvent("EVT_MOTION")
		l_2_0._previous_mouse_event = l_2_0._previous_mouse_event or l_2_3
		if l_2_3:get_position() ~= l_2_0._previous_mouse_event:get_position() then
			local l_2_4 = EWS:get_screen_pixel(l_2_3:get_position_on_screen()) / 255
			local l_2_5 = Color(l_2_4.x, l_2_4.y, l_2_4.z)
			l_2_0:set_color(l_2_5)
			l_2_0:_send_event("EVT_COLOR_UPDATED", l_2_5)
		end
		if l_2_3:left_is_down() == true and l_2_0._previous_mouse_event:left_is_down() == false then
			l_2_0:_on_exit_eyedropper_mode(nil, l_2_3)
			l_2_3 = nil
		end
		l_2_0._previous_mouse_event = l_2_3
	end
end

ColorPickerFields.panel = function(l_3_0)
	return l_3_0._panel
end

ColorPickerFields.color = function(l_4_0)
	do
		local l_4_1 = l_4_0:_field_value("Alpha") or 255
	do
		end
		local l_4_2 = nil
	do
		end
		local l_4_3 = nil
	do
		end
		local l_4_4 = nil
	end
	local l_4_5 = nil
	local l_4_6 = l_4_0:_field_value("Red") or 0
	local l_4_7 = l_4_0:_field_value("Green") or 0
	local l_4_8 = l_4_0:_field_value("Blue") or 0
	local l_4_9 = Color
	return l_4_9(l_4_5 / 255, l_4_6 / 255, l_4_7 / 255, l_4_8 / 255)
end

ColorPickerFields.set_color = function(l_5_0, l_5_1)
	l_5_0:_set_field_values_except(nil, l_5_1)
end

ColorPickerFields._field_value = function(l_6_0, l_6_1)
	local l_6_7, l_6_8, l_6_9, l_6_10 = nil
	if not l_6_0._field_groups or not assert(l_6_0._field_groups[l_6_1], "Invalid field.") then
		local l_6_2, l_6_3 = {}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	for i_0,i_1 in ipairs(l_6_2) do
		local l_6_4 = nil
		return tonumber(i_1:get_value())
	end
end

ColorPickerFields._change_field_value = function(l_7_0, l_7_1, l_7_2)
	local l_7_7, l_7_8, l_7_9, l_7_10 = nil
	local l_7_3 = assert(l_7_0._field_groups[l_7_1], "Invalid field.")
	for i_0,i_1 in ipairs(l_7_3) do
		i_1:change_value(string.format("%.0f", l_7_2))
	end
end

ColorPickerFields._create_panel = function(l_8_0, l_8_1, l_8_2, l_8_3)
	l_8_0 = l_8_2 == nil and (l_8_0)
	l_8_2 = true
	l_8_0 = l_8_3 == nil and (l_8_0)
	l_8_3 = true
	l_8_0._panel = EWS:Panel(l_8_1)
	l_8_0._panel:set_min_size(Vector3(180, 134, 0))
	local l_8_4 = EWS:BoxSizer("HORIZONTAL")
	l_8_0._panel:set_sizer(l_8_4)
	local l_8_5 = EWS:Notebook(l_8_0._panel, "", "NB_TOP")
	l_8_5:add_page(l_8_0:_create_rgb_fields(l_8_5), "RGB", true)
	local l_8_9 = l_8_5:add_page
	local l_8_10 = l_8_5
	l_8_9(l_8_10, l_8_0:_create_hsv_fields(l_8_5), "HSV", false)
	if not l_8_2 then
		l_8_9 = ipairs
		l_8_10 = l_8_0._field_groups
		l_8_10 = l_8_10.Alpha
		l_8_9 = l_8_9(l_8_10)
		for i_0,i_1 in l_8_9 do
			l_8_8:set_enabled(false)
		end
	end
	if not l_8_3 then
		for i_0,i_1 in ipairs(l_8_0._field_groups.Value) do
			i_1:set_enabled(false)
		end
	end
	l_8_4:add(l_8_5, 1, 3, "ALL,EXPAND")
	l_8_0._color_well_column_panel = EWS:Panel(l_8_0._panel)
	l_8_0._color_well_column_panel:set_sizer(EWS:BoxSizer("VERTICAL"))
	EWS:BoxSizer("VERTICAL"):add(l_8_0:_create_color_well(l_8_0._color_well_column_panel), 1, 23, "TOP,EXPAND")
	EWS:BoxSizer("VERTICAL"):add(l_8_0:_create_color_picker_button(l_8_0._color_well_column_panel), 0, 4, "TOP,BOTTOM,EXPAND")
	l_8_4:add(l_8_0._color_well_column_panel, 0, 3, "RIGHT,EXPAND")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ColorPickerFields._create_color_well = function(l_9_0, l_9_1)
	l_9_0._color_well = EWS:ColorWell(l_9_1, "")
	l_9_0._color_well:set_tool_tip("Active color")
	l_9_0._color_well:set_size(Vector3(41, 80, 0))
	l_9_0._color_well:set_color(l_9_0:color())
	return l_9_0._color_well
end

ColorPickerFields._create_color_picker_button = function(l_10_0, l_10_1)
	l_10_0._color_picker_button = EWS:BitmapButton(l_10_1, CoreEws.image_path("toolbar/eye_dropper_16x16.png"), "", "")
	l_10_0._color_picker_button:set_tool_tip("Pick a color from the screen")
	l_10_0._color_picker_button:connect("EVT_COMMAND_BUTTON_CLICKED", CoreEvent.callback(l_10_0, l_10_0, "_on_enter_eyedropper_mode"), l_10_0._color_picker_button)
	return l_10_0._color_picker_button
end

ColorPickerFields._create_rgb_fields = function(l_11_0, l_11_1)
	local l_11_2 = {}
	local l_11_3 = "Red"
	local l_11_4 = {}
	l_11_4.max = 255
	local l_11_5 = "Green"
	local l_11_6 = {}
	l_11_6.max = 255
	local l_11_7 = "Blue"
	local l_11_8 = {}
	l_11_8.max = 255
	local l_11_9 = "Alpha"
	local l_11_10 = {}
	l_11_10.max = 255
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_11_3, l_11_4 = l_11_0:_create_panel_with_fields, l_11_0
	l_11_5 = l_11_1
	l_11_6 = l_11_2
	return l_11_3(l_11_4, l_11_5, l_11_6)
end

ColorPickerFields._create_hsv_fields = function(l_12_0, l_12_1)
	local l_12_2 = {}
	local l_12_3 = "Hue"
	local l_12_4 = {}
	l_12_4.max = 359
	l_12_4.wrap = true
	local l_12_5 = "Sat"
	local l_12_6 = {}
	l_12_6.max = 100
	local l_12_7 = "Value"
	local l_12_8 = {}
	l_12_8.max = 100
	local l_12_9 = "Alpha"
	local l_12_10 = {}
	l_12_10.max = 255
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_12_3, l_12_4 = l_12_0:_create_panel_with_fields, l_12_0
	l_12_5 = l_12_1
	l_12_6 = l_12_2
	return l_12_3(l_12_4, l_12_5, l_12_6)
end

ColorPickerFields._create_panel_with_fields = function(l_13_0, l_13_1, l_13_2)
	local l_13_3 = EWS:Panel(l_13_1)
	local l_13_9 = EWS:FlexGridSizer
	l_13_9 = l_13_9(EWS, 0, 2, 3, 0)
	local l_13_4 = nil
	l_13_4(l_13_9, 1, 1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_13_4(l_13_3, l_13_9)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_13_4(l_13_9, 50, 0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_13_8 = l_13_9
	l_13_4(l_13_8, 0, 0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_13_8 = l_13_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_13_4 do
		local l_13_10 = 0
		local l_13_11 = EWS:StaticText(l_13_3, l_13_6 .. ":")
		local l_13_12 = EWS:SpinCtrl(l_13_3, tostring(l_13_10), "", l_13_7.wrap and "SP_WRAP,SP_ARROW_KEYS" or "SP_ARROW_KEYS")
		l_13_12:set_range(0, l_13_7.max or 255)
		l_13_12:connect("EVT_COMMAND_TEXT_UPDATED", CoreEvent.callback(l_13_0, l_13_0, "_on_field_edited"), l_13_12)
		l_13_9:add(l_13_11, 0, 5, "LEFT,ALIGN_CENTER_VERTICAL")
		l_13_9:add(l_13_12, 1, 5, "RIGHT,EXPAND")
		if not l_13_0._field_groups then
			l_13_0._field_groups = {}
		end
		if not l_13_0._field_groups[l_13_6] then
			l_13_0._field_groups[l_13_6] = {}
		end
		table.insert(l_13_0._field_groups[l_13_6], l_13_12)
	end
	return l_13_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ColorPickerFields._on_field_edited = function(l_14_0, l_14_1, l_14_2)
	local l_14_6, l_14_7 = ipairs, l_14_0:_mirroring_fields(l_14_1)
	l_14_6 = l_14_6(l_14_7)
	for i_0,i_1 in l_14_6 do
		l_14_5:change_value(l_14_1:get_value())
	end
	if table.contains({"Red", "Green", "Blue"}, l_14_0:_field_label(l_14_1)) and l_14_0:_parse_values({Red = 255, Green = 255, Blue = 255, Alpha = 255}) then
		l_14_0:_set_field_values_except(l_14_0:_field_label(l_14_1), Color(l_14_0:_parse_values({Red = 255, Green = 255, Blue = 255, Alpha = 255}).Alpha, l_14_0:_parse_values({Red = 255, Green = 255, Blue = 255, Alpha = 255}).Red, l_14_0:_parse_values({Red = 255, Green = 255, Blue = 255, Alpha = 255}).Green, l_14_0:_parse_values({Red = 255, Green = 255, Blue = 255, Alpha = 255}).Blue))
	end
	do return end
	if table.contains({"Hue", "Sat", "Value"}, l_14_0:_field_label(l_14_1)) and l_14_0:_parse_values({Hue = 1, Sat = 100, Value = 100, Alpha = 255}) then
		r = CoreMath.hsv_to_rgb(l_14_0:_parse_values({Hue = 1, Sat = 100, Value = 100, Alpha = 255}).Hue, l_14_0:_parse_values({Hue = 1, Sat = 100, Value = 100, Alpha = 255}).Sat, l_14_0:_parse_values({Hue = 1, Sat = 100, Value = 100, Alpha = 255}).Value)
		l_14_0:_set_field_values_except(l_14_0:_field_label(l_14_1), Color(l_14_0:_parse_values({Hue = 1, Sat = 100, Value = 100, Alpha = 255}).Alpha, r, g, b))
	end
	l_14_0:_send_event("EVT_COLOR_UPDATED", l_14_0:color())
	l_14_0:_send_event("EVT_COLOR_CHANGED", l_14_0:color())
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ColorPickerFields._on_enter_eyedropper_mode = function(l_15_0, l_15_1, l_15_2)
	l_15_0._is_picking_color_from_screen = true
end

ColorPickerFields._on_exit_eyedropper_mode = function(l_16_0, l_16_1, l_16_2)
	l_16_0._is_picking_color_from_screen = nil
	l_16_0._panel:set_focus()
	l_16_0:_send_event("EVT_COLOR_CHANGED", color_under_cursor)
end

ColorPickerFields._parse_values = function(l_17_0, l_17_1)
	local l_17_6, l_17_7, l_17_8 = nil
	local l_17_2 = {}
	for i_0,i_1 in pairs(l_17_1) do
		if l_17_0:_field_value(i_0) == nil then
			return nil
		else
			l_17_2[l_17_9] = l_17_0:_field_value(i_0) / i_1
		end
	end
	return l_17_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ColorPickerFields._set_field_values_except = function(l_18_0, l_18_1, l_18_2)
	local l_18_7, l_18_8, l_18_9, l_18_10, l_18_11, l_18_12 = nil
	hue = CoreMath.rgb_to_hsv(l_18_2.red, l_18_2.green, l_18_2.blue)
	local l_18_3 = {}
	l_18_3.Red = l_18_2.red * 255
	l_18_3.Green = l_18_2.green * 255
	l_18_3.Blue = l_18_2.blue * 255
	l_18_3.Alpha = l_18_2.alpha * 255
	l_18_3.Hue = hue
	l_18_3.Sat = saturation * 100
	l_18_3.Value = value * 100
	for i_0,i_1 in pairs(l_18_3) do
		if i_0 ~= l_18_1 then
			l_18_0:_change_field_value(i_0, i_1)
		end
	end
	l_18_0._color_well:set_color(l_18_2)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ColorPickerFields._field_label = function(l_19_0, l_19_1)
	local l_19_5, l_19_6, l_19_7 = nil
	for i_0,i_1 in pairs(l_19_0._field_groups) do
		if table.contains(i_1, l_19_1) then
			return i_0
		end
	end
end

ColorPickerFields._mirroring_fields = function(l_20_0, l_20_1)
	local l_20_2 = table.map_values(l_20_0._field_groups)
	local l_20_3 = table.find_value(l_20_2, function(l_21_0)
		-- upvalues: l_20_1
		local l_21_1 = table.contains
		local l_21_2 = l_21_0
		local l_21_3 = l_20_1
		return l_21_1(l_21_2, l_21_3)
  end)
	local l_20_4 = table.exclude
	local l_20_5 = l_20_3
	local l_20_6 = l_20_1
	return l_20_4(l_20_5, l_20_6)
end


