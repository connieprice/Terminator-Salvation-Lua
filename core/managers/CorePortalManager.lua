if not CorePortalManager then
	CorePortalManager = class()
end
CorePortalManager.EFFECT_MANAGER = World:effect_manager()
CorePortalManager.init = function(l_1_0)
	l_1_0._portal_shapes = {}
	l_1_0._all_units = {}
	l_1_0._all_effects = {}
	l_1_0._unit_groups = {}
	l_1_0._deactivate_funtion = callback(l_1_0, l_1_0, "unit_deactivated")
end

CorePortalManager.clear = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in ipairs(l_2_0._portal_shapes) do
		i_1:show_all()
	end
	l_2_0._portal_shapes = {}
	l_2_0._all_units = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CorePortalManager.add_portal = function(l_3_0, l_3_1, l_3_2, l_3_3)
	cat_print("portal", "add_portal", #l_3_1)
	if #l_3_1 > 0 then
		table.insert(l_3_0._portal_shapes, CorePortalShape:new(l_3_1, l_3_2, l_3_3))
	end
end

CorePortalManager.add_unit = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8, l_4_13, l_4_14, l_4_15, l_4_16 = nil
	if l_4_1:unit_data().ignore_portal then
		return 
	end
	for i_0,i_1 in ipairs(l_4_0._portal_shapes) do
		if i_1:add_unit(l_4_1) then
			local l_4_11 = nil
			local l_4_12 = nil
			l_4_0._all_units[l_4_1:key()] = (l_4_0._all_units[l_4_1:key()] or 0) + l_4_12
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_4_0:change_visibility(l_4_1, l_4_10:is_inside() or (l_4_1:unit_data().portal_visible_inverse and 1) or -1, l_4_1:unit_data().portal_visible_inverse)
		end
	end
	for i_0,i_1 in pairs(l_4_0._unit_groups) do
		i_1:add_unit(l_4_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CorePortalManager.remove_dynamic_unit = function(l_5_0, l_5_1)
	l_5_0:remove_unit(l_5_1)
	if not l_5_1:body(l_5_1:orientation_object()) then
		local l_5_2, l_5_3, l_5_4, l_5_5, l_5_6, l_5_7 = l_5_1:body(0)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if alive(l_5_2) then
		l_5_2:set_activate_tag("dynamic_portal")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_5_2:set_deactivate_tag("dynamic_portal")
	end
	l_5_1:add_body_activation_callback(l_5_0._deactivate_funtion)
end

CorePortalManager.unit_deactivated = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	if not l_6_4 then
		cat_print("portal", "should add unit here", l_6_1, l_6_2, l_6_3, l_6_4)
		l_6_0:add_unit(l_6_2)
		l_6_2:remove_body_activation_callback(l_6_0._deactivate_funtion)
	end
end

CorePortalManager.remove_unit = function(l_7_0, l_7_1)
	local l_7_5 = cat_print
	local l_7_6 = "portal"
	l_7_5(l_7_6, "remove_unit", l_7_1, l_7_1:visible())
	l_7_5 = l_7_0._all_units
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_5[l_7_6] = nil
	l_7_5 = ipairs
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_5 = l_7_5(l_7_6)
	for i_0,i_1 in l_7_5 do
		l_7_4:remove_unit(l_7_1)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_1:set_visible(true)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CorePortalManager.change_visibility = function(l_8_0, l_8_1, l_8_2, l_8_3)
	local l_8_4 = l_8_0._all_units
	local l_8_5 = l_8_1:key()
	l_8_4[l_8_5] = l_8_0._all_units[l_8_1:key()] + l_8_2
	l_8_4 = l_8_0._all_units
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_8_4 = l_8_4[l_8_5]
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_8_4 == 0 then
		l_8_4 = l_8_1:set_visible
		l_8_4(l_8_5, l_8_3 == false)
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_8_4 = l_8_1:visible
		l_8_4 = l_8_4(l_8_5)
		l_8_4 = not l_8_4
		 -- DECOMPILER ERROR: Overwrote pending register.

	if l_8_4 ~= l_8_3 then
		end
		l_8_4 = l_8_1:set_visible
		l_8_4(l_8_5, l_8_3 == true)
	end
end

CorePortalManager.add_effect = function(l_9_0, l_9_1)
	local l_9_5, l_9_6, l_9_7, l_9_8 = nil
	l_9_1.id = l_9_0.EFFECT_MANAGER:spawn(l_9_1)
	l_9_0._all_effects[l_9_1] = 0
	for i_0,i_1 in ipairs(l_9_0._portal_shapes) do
		if i_1:add_effect(l_9_1) then
			l_9_0._all_effects[l_9_1] = l_9_0._all_effects[l_9_1] + i_1
		end
	end
end

CorePortalManager.change_effect_visibility = function(l_10_0, l_10_1, l_10_2)
	l_10_0._all_effects[l_10_1] = l_10_0._all_effects[l_10_1] + l_10_2
	if l_10_0._all_effects[l_10_1] == 0 then
		l_10_1.hidden = true
		l_10_0.EFFECT_MANAGER:set_frozen(l_10_1.id, true)
		l_10_0.EFFECT_MANAGER:set_hidden(l_10_1.id, true)
	elseif l_10_1.hidden then
		l_10_1.hidden = false
		l_10_0.EFFECT_MANAGER:set_frozen(l_10_1.id, false)
		l_10_0.EFFECT_MANAGER:set_hidden(l_10_1.id, false)
	end
end

CorePortalManager.restart_effects = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7, l_11_9, l_11_10, l_11_11, l_11_13, l_11_14 = nil
	for i_0,i_1 in ipairs(l_11_0._portal_shapes) do
		i_1:clear_effects()
	end
	for i_0,i_1 in pairs(clone(l_11_0._all_effects)) do
		if i_0.id then
			l_11_0.EFFECT_MANAGER:kill(i_0.id)
		end
		l_11_0:add_effect(i_0)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- WARNING: undefined locals caused missing assignments!
end

CorePortalManager.render = function(l_12_0)
	local l_12_4, l_12_5, l_12_6, l_12_7 = nil
	for i_0,i_1 in ipairs(l_12_0._portal_shapes) do
		i_1:update(TimerManager:wall():time(), TimerManager:wall():delta_time())
	end
end

CorePortalManager.debug_draw_border = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_4 = 500
	local l_13_5 = 10
	do
		local l_13_6 = l_13_1:to_table()
		for l_13_10 = 2, #l_13_6 do
			while 1 do
				local l_13_11 = 0
				while l_13_11 < l_13_5 do
					if l_13_2 and l_13_3 then
						local l_13_12 = Vector3(l_13_6[l_13_10 - 1].x, l_13_6[l_13_10 - 1].y, l_13_3)
						local l_13_13 = Vector3(l_13_6[l_13_10].x, l_13_6[l_13_10].y, l_13_3)
						local l_13_14 = Vector3(l_13_6[l_13_10 - 1].x, l_13_6[l_13_10 - 1].y, l_13_2)
						Application:draw_line(l_13_12, l_13_13, 1, 0, 0)
						Application:draw_line(l_13_12, l_13_14, 0, 1, 0)
					else
						local l_13_15 = Vector3(l_13_6[l_13_10 - 1].x, l_13_6[l_13_10 - 1].y, l_13_4 * l_13_11)
						local l_13_16 = Vector3(l_13_6[l_13_10].x, l_13_6[l_13_10].y, l_13_4 * l_13_11)
						local l_13_17 = Vector3(l_13_6[l_13_10 - 1].x, l_13_6[l_13_10 - 1].y, l_13_4 * (l_13_11 + 1))
						Application:draw_line(l_13_15, l_13_16, 1, 0, 0)
						Application:draw_line(l_13_15, l_13_17, 0, 1, 0)
					end
					l_13_11 = l_13_11 + 1
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CorePortalManager.unit_groups = function(l_14_0)
	return l_14_0._unit_groups
end

CorePortalManager.unit_group_on_shape = function(l_15_0, l_15_1)
	local l_15_5, l_15_6, l_15_7, l_15_8 = nil
	for i_0,i_1 in pairs(l_15_0._unit_groups) do
		for i_0,i_1 in ipairs(i_1:shapes()) do
			if i_1 == l_15_1 then
				return l_15_13
			end
		end
	end
end

CorePortalManager.unit_group = function(l_16_0, l_16_1)
	return l_16_0._unit_groups[l_16_1]
end

CorePortalManager.add_unit_group = function(l_17_0, l_17_1)
	local l_17_2 = CorePortalUnitGroup:new(l_17_1)
	l_17_0._unit_groups[l_17_1] = l_17_2
	return l_17_2
end

CorePortalManager.remove_unit_group = function(l_18_0, l_18_1)
	l_18_0._unit_groups[l_18_1] = nil
end

CorePortalManager.clear_unit_groups = function(l_19_0)
	l_19_0._unit_groups = {}
end

CorePortalManager.group_name = function(l_20_0)
	local l_20_1 = "group"
	do
		while 1 do
			local l_20_2 = 1
			while l_20_0._unit_groups[l_20_1 .. l_20_2] do
				l_20_2 = l_20_2 + 1
			end
			return l_20_1 .. l_20_2
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

CorePortalManager.save = function(l_21_0, l_21_1)
	local l_21_7, l_21_8, l_21_9, l_21_10, l_21_11 = nil
	local l_21_3 = l_21_1 or ""
	for i_0,i_1 in pairs(l_21_0._unit_groups) do
		local l_21_4 = ""
		l_21_4 = l_21_4 .. l_21_3 .. "\t<unit_group name=\"" .. i_0 .. "\">\n"
		for i_0,i_1 in ipairs(i_1:shapes()) do
			l_21_4 = l_21_4 .. i_1:save(l_21_3 .. "\t\t") .. "\n"
		end
		l_21_4 = l_21_4 .. l_21_3 .. "\t</unit_group>\n"
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	return l_21_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CorePortalManager.save_level_data = function(l_22_0)
	local l_22_5, l_22_6, l_22_7, l_22_8 = nil
	local l_22_1 = {}
	for i_0,i_1 in pairs(l_22_0._unit_groups) do
		local l_22_14 = {}
		for i_0,i_1 in ipairs(i_1:shapes()) do
			table.insert(l_22_14, i_1:save_level_data())
		end
		l_22_1[l_22_9] = l_22_14
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	return l_22_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not CorePortalShape then
	CorePortalShape = class()
end
CorePortalShape.init = function(l_23_0, l_23_1, l_23_2, l_23_3)
	l_23_0._polygon = ScriptPolygon2D(l_23_1)
	l_23_0._units = {}
	l_23_0._inverse_units = {}
	l_23_0._effects = {}
	l_23_0._is_inside = true
	l_23_0._min = l_23_2
	l_23_0._max = l_23_3
end

CorePortalShape.add_unit = function(l_24_0, l_24_1)
	if l_24_0:inside(l_24_1:position()) then
		l_24_0._units[l_24_1:key()] = l_24_1
		local l_24_2 = l_24_1:unit_data().portal_visible_inverse
		if l_24_2 then
			l_24_1:set_visible(false)
		end
		return true, l_24_2 and -1 or 1, l_24_0
	end
end

CorePortalShape.remove_unit = function(l_25_0, l_25_1)
	l_25_0._units[l_25_1:key()] = nil
end

CorePortalShape.add_effect = function(l_26_0, l_26_1)
	if l_26_0:inside(l_26_1.position) then
		table.insert(l_26_0._effects, l_26_1)
		return true, 1
	end
end

CorePortalShape.clear_effects = function(l_27_0)
	l_27_0._effects = {}
end

CorePortalShape.show_all = function(l_28_0)
	local l_28_4, l_28_5, l_28_6, l_28_7, l_28_8, l_28_9 = nil
	for i_0,i_1 in pairs(l_28_0._units) do
		if alive(i_1) then
			i_1:set_visible(true)
		end
	end
end

CorePortalShape.inside = function(l_29_0, l_29_1)
	local l_29_2 = l_29_0._polygon:inside(l_29_1)
	if l_29_2 and l_29_0._min and l_29_0._max then
		local l_29_3 = l_29_1.z
		if l_29_0._min < l_29_3 and l_29_3 < l_29_0._max then
			return true
		end
	else
		return false
	end
	return l_29_2
end

CorePortalShape.is_inside = function(l_30_0)
	return l_30_0._is_inside
end

CorePortalShape.update = function(l_31_0, l_31_1, l_31_2)
	local l_31_3 = false
	local l_31_7, l_31_8 = ipairs, managers.viewport:active_viewports()
	l_31_7 = l_31_7(l_31_8)
	for i_0,i_1 in l_31_7 do
		do
			local l_31_9 = l_31_6:camera()
			if alive(l_31_9) and l_31_6:is_rendering_scene("World") then
				l_31_3 = l_31_0:inside(l_31_9:position())
		else
			if l_31_3 then
				end
			end
			if l_31_0._is_inside ~= l_31_3 then
				l_31_0._is_inside = l_31_3
				for i_0,i_1 in pairs(l_31_0._units) do
					l_31_0:_change_visibility(i_1)
				end
				for i_0,i_1 in ipairs(l_31_0._effects) do
					do
						local l_31_10, l_31_11 = l_31_0._is_inside and 1 or -1
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					managers.portal:change_effect_visibility(i_1, l_31_10)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 29 
end

CorePortalShape._change_visibility = function(l_32_0, l_32_1)
	if alive(l_32_1) then
		local l_32_2 = l_32_1:unit_data().portal_visible_inverse
		do
			local l_32_3, l_32_4 = l_32_0._is_inside ~= l_32_2 and 1 or -1
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		managers.portal:change_visibility(l_32_1, l_32_3, l_32_2)
	end
end

if not CorePortalUnitGroup then
	CorePortalUnitGroup = class()
end
CorePortalUnitGroup.init = function(l_33_0, l_33_1)
	l_33_0._name = l_33_1
	l_33_0._shapes = {}
	l_33_0._r = 0.5 + math.rand(0.5)
	l_33_0._g = 0.5 + math.rand(0.5)
	l_33_0._b = 0.5 + math.rand(0.5)
	l_33_0._units = {}
end

CorePortalUnitGroup.name = function(l_34_0)
	return l_34_0._name
end

CorePortalUnitGroup.shapes = function(l_35_0)
	return l_35_0._shapes
end

CorePortalUnitGroup.add_shape = function(l_36_0, l_36_1)
	local l_36_2 = CorePortalUnitGroupShape:new(l_36_1)
	table.insert(l_36_0._shapes, l_36_2)
	return l_36_2
end

CorePortalUnitGroup.remove_shape = function(l_37_0, l_37_1)
	table.delete(l_37_0._shapes, l_37_1)
end

CorePortalUnitGroup.add_unit = function(l_38_0, l_38_1)
	local l_38_5, l_38_6, l_38_7, l_38_8 = nil
	for i_0,i_1 in ipairs(l_38_0._shapes) do
		if i_1:is_inside(l_38_1:position()) then
			table.insert(l_38_0._units, l_38_1)
		end
	end
end

CorePortalUnitGroup.lock_units = function(l_39_0)
	for i_0,i_1 in ipairs(l_39_0._units) do
	end
end

CorePortalUnitGroup.draw = function(l_40_0, l_40_1, l_40_2, l_40_3)
	local l_40_10, l_40_11, l_40_12, l_40_13 = nil
	local l_40_4 = l_40_0._r * l_40_3
	local l_40_5 = l_40_0._g * l_40_3
	local l_40_6 = l_40_0._b * l_40_3
	for i_0,i_1 in ipairs(l_40_0._shapes) do
		i_1:draw(l_40_1, l_40_2, l_40_4, l_40_5, l_40_6)
	end
end

if not CorePortalUnitGroupShape then
	CorePortalUnitGroupShape = class(CoreShapeBox)
end
CorePortalUnitGroupShape.init = function(l_41_0, l_41_1)
	l_41_1.type = "box"
	CoreShapeBox.init(l_41_0, l_41_1)
end

CorePortalUnitGroupShape.draw = function(l_42_0, l_42_1, l_42_2, l_42_3, l_42_4, l_42_5)
	CoreShapeBox.draw(l_42_0, l_42_1, l_42_2, l_42_3, l_42_4, l_42_5)
	if alive(l_42_0._unit) then
		Application:draw(l_42_0._unit, l_42_3, l_42_4, l_42_5)
	end
end


