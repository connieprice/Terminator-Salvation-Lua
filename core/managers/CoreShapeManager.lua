if not CoreShapeManager then
	CoreShapeManager = class()
end
CoreShapeManager.init = function(l_1_0)
	l_1_0._shapes = {}
	l_1_0._shape_types = {}
	if not rawget(_G, "ShapeBox") then
		l_1_0._shape_types.box = rawget(_G, "CoreShapeBox")
	end
	if not rawget(_G, "ShapeBoxMiddle") then
		l_1_0._shape_types.box_middle = rawget(_G, "CoreShapeBoxMiddle")
	end
	if not rawget(_G, "ShapeSphere") then
		l_1_0._shape_types.sphere = rawget(_G, "CoreShapeSphere")
	end
	if not rawget(_G, "ShapeCylinder") then
		l_1_0._shape_types.cylinder = rawget(_G, "CoreShapeCylinder")
	end
end

CoreShapeManager.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7, l_2_8, l_2_9 = nil
	for i_0,i_1 in ipairs(l_2_0._shapes) do
		i_1:draw(l_2_1, l_2_2, 0.8, 0.8)
	end
end

CoreShapeManager.add_shape = function(l_3_0, l_3_1, l_3_2)
	l_3_2.type = l_3_1
	local l_3_3 = l_3_0._shape_types[l_3_1]:new(l_3_2)
	table.insert(l_3_0._shapes, l_3_3)
	return l_3_3
end

CoreShapeManager.shape_type = function(l_4_0, l_4_1)
	return l_4_0._shape_types[l_4_1]
end

CoreShapeManager.remove_shape = function(l_5_0, l_5_1)
	l_5_1:destroy()
	table.delete(l_5_0._shapes, l_5_1)
end

CoreShapeManager.clear_shapes = function(l_6_0)
	local l_6_4, l_6_5 = ipairs, clone(l_6_0._shapes)
	l_6_4 = l_6_4(l_6_5)
	for i_0,i_1 in l_6_4 do
		l_6_0:remove_shape(l_6_3)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreShapeManager.save = function(l_7_0)
end

CoreShapeManager.parse = function(l_8_0, l_8_1)
	local l_8_2 = {}
	l_8_2.type = l_8_1:parameter("type")
	l_8_2.position = math.string_to_vector(l_8_1:parameter("position"))
	local l_8_6, l_8_10 = math.string_to_rotation, l_8_1:parameter("rotation")
	l_8_6 = l_8_6(l_8_10)
	l_8_2.rotation = l_8_6
	l_8_6, l_8_10 = l_8_1:children, l_8_1
	l_8_6 = l_8_6(l_8_10)
	for i_0 in l_8_6 do
		local l_8_5 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_8_5 do
			local l_8_11 = l_8_9:parameter("name")
			l_8_2[l_8_11] = string_to_value(l_8_9:parameter("type"), l_8_9:parameter("value"))
		end
	end
	return l_8_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not CoreShape then
	CoreShape = class()
end
CoreShape.init = function(l_9_0, l_9_1)
	l_9_0._name = l_9_1.name or ""
	l_9_0._type = l_9_1.type or "none"
	if not l_9_1.position then
		l_9_0._position = Vector3()
	end
	if not l_9_1.rotation then
		l_9_0._rotation = Rotation()
	end
	l_9_0._properties = {}
	l_9_0:build_dialog()
end

CoreShape.build_dialog = function(l_10_0)
	if not Application:editor() then
		return 
	end
	l_10_0._properties_ctrls = {}
	l_10_0._dialog = EWS:Dialog(nil, "Shape properties", "", Vector3(200, 100, 0), Vector3(750, 600, 0), "DEFAULT_DIALOG_STYLE,RESIZE_BORDER,STAY_ON_TOP")
	l_10_0._dialog_sizer = EWS:BoxSizer("VERTICAL")
	l_10_0._dialog:set_sizer(l_10_0._dialog_sizer)
	l_10_0._min_value = 10
	l_10_0._max_value = 10000000
	l_10_0:set_dialog_visible(false)
end

CoreShape.build_properties_ctrls = function(l_11_0)
end

CoreShape.name = function(l_12_0)
	if not l_12_0._unit or not l_12_0._unit:unit_data().name_id then
		return l_12_0._name
	end
end

CoreShape.unit = function(l_13_0)
	return l_13_0._unit
end

CoreShape.set_unit = function(l_14_0, l_14_1)
	l_14_0._unit = l_14_1
end

CoreShape.position = function(l_15_0)
	if not l_15_0._unit or not l_15_0._unit:position() then
		return l_15_0._position
	end
