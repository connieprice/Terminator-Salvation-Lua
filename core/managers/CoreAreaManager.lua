if not CoreAreaManager then
	CoreAreaManager = class(CallbackHandler)
end
CoreAreaManager.init = function(l_1_0)
	CallbackHandler.init(l_1_0)
	l_1_0:_set_default_interval(0.1)
	l_1_0._every_frame_check = {}
	l_1_0._area_group_map = {}
	l_1_0._brush = Draw:brush()
end

CoreAreaManager._set_default_interval = function(l_2_0, l_2_1)
	l_2_0._DEFAULT_INTERVAL = l_2_1
end

CoreAreaManager.default_interval = function(l_3_0)
	return l_3_0._DEFAULT_INTERVAL
end

CoreAreaManager.create_area = function(l_4_0, l_4_1)
	do
		local l_4_2 = l_4_1:parameter("name")
		if not l_4_0._area_group_map[l_4_2] then
			if not rawget(_G, "AreaGroup") then
				l_4_0._area_group_map[l_4_2] = rawget(_G, "CoreAreaGroup"):new(l_4_0, l_4_1, l_4_2)
			end
			l_4_0._area_group_map[l_4_2]:parse(l_4_1)
			return l_4_0._area_group_map[l_4_2]
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 19 
end

CoreAreaManager.get_area = function(l_5_0, l_5_1, l_5_2)
	if not l_5_0._area_group_map[l_5_1] then
		if not rawget(_G, "AreaGroup") then
			l_5_0._area_group_map[l_5_1] = rawget(_G, "CoreAreaGroup"):new(l_5_0, l_5_2, l_5_1)
		end
		do
			local l_5_3 = parse_values_node(l_5_2)
			if l_5_3.area_type then
				l_5_0._area_group_map[l_5_1]:set_properties(l_5_3)
			end
			return l_5_0._area_group_map[l_5_1]
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 16 
end

CoreAreaManager.update = function(l_6_0, l_6_1, l_6_2)
	local l_6_6, l_6_7, l_6_8, l_6_9 = nil
	CallbackHandler.update(l_6_0, l_6_2)
	for i_0,i_1 in ipairs(l_6_0._every_frame_check) do
		i_1()
	end
	l_6_0:debug_draw()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAreaManager.debug_draw = function(l_7_0)
	local l_7_4, l_7_5, l_7_6, l_7_7 = nil
	if not Application:editor() then
		return 
	end
	if not managers.editor:simulation_debug_areas() then
		return 
	end
	for i_0,i_1 in pairs(l_7_0._area_group_map) do
		local l_7_10 = 0.25
		local l_7_11 = 0.5
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_7_9:active() then
			local l_7_15, l_7_16 = 0, 0
			for i_0,i_1 in ipairs(l_7_9:shapes()) do
				i_1:draw(l_7_0._brush, Color(l_7_10, l_7_11, l_7_15, l_7_16))
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 29 
end

CoreAreaManager.destroy = function(l_8_0)
	l_8_0._area_group_map = nil
end

CoreAreaManager.stop_simulation = function(l_9_0)
	local l_9_4, l_9_5, l_9_6, l_9_7 = nil
	for i_0,i_1 in pairs(l_9_0._area_group_map) do
		i_1:deactivate(true)
	end
	l_9_0._area_group_map = {}
	l_9_0._every_frame_check = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAreaManager.clear_area_groups = function(l_10_0)
	local l_10_4, l_10_5, l_10_6, l_10_7 = nil
	for i_0,i_1 in pairs(l_10_0._area_group_map) do
		i_1:clear_units_vector()
	end
end

CoreAreaManager.add = function(l_11_0, l_11_1, l_11_2)
	if l_11_2 == 0 then
		table.insert(l_11_0._every_frame_check, l_11_1)
		return l_11_1
	end
	local l_11_3 = CallbackHandler.add
	local l_11_4 = l_11_0
	local l_11_5 = l_11_1
	local l_11_6 = l_11_2
	return l_11_3(l_11_4, l_11_5, l_11_6)
end

