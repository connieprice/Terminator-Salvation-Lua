require("units/beings/AiNerveSystem")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
local l_0_0 = function(l_1_0)
	local l_1_1 = alive
	local l_1_2 = l_1_0.external.paralyzed_by_unit
	return l_1_1(l_1_2)
end

local l_0_1 = function(l_2_0)
	if l_2_0.cover then
		return l_2_0.cover_point
	end
end

if not PlayerAiNerveSystem then
	PlayerAiNerveSystem = class(AiNerveSystem)
end
PlayerAiNerveSystem.init = function(l_3_0, l_3_1)
	AiNerveSystem.init(l_3_0, l_3_1)
	l_3_0._look_at_rotation = Rotation()
	l_3_0._look_at_distance = 100000
	l_3_0._unit = l_3_1
	l_3_0._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_3_0.low_frequency_update, "player_nervesystem"))
	l_3_0._aim_target_position = nil
	l_3_0._want_to_peek = false
	l_3_0._player_movement_utilities = PlayerMovementUtilities:new()
end

PlayerAiNerveSystem._update_movement_blocked_max_time = function(l_4_0)
	local l_4_1 = tweak_data.ai.humans.ai_player.MOVEMENT_BLOCKED_TIME_NORMAL
	local l_4_2 = tweak_data.ai.humans.ai_player.MOVEMENT_BLOCKED_TIME_THREATENED
	local l_4_3 = {}
	l_4_3.normal = math.random(l_4_1.rand_min, l_4_1.rand_max)
	l_4_3.threatened = math.random(l_4_2.rand_min, l_4_2.rand_max)
	l_4_0._movement_blocked_max_time = l_4_3
end

PlayerAiNerveSystem.destroy = function(l_5_0)
	managers.ai.cover_manager:release_cover(l_5_0._unit)
	l_5_0._low_frequency:remove()
	AiNerveSystem.destroy(l_5_0)
end

PlayerAiNerveSystem.warp_to = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = l_6_0._ai_data._behavior.arrive_orders
	AiNerveSystem.warp_to(l_6_0, l_6_1, l_6_2)
	local l_6_4 = l_6_2 + 10000 * l_6_1:y()
	if l_6_0:is_enabled() then
		local l_6_5 = l_6_0._unit:input()
		l_6_5:set_aim_target_position(l_6_4)
		l_6_5:set_eye_target_position(l_6_4)
	end
	l_6_0._next_update_eye_target = l_6_4
	l_6_0._aim_target_position = l_6_4
	l_6_0._ai_data._behavior.arrive_orders = l_6_3
end

PlayerAiNerveSystem.reset = function(l_7_0)
	AiNerveSystem.reset(l_7_0)
	l_7_0:_reset_input()
end

PlayerAiNerveSystem._reset_input = function(l_8_0)
	if l_8_0:is_enabled() then
		local l_8_1 = l_8_0._unit:input()
		l_8_1:clear()
		local l_8_2 = l_8_0._unit:position() + 10000 * l_8_0._unit:rotation():y()
		l_8_1:set_aim_target_position(l_8_2)
		l_8_1:set_eye_target_position(l_8_2)
	end
end

PlayerAiNerveSystem.update = function(l_9_0, l_9_1, l_9_2, l_9_3)
	local l_9_4 = l_9_0._ai_data.input
	local l_9_5 = l_9_1:player_data()
	if not l_9_5.entering_wounded and not l_9_5.wounded then
		l_9_4.is_down = l_9_5.exiting_wounded
	end
	l_9_4.exiting_wounded = l_9_5.exiting_wounded
	if not AiNerveSystem.update(l_9_0, l_9_1, l_9_2, l_9_3) then
		l_9_0:_reset_input(l_9_1:input())
		if l_9_0:_is_dead() then
			managers.ai.cover_manager:release_cover(l_9_0._unit)
		end
		return 
	end
	l_9_0:update_radius(l_9_5, l_9_0._ai_data)
	l_9_0._low_frequency:update(l_9_0, l_9_3, l_9_1, l_9_2)
	local l_9_6 = l_9_0:_calculate_look_at_position(l_9_1, l_9_0._unit_position, l_9_3, l_9_0._aim_target_position)
	local l_9_7 = l_9_1:input()
	if l_9_0._aim_target_position then
		l_9_7:set_aim_target_position(l_9_0._aim_target_position)
	else
		l_9_7:set_aim_target_position(l_9_6)
	end
	l_9_7:set_eye_target_position(l_9_6)