end

CoreShape.set_position = function(l_16_0, l_16_1)
	l_16_0._position = l_16_1
end

CoreShape.rotation = function(l_17_0)
	if not l_17_0._unit or not l_17_0._unit:rotation() then
		return l_17_0._rotation
	end
end

CoreShape.set_rotation = function(l_18_0, l_18_1)
	l_18_0._rotation = l_18_1
end

CoreShape.properties = function(l_19_0)
	return l_19_0._properties
end

CoreShape.property = function(l_20_0, l_20_1)
	return l_20_0._properties[l_20_1]
end

CoreShape.set_property = function(l_21_0, l_21_1, l_21_2)
	local l_21_7, l_21_8 = nil
	local l_21_6 = math.clamp
	l_21_6 = l_21_6(l_21_2, l_21_0._min_value, l_21_0._max_value)
	l_21_2 = l_21_6
	l_21_6 = l_21_0._properties
	l_21_6[l_21_1] = l_21_2
	l_21_6 = l_21_0._properties_ctrls
	if l_21_6 then
		l_21_6 = ipairs
		l_21_6 = l_21_6(l_21_0._properties_ctrls[l_21_1])
		for i_0,i_1 in l_21_6 do
			i_1:set_value(string.format("%.2f", l_21_2 / 100))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreShape.set_property_string = function(l_22_0, l_22_1, l_22_2)
	l_22_0._properties[l_22_1] = l_22_2
end

CoreShape.scale = function(l_23_0)
end

CoreShape.set_dialog_visible = function(l_24_0, l_24_1)
	l_24_0._dialog:set_visible(l_24_1)
end

CoreShape.panel = function(l_25_0, l_25_1, l_25_2)
	if not l_25_0._panel and l_25_1 and l_25_2 then
		l_25_0:create_panel(l_25_1, l_25_2)
	end
	return l_25_0._panel
end

CoreShape.create_panel = function(l_26_0, l_26_1, l_26_2)
	l_26_0._panel = EWS:Panel(l_26_1, "", "")
	l_26_0._panel_sizer = EWS:BoxSizer("VERTICAL")
	l_26_0._panel:set_sizer(l_26_0._panel_sizer)
	l_26_2:add(l_26_0._panel, 0, 0, "EXPAND")
end

CoreShape._create_size_ctrl = function(l_27_0, l_27_1, l_27_2, l_27_3, l_27_4, l_27_5)
	local l_27_6 = EWS:BoxSizer("HORIZONTAL")
	l_27_6:add(EWS:StaticText(l_27_4, l_27_1, "", "ALIGN_LEFT"), 2, 0, "EXPAND")
	local l_27_7 = EWS:TextCtrl(l_27_4, string.format("%.2f", l_27_3 / 100), "", "TE_PROCESS_ENTER")
	local l_27_8 = EWS:SpinButton(l_27_4, "", "SP_VERTICAL")
	l_27_7:connect("EVT_CHAR", callback(nil, _G, "verify_number"), l_27_7)
	l_27_7:set_tool_tip("Type in property " .. l_27_1)
	local l_27_9, l_27_10 = l_27_7:connect, l_27_7
	local l_27_11 = "EVT_COMMAND_TEXT_ENTER"
	local l_27_12 = callback(l_27_0, l_27_0, "update_size")
	local l_27_13 = {}
	l_27_13.ctrl = l_27_7
	l_27_13.property = l_27_2
	l_27_9(l_27_10, l_27_11, l_27_12, l_27_13)
	l_27_9, l_27_10 = l_27_7:connect, l_27_7
	l_27_11 = "EVT_KILL_FOCUS"
	l_27_12 = callback
	l_27_13 = l_27_0
	l_27_12 = l_27_12(l_27_13, l_27_0, "update_size")
	l_27_9(l_27_10, l_27_11, l_27_12, l_27_13)
	l_27_13 = {ctrl = l_27_7, property = l_27_2}
	l_27_9, l_27_10 = l_27_8:connect, l_27_8
	l_27_11 = "EVT_SCROLL_LINEUP"
	l_27_12 = callback
	l_27_13 = l_27_0
	l_27_12 = l_27_12(l_27_13, l_27_0, "update_size_spin")
	l_27_9(l_27_10, l_27_11, l_27_12, l_27_13)
	l_27_13 = {ctrl = l_27_7, property = l_27_2, step = 0.1}
	l_27_9, l_27_10 = l_27_8:connect, l_27_8
	l_27_11 = "EVT_SCROLL_LINEDOWN"
	l_27_12 = callback
	l_27_13 = l_27_0
	l_27_12 = l_27_12(l_27_13, l_27_0, "update_size_spin")
	l_27_9(l_27_10, l_27_11, l_27_12, l_27_13)
	l_27_13 = {ctrl = l_27_7, property = l_27_2, step = -0.1}
	l_27_9, l_27_10 = l_27_6:add, l_27_6
	l_27_11 = l_27_7
	l_27_12 = 3
	l_27_13 = 0
	l_27_9(l_27_10, l_27_11, l_27_12, l_27_13, "EXPAND")
	l_27_9, l_27_10 = l_27_6:add, l_27_6
	l_27_11 = l_27_8
	l_27_12 = 0
	l_27_13 = 0
	l_27_9(l_27_10, l_27_11, l_27_12, l_27_13, "EXPAND")
	l_27_9 = l_27_0._properties_ctrls
	l_27_10 = l_27_0._properties_ctrls
	l_27_10 = l_27_10[l_27_2]
	if not l_27_10 then
		l_27_9[l_27_2], l_27_10 = l_27_10, {}
	end
	l_27_9 = table
	l_27_9 = l_27_9.insert
	l_27_10 = l_27_0._properties_ctrls
	l_27_10 = l_27_10[l_27_2]
	l_27_11 = l_27_7
	l_27_9(l_27_10, l_27_11)
	l_27_9, l_27_10 = l_27_5:add, l_27_5
	l_27_11 = l_27_6
	l_27_12 = 1
	l_27_13 = 0
	l_27_9(l_27_10, l_27_11, l_27_12, l_27_13, "EXPAND")
	return l_27_7
