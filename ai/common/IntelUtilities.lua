if not IntelUtilities then
	IntelUtilities = class()
end
IntelUtilities.find_targets = function(l_1_0, l_1_1, l_1_2)
	local l_1_8, l_1_9, l_1_10, l_1_11, l_1_12, l_1_13 = nil
	local l_1_3 = {}
	if not l_1_1 then
		return l_1_3
	end
	local l_1_4 = nil
	for i_0,i_1 in pairs(l_1_1) do
		if i_1.position and (not l_1_4 or l_1_4 < i_1.range) then
			l_1_4 = i_1.range
		end
	end
	if not l_1_4 then
		return l_1_3
	end
	local l_1_25, l_1_26, l_1_30, l_1_31 = "sphere", l_1_0:position(), l_1_4, managers.slot:get_mask(l_1_2)
	local l_1_14, l_1_15, l_1_16, l_1_17, l_1_18 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_19 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_1_17 then
		local l_1_20 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_1_21 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		for l_1_21,i_1 in l_1_18 do
			local l_1_23, l_1_24 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if (not l_1_25 or l_1_23) and (not l_1_15 or l_1_23) then
				for i_0,i_1 in l_1_23 do
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					if (#l_1_1 == 1 or mvector3.distance(nil, l_1_29.position) < l_1_29.range) and math.abs(l_1_31.spin) < l_1_29.half_fov and math.abs(l_1_31.pitch) < l_1_29.half_zfov then
						if l_1_26 then
							do return end
						end
						 -- DECOMPILER ERROR: Overwrote pending register.

					if not World:raycast("ray", l_1_29.position, l_1_26:primary_target_position(), "slot_mask", IntelUtilities.world_slot_mask) then
						end
						 -- DECOMPILER ERROR: Overwrote pending register.

						l_1_3[l_1_17] = l_1_22
					end
			else
				end
			end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_1_18.category_debug_render["ai.eyes"] then
			IntelUtilities._debug_render_unit_eyes(l_1_19, l_1_1)
		end
		return l_1_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 50 
end

IntelUtilities.ai_update_eyes = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8 = nil
	local l_2_1 = l_2_0:ai_data().current_unit_eyes
	if not l_2_1 then
		return 
	end
	for i_0,i_1 in pairs(l_2_1) do
		IntelUtilities.set_eye_info(l_2_0, i_1)
	end
end

IntelUtilities.ai_update_weapons = function(l_3_0)
	local l_3_5, l_3_6, l_3_7, l_3_8 = nil
	local l_3_1 = l_3_0:ai_data().UNIT_WEAPONS
	if not l_3_1 then
		return 
	end
	for i_0,i_1 in pairs(l_3_1) do
		i_1.position = l_3_0:get_object(i_1.name):position()
	end
end

IntelUtilities.ai_is_target_visible = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = nil
	if not l_4_0:ai_data().current_unit_eyes then
		return false
	end
	if l_4_2 then
		l_4_3 = l_4_2 - l_4_0:position()
	end
	local l_4_4 = nil
	local l_4_5 = IntelUtilities.is_target_visible
	local l_4_6 = l_4_0
	local l_4_7 = l_4_4
	local l_4_8 = l_4_1
	local l_4_9 = nil
	return l_4_5(l_4_6, l_4_7, l_4_8, l_4_9, l_4_3)
end

IntelUtilities.is_target_visible = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4)
	local l_5_11, l_5_12, l_5_13, l_5_14, l_5_15, l_5_16, l_5_17, l_5_18, l_5_19, l_5_20, l_5_21, l_5_22, l_5_23, l_5_24 = nil
	if not l_5_3 then
		local l_5_6 = l_5_2:oobb():center()
		local l_5_7 = (managers.slot:get_mask("visibility_blockers"))
		for i_0,i_1 in pairs(l_5_1) do
			local l_5_8 = nil
			assert(i_1, "must have an eye")
			if i_1.position then
				l_5_8 = i_1.position
				if l_5_4 then
					l_5_8 = l_5_8 + l_5_4
				end
			if mvector3.distance(l_5_6, l_5_8) < i_1.range then
				end
				local l_5_28 = IntelUtilities._is_target_in_range_visible
				local l_5_29 = l_5_0
				local l_5_30 = l_5_8
				local l_5_31 = l_5_27
				return l_5_28(l_5_29, l_5_30, l_5_31, l_5_2, l_5_6, l_5_7)
			end
		end
		return false
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 7 
end

IntelUtilities.within_eye_fov = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = l_6_1.forward:with_z(0)
	local l_6_4 = l_6_2 - l_6_1.position:with_z(0)
	local l_6_5 = l_6_4:angle(l_6_3)
	return math.abs(l_6_5) <= l_6_1.half_fov
end