end

PlayerAiNerveSystem.low_frequency_update = function(l_10_0, l_10_1, l_10_2, l_10_3)
	-- upvalues: l_0_0
	local l_10_4 = l_10_0._ai_data.input
	local l_10_5 = l_10_2:player_data()
	local l_10_6 = l_10_0._ai_data.output
	local l_10_7, l_10_8 = nil, nil
	AiNerveSystem.low_frequency_update(l_10_0, l_10_2, l_10_3, l_10_1)
	if l_10_0._move_to_position and not l_10_0._movement_blocked then
		local l_10_9 = l_10_0._unit_position
		local l_10_10 = mvector3.distance(l_10_0._move_to_position, l_10_9)
		local l_10_11 = (l_10_0._ai_data:path())
		local l_10_12, l_10_13 = nil, nil
		if l_10_10 < tweak_data.ai.SLOW_DOWN_DISTANCE and l_10_0._current_path_index and l_10_0._current_path_index + 1 <= #l_10_11 then
			l_10_12 = l_10_11[l_10_0._current_path_index + 1]
			l_10_13 = l_10_10 / tweak_data.ai.SLOW_DOWN_DISTANCE
		else
			l_10_12 = l_10_0._move_to_position
			l_10_13 = tweak_data.ai.SLOW_DOWN_SPEED_CHANGE
		end
		local l_10_14 = l_10_12 - l_10_0._unit_position
		local l_10_15 = l_10_0._unit:rotation():y()
		local l_10_16 = (l_10_15:angle(l_10_14))
		local l_10_17 = nil
		if l_10_0._waypoint_options and l_10_0._waypoint_options.speed and l_10_0._ai_data.SPEEDS then
			l_10_17 = l_10_0._ai_data.SPEEDS[l_10_0._waypoint_options.speed]
			assert(l_10_17)
		else
			l_10_17 = l_10_6.move_speed
		end
		if tweak_data.ai.SLOW_DOWN_ANGLE < math.abs(l_10_16) then
			l_10_17 = l_10_17 * l_10_13
		end
		l_10_8 = l_10_17 / l_10_10 * (l_10_0._move_to_position - l_10_9)
	end
	local l_10_18 = l_10_2:input()
	l_10_18:clear()
	if l_10_8 and not l_0_0(l_10_0._ai_data) then
		l_10_18:set_movement(l_10_8)
	end
	l_10_0:_update_cover(l_10_2, l_10_5, l_10_18)
	if alive(l_10_6.firing_target) then
		local l_10_19 = l_10_6.firing_target:targeting_info()
		if l_10_19 then
			l_10_7 = l_10_19:primary_target_position()
		end
	else
		l_10_7 = l_10_6.firing_target:oobb():center()
	end
	l_10_0:_update_fire(l_10_2, l_10_5, l_10_7, l_10_18, l_10_1, l_10_3)
	if l_10_5.time_since_incoming_fire > 0.5 then
		l_10_4.time_under_incoming_fire = 0
	else
		l_10_4.time_under_incoming_fire = l_10_4.time_under_incoming_fire + l_10_1
	end
	l_10_4.time_since_incoming_fire = l_10_5.time_since_incoming_fire
	if l_10_4.entering_target_cover and l_10_0._ai_data:new_path_requested() then
		l_10_0._ai_data:abort_new_path_request()
	end
	l_10_0._aim_target_position = l_10_7
	l_10_0._animation_driven_movement = l_10_5.quick_moving
end

PlayerAiNerveSystem.update_radius = function(l_11_0, l_11_1, l_11_2)
	-- upvalues: l_0_1
	if l_0_1(l_11_1) or l_11_1.quick_moving or l_11_1.leaving_cover then
		l_11_2.radius = 0.6 * tweak_data.ai.humans.ai_player.MOVER_IN_COVER_DIAMETER
	else
		l_11_2.radius = 0.6 * tweak_data.ai.humans.ai_player.MOVER_ON_GROUND_DIAMETER
	end
