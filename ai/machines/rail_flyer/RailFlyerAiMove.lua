if not RailFlyerAiMove then
	RailFlyerAiMove = class()
end
RailFlyerAiMove.init_data = function(l_1_0, l_1_1)
	l_1_1._move = {}
	l_1_1._move.fire_locked = true
	l_1_1._move.behavior_locked = true
	l_1_1._move.looking_locked = true
	l_1_1._move.allowed_to_fire = false
	l_1_1._move.latest_approach_time = 0
	l_1_1.default_waypoint_pause_time = 0
	l_1_1._move.target_from_behind = true
	l_1_1.arrived_radius = tweak_data.rail.flyer.ARRIVED_RADIUS
	l_1_1._move.path_info = {}
	l_1_1._move.path_info.path = nil
	l_1_1._move.normalized_speed_factor = 1000
	if l_1_1.input.target_range == nil then
		l_1_1.input.target_range = tweak_data.rail.flyer.DEFAULT_TARGET_RANGE
	end
	l_1_1.input.collision_slotmask = managers.slot:get_mask("rail_vehicles")
end

RailFlyerAiMove.logic_rail_flyer_move_init = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	return 0
end

RailFlyerAiMove.logic_rail_flyer_move_start = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	local l_3_8 = l_3_2:ai_data()
	if l_3_8:new_path_requested() then
		l_3_0:_find_path(l_3_2, l_3_8)
	end
	if l_3_8._move.path ~= nil then
		l_3_0:_set_path(l_3_2, l_3_8)
		l_3_8._move.path = nil
	end
	if l_3_8._behavior.target ~= nil and alive(l_3_8._behavior.target) then
		if l_3_8.input.moving_to_position ~= nil and tweak_data.rail.flyer.LOST_DISTANCE < mvector3.distance(l_3_8.input.moving_to_position, l_3_8._behavior.target:position()) then
			l_3_0:_set_path(l_3_2, l_3_8)
		end
		l_3_8.output.move_speed = l_3_0:_get_pursuit_speed(l_3_2, l_3_8._behavior.target, l_3_8)
	end
	return nil
end

RailFlyerAiMove._flyer_is_behind_target_vehicle = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = l_4_2 - l_4_1
	local l_4_5 = mvector3.dot(l_4_3, l_4_4)
	return l_4_5 >= 0
end

RailFlyerAiMove._waypoint_is_behind_target_vehicle = function(l_5_0, l_5_1, l_5_2, l_5_3)
	if l_5_1.input.moving_to_position ~= nil then
		local l_5_4 = l_5_3
		local l_5_5 = l_5_2 - l_5_1.input.moving_to_position
		local l_5_6 = mvector3.dot(l_5_4, l_5_5)
		return l_5_6 >= 0
	else
		return true
	end
end

RailFlyerAiMove._allowed_to_fire = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = mvector3.distance(l_6_2, l_6_3)
	l_6_1.output.firing_target_position = l_6_1._behavior.target:position()
	l_6_1.output.firing_target = l_6_1._behavior.target
	local l_6_5 = l_6_1._move
	l_6_5.allowed_to_fire = l_6_4 < l_6_1.input.target_range + tweak_data.rail.flyer.RANGE_SPREAD
end