CoreAreaManager.remove = function(l_12_0, l_12_1)
	if table.contains(l_12_0._every_frame_check, l_12_1) then
		table.delete(l_12_0._every_frame_check, l_12_1)
		return 
	end
	CallbackHandler.remove(l_12_0, l_12_1)
end

CoreAreaManager.save = function(l_13_0, l_13_1)
end

CoreAreaManager.load = function(l_14_0, l_14_1)
	l_14_0:clear_area_groups()
end

if not CoreAreaGroup then
	CoreAreaGroup = class()
end
CoreAreaGroup.init = function(l_15_0, l_15_1, l_15_2, l_15_3)
	l_15_0._cbh = l_15_1
	l_15_0._name = l_15_3
	l_15_0._type = "on_enter"
	l_15_0._in_area = false
	l_15_0._enter_state = 1
	l_15_0._exit_state = 0
	l_15_0._shape_vector = {}
	l_15_0._trigger_vector = {}
	l_15_0._units_vector = {}
	l_15_0._interval = l_15_0._cbh:default_interval()
	l_15_0._condition = "all"
	l_15_0._active = false
end

CoreAreaGroup.parse = function(l_16_0, l_16_1)
	if l_16_1:has_parameter("interval") then
		local l_16_5, l_16_6, l_16_7 = tonumber, l_16_1:parameter("interval"), .end
		l_16_5 = l_16_5(l_16_6, l_16_7)
		l_16_0._interval = l_16_5
	end
	if l_16_1:has_parameter("area_type") then
		l_16_0._type = l_16_1:parameter("area_type")
	end
	if l_16_0._type == "on_exit" then
		l_16_0._in_area = true
		l_16_0._enter_state = 0
		l_16_0._exit_state = 1
	end
	for i_0 in l_16_1:children() do
		local l_16_9 = (i_0:parameter("type"))
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_16_9 == "sphere" then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_16_9 == "box" then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_16_9 == "plane" then
			table.insert(l_16_0._shape_vector, nil)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 57 
end

CoreAreaGroup.set_properties = function(l_17_0, l_17_1)
	local l_17_5, l_17_6, l_17_7, l_17_8, l_17_9, l_17_10 = nil
	if #l_17_0._shape_vector > 0 then
		return 
	end
	l_17_0._properties = l_17_1
	if not l_17_1.area_interval then
		l_17_0._interval = l_17_0._interval
	end
	l_17_0._type = l_17_1.area_type
	if l_17_0._type == "on_exit" then
		l_17_0._in_area = true
		l_17_0._enter_state = 0
		l_17_0._exit_state = 1
	end
	for i_0,i_1 in pairs(l_17_1.shapes) do
		 -- DECOMPILER ERROR: Overwrote pending register.

		if i_1.type == "sphere" then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if i_1.type == "box" then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if i_1.type == "plane" then
			table.insert(l_17_0._shape_vector, nil)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 54 
end

CoreAreaGroup.clear_units_vector = function(l_18_0)
	if l_18_0._units_vector then
		l_18_0._units_vector = {}
	else
		l_18_0._units_vector = nil
		l_18_0._units_vector = {}
	end
end

CoreAreaGroup.add_unit = function(l_19_0, l_19_1)
	cat_debug("gaspode", "ADD UNIT", l_19_1:name(), "in", l_19_0._name)
	if not table.containse(l_19_0._units_vector, l_19_1) then
		table.insert(l_19_0._units_vector, l_19_1)
	end
end