end

CoreShape.update_size = function(l_28_0, l_28_1)
	local l_28_2 = l_28_1.ctrl:get_value()
	l_28_0:set_property(l_28_1.property, l_28_2 * 100)
	l_28_1.ctrl:set_selection(-1, -1)
end

CoreShape.update_size_spin = function(l_29_0, l_29_1)
	local l_29_2 = l_29_1.ctrl:get_value() + l_29_1.step
	l_29_0:set_property(l_29_1.property, l_29_2 * 100)
end

CoreShape.draw = function(l_30_0, l_30_1, l_30_2, l_30_3, l_30_4, l_30_5)
end

CoreShape.is_inside = function(l_31_0, l_31_1)
end

CoreShape.is_outside = function(l_32_0, l_32_1)
end

CoreShape.save = function(l_33_0, l_33_1)
	local l_33_3 = nil
	local l_33_4 = l_33_1 or ""
	do
		local l_33_5 = vector_to_string(l_33_0:position(), "%.4f")
		l_33_4 = l_33_4 .. "<shape type=\"" .. l_33_0._type .. "\" position=\"" .. l_33_5 .. "\" rotation=\"" .. rotation_to_string(l_33_0:rotation(), "%.4f") .. "\">\n"
		l_33_4 = l_33_4 .. save_value_string(l_33_0, "_properties", l_33_3 .. "\t") .. "\n"
		l_33_4 = l_33_4 .. l_33_3 .. "</shape>"
		return l_33_4
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreShape.save_level_data = function(l_34_0)
	local l_34_5, l_34_6 = nil
	local l_34_1 = {}
	l_34_1.type = l_34_0._type
	l_34_1.position = l_34_0:position()
	l_34_1.rotation = l_34_0:rotation()
	for i_0,i_1 in pairs(l_34_0._properties) do
		l_34_1[i_0] = i_1
	end
	return l_34_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreShape.destroy = function(l_35_0)
	l_35_0._dialog:destroy()
end

if not CoreShapeBox then
	CoreShapeBox = class(CoreShape)
end
CoreShapeBox.init = function(l_36_0, l_36_1)
	CoreShape.init(l_36_0, l_36_1)
	l_36_0._properties.width = l_36_1.width or 1000
	l_36_0._properties.depth = l_36_1.depth or 1000
	l_36_0._properties.height = l_36_1.height or 1000
	l_36_0:build_properties_ctrls()
end

CoreShapeBox.create_panel = function(l_37_0, l_37_1, l_37_2)
	CoreShape.create_panel(l_37_0, l_37_1, l_37_2)
	l_37_0:_create_size_ctrl("Width [m]", "width", l_37_0._properties.width, l_37_0._panel, l_37_0._panel_sizer)
	l_37_0:_create_size_ctrl("Depth [m]", "depth", l_37_0._properties.depth, l_37_0._panel, l_37_0._panel_sizer)
	l_37_0:_create_size_ctrl("Height [m]", "height", l_37_0._properties.height, l_37_0._panel, l_37_0._panel_sizer)
	l_37_0._panel:set_min_size(Vector3(-1, 60, 0))