IntelUtilities._is_target_in_range_visible = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5)
	local l_7_6 = l_7_4 - l_7_1
	local l_7_7 = l_7_6:to_polar_with_reference(l_7_2.forward, math.UP)
	if l_7_2.half_fov < math.abs(l_7_7.spin) or l_7_2.half_zfov < math.abs(l_7_7.pitch) then
		return false
	end
	if l_7_3 then
		local l_7_8 = IntelUtilities._target_line_of_sight
		local l_7_9 = l_7_0
		local l_7_10 = l_7_1
		local l_7_11 = l_7_3
		local l_7_12, l_7_17 = l_7_5
		return l_7_8(l_7_9, l_7_10, l_7_11, l_7_12)
	end
	local l_7_13 = IntelUtilities._position_line_of_sight
	local l_7_14 = l_7_1
	local l_7_15 = enemy_position
	local l_7_16 = l_7_5
	return l_7_13(l_7_14, l_7_15, l_7_16)
end

IntelUtilities.set_eye_info = function(l_8_0, l_8_1)
	assert(l_8_1.name, "Orientation object must have a name")
	if not l_8_1.object then
		l_8_1.object = l_8_0:get_object(l_8_1.name)
	end
	assert(l_8_1.object, "orientation object " .. l_8_1.name .. " not found")
	local l_8_2 = IntelUtilities.orientation_object_info(l_8_1.object, l_8_1.forward_axis)
	l_8_1.forward = l_8_1.object
	l_8_1.position = l_8_2
end

IntelUtilities.orientation_object_info = function(l_9_0, l_9_1)
	local l_9_2 = (l_9_0:position())
	local l_9_3 = nil
	if not l_9_1 or l_9_1 == "y" then
		l_9_3 = l_9_0:rotation():y()
	elseif l_9_1 == "x" then
		l_9_3 = l_9_0:rotation():x()
	elseif l_9_1 == "z" then
		l_9_3 = l_9_0:rotation():z()
	else
		assert(true, "Invalid axis specified")
	end
	return l_9_2, l_9_3
end

IntelUtilities.ai_have_target_line_of_fire = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = (l_10_0:ai_data())
	local l_10_4 = nil
	if l_10_2 then
		l_10_4 = l_10_2 - l_10_0:position()
	end
	local l_10_5 = IntelUtilities.have_line_of_fire
	local l_10_6 = l_10_0
	local l_10_7 = l_10_3.WEAPONS_RANGE
	local l_10_8 = l_10_3.UNIT_WEAPONS
	local l_10_9 = l_10_1
	local l_10_10 = nil
	local l_10_11 = l_10_4
	local l_10_12 = l_10_3.LINE_OF_FIRE_SLOT_MASK
	local l_10_13 = l_10_3.FRIENDLY_UNITS_SLOT_MASK
	return l_10_5(l_10_6, l_10_7, l_10_8, l_10_9, l_10_10, l_10_11, l_10_12, l_10_13)
end

IntelUtilities.ai_have_position_line_of_fire = function(l_11_0, l_11_1, l_11_2, l_11_3)
	local l_11_4 = (l_11_0:ai_data())
	local l_11_5 = nil
	if l_11_2 then
		l_11_5 = l_11_2 - l_11_0:position()
	end
	local l_11_6, l_11_7 = IntelUtilities.have_line_of_fire(l_11_0, l_11_4.WEAPONS_RANGE, l_11_4.UNIT_WEAPONS, nil, l_11_1, l_11_5, l_11_4.LINE_OF_FIRE_SLOT_MASK, l_11_4.FRIENDLY_UNITS_SLOT_MASK)
	do
		return l_11_6 or not l_11_3 or not l_11_7 or mvector3.distance(l_11_7, l_11_1) < l_11_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

IntelUtilities.have_line_of_fire = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4, l_12_5, l_12_6, l_12_7)
	local l_12_16, l_12_17, l_12_18, l_12_19, l_12_20, l_12_21, l_12_23, l_12_24 = nil
	if not l_12_4 then
		local l_12_9 = l_12_3:position()
		local l_12_10 = managers.slot:get_mask(l_12_6)
		assert(l_12_10)
		assert(managers.slot:get_mask(l_12_7))
		if l_12_5 then
			local l_12_11, l_12_12 = , l_12_0:position() + l_12_5
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_12_1 < mvector3.distance(l_12_9, l_12_12) then
			return false, nil
		end
		for i_0,i_1 in ipairs(l_12_2) do
			local l_12_13, l_12_14 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

			end
			if i_1.enabled and i_1.position then
				if l_12_5 then
					local l_12_26, l_12_27 = nil
					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

					if l_12_3 then
						do return end
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					 -- DECOMPILER ERROR: Overwrote pending register.

					 -- DECOMPILER ERROR: Overwrote pending register.

				if nil and not IntelUtilities._friendly_fire(l_12_0, l_12_2, i_1, l_12_3, nil, l_12_5, l_12_13) then
					end
					 -- DECOMPILER ERROR: Confused about usage of registers!

					return true, nil
				end
				for i_0,i_1 in l_12_15 do
					 -- DECOMPILER ERROR: Confused about usage of registers!

					return false, nil
				end
				return false, nil
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 5 49 
end

