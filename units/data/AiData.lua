if not AiData then
	AiData = class()
end
AiData.init = function(l_1_0)
	l_1_0.brain = nil
	l_1_0.brain_infos = nil
	l_1_0.stay_on_ground = true
	l_1_0.group_name = nil
	l_1_0.input = {}
	l_1_0.input.brain = nil
	l_1_0.input.is_dead = false
	l_1_0.input.is_down = false
	l_1_0.input.collision_slotmask = nil
	l_1_0.input.moving_to_position = nil
	l_1_0.input.passed_last_waypoint = false
	l_1_0.input.buffered_events = {}
	l_1_0.input.buffered_damages = {}
	l_1_0.output = {}
	l_1_0.output.look_at_position = nil
	l_1_0.output.currently_targeted_threat = nil
	l_1_0.external = {}
	l_1_0.human_player_priority_target = true
	l_1_0.max_slope_angle = 30
	l_1_0._latest_target_position = nil
	l_1_0._path = nil
	l_1_0._path_out_counter = 0
	l_1_0._path_in_counter = 0
	l_1_0._path_completed_counter = -1
	l_1_0._loop_path = false
	l_1_0._waypoints = nil
	l_1_0._min_target_weight = 0
	l_1_0._max_target_weight = 1
	local l_1_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0.AGGRESIVE_MOVE_TIMERS, l_1_1 = l_1_1, {0, 0}
	l_1_0.HIDE_TIMERS, l_1_1 = l_1_1, {0, 0}
end

AiData.set_new_path = function(l_2_0, l_2_1, l_2_2)
	if l_2_1 == l_2_0._path then
		return 
	end
	l_2_0._path = l_2_1
	l_2_0._loop_path = l_2_2
	l_2_0._path_out_counter = l_2_0._path_in_counter + 1
end

AiData.path = function(l_3_0)
	return l_3_0._path
end

AiData.request_new_path = function(l_4_0)
	l_4_0._path_in_counter = l_4_0._path_out_counter + 1
end

AiData.accept_new_path = function(l_5_0)
	l_5_0._path_in_counter = l_5_0._path_out_counter
end

AiData.abort_new_path_request = function(l_6_0)
	l_6_0._path_in_counter = l_6_0._path_out_counter
end

AiData.new_path_requested = function(l_7_0)
	return l_7_0._path_out_counter < l_7_0._path_in_counter
end

AiData.new_path_received = function(l_8_0)
	return l_8_0._path_in_counter < l_8_0._path_out_counter
end

AiData.set_current_path_completed = function(l_9_0)
	l_9_0._path_completed_counter = l_9_0._path_out_counter
end

AiData.current_path_completed = function(l_10_0)
	return l_10_0._path_completed_counter == l_10_0._path_out_counter
end

AiData.set_waypoints = function(l_11_0, l_11_1)
	local l_11_5, l_11_6, l_11_7, l_11_8 = nil
	if not l_11_1 then
		l_11_0._waypoints = nil
		return 
	end
	l_11_0._waypoints = {}
	for i_0,i_1 in ipairs(l_11_1) do
		local l_11_11 = table.insert
		l_11_11(l_11_0._waypoints, {position_xy = l_11_10.position:with_z(0), rotation = l_11_10.rotation, options = l_11_10.options, id = l_11_10.id})
	end
end

AiData.is_waypoint = function(l_12_0, l_12_1)
	local l_12_2 = l_12_0:waypoint(l_12_1)
	return l_12_2 ~= nil
end

AiData.waypoint = function(l_13_0, l_13_1)
	local l_13_7, l_13_8, l_13_9, l_13_10 = nil
	local l_13_2 = 1
	if not l_13_0._waypoints then
		return 
	end
	local l_13_3 = l_13_1:with_z(0)
	for i_0,i_1 in pairs(l_13_0._waypoints) do
		if i_1.position_xy - l_13_3:length() < l_13_2 then
			return i_1
		end
	end
end

AiData.clear_output = function(l_14_0)
	l_14_0.output.look_at_position = nil
end

AiData.debug_draw_path = function(l_15_0)
	if not l_15_0._path then
		return 
	end
	local l_15_1 = Draw:brush()
	local l_15_2 = Draw:brush()
	local l_15_7, l_15_8 = l_15_2:set_color, l_15_2
	l_15_7(l_15_8, Color(1, 0, 0))
	l_15_7 = nil
	local l_15_3 = nil
	l_15_8 = ipairs
	l_15_3 = l_15_0._path
	l_15_8 = l_15_8(l_15_3)
	for i_0,i_1 in l_15_8 do
		if l_15_0:is_waypoint(l_15_6) then
			l_15_2:sphere(l_15_6, 50)
		else
			l_15_1:sphere(l_15_6, 50)
		end
		if l_15_7 then
			l_15_1:line(l_15_7, l_15_6)
		end
		l_15_7 = l_15_6
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiData.update_stuck_time = function(l_16_0, l_16_1, l_16_2)
	if l_16_2 then
		if not l_16_0.stuck_time then
			l_16_0.stuck_time = 0
		else
			l_16_0.stuck_time = l_16_0.stuck_time + l_16_1
		end
	else
		l_16_0.stuck_time = nil
	end
end

AiData.set_weapon_range_to_rail = function(l_17_0, l_17_1)
	l_17_1.WEAPONS_RANGE = 10000
end

AiData.set_default_enemy_slot_mask_to_enemies = function(l_18_0, l_18_1)
	l_18_1.input.enemy_slot_mask = "enemies"
end