end

PlayerAiNerveSystem._update_fire = function(l_12_0, l_12_1, l_12_2, l_12_3, l_12_4, l_12_5, l_12_6)
	-- upvalues: l_0_1
	local l_12_7 = l_12_0._ai_data.output
	local l_12_8 = alive(l_12_7.firing_target)
	if l_12_7.allowed_to_fire then
		if not l_12_2.is_down then
			local l_12_9 = l_12_8
		end
	else
		if (not false or not l_12_7.hide_in_cover or l_12_0._burst_end_time or not l_0_1(l_12_2) or false) and IntelUtilities.ai_friendly_fire(l_12_1, l_12_3) then
			local l_12_10, l_12_11, l_12_12, l_12_13, l_12_18 = false
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_12_0:_burst_fire(l_12_6, l_12_10, l_12_2.firing) then
			l_12_4:set_fire(1, true)
			l_12_4:set_precision_aiming()
			local l_12_14, l_12_15 = , l_12_0:_update_weapons_dispersions
			local l_12_16 = l_12_0
			local l_12_17 = l_12_1
			l_12_15 = l_12_15(l_12_16, l_12_17, {l_12_7.firing_target}, l_12_5)
			l_12_16, l_12_17 = l_12_4:set_miss_dispersion, l_12_4
			l_12_16(l_12_17, l_12_15[1])
		elseif l_12_0._burst_start_time then
			l_12_4:set_precision_aiming()
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 16 
end