RailFlyerAiMove._get_pursuit_speed = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_4, l_7_5, l_7_6, l_7_7, l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13 = nil, nil, nil, nil, nil, nil, nil, nil, nil, nil
	l_7_4 = l_7_1:position()
	l_7_5 = l_7_2:position()
	l_7_6 = mvector3.distance(l_7_5:with_z(0), l_7_4:with_z(0))
	l_7_7 = l_7_2:rotation():y()
	l_7_8 = l_7_2:base():get_speed_vector()
	l_7_9 = mvector3.dot(l_7_7, l_7_8)
	if l_7_3._move.target_from_behind then
		if l_7_3.input.target_range < l_7_6 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	elseif not l_7_0:_flyer_is_behind_target_vehicle(l_7_4, l_7_5, l_7_7) then
		if l_7_3.input.target_range < l_7_6 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		if l_7_3.input.moving_to_position ~= nil then
			l_7_3._combat.target_from_here = l_7_5 - l_7_3.input.target_range * l_7_7
			 -- DECOMPILER ERROR: Confused about usage of registers!

			mvector3.set_z(l_7_3._combat.target_from_here, mvector3.z(l_7_3.input.moving_to_position))
		end
		l_7_13 = math.clamp(l_7_12, tweak_data.rail.flyer.MIN_SPEED, tweak_data.rail.flyer.MAX_SPEED) / l_7_3._move.normalized_speed_factor
		l_7_0:_allowed_to_fire(l_7_3, l_7_4, l_7_5)
		return l_7_13
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 100 
end

RailFlyerAiMove._find_and_set_closest_waypoint = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_1:ai_data()
	l_8_0:_set_path(l_8_2, l_8_3)
end

RailFlyerAiMove._get_closest_waypoint = function(l_9_0, l_9_1, l_9_2)
	local l_9_3, l_9_9, l_9_10, l_9_16, l_9_17 = nil
	if l_9_1:ai_data():path() ~= nil then
		local l_9_4, l_9_5 = , nil
		for l_9_13,l_9_14 in pairs(l_9_4) do
			local l_9_6 = nil
			local l_9_19 = mvector3.distance
			local l_9_20 = l_9_2
			l_9_19 = l_9_19(l_9_20, l_9_4[1])
			local l_9_18 = nil
			l_9_6 = l_9_19
			if not l_9_5 or l_9_6 < l_9_5 then
				l_9_6 = l_9_5
				l_9_3 = l_9_15
			end
		end
	end
	if not l_9_3 then
		local l_9_11, l_9_12 = , l_9_1:position
		return l_9_12(l_9_1)
	end
	return l_9_3
end

RailFlyerAiMove._find_path = function(l_10_0, l_10_1, l_10_2)
	if l_10_2._move._closest_track == false then
		local l_10_3 = 50000
		local l_10_4 = 1
		local l_10_5 = nil
		local l_10_6 = l_10_1:position()
		local l_10_11, l_10_12 = World:find_units_quick, World
		l_10_11 = l_10_11(l_10_12, "all", World:make_slot_mask(43))
		local l_10_7 = nil
		l_10_12 = pairs
		l_10_7 = l_10_11
		l_10_12 = l_10_12(l_10_7)
		for i_0,i_1 in l_10_12 do
			if l_10_10:name() == "rail_path" then
				local l_10_13, l_10_14, l_10_15 = l_10_10:path():get_closest_point(l_10_6)
			if l_10_15 < l_10_3 then
				end
				l_10_3 = l_10_15
				l_10_4 = l_10_14
				l_10_2._move.path_info.path = l_10_10
			end
		end
		l_10_0:_set_path(l_10_1, l_10_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_10_2.default_waypoints = nil
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

RailFlyerAiMove._set_path = function(l_11_0, l_11_1, l_11_2)
	local l_11_3 = l_11_2._move.path_info.path
	if l_11_3 then
		l_11_3:path():add_user(l_11_1)
		local l_11_4, l_11_5, l_11_6 = l_11_3:path():get_closest_point(l_11_1:position())
		local l_11_7 = l_11_3:path():get(l_11_5, l_11_2._move.displacement)
		local l_11_8 = l_11_3:path():get2(l_11_3:path(), l_11_5, l_11_2._move.displacement)
	if l_11_7 then
		end
	if #l_11_7 > 0 then
		end
		l_11_2:set_new_path(nil, false)
		l_11_2:set_waypoints(l_11_7)
		l_11_2:set_new_path(l_11_8, false)
		l_11_2._move.path_info.path = l_11_3
	end
end


