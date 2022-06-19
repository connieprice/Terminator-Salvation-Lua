if not FindTargetObject then
	FindTargetObject = class()
end
FindTargetObject.init = function(l_1_0, l_1_1)
	local l_1_2 = l_1_1:ai_data()
	l_1_0._ai_data = l_1_2
	l_1_0._unit = l_1_1
	IntelUtilities.ai_update_eyes(l_1_1)
	l_1_0:_setup_eyes()
	l_1_0._world_slot_mask = managers.slot:get_mask("visibility_blockers")
	l_1_0._enemy_slot_mask = managers.slot:get_mask(l_1_2.input.enemy_slot_mask)
	l_1_0._unit_visibility_query = l_1_1:visibility_query()
	l_1_0._hit_callback = callback(l_1_0, l_1_0, "hit_callback")
	l_1_0._passed_callback = callback(l_1_0, l_1_0, "passed_callback")
	l_1_0:reset_query()
end

local l_0_0 = false
FindTargetObject.start_query = function(l_2_0, l_2_1)
	-- upvalues: l_0_0
	local l_2_12, l_2_13, l_2_14, l_2_15, l_2_16, l_2_17, l_2_18, l_2_19, l_2_23, l_2_24, l_2_25, l_2_26, l_2_27, l_2_28, l_2_29, l_2_30, l_2_31, l_2_32, l_2_33, l_2_34, l_2_35, l_2_36, l_2_37, l_2_38, l_2_40, l_2_41, l_2_42, l_2_43, l_2_44, l_2_45 = nil
	l_2_0:reset_query()
	l_2_0:_setup_eyes()
	local l_2_2 = (World:find_units_quick("sphere", l_2_1, l_2_0._max_range, l_2_0._enemy_slot_mask))
	local l_2_3, l_2_4, l_2_5, l_2_6, l_2_7 = nil, nil, nil, nil, nil
	local l_2_8 = math.UP
	for i_0,i_1 in pairs(l_2_2) do
		l_2_4 = i_1:visibility_query()
		if not l_2_4 or l_2_4:visible_from_position(l_2_1) then
			l_2_3 = i_1:position()
		if not l_2_0._unit_visibility_query or l_2_0._unit_visibility_query:visible_from_position(l_2_3) then
			end
			l_2_5 = i_1:targeting_info()
			for i_0,i_1 in pairs(l_2_0._unit_eyes) do
				if #l_2_0._unit_eyes == 1 or mvector3.distance(l_2_3, i_1.position) < i_1.range then
					l_2_6 = l_2_3 - i_1.position
					l_2_7 = l_2_6:to_polar_with_reference(i_1.forward, l_2_8)
				if math.abs(l_2_7.spin) < i_1.half_fov then
					end
					if math.abs(l_2_7.pitch) < i_1.half_zfov then
						if l_2_5 then
							l_2_3 = l_2_5:primary_target_position()
						else
							l_2_3 = l_2_21:oobb():center()
						end
						if l_0_0 then
							l_2_0._ray_targets[World:issue_raycast(l_2_0._hit_callback, "ray", i_1.position, l_2_3, "passed", l_2_0._passed_callback, "slot_mask", l_2_0._world_slot_mask, "ignore_unit", l_2_0._unit)] = l_2_21
							l_2_0._waiting_for_ray_casts = l_2_0._waiting_for_ray_casts + 1
						end
					else
						l_2_0._ray_targets[1] = l_2_21
						l_2_0._waiting_for_ray_casts = 1
						local l_2_46 = nil
						l_2_0._hit_callback(1, World:raycast("ray", i_1.position, l_2_3, "slot_mask", l_2_0._world_slot_mask))
					end
			end
		end
	end
	if Global.category_debug_render["ai.eyes"] then
		IntelUtilities._debug_render_unit_eyes(unit, unit_eyes)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

FindTargetObject.is_query_done = function(l_3_0)
	return l_3_0._waiting_for_ray_casts == 0
end

FindTargetObject.reset_query = function(l_4_0)
	l_4_0._targets = {}
	l_4_0._ray_targets = {}
	l_4_0._waiting_for_ray_casts = 0
end

FindTargetObject.get_result = function(l_5_0)
	return l_5_0._targets
end

FindTargetObject.hit_callback = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._waiting_for_ray_casts == 0 then
		return 
	end
	l_6_0._waiting_for_ray_casts = l_6_0._waiting_for_ray_casts - 1
	if not l_6_2 then
		local l_6_3 = l_6_0._ray_targets[l_6_1]
		assert(l_6_3)
	if alive(l_6_3) then
		end
		local l_6_4 = l_6_3:key()
		l_6_0._targets[l_6_4] = l_6_3
	end
end

FindTargetObject.passed_callback = function(l_7_0, l_7_1, l_7_2)
end

FindTargetObject._setup_eyes = function(l_8_0)
	local l_8_4, l_8_5, l_8_6, l_8_7, l_8_8, l_8_9 = nil
	assert(l_8_0._ai_data.current_unit_eyes)
	if l_8_0._unit_eyes ~= l_8_0._ai_data.current_unit_eyes then
		l_8_0._unit_eyes = l_8_0._ai_data.current_unit_eyes
		for i_0,i_1 in pairs(l_8_0._unit_eyes) do
			if not l_8_0._max_range or l_8_0._max_range < i_1.range then
				l_8_0._max_range = i_1.range
			end
		end
	end
end