PlayerAiNerveSystem._update_cover = function(l_13_0, l_13_1, l_13_2, l_13_3)
	-- upvalues: l_0_1 , l_0_0
	local l_13_4 = l_13_0._ai_data.output.target_cover_info
	if l_13_4 and not managers.cover:is_valid_cover(l_13_4:cover()) then
		l_13_4 = nil
	end
	local l_13_5 = l_0_1(l_13_2)
	if l_13_4 or l_13_5 and l_13_0._ai_data._behavior.use_covers and l_13_0._ai_data._cover.threat then
		local l_13_7, l_13_24, l_13_25, l_13_26 = not l_13_0._ai_data.input.is_down
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_13_7 then
		local l_13_8 = nil
		if l_13_5 then
			local l_13_9 = nil
			l_13_9 = l_13_2.cover_point:position()
			if l_13_4 and l_13_0._move_to_position and not l_13_0._move_to_position_waypoint and l_13_4:closest_cover_point():position() - l_13_9:length() < 1 then
				l_13_0:_set_move_to_position(nil)
				l_13_0._ai_data:set_current_path_completed()
				l_13_0._ai_data:request_new_path()
			end
			if l_13_0._move_to_position then
				if l_13_2.cover_outer_position then
					l_13_3:set_leave_cover()
				end
			else
				local l_13_10 = nil
				local l_13_11 = nil
			 -- DECOMPILER ERROR: unhandled construct in 'if'

			if l_13_2.cover_point_edge == CoverEdgeType.NOT_EDGE and l_13_2.cover_normal:dot(l_13_0._move_to_position - l_13_9:normalized()) > 0.8 then
				end
				l_13_3:set_leave_cover()
			end
			do return end
			local l_13_12 = nil
			if not l_13_2.cover_point_edge == CoverEdgeType.LEFT then
				local l_13_16 = nil
				if -l_13_2.cover_normal:cross(math.UP):dot(l_13_11) > 0 then
					l_13_3:set_leave_cover()
					 -- DECOMPILER ERROR: Confused about usage of registers!

					local l_13_17, l_13_18 = nil
				if l_13_0:_update_cover_quick_move(l_13_2, l_13_9, l_13_11, l_13_2.cover_point_edge == CoverEdgeType.LEFT) then
					end
					l_13_3:set_quick_move_info_index(l_13_0:_update_cover_quick_move(l_13_2, l_13_9, l_13_11, l_13_2.cover_point_edge == CoverEdgeType.LEFT), R19_PC130)
				end
				if l_13_2.cover_outer_position and not l_13_3:leave_cover() then
					local l_13_19 = nil
					 -- DECOMPILER ERROR: Confused about usage of registers!

				if (l_13_4 or not managers.ai.cover_manager:reserved_overlaps_human_player(l_13_0._unit)) and (not l_13_0._ai_data._cover.cover_info or managers.cover_util:can_enter_cover(l_13_0._unit, l_13_0._ai_data._cover.cover_info, tweak_data.ai.humans.ai_player.MAX_ENTER_COVER_DISTANCE, true)) then
					end
					l_13_3:set_enter_inner_cover_position()
				end
				if not l_13_2.cover_outer_position and not l_13_3:leave_cover() then
					local l_13_21 = nil
				if managers.ai.cover_manager:reserved_overlaps_human_player(l_13_0._unit) then
					end
					l_13_3:set_enter_outer_cover_position()
				end
				if not l_13_0._move_to_position and not l_13_0._ai_data.output.hide_in_cover and not l_13_3:leave_cover() then
					if not l_13_2.peeking_up and not l_13_2.peeking_side then
						l_13_0._want_to_peek = true
					end
					l_13_3:set_precision_aiming()
					 -- DECOMPILER ERROR: Confused about usage of registers!

					if not l_13_3:aim_target_position() then
						l_13_3:set_aim_target_position(l_13_21 + math.UP * 120 - 10000 * l_13_2.cover_normal)
					end
				if l_13_0._want_to_peek then
					end
				if l_13_2.peeking_up or l_13_2.peeking_side then
					end
					l_13_0._want_to_peek = false
					l_13_0:_forced_targeting_update()
				end
				if not l_13_0._move_to_position and not l_0_0(l_13_0._ai_data) and l_13_2.cover_point_edge ~= CoverEdgeType.NOT_EDGE and managers.cover_util:high_cover(l_13_2.cover) then
					if l_13_2.cover_point_edge == CoverEdgeType.LEFT and l_13_2.facing_right_in_cover then
						l_13_3:set_movement(-l_13_2.cover:right())
					end
				else
					if l_13_2.cover_point_edge == CoverEdgeType.RIGHT and not l_13_2.facing_right_in_cover then
						l_13_3:set_movement(l_13_2.cover:right())
					end
				else
					if l_13_0._ai_data:current_path_completed() then
						l_13_4:update_distance(l_13_0._unit_position)
					if managers.cover_util:can_enter_cover(l_13_0._unit, l_13_4, tweak_data.ai.humans.ai_player.MAX_ENTER_COVER_DISTANCE, true) then
						end
						local l_13_22 = nil
						l_13_3:set_enter_cover(l_13_4, managers.ai.cover_manager:overlaps_human_player(l_13_4:cover(), l_13_4:closest_cover_point():position()))
					end
				end
				local l_13_23 = nil
				 -- DECOMPILER ERROR: Confused about usage of registers!

				if not managers.ai.cover_manager:get_reserved_position(l_13_1) or managers.ai.cover_manager:get_reserved_position(l_13_1) - l_13_4:closest_cover_point():position():length() > 5 then
					managers.ai.cover_manager:reserve_cover(l_13_1, l_13_4:closest_cover_point():position(), 0.5 * tweak_data.ai.humans.ai_player.RESERVE_COVER_WIDTH)
				end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			elseif l_13_5 then
				l_13_3:set_leave_cover()
			else
				if managers.ai.cover_manager:get_reserved_position(l_13_1) then
					managers.ai.cover_manager:release_cover(l_13_1)
				end
			end
			local l_13_27 = nil
			do
				l_13_0._ai_data.input.in_target_cover = not l_13_4 or l_13_27
				l_13_0._ai_data.input.entering_target_cover = l_13_3:enter_cover()
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 113 
end