IntelUtilities.ai_friendly_fire = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_4 = (l_13_0:ai_data())
	local l_13_5 = nil
	if l_13_3 then
		l_13_5 = l_13_3 - l_13_0:position()
	end
	local l_13_6 = managers.slot:get_mask(l_13_4.FRIENDLY_UNITS_SLOT_MASK)
	local l_13_7 = IntelUtilities._friendly_fire
	local l_13_8 = l_13_0
	local l_13_9 = l_13_4.UNIT_WEAPONS
	local l_13_10 = nil
	local l_13_11 = l_13_2
	local l_13_12 = l_13_1
	local l_13_13 = l_13_5
	local l_13_14 = l_13_6
	return l_13_7(l_13_8, l_13_9, l_13_10, l_13_11, l_13_12, l_13_13, l_13_14)
end

IntelUtilities._friendly_fire = function(l_14_0, l_14_1, l_14_2, l_14_3, l_14_4, l_14_5, l_14_6)
	local l_14_10, l_14_11, l_14_12, l_14_13, l_14_14, l_14_15, l_14_17, l_14_18 = nil
	for i_0,i_1 in ipairs(l_14_1) do
		end
		if i_1 ~= l_14_2 then
			if l_14_5 then
				local l_14_20 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_14_3 then
					do return end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

			if nil then
				end
				return true
			end
		end
		return false
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 11 
end

IntelUtilities._target_line_of_sight = function(l_15_0, l_15_1, l_15_2, l_15_3)
	if l_15_2:visibility_query() and not l_15_2:visibility_query():visible_from_position(l_15_1) then
		return false, nil
	end
	local l_15_4 = (l_15_2:targeting_info())
	local l_15_5 = nil
	if l_15_4 then
		l_15_5 = l_15_4:primary_target_position()
	else
		l_15_5 = l_15_2:oobb():center()
	end
	local l_15_6 = IntelUtilities._position_line_of_sight
	local l_15_7 = l_15_1
	local l_15_8 = l_15_5
	local l_15_9 = l_15_3
	return l_15_6(l_15_7, l_15_8, l_15_9)
end

IntelUtilities._position_line_of_sight = function(l_16_0, l_16_1, l_16_2)
	local l_16_3 = World:raycast("ray", l_16_0, l_16_1, "slot_mask", l_16_2)
	if not l_16_3 then
		return true, l_16_1
	end
	return false, l_16_3.position
end

IntelUtilities._debug_render_unit_eyes = function(l_17_0, l_17_1)
	local l_17_6, l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_13, l_17_14, l_17_15, l_17_16, l_17_17, l_17_18, l_17_19, l_17_20, l_17_21, l_17_22, l_17_23, l_17_24, l_17_25, l_17_26, l_17_27, l_17_28, l_17_29, l_17_30, l_17_31 = nil
	local l_17_2 = Draw:brush()
	l_17_2:set_persistance(0.25)
	for i_0,i_1 in pairs(l_17_1) do
		l_17_2:set_color(Color(0.5, 1, 0, 0))
		l_17_2:sphere(eye_position, 100)
		if i_1.half_fov < 90 and i_1.half_zfov < 90 then
			local l_17_34 = i_1.position + i_1.forward * i_1.range
			local l_17_35 = i_1.range * math.tan(i_1.half_fov)
			local l_17_36 = nil
			local l_17_37 = nil
			local l_17_38 = l_17_34 + math.cross(math.UP, l_17_33.forward) * l_17_35 + math.UP * (l_17_33.range * math.tan(l_17_33.half_zfov))
			local l_17_39 = l_17_34 + math.cross(math.UP, l_17_33.forward) * l_17_35 - math.UP * l_17_36
			l_17_2:pyramid(l_17_33.position, l_17_38, l_17_39, l_17_34 - l_17_37 * l_17_35 - math.UP * l_17_36, l_17_34 - l_17_37 * l_17_35 + math.UP * l_17_36)
			l_17_2:set_color(Color(0.5, 1, 1, 0))
			l_17_2:quad(l_17_38, l_17_39, l_17_33.position, l_17_33.position)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_17_2:quad(l_17_34 - l_17_37 * l_17_35 + math.UP * l_17_36, l_17_34 - l_17_37 * l_17_35 - math.UP * l_17_36, l_17_33.position, l_17_33.position)
			l_17_2:sphere(l_17_38, 200)
			l_17_2:sphere(l_17_39, 200)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_17_2:sphere(l_17_34 - l_17_37 * l_17_35 + math.UP * l_17_36, 200)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_17_2:sphere(l_17_34 - l_17_37 * l_17_35 - math.UP * l_17_36, 200)
		end
	end
end