end

CoreShapeBox.build_properties_ctrls = function(l_38_0)
	if not Application:editor() then
		return 
	end
	l_38_0:_create_size_ctrl("Width [m]", "width", l_38_0._properties.width, l_38_0._dialog, l_38_0._dialog_sizer)
	l_38_0:_create_size_ctrl("Depth [m]", "depth", l_38_0._properties.depth, l_38_0._dialog, l_38_0._dialog_sizer)
	l_38_0:_create_size_ctrl("Height [m]", "height", l_38_0._properties.height, l_38_0._dialog, l_38_0._dialog_sizer)
	l_38_0._dialog:set_size(Vector3(190, 90, 0))
end

CoreShapeBox.width = function(l_39_0)
	return l_39_0._properties.width
end

CoreShapeBox.set_width = function(l_40_0, l_40_1)
	l_40_0:set_property("width", l_40_1)
end

CoreShapeBox.depth = function(l_41_0)
	return l_41_0._properties.depth
end

CoreShapeBox.set_depth = function(l_42_0, l_42_1)
	l_42_0:set_property("depth", l_42_1)
end

CoreShapeBox.height = function(l_43_0)
	return l_43_0._properties.height
end

CoreShapeBox.set_height = function(l_44_0, l_44_1)
	l_44_0:set_property("height", l_44_1)
end

CoreShapeBox.still_inside = function(l_45_0, l_45_1)
	local l_45_2, l_45_3 = l_45_0:is_inside, l_45_0
	local l_45_4 = l_45_1
	return l_45_2(l_45_3, l_45_4)
end

CoreShapeBox.is_inside = function(l_46_0, l_46_1)
	local l_46_2 = l_46_1 - l_46_0:position()
	local l_46_3 = l_46_0:rotation()
	local l_46_4 = l_46_3:x():dot(l_46_2)
	if l_46_4 > 0 and l_46_4 < l_46_0._properties.width then
		l_46_4 = l_46_3:y():dot(l_46_2)
	if l_46_4 > 0 then
		end
	if l_46_4 < l_46_0._properties.depth then
		end
		l_46_4 = l_46_3:z():dot(l_46_2)
	if l_46_4 > 0 then
		end
	if l_46_4 < l_46_0._properties.height then
		end
		return true
	end
	return false
end

CoreShapeBox.draw = function(l_47_0, l_47_1, l_47_2, l_47_3, l_47_4, l_47_5)
	local l_47_6 = Draw:brush()
	l_47_6:set_color(Color(0.5, l_47_3, l_47_4, l_47_5))
	local l_47_7 = l_47_0:position()
	local l_47_8 = l_47_0:rotation()
	l_47_7 = l_47_7 + l_47_8:x() * l_47_0._properties.width / 2 + l_47_8:y() * l_47_0._properties.depth / 2 + l_47_8:z() * l_47_0._properties.height / 2
	l_47_6:box(l_47_7, l_47_8:x() * l_47_0._properties.width / 2, l_47_8:y() * l_47_0._properties.depth / 2, l_47_8:z() * l_47_0._properties.height / 2)
end

if not CoreShapeBoxMiddle then
	CoreShapeBoxMiddle = class(CoreShapeBox)
end
CoreShapeBoxMiddle.init = function(l_48_0, l_48_1)
	CoreShapeBox.init(l_48_0, l_48_1)
end

CoreShapeBoxMiddle.is_inside = function(l_49_0, l_49_1)
	local l_49_2 = l_49_0:rotation()
	local l_49_3 = l_49_2:x() * l_49_0._properties.width / 2
	local l_49_4 = l_49_2:y() * l_49_0._properties.depth / 2
	local l_49_5 = l_49_2:z() * l_49_0._properties.height / 2
	local l_49_6 = l_49_0:position() - l_49_3 - l_49_4 - l_49_5
	local l_49_7 = l_49_1 - l_49_6
	local l_49_8 = l_49_2:x():dot(l_49_7)
	if l_49_8 > 0 and l_49_8 < l_49_0._properties.width then
		l_49_8 = l_49_2:y():dot(l_49_7)
	if l_49_8 > 0 then
		end
	if l_49_8 < l_49_0._properties.depth then
		end
		l_49_8 = l_49_2:z():dot(l_49_7)
	if l_49_8 > 0 then
		end
	if l_49_8 < l_49_0._properties.height then
		end
		return true
	end
	return false
end