CoreAreaGroup.remove_unit = function(l_20_0, l_20_1)
	cat_debug("gaspode", "REMOVE UNIT in", l_20_0._name)
	table.delete(l_20_0._units_vector, l_20_1)
	cat_debug("gaspode", #l_20_0._units_vector)
end

CoreAreaGroup.activate = function(l_21_0)
	cat_debug("gaspode", "-- CoreAreaGroup:activate - area:", l_21_0._name)
	if #l_21_0._shape_vector ~= 0 then
		l_21_0._active = true
		l_21_0._callback = l_21_0._cbh:add(callback(l_21_0, l_21_0, "check_area_group"), l_21_0._interval)
	else
		Application:error("-- CoreAreaGroup:activate - There are no shapes in area group!", l_21_0._name)
	end
end

CoreAreaGroup.deactivate = function(l_22_0, l_22_1)
	cat_debug("gaspode", "-- CoreAreaGroup:deactivate - area:", l_22_0._name)
	if l_22_1 then
		cat_debug("gaspode", "-- CoreAreaGroup:deactivate - area:", l_22_0._name, "was running simulation, clear units now")
		l_22_0._units_vector = {}
	end
	if l_22_0._callback then
		l_22_0._active = false
		l_22_0._cbh:remove(l_22_0._callback)
		l_22_0._callback = nil
	end
end

CoreAreaGroup.active = function(l_23_0)
	return l_23_0._active
end

CoreAreaGroup.shapes = function(l_24_0)
	return l_24_0._shape_vector
end

CoreAreaGroup.check_area_group = function(l_25_0)
	local l_25_6, l_25_7, l_25_8, l_25_9, l_25_14, l_25_15, l_25_16, l_25_17, l_25_18, l_25_19, l_25_21, l_25_22, l_25_24, l_25_25 = nil
	local l_25_1 = false
	local l_25_2 = {}
	for i_0,i_1 in ipairs(l_25_0._shape_vector) do
		do
			if i_1:check_shape(l_25_0._units_vector) ~= 0 then
				for i_0,i_1 in ipairs(i_1:check_shape(l_25_0._units_vector)) do
					local l_25_12 = nil
					if not table.contains(l_25_2, i_1) then
						table.insert(l_25_2, i_1)
					end
				end
			end
		end
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if #l_25_2 ~= 0 and l_25_0._condition == "all" and #l_25_0._units_vector == #l_25_2 then
			l_25_1 = true
		end
		do return end
		if l_25_0._condition <= #l_25_2 then
			l_25_1 = true
		end
		if l_25_1 and not l_25_0._in_area then
			l_25_0._in_area = true
			local l_25_20 = l_25_0._name
			cat_debug("gaspode", "-- CoreAreaGroup:check_area_group - entered_area", l_25_20)
			if l_25_0._type == "on_enter" then
				l_25_0:deactivate()
			end
			for l_25_20,i_1 in ipairs(l_25_0._trigger_vector) do
				i_1:set_state(l_25_0._enter_state)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		do return end
		if l_25_0._in_area then
			l_25_0._in_area = false
			local l_25_23 = l_25_0._name
			cat_debug("gaspode", "-- CoreAreaGroup:check_area_group - left_area", l_25_23)
			if l_25_0._type == "on_exit" then
				l_25_0:deactivate()
			end
			for l_25_23,i_1 in ipairs(l_25_0._trigger_vector) do
				i_1:set_state(l_25_0._exit_state)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreAreaGroup.add_trigger = function(l_26_0, l_26_1)
	table.insert(l_26_0._trigger_vector, l_26_1)
end

if not CoreAreaGroupSphere then
	CoreAreaGroupSphere = class()
end
CoreAreaGroupSphere.init = function(l_27_0, l_27_1, l_27_2)
	if l_27_2 then
		l_27_0._properties = l_27_2
	else
		l_27_0._properties = {}
		l_27_0._properties.position = math.string_to_vector(l_27_1:parameter("position")) + managers.world:offset()
		l_27_0._properties.radious = tonumber(l_27_1:parameter("radious"))
		l_27_0._properties.height = tonumber(l_27_1:parameter("height"))
	end
	l_27_0._check = l_27_0.check_2d
	if l_27_0._properties.height ~= 0 then
		l_27_0._check = l_27_0.check_3d
	end
end

CoreAreaGroupSphere.check_2d = function(l_28_0, l_28_1)
	local l_28_6, l_28_7, l_28_8, l_28_9 = nil
	local l_28_2 = {}
	for i_0,i_1 in ipairs(l_28_1) do
		if Vector3(i_1:position().x, i_1:position().y, l_28_0._properties.position.z) - l_28_0._properties.position:length() < l_28_0._properties.radious then
			table.insert(l_28_2, l_28_11)
		end
	end
	return l_28_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAreaGroupSphere.check_3d = function(l_29_0, l_29_1)
	local l_29_6, l_29_7, l_29_8, l_29_9 = nil
	local l_29_2 = {}
	for i_0,i_1 in ipairs(l_29_1) do
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if Vector3(i_1:position().x, i_1:position().y, l_29_0._properties.position.z) - l_29_0._properties.position:length() < l_29_0._properties.radious and l_29_0._properties.height < 0 and i_1:position().z < l_29_0._properties.position.z and l_29_0._properties.position.z + l_29_0._properties.height < i_1:position().z then
			table.insert(l_29_2, l_29_11)
		end
		for l_29_10,l_29_11 in l_29_3 do
			if l_29_0._properties.position.z < i_1:position().z and i_1:position().z < l_29_0._properties.position.z + l_29_0._properties.height then
				table.insert(l_29_2, l_29_11)
			end
		end
		return l_29_2
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
end

CoreAreaGroupSphere.check_shape = function(l_30_0, l_30_1)
	local l_30_2, l_30_3 = l_30_0:_check, l_30_0
	local l_30_4 = l_30_1
	return l_30_2(l_30_3, l_30_4)
end

CoreAreaGroupSphere.draw = function(l_31_0, l_31_1, l_31_2)
	local l_31_3 = -20000
	local l_31_4 = 40000
	local l_31_5 = l_31_0._properties.position
	if l_31_0._properties.height ~= 0 or l_31_5.z ~= 0 then
		l_31_4 = l_31_0._properties.height
		l_31_3 = 0
	end
	l_31_1:set_color(l_31_2)
	l_31_1:cylinder(l_31_5 + Vector3(0, 0, l_31_3), l_31_5 + Vector3(0, 0, l_31_4 + l_31_3), l_31_0._properties.radious)
	Application:draw_cylinder(l_31_5 + Vector3(0, 0, l_31_3), l_31_5 + Vector3(0, 0, l_31_4 + l_31_3), l_31_0._properties.radious, l_31_2.red, l_31_2.green, l_31_2.blue)
end

if not CoreAreaGroupBox then
	CoreAreaGroupBox = class()
end
CoreAreaGroupBox.init = function(l_32_0, l_32_1, l_32_2)
	if l_32_2 then
		l_32_0._properties = l_32_2
	else
		l_32_0._properties = {}
		l_32_0._properties.position = math.string_to_vector(l_32_1:parameter("position")) + managers.world:offset()
		l_32_0._properties.width = tonumber(l_32_1:parameter("width"))
		l_32_0._properties.length = tonumber(l_32_1:parameter("length"))
		l_32_0._properties.height = tonumber(l_32_1:parameter("height"))
	end
	l_32_0._check = l_32_0.check_2d
	if l_32_0._properties.height ~= 0 then
		l_32_0._check = l_32_0.check_3d
	end
end

CoreAreaGroupBox.check_2d = function(l_33_0, l_33_1)
	local l_33_10, l_33_11, l_33_12, l_33_13, l_33_14, l_33_15, l_33_16, l_33_17, l_33_18, l_33_19, l_33_20, l_33_21, l_33_22, l_33_23, l_33_24, l_33_25, l_33_26, l_33_27, l_33_28, l_33_29 = nil
	local l_33_2 = {}
	local l_33_3 = l_33_0._properties.position
	local l_33_4 = l_33_0._properties.width
	local l_33_5 = l_33_0._properties.length
	local l_33_6 = l_33_0._properties.height
	for i_0,i_1 in ipairs(l_33_1) do
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_33_4 < 0 and i_1:position().x < l_33_3.x and l_33_3.x + l_33_4 < i_1:position().x then
			do return end
		end
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if (l_33_3.x >= i_1:position().x or i_1:position().x >= l_33_3.x + l_33_4 or l_33_5 < 0) and i_1:position().y < l_33_3.y and l_33_3.y + l_33_5 < i_1:position().y then
			do return end
		end
		end
		if l_33_3.y >= i_1:position().y or i_1:position().y >= l_33_3.y + l_33_5 or 0 + 1 + 1 + 1 + 1 == 2 then
			table.insert(l_33_2, i_1)
		end
	end
	return l_33_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAreaGroupBox.check_3d = function(l_34_0, l_34_1)
	local l_34_10, l_34_11, l_34_12, l_34_13, l_34_14, l_34_15, l_34_16, l_34_17, l_34_18, l_34_19, l_34_20, l_34_21, l_34_22, l_34_23, l_34_24, l_34_25, l_34_26, l_34_27, l_34_28, l_34_29, l_34_30, l_34_31, l_34_32, l_34_33, l_34_34, l_34_35, l_34_36, l_34_37 = nil
	local l_34_2 = {}
	local l_34_3 = l_34_0._properties.position
	local l_34_4 = l_34_0._properties.width
	local l_34_5 = l_34_0._properties.length
	local l_34_6 = l_34_0._properties.height
	for i_0,i_1 in ipairs(l_34_1) do
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_34_4 < 0 and i_1:position().x < l_34_3.x and l_34_3.x + l_34_4 < i_1:position().x then
			do return end
		end
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if (l_34_3.x >= i_1:position().x or i_1:position().x >= l_34_3.x + l_34_4 or l_34_5 < 0) and i_1:position().y < l_34_3.y and l_34_3.y + l_34_5 < i_1:position().y then
			do return end
		end
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if (l_34_3.y >= i_1:position().y or i_1:position().y >= l_34_3.y + l_34_5 or l_34_6 < 0) and i_1:position().z < l_34_3.z and l_34_3.z + l_34_6 < i_1:position().z then
			do return end
		end
		end
		if l_34_3.z >= i_1:position().z or i_1:position().z >= l_34_3.z + l_34_6 or 0 + 1 + 1 + 1 + 1 + 1 + 1 == 3 then
			table.insert(l_34_2, i_1)
		end
	end
	return l_34_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAreaGroupBox.check_shape = function(l_35_0, l_35_1)
	local l_35_2, l_35_3 = l_35_0:_check, l_35_0
	local l_35_4 = l_35_1
	return l_35_2(l_35_3, l_35_4)
end

CoreAreaGroupBox.draw = function(l_36_0, l_36_1, l_36_2)
	local l_36_3 = -20000
	local l_36_4 = 40000
	local l_36_5 = l_36_0._properties.position
	if l_36_0._properties.height ~= 0 or l_36_5.z ~= 0 then
		l_36_4 = l_36_0._properties.height
		l_36_3 = 0
	end
	l_36_1:set_color(l_36_2)
	local l_36_6 = l_36_5 + Vector3(0, 0, l_36_3)
	local l_36_7 = (l_36_6 + (l_36_6 + Vector3(l_36_0._properties.width, l_36_0._properties.length, l_36_4))) / 2
	l_36_1:box(l_36_7, Vector3(l_36_0._properties.width / 2, 0, 0), Vector3(0, l_36_0._properties.length / 2, 0), Vector3(0, 0, l_36_4 / 2))
	Application:draw_box(l_36_5 + Vector3(0, 0, l_36_3), l_36_5 + Vector3(l_36_0._properties.width, l_36_0._properties.length, l_36_4 + l_36_3), l_36_2.red, l_36_2.green, l_36_2.blue)
end

if not CoreAreaGroupPlane then
	CoreAreaGroupPlane = class()
end
CoreAreaGroupPlane.init = function(l_37_0, l_37_1, l_37_2)
	if l_37_2 then
		l_37_0._properties = l_37_2
	else
		l_37_0._properties = {}
		l_37_0._properties.position = math.string_to_vector(l_37_1:parameter("position")) + managers.world:offset()
		l_37_0._properties.rotation = math.string_to_rotation(l_37_1:parameter("rotation"))
		l_37_0._properties.width = tonumber(l_37_1:parameter("width"))
		l_37_0._properties.height = tonumber(l_37_1:parameter("height"))
	end
	l_37_0._check = l_37_0.check_2d
	if l_37_0._properties.height ~= 0 then
		l_37_0._check = l_37_0.check_3d
	end
	l_37_0._padding = 1000
	l_37_0._last_units_in_area = {}
end

CoreAreaGroupPlane.check_2d = function(l_38_0, l_38_1)
	local l_38_7, l_38_8, l_38_9, l_38_10, l_38_11, l_38_12, l_38_13, l_38_14, l_38_19, l_38_20, l_38_21, l_38_22, l_38_23, l_38_24, l_38_25, l_38_26 = nil
	local l_38_2 = {}
	local l_38_3 = l_38_0._properties.rotation
	for i_0,i_1 in ipairs(l_38_0._last_units_in_area) do
		if alive(i_1) then
			local l_38_17 = i_1:position()
			if l_38_3:y():dot(i_1:position() - l_38_0._properties.position) > 0 then
				table.insert(l_38_2, l_38_16)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			local l_38_18 = nil
		if l_38_3:x():dot(i_1:position() - l_38_0._properties.position) <= 0 or l_38_3:x():dot(i_1:position() - l_38_0._properties.position) >= l_38_0._properties.width or l_38_3:y():dot(i_1:position() - l_38_0._properties.position) < -l_38_0._padding then
			end
			table.insert(l_38_2, l_38_16)
		end
	end
	for i_0,i_1 in ipairs(l_38_1) do
		if not table.contains(l_38_2, i_1) then
			local l_38_29 = i_1:position()
		if -l_38_0._padding < l_38_3:y():dot(i_1:position() - l_38_0._properties.position) then
			end
		if l_38_3:y():dot(i_1:position() - l_38_0._properties.position) < l_38_0._padding and l_38_3:y():dot(i_1:position() - l_38_0._properties.position) > 0 then
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_38_30 = nil
		if l_38_3:x():dot(i_1:position() - l_38_0._properties.position) > 0 then
			end
		if l_38_3:x():dot(i_1:position() - l_38_0._properties.position) < l_38_0._properties.width then
			end
			table.insert(l_38_2, l_38_28)
		end
	end
	l_38_0._last_units_in_area = l_38_2
	return l_38_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAreaGroupPlane.check_3d = function(l_39_0, l_39_1)
	local l_39_7, l_39_8, l_39_9, l_39_10, l_39_11, l_39_12, l_39_13, l_39_14, l_39_20, l_39_21, l_39_22, l_39_23, l_39_24, l_39_25, l_39_26, l_39_27 = nil
	local l_39_2 = {}
	local l_39_3 = l_39_0._properties.rotation
	for i_0,i_1 in ipairs(l_39_0._last_units_in_area) do
		if alive(i_1) then
			local l_39_17 = i_1:position()
			if l_39_3:y():dot(i_1:position() - l_39_0._properties.position) > 0 then
				table.insert(l_39_2, l_39_16)
			end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		else
			local l_39_18 = nil
			if l_39_3:x():dot(i_1:position() - l_39_0._properties.position) <= 0 or l_39_3:x():dot(i_1:position() - l_39_0._properties.position) >= l_39_0._properties.width or l_39_3:y():dot(i_1:position() - l_39_0._properties.position) < -l_39_0._padding then
				table.insert(l_39_2, l_39_16)
			end
		else
			local l_39_19 = nil
		if l_39_3:z():dot(l_39_18) <= 0 or l_39_3:z():dot(l_39_18) >= l_39_0._properties.height then
			end
			table.insert(l_39_2, l_39_16)
		end
	end
	for i_0,i_1 in ipairs(l_39_1) do
		if not table.contains(l_39_2, i_1) then
			local l_39_30 = i_1:position()
		if -l_39_0._padding < l_39_3:y():dot(i_1:position() - l_39_0._properties.position) then
			end
		if l_39_3:y():dot(i_1:position() - l_39_0._properties.position) < l_39_0._padding and l_39_3:y():dot(i_1:position() - l_39_0._properties.position) > 0 then
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_39_31 = nil
		if l_39_3:x():dot(i_1:position() - l_39_0._properties.position) > 0 then
			end
		if l_39_3:x():dot(i_1:position() - l_39_0._properties.position) < l_39_0._properties.width then
			end
			local l_39_32 = nil
		if l_39_3:z():dot(l_39_31) > 0 then
			end
		if l_39_3:z():dot(l_39_31) < l_39_0._properties.height then
			end
			table.insert(l_39_2, l_39_29)
		end
	end
	l_39_0._last_units_in_area = l_39_2
	return l_39_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreAreaGroupPlane.check_shape = function(l_40_0, l_40_1)
	local l_40_2, l_40_3 = l_40_0:_check, l_40_0
	local l_40_4 = l_40_1
	return l_40_2(l_40_3, l_40_4)
end

CoreAreaGroupPlane.draw = function(l_41_0, l_41_1, l_41_2)
	local l_41_3 = -20000
	local l_41_4 = 40000
	local l_41_5 = l_41_0._properties.position
	local l_41_6 = l_41_0._properties.rotation
	if l_41_0._properties.height ~= 0 or l_41_5.z ~= 0 then
		l_41_4 = l_41_0._properties.height
		l_41_3 = 0
	end
	l_41_1:set_color(l_41_2)
	local l_41_7 = l_41_5 + Vector3(0, 0, l_41_3)
	local l_41_8 = l_41_0._properties.width
	local l_41_9 = l_41_5 + Vector3(0, 0, l_41_3)
	local l_41_10 = l_41_5 + l_41_0._properties.rotation:x() * l_41_8 + Vector3(0, 0, l_41_3)
	local l_41_11 = l_41_5 + l_41_0._properties.rotation:x() * l_41_8 + Vector3(0, 0, l_41_4 + l_41_3)
	local l_41_12 = l_41_5 + Vector3(0, 0, l_41_4 + l_41_3)
	l_41_1:quad(l_41_9, l_41_10, l_41_11, l_41_12)
	Application:draw_rotation(l_41_5, l_41_0._properties.rotation)
	Application:draw_line(l_41_9, l_41_10, l_41_2.red, l_41_2.green, l_41_2.blue)
	Application:draw_line(l_41_10, l_41_11, l_41_2.red, l_41_2.green, l_41_2.blue)
	Application:draw_line(l_41_11, l_41_12, l_41_2.red, l_41_2.green, l_41_2.blue)
	Application:draw_line(l_41_12, l_41_9, l_41_2.red, l_41_2.green, l_41_2.blue)
	local l_41_13 = math.clamp(l_41_4 / 20, 250, 10000)
	for l_41_17 = l_41_3, l_41_4 + l_41_3, l_41_13 do
		local l_41_18 = l_41_5 + Vector3(0, 0, l_41_17)
		Application:draw_line(l_41_18, l_41_18 + l_41_0._properties.rotation:y() * 500, 0, 1, 0)
		Application:draw_line(l_41_18 + l_41_0._properties.rotation:x() * l_41_8, l_41_18 + l_41_0._properties.rotation:x() * l_41_8 + l_41_0._properties.rotation:y() * 500, 0, 1, 0)
		Application:draw_line(l_41_18 + l_41_0._properties.rotation:x() * l_41_8 / 2, l_41_18 + l_41_0._properties.rotation:x() * l_41_8 / 2 + l_41_0._properties.rotation:y() * 500, 0, 1, 0)
		Application:draw_line(l_41_18, l_41_18 + l_41_0._properties.rotation:y() * -500, 1, 0, 0)
		Application:draw_line(l_41_18 + l_41_0._properties.rotation:x() * l_41_8, l_41_18 + l_41_0._properties.rotation:x() * l_41_8 + l_41_0._properties.rotation:y() * -500, 1, 0, 0)
		Application:draw_line(l_41_18 + l_41_0._properties.rotation:x() * l_41_8 / 2, l_41_18 + l_41_0._properties.rotation:x() * l_41_8 / 2 + l_41_0._properties.rotation:y() * -500, 1, 0, 0)
	end
end