PlayerAiNerveSystem._update_cover_quick_move = function(l_14_0, l_14_1, l_14_2, l_14_3, l_14_4)
	local l_14_17, l_14_18, l_14_19, l_14_20, l_14_21, l_14_22 = nil
	local l_14_5 = l_14_1.quick_move_infos
	local l_14_6 = l_14_1.cover_point
	local l_14_7, l_14_8, l_14_9, l_14_10 = nil, nil, nil, nil
	if l_14_2 - l_14_0._move_to_position:length() < 150 then
		local l_14_11, l_14_12 = l_14_0:_next_path_position()
		if l_14_11 then
			l_14_12 = l_14_2 - l_14_11:length()
			local l_14_13 = nil
		end
	else
		l_14_11 = l_14_0._move_to_position
	end
	for i_0,i_1 in pairs(l_14_5) do
		local l_14_14, l_14_15 = nil
		if i_1:possible_from_cover_point(l_14_4, l_14_6) and not managers.ai.cover_manager:is_cover_reserved(i_1:target_cover(), i_1:target_cover_point(l_14_6):position()) and i_1:target_cover_point(l_14_6):position() - l_14_2:length() > 0 then
			local l_14_27 = nil
		if i_1:target_cover_point(l_14_6):position() - l_14_14:length() < l_14_15 and (not l_14_9 or i_1:target_cover_point(l_14_6):position() - l_14_14:length() < l_14_9) then
			end
			l_14_7 = l_14_26
			l_14_8 = l_14_25
			l_14_9 = i_1:target_cover_point(l_14_6):position() - l_14_14:length()
			l_14_10 = l_14_27
		end
	end
	if l_14_7 and l_14_0._player_movement_utilities:is_quick_move_path_free(l_14_0._unit, l_14_7, l_14_6, l_14_10) then
		return l_14_8, l_14_1.quick_move_infos_id
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

PlayerAiNerveSystem._calculate_look_at_position = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4)
	local l_15_5 = 500
	local l_15_6 = nil
	if l_15_4 then
		l_15_6 = l_15_4
	elseif l_15_0._waypoint_rotation_look_at_position then
		return l_15_0._waypoint_rotation_look_at_position
	elseif l_15_0._move_to_position then
		l_15_6 = l_15_0._move_to_position
	else
		l_15_6 = l_15_0._ai_data.output.look_at_position
	end
	if l_15_0._next_update_eye_target and l_15_6 then
		l_15_0._next_update_eye_target = nil
	else
		l_15_6 = l_15_0._next_update_eye_target
	end
	if not l_15_6 then
		l_15_6 = l_15_2 + 10000 * l_15_1:rotation():y()
	end
	local l_15_7 = mvector3.distance(l_15_6, l_15_2)
	if l_15_5 < l_15_7 then
		return l_15_6
	end
	local l_15_8 = l_15_6 - l_15_2
	l_15_8 = l_15_8 + (l_15_5 - l_15_7) * l_15_8:flat(math.UP):normalized()
	l_15_7 = l_15_5
	l_15_0._look_at_rotation = Rotation:look_at(l_15_8, math.UP)
	l_15_0._look_at_distance = l_15_7
	return l_15_2 + l_15_0._look_at_distance * l_15_0._look_at_rotation:y()
end

PlayerAiNerveSystem._burst_fire = function(l_16_0, l_16_1, l_16_2, l_16_3)
	local l_16_4 = tweak_data.ai.humans.ai_player
	l_16_0._burst_mean_time = l_16_4.BURST_LENGTH
	l_16_0._burst_standard_deviation_time = 2 * l_16_4.BURST_LENGTH
	l_16_0._burst_max_deviation_time = 0.4 * l_16_4.BURST_LENGTH
	l_16_0._burst_pause_mean_time = l_16_4.TIME_BETWEEN_BURSTS
	l_16_0._burst_pause_standard_deviation_time = 2 * l_16_4.TIME_BETWEEN_BURSTS
	l_16_0._burst_pause_max_deviation_time = 0.4 * l_16_4.TIME_BETWEEN_BURSTS
	local l_16_5 = AiNerveSystem._burst_fire
	local l_16_6 = l_16_0
	local l_16_7 = l_16_1
	local l_16_8 = l_16_2
	local l_16_9 = l_16_3
	return l_16_5(l_16_6, l_16_7, l_16_8, l_16_9)
end

PlayerAiNerveSystem._is_dead = function(l_17_0)
	if l_17_0._unit:damage_data():is_fully_damaged() then
		return not l_17_0._unit:player_data().revive_when_fully_damaged
	end
end