CoreShapeBoxMiddle.draw = function(l_50_0, l_50_1, l_50_2, l_50_3, l_50_4, l_50_5)
	local l_50_6 = Draw:brush()
	l_50_6:set_color(Color(0.5, l_50_3, l_50_4, l_50_5))
	local l_50_7 = l_50_0:position()
	local l_50_8 = l_50_0:rotation()
	l_50_6:box(l_50_7, l_50_8:x() * l_50_0._properties.width / 2, l_50_8:y() * l_50_0._properties.depth / 2, l_50_8:z() * l_50_0._properties.height / 2)
end

if not CoreShapeSphere then
	CoreShapeSphere = class(CoreShape)
end
CoreShapeSphere.init = function(l_51_0, l_51_1)
	CoreShape.init(l_51_0, l_51_1)
	l_51_0._properties.radius = l_51_1.radius or 1000
	l_51_0:build_properties_ctrls()
end

CoreShapeSphere.build_properties_ctrls = function(l_52_0)
	if not Application:editor() then
		return 
	end
	l_52_0:_create_size_ctrl("Radius [m]", "radius", l_52_0._properties.radius, l_52_0._dialog_sizer)
	l_52_0._dialog:set_size(Vector3(190, 50, 0))
end

CoreShapeSphere.radius = function(l_53_0)
	return l_53_0._properties.radius
end

CoreShapeSphere.set_radius = function(l_54_0, l_54_1)
	l_54_0:set_property("radius", l_54_1)
end

CoreShapeSphere.is_inside = function(l_55_0, l_55_1)
	return l_55_1 - l_55_0:position():length() < l_55_0._properties.radius
end

CoreShapeSphere.draw = function(l_56_0, l_56_1, l_56_2, l_56_3, l_56_4, l_56_5)
	local l_56_6 = Draw:brush()
	l_56_6:set_color(Color(0.5, l_56_3, l_56_4, l_56_5))
	l_56_6:sphere(l_56_0:position(), l_56_0._properties.radius, 4)
	Application:draw_sphere(l_56_0:position(), l_56_0._properties.radius, l_56_3, l_56_4, l_56_5)
end

if not CoreShapeCylinder then
	CoreShapeCylinder = class(CoreShape)
end
CoreShapeCylinder.init = function(l_57_0, l_57_1)
	CoreShape.init(l_57_0, l_57_1)
	l_57_0._properties.radius = l_57_1.radius or 1000
	l_57_0._properties.height = l_57_1.height or 1000
	l_57_0:build_properties_ctrls()
end

CoreShapeCylinder.build_properties_ctrls = function(l_58_0)
	if not Application:editor() then
		return 
	end
	l_58_0:_create_size_ctrl("Radius [m]", "radius", l_58_0._properties.radius, l_58_0._dialog_sizer)
	l_58_0:_create_size_ctrl("Height [m]", "height", l_58_0._properties.height, l_58_0._dialog_sizer)
	l_58_0._dialog:set_size(Vector3(190, 70, 0))
end

CoreShapeCylinder.radius = function(l_59_0)
	return l_59_0._properties.radius
end

CoreShapeCylinder.set_radius = function(l_60_0, l_60_1)
	l_60_0:set_property("radius", l_60_1)
end

CoreShapeCylinder.height = function(l_61_0)
	return l_61_0._properties.height
end

CoreShapeCylinder.set_height = function(l_62_0, l_62_1)
	l_62_0:set_property("height", l_62_1)
end

CoreShapeCylinder.draw = function(l_63_0, l_63_1, l_63_2, l_63_3, l_63_4, l_63_5)
	local l_63_6 = Draw:brush()
	l_63_6:set_color(Color(0.5, l_63_3, l_63_4, l_63_5))
	local l_63_7 = l_63_0:position()
	local l_63_8 = l_63_0:rotation()
	l_63_6:cylinder(l_63_7, l_63_7 + l_63_8:z() * l_63_0._properties.height, l_63_0._properties.radius, 100)
	Application:draw_cylinder(l_63_7, l_63_7 + l_63_8:z() * l_63_0._properties.height, l_63_0._properties.radius, l_63_3, l_63_4, l_63_5)
end

CoreShapeCylinder.is_inside = function(l_64_0, l_64_1)
	local l_64_2 = l_64_1 - l_64_0:position()
	local l_64_3 = l_64_0:rotation()
	local l_64_4 = l_64_3:z():dot(l_64_2)
	if l_64_4 > 0 and l_64_4 < l_64_0._properties.height then
		local l_64_5 = l_64_0:position()
		local l_64_6 = l_64_5 + l_64_3:z() * l_64_0._properties.height
	if math.distance_to_segment(l_64_1, l_64_5, l_64_6) <= l_64_0._properties.radius then
		end
		return true
	end
	return false
end


