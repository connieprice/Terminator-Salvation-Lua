local L0_0
L0_0 = require
L0_0("units/beings/AiNerveSystem")
L0_0 = require
L0_0("shared/updatescheduler/UpdateSchedulerDtMethod")
function L0_0(A0_1)
	return alive(A0_1.external.paralyzed_by_unit)
end
PlayerAiNerveSystem = PlayerAiNerveSystem or class(AiNerveSystem)
function PlayerAiNerveSystem.init(A0_2, A1_3)
	AiNerveSystem.init(A0_2, A1_3)
	A0_2._look_at_rotation = Rotation()
	A0_2._look_at_distance = 100000
	A0_2._unit = A1_3
	A0_2._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(A0_2.low_frequency_update, "player_nervesystem"))
	A0_2._aim_target_position = nil
	A0_2._want_to_peek = false
	A0_2._player_movement_utilities = PlayerMovementUtilities:new()
end
function PlayerAiNerveSystem._update_movement_blocked_max_time(A0_4)
	local L1_5, L2_6, L3_7
	L1_5 = tweak_data
	L1_5 = L1_5.ai
	L1_5 = L1_5.humans
	L1_5 = L1_5.ai_player
	L1_5 = L1_5.MOVEMENT_BLOCKED_TIME_NORMAL
	L2_6 = tweak_data
	L2_6 = L2_6.ai
	L2_6 = L2_6.humans
	L2_6 = L2_6.ai_player
	L2_6 = L2_6.MOVEMENT_BLOCKED_TIME_THREATENED
	L3_7 = {}
	L3_7.normal = math.random(L1_5.rand_min, L1_5.rand_max)
	L3_7.threatened = math.random(L2_6.rand_min, L2_6.rand_max)
	A0_4._movement_blocked_max_time = L3_7
end
function PlayerAiNerveSystem.destroy(A0_8)
	managers.ai.cover_manager:release_cover(A0_8._unit)
	A0_8._low_frequency:remove()
	AiNerveSystem.destroy(A0_8)
end
function PlayerAiNerveSystem.warp_to(A0_9, A1_10, A2_11)
	local L3_12, L4_13
	L3_12 = A0_9._ai_data
	L3_12 = L3_12._behavior
	L3_12 = L3_12.arrive_orders
	L4_13 = AiNerveSystem
	L4_13 = L4_13.warp_to
	L4_13(A0_9, A1_10, A2_11)
	L4_13 = A1_10.y
	L4_13 = L4_13(A1_10)
	L4_13 = 10000 * L4_13
	L4_13 = A2_11 + L4_13
	if A0_9:is_enabled() then
		A0_9._unit:input():set_aim_target_position(L4_13)
		A0_9._unit:input():set_eye_target_position(L4_13)
	end
	A0_9._next_update_eye_target = L4_13
	A0_9._aim_target_position = L4_13
	A0_9._ai_data._behavior.arrive_orders = L3_12
end
function PlayerAiNerveSystem.reset(A0_14)
	AiNerveSystem.reset(A0_14)
	A0_14:_reset_input()
end
function PlayerAiNerveSystem._reset_input(A0_15)
	local L1_16, L2_17
	L2_17 = A0_15
	L1_16 = A0_15.is_enabled
	L1_16 = L1_16(L2_17)
	if L1_16 then
		L1_16 = A0_15._unit
		L2_17 = L1_16
		L1_16 = L1_16.input
		L1_16 = L1_16(L2_17)
		L2_17 = L1_16.clear
		L2_17(L1_16)
		L2_17 = A0_15._unit
		L2_17 = L2_17.position
		L2_17 = L2_17(L2_17)
		L2_17 = L2_17 + 10000 * A0_15._unit:rotation():y()
		L1_16:set_aim_target_position(L2_17)
		L1_16:set_eye_target_position(L2_17)
	end
end
function PlayerAiNerveSystem.update(A0_18, A1_19, A2_20, A3_21)
	local L4_22, L5_23, L6_24
	L4_22 = A0_18._ai_data
	L4_22 = L4_22.input
	L6_24 = A1_19
	L5_23 = A1_19.player_data
	L5_23 = L5_23(L6_24)
	L6_24 = L5_23.entering_wounded
	if not L6_24 then
		L6_24 = L5_23.wounded
		L6_24 = L6_24 or L5_23.exiting_wounded
	end
	L4_22.is_down = L6_24
	L6_24 = L5_23.exiting_wounded
	L4_22.exiting_wounded = L6_24
	L6_24 = AiNerveSystem
	L6_24 = L6_24.update
	L6_24 = L6_24(A0_18, A1_19, A2_20, A3_21)
	if not L6_24 then
		L6_24 = A0_18._reset_input
		L6_24(A0_18, A1_19:input())
		L6_24 = A0_18._is_dead
		L6_24 = L6_24(A0_18)
		if L6_24 then
			L6_24 = managers
			L6_24 = L6_24.ai
			L6_24 = L6_24.cover_manager
			L6_24 = L6_24.release_cover
			L6_24(L6_24, A0_18._unit)
		end
		return
	end
	L6_24 = A0_18.update_radius
	L6_24(A0_18, L5_23, A0_18._ai_data)
	L6_24 = A0_18._low_frequency
	L6_24 = L6_24.update
	L6_24(L6_24, A0_18, A3_21, A1_19, A2_20)
	L6_24 = A0_18._calculate_look_at_position
	L6_24 = L6_24(A0_18, A1_19, A0_18._unit_position, A3_21, A0_18._aim_target_position)
	if A0_18._aim_target_position then
		A1_19:input():set_aim_target_position(A0_18._aim_target_position)
	else
		A1_19:input():set_aim_target_position(L6_24)
	end
	A1_19:input():set_eye_target_position(L6_24)
end
function PlayerAiNerveSystem.low_frequency_update(A0_25, A1_26, A2_27, A3_28)
	local L4_29, L5_30, L6_31, L7_32, L8_33, L9_34, L10_35, L11_36, L12_37, L13_38, L14_39, L15_40, L16_41, L17_42
	L4_29 = A0_25._ai_data
	L4_29 = L4_29.input
	L6_31 = A2_27
	L5_30 = A2_27.player_data
	L5_30 = L5_30(L6_31)
	L6_31 = A0_25._ai_data
	L6_31 = L6_31.output
	L7_32, L8_33 = nil, nil
	L9_34 = AiNerveSystem
	L9_34 = L9_34.low_frequency_update
	L10_35 = A0_25
	L11_36 = A2_27
	L12_37 = A3_28
	L13_38 = A1_26
	L9_34(L10_35, L11_36, L12_37, L13_38)
	L9_34 = A0_25._move_to_position
	if L9_34 then
		L9_34 = A0_25._movement_blocked
		if not L9_34 then
			L9_34 = A0_25._unit_position
			L10_35 = mvector3
			L10_35 = L10_35.distance
			L11_36 = A0_25._move_to_position
			L12_37 = L9_34
			L10_35 = L10_35(L11_36, L12_37)
			L11_36 = A0_25._ai_data
			L12_37 = L11_36
			L11_36 = L11_36.path
			L11_36 = L11_36(L12_37)
			L12_37, L13_38 = nil, nil
			L14_39 = tweak_data
			L14_39 = L14_39.ai
			L14_39 = L14_39.SLOW_DOWN_DISTANCE
			if L10_35 < L14_39 then
				L14_39 = A0_25._current_path_index
				if L14_39 then
					L14_39 = A0_25._current_path_index
					L14_39 = L14_39 + 1
					L15_40 = #L11_36
					if L14_39 <= L15_40 then
						L14_39 = A0_25._current_path_index
						L14_39 = L14_39 + 1
						L12_37 = L11_36[L14_39]
						L14_39 = tweak_data
						L14_39 = L14_39.ai
						L14_39 = L14_39.SLOW_DOWN_DISTANCE
						L13_38 = L10_35 / L14_39
					end
				end
			else
				L12_37 = A0_25._move_to_position
				L14_39 = tweak_data
				L14_39 = L14_39.ai
				L13_38 = L14_39.SLOW_DOWN_SPEED_CHANGE
			end
			L14_39 = A0_25._unit_position
			L14_39 = L12_37 - L14_39
			L15_40 = A0_25._unit
			L16_41 = L15_40
			L15_40 = L15_40.rotation
			L15_40 = L15_40(L16_41)
			L16_41 = L15_40
			L15_40 = L15_40.y
			L15_40 = L15_40(L16_41)
			L17_42 = L15_40
			L16_41 = L15_40.angle
			L16_41 = L16_41(L17_42, L14_39)
			L17_42 = nil
			if A0_25._waypoint_options and A0_25._waypoint_options.speed and A0_25._ai_data.SPEEDS then
				L17_42 = A0_25._ai_data.SPEEDS[A0_25._waypoint_options.speed]
				assert(L17_42)
			else
				L17_42 = L6_31.move_speed
			end
			if math.abs(L16_41) > tweak_data.ai.SLOW_DOWN_ANGLE then
				L17_42 = L17_42 * L13_38
			end
			L8_33 = L17_42 / L10_35 * (A0_25._move_to_position - L9_34)
		end
	end
	L10_35 = A2_27
	L9_34 = A2_27.input
	L9_34 = L9_34(L10_35)
	L11_36 = L9_34
	L10_35 = L9_34.clear
	L10_35(L11_36)
	if L8_33 then
		L10_35 = _UPVALUE0_
		L11_36 = A0_25._ai_data
		L10_35 = L10_35(L11_36)
		if not L10_35 then
			L11_36 = L9_34
			L10_35 = L9_34.set_movement
			L12_37 = L8_33
			L10_35(L11_36, L12_37)
		end
	end
	L11_36 = A0_25
	L10_35 = A0_25._update_cover
	L12_37 = A2_27
	L13_38 = L5_30
	L14_39 = L9_34
	L10_35(L11_36, L12_37, L13_38, L14_39)
	L10_35 = alive
	L11_36 = L6_31.firing_target
	L10_35 = L10_35(L11_36)
	if L10_35 then
		L10_35 = L6_31.firing_target
		L11_36 = L10_35
		L10_35 = L10_35.targeting_info
		L10_35 = L10_35(L11_36)
		if L10_35 then
			L12_37 = L10_35
			L11_36 = L10_35.primary_target_position
			L11_36 = L11_36(L12_37)
			L7_32 = L11_36
		else
			L11_36 = L6_31.firing_target
			L12_37 = L11_36
			L11_36 = L11_36.oobb
			L11_36 = L11_36(L12_37)
			L12_37 = L11_36
			L11_36 = L11_36.center
			L11_36 = L11_36(L12_37)
			L7_32 = L11_36
		end
	end
	L11_36 = A0_25
	L10_35 = A0_25._update_fire
	L12_37 = A2_27
	L13_38 = L5_30
	L14_39 = L7_32
	L15_40 = L9_34
	L16_41 = A1_26
	L17_42 = A3_28
	L10_35(L11_36, L12_37, L13_38, L14_39, L15_40, L16_41, L17_42)
	L10_35 = L5_30.time_since_incoming_fire
	if L10_35 > 0.5 then
		L4_29.time_under_incoming_fire = 0
	else
		L10_35 = L4_29.time_under_incoming_fire
		L10_35 = L10_35 + A1_26
		L4_29.time_under_incoming_fire = L10_35
	end
	L10_35 = L5_30.time_since_incoming_fire
	L4_29.time_since_incoming_fire = L10_35
	L10_35 = L4_29.entering_target_cover
	if L10_35 then
		L10_35 = A0_25._ai_data
		L11_36 = L10_35
		L10_35 = L10_35.new_path_requested
		L10_35 = L10_35(L11_36)
		if L10_35 then
			L10_35 = A0_25._ai_data
			L11_36 = L10_35
			L10_35 = L10_35.abort_new_path_request
			L10_35(L11_36)
		end
	end
	A0_25._aim_target_position = L7_32
	L10_35 = L5_30.quick_moving
	A0_25._animation_driven_movement = L10_35
end
function PlayerAiNerveSystem.update_radius(A0_43, A1_44, A2_45)
	if _UPVALUE0_(A1_44) or A1_44.quick_moving or A1_44.leaving_cover then
		A2_45.radius = 0.6 * tweak_data.ai.humans.ai_player.MOVER_IN_COVER_DIAMETER
	else
		A2_45.radius = 0.6 * tweak_data.ai.humans.ai_player.MOVER_ON_GROUND_DIAMETER
	end
end
function PlayerAiNerveSystem._update_fire(A0_46, A1_47, A2_48, A3_49, A4_50, A5_51, A6_52)
	local L7_53, L8_54, L9_55
	L7_53 = A0_46._ai_data
	L7_53 = L7_53.output
	L8_54 = alive
	L9_55 = L7_53.firing_target
	L8_54 = L8_54(L9_55)
	L9_55 = L7_53.allowed_to_fire
	L9_55 = L9_55 and not L9_55 and L8_54
	if L9_55 and L7_53.hide_in_cover and not A0_46._burst_end_time and _UPVALUE0_(A2_48) then
		L9_55 = false
	end
	if L9_55 and IntelUtilities.ai_friendly_fire(A1_47, A3_49) then
		L9_55 = false
	end
	if A0_46:_burst_fire(A6_52, L9_55, A2_48.firing) then
		A4_50:set_fire(1, true)
		A4_50:set_precision_aiming()
		A4_50:set_miss_dispersion(A0_46:_update_weapons_dispersions(A1_47, {
			L7_53.firing_target
		}, A5_51)[1])
	elseif A0_46._burst_start_time then
		A4_50:set_precision_aiming()
	end
end
function PlayerAiNerveSystem._update_cover(A0_56, A1_57, A2_58, A3_59)
	local L4_60, L5_61, L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L15_71
	L4_60 = A0_56._ai_data
	L4_60 = L4_60.output
	L4_60 = L4_60.target_cover_info
	if L4_60 then
		L5_61 = managers
		L5_61 = L5_61.cover
		L6_62 = L5_61
		L5_61 = L5_61.is_valid_cover
		L8_64 = L4_60
		L7_63 = L4_60.cover
		L15_71 = L7_63(L8_64)
		L5_61 = L5_61(L6_62, L7_63, L8_64, L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L15_71, L7_63(L8_64))
		if not L5_61 then
			L4_60 = nil
		end
	end
	L5_61 = _UPVALUE0_
	L6_62 = A2_58
	L5_61 = L5_61(L6_62)
	if not L4_60 then
		L6_62 = L5_61 and L6_62.use_covers
	elseif L6_62 then
		L6_62 = A0_56._ai_data
		L6_62 = L6_62.input
		L6_62 = L6_62.is_down
		L6_62 = not L6_62
	end
	if L6_62 then
		L7_63 = nil
		if L5_61 then
			L8_64 = A2_58.cover_point
			L10_66 = L8_64
			L9_65 = L8_64.position
			L9_65 = L9_65(L10_66)
			L7_63 = L9_65
			if L4_60 then
				L9_65 = A0_56._move_to_position
				if L9_65 then
					L9_65 = A0_56._move_to_position_waypoint
					if not L9_65 then
						L10_66 = L4_60
						L9_65 = L4_60.closest_cover_point
						L9_65 = L9_65(L10_66)
						L10_66 = L9_65
						L9_65 = L9_65.position
						L9_65 = L9_65(L10_66)
						L9_65 = L9_65 - L7_63
						L10_66 = L9_65
						L9_65 = L9_65.length
						L9_65 = L9_65(L10_66)
						if L9_65 < 1 then
							L10_66 = A0_56
							L9_65 = A0_56._set_move_to_position
							L11_67 = nil
							L9_65(L10_66, L11_67)
							L9_65 = A0_56._ai_data
							L10_66 = L9_65
							L9_65 = L9_65.set_current_path_completed
							L9_65(L10_66)
							L9_65 = A0_56._ai_data
							L10_66 = L9_65
							L9_65 = L9_65.request_new_path
							L9_65(L10_66)
						end
					end
				end
			end
			L9_65 = A0_56._move_to_position
			if L9_65 then
				L9_65 = A2_58.cover_outer_position
				if L9_65 then
					L10_66 = A3_59
					L9_65 = A3_59.set_leave_cover
					L9_65(L10_66)
				else
					L9_65 = A0_56._move_to_position
					L9_65 = L9_65 - L7_63
					L10_66 = L9_65
					L9_65 = L9_65.normalized
					L9_65 = L9_65(L10_66)
					L10_66 = A2_58.cover_normal
					L11_67 = L10_66
					L10_66 = L10_66.dot
					L12_68 = L9_65
					L10_66 = L10_66(L11_67, L12_68)
					L11_67 = A2_58.cover_point_edge
					L12_68 = CoverEdgeType
					L12_68 = L12_68.NOT_EDGE
					if L11_67 == L12_68 then
						if L10_66 > 0.8 then
							L12_68 = A3_59
							L11_67 = A3_59.set_leave_cover
							L11_67(L12_68)
						end
					else
						L11_67 = A2_58.cover_normal
						L12_68 = L11_67
						L11_67 = L11_67.cross
						L13_69 = math
						L13_69 = L13_69.UP
						L11_67 = L11_67(L12_68, L13_69)
						L12_68 = A2_58.cover_point_edge
						L13_69 = CoverEdgeType
						L13_69 = L13_69.LEFT
						L12_68 = L12_68 == L13_69
						if not L12_68 then
							L11_67 = -L11_67
						end
						L14_70 = L11_67
						L13_69 = L11_67.dot
						L15_71 = L9_65
						L13_69 = L13_69(L14_70, L15_71)
						if L13_69 > 0 then
							L15_71 = A3_59
							L14_70 = A3_59.set_leave_cover
							L14_70(L15_71)
							L15_71 = A0_56
							L14_70 = A0_56._update_cover_quick_move
							L15_71 = L14_70(L15_71, A2_58, L7_63, L9_65, L12_68)
							if L14_70 then
								A3_59:set_quick_move_info_index(L14_70, L15_71)
							end
						end
					end
				end
			end
			L9_65 = A2_58.cover_outer_position
			if L9_65 then
				L10_66 = A3_59
				L9_65 = A3_59.leave_cover
				L9_65 = L9_65(L10_66)
				if not L9_65 then
					L9_65 = managers
					L9_65 = L9_65.ai
					L9_65 = L9_65.cover_manager
					L10_66 = L9_65
					L9_65 = L9_65.reserved_overlaps_human_player
					L11_67 = A0_56._unit
					L9_65 = L9_65(L10_66, L11_67)
					L10_66 = L4_60 or L10_66.cover_info
					if not L9_65 then
						if L10_66 then
							L11_67 = managers
							L11_67 = L11_67.cover_util
							L12_68 = L11_67
							L11_67 = L11_67.can_enter_cover
							L13_69 = A0_56._unit
							L14_70 = L10_66
							L15_71 = tweak_data
							L15_71 = L15_71.ai
							L15_71 = L15_71.humans
							L15_71 = L15_71.ai_player
							L15_71 = L15_71.MAX_ENTER_COVER_DISTANCE
							L11_67 = L11_67(L12_68, L13_69, L14_70, L15_71, true)
						elseif L11_67 then
							L12_68 = A3_59
							L11_67 = A3_59.set_enter_inner_cover_position
							L11_67(L12_68)
						end
					end
				end
			end
			L9_65 = A2_58.cover_outer_position
			if not L9_65 then
				L10_66 = A3_59
				L9_65 = A3_59.leave_cover
				L9_65 = L9_65(L10_66)
				if not L9_65 then
					L9_65 = managers
					L9_65 = L9_65.ai
					L9_65 = L9_65.cover_manager
					L10_66 = L9_65
					L9_65 = L9_65.reserved_overlaps_human_player
					L11_67 = A0_56._unit
					L9_65 = L9_65(L10_66, L11_67)
					if L9_65 then
						L11_67 = A3_59
						L10_66 = A3_59.set_enter_outer_cover_position
						L10_66(L11_67)
					end
				end
			end
			L9_65 = A0_56._move_to_position
			if not L9_65 then
				L9_65 = A0_56._ai_data
				L9_65 = L9_65.output
				L9_65 = L9_65.hide_in_cover
				if not L9_65 then
					L10_66 = A3_59
					L9_65 = A3_59.leave_cover
					L9_65 = L9_65(L10_66)
					if not L9_65 then
						L9_65 = A2_58.peeking_up
						if not L9_65 then
							L9_65 = A2_58.peeking_side
							if not L9_65 then
								A0_56._want_to_peek = true
							end
						end
						L10_66 = A3_59
						L9_65 = A3_59.set_precision_aiming
						L9_65(L10_66)
						L10_66 = A3_59
						L9_65 = A3_59.aim_target_position
						L9_65 = L9_65(L10_66)
						if not L9_65 then
							L10_66 = A3_59
							L9_65 = A3_59.set_aim_target_position
							L11_67 = math
							L11_67 = L11_67.UP
							L11_67 = L11_67 * 120
							L11_67 = L7_63 + L11_67
							L12_68 = A2_58.cover_normal
							L12_68 = 10000 * L12_68
							L11_67 = L11_67 - L12_68
							L9_65(L10_66, L11_67)
						end
						L9_65 = A0_56._want_to_peek
						if L9_65 then
							L9_65 = A2_58.peeking_up
							if not L9_65 then
								L9_65 = A2_58.peeking_side
							elseif L9_65 then
								A0_56._want_to_peek = false
								L10_66 = A0_56
								L9_65 = A0_56._forced_targeting_update
								L9_65(L10_66)
							end
						end
					end
				end
			end
			L9_65 = A0_56._move_to_position
			if not L9_65 then
				L9_65 = _UPVALUE1_
				L10_66 = A0_56._ai_data
				L9_65 = L9_65(L10_66)
				if not L9_65 then
					L9_65 = A2_58.cover_point_edge
					L10_66 = CoverEdgeType
					L10_66 = L10_66.NOT_EDGE
					if L9_65 ~= L10_66 then
						L9_65 = managers
						L9_65 = L9_65.cover_util
						L10_66 = L9_65
						L9_65 = L9_65.high_cover
						L11_67 = A2_58.cover
						L9_65 = L9_65(L10_66, L11_67)
						if L9_65 then
							L9_65 = A2_58.cover_point_edge
							L10_66 = CoverEdgeType
							L10_66 = L10_66.LEFT
							if L9_65 == L10_66 then
								L9_65 = A2_58.facing_right_in_cover
								if L9_65 then
									L10_66 = A3_59
									L9_65 = A3_59.set_movement
									L11_67 = A2_58.cover
									L12_68 = L11_67
									L11_67 = L11_67.right
									L11_67 = L11_67(L12_68)
									L11_67 = -L11_67
									L9_65(L10_66, L11_67)
								end
							else
								L9_65 = A2_58.cover_point_edge
								L10_66 = CoverEdgeType
								L10_66 = L10_66.RIGHT
								if L9_65 == L10_66 then
									L9_65 = A2_58.facing_right_in_cover
									if not L9_65 then
										L10_66 = A3_59
										L9_65 = A3_59.set_movement
										L11_67 = A2_58.cover
										L12_68 = L11_67
										L11_67 = L11_67.right
										L15_71 = L11_67(L12_68)
										L9_65(L10_66, L11_67, L12_68, L13_69, L14_70, L15_71, L11_67(L12_68))
									end
								end
							end
						end
					end
				end
			end
		else
			L8_64 = A0_56._ai_data
			L9_65 = L8_64
			L8_64 = L8_64.current_path_completed
			L8_64 = L8_64(L9_65)
			if L8_64 then
				L9_65 = L4_60
				L8_64 = L4_60.update_distance
				L10_66 = A0_56._unit_position
				L8_64(L9_65, L10_66)
				L8_64 = managers
				L8_64 = L8_64.cover_util
				L9_65 = L8_64
				L8_64 = L8_64.can_enter_cover
				L10_66 = A0_56._unit
				L11_67 = L4_60
				L12_68 = tweak_data
				L12_68 = L12_68.ai
				L12_68 = L12_68.humans
				L12_68 = L12_68.ai_player
				L12_68 = L12_68.MAX_ENTER_COVER_DISTANCE
				L13_69 = true
				L8_64 = L8_64(L9_65, L10_66, L11_67, L12_68, L13_69)
				if L8_64 then
					L8_64 = managers
					L8_64 = L8_64.ai
					L8_64 = L8_64.cover_manager
					L9_65 = L8_64
					L8_64 = L8_64.overlaps_human_player
					L11_67 = L4_60
					L10_66 = L4_60.cover
					L10_66 = L10_66(L11_67)
					L12_68 = L4_60
					L11_67 = L4_60.closest_cover_point
					L11_67 = L11_67(L12_68)
					L12_68 = L11_67
					L11_67 = L11_67.position
					L15_71 = L11_67(L12_68)
					L8_64 = L8_64(L9_65, L10_66, L11_67, L12_68, L13_69, L14_70, L15_71, L11_67(L12_68))
					L10_66 = A3_59
					L9_65 = A3_59.set_enter_cover
					L11_67 = L4_60
					L12_68 = L8_64
					L9_65(L10_66, L11_67, L12_68)
				end
			end
			L9_65 = L4_60
			L8_64 = L4_60.closest_cover_point
			L8_64 = L8_64(L9_65)
			L9_65 = L8_64
			L8_64 = L8_64.position
			L8_64 = L8_64(L9_65)
			L7_63 = L8_64
		end
		L8_64 = managers
		L8_64 = L8_64.ai
		L8_64 = L8_64.cover_manager
		L9_65 = L8_64
		L8_64 = L8_64.get_reserved_position
		L10_66 = A1_57
		L8_64 = L8_64(L9_65, L10_66)
		if L8_64 then
			L9_65 = L8_64 - L7_63
			L10_66 = L9_65
			L9_65 = L9_65.length
			L9_65 = L9_65(L10_66)
		elseif L9_65 > 5 then
			L9_65 = managers
			L9_65 = L9_65.ai
			L9_65 = L9_65.cover_manager
			L10_66 = L9_65
			L9_65 = L9_65.reserve_cover
			L11_67 = A1_57
			L12_68 = L7_63
			L13_69 = tweak_data
			L13_69 = L13_69.ai
			L13_69 = L13_69.humans
			L13_69 = L13_69.ai_player
			L13_69 = L13_69.RESERVE_COVER_WIDTH
			L13_69 = 0.5 * L13_69
			L9_65(L10_66, L11_67, L12_68, L13_69)
		end
	elseif L5_61 then
		L8_64 = A3_59
		L7_63 = A3_59.set_leave_cover
		L7_63(L8_64)
	else
		L7_63 = managers
		L7_63 = L7_63.ai
		L7_63 = L7_63.cover_manager
		L8_64 = L7_63
		L7_63 = L7_63.get_reserved_position
		L9_65 = A1_57
		L7_63 = L7_63(L8_64, L9_65)
		if L7_63 then
			L7_63 = managers
			L7_63 = L7_63.ai
			L7_63 = L7_63.cover_manager
			L8_64 = L7_63
			L7_63 = L7_63.release_cover
			L9_65 = A1_57
			L7_63(L8_64, L9_65)
		end
	end
	L7_63 = A0_56._ai_data
	L7_63 = L7_63.input
	L8_64 = L4_60 and L5_61
	L7_63.in_target_cover = L8_64
	L7_63 = A0_56._ai_data
	L7_63 = L7_63.input
	L9_65 = A3_59
	L8_64 = A3_59.enter_cover
	L8_64 = L8_64(L9_65)
	L7_63.entering_target_cover = L8_64
end
function PlayerAiNerveSystem._update_cover_quick_move(A0_72, A1_73, A2_74, A3_75, A4_76)
	local L5_77, L6_78, L7_79, L8_80, L9_81, L10_82, L11_83, L12_84, L13_85, L14_86, L15_87, L16_88, L17_89, L18_90, L19_91
	L5_77 = A1_73.quick_move_infos
	L6_78 = A1_73.cover_point
	L7_79, L8_80, L9_81, L10_82 = nil, nil, nil, nil
	L11_83 = A0_72._move_to_position
	L12_84 = A2_74 - L11_83
	L12_84 = L12_84.length
	L12_84 = L12_84(L13_85)
	if L12_84 < 150 then
		L11_83 = L13_85
		if L11_83 then
			L12_84 = L13_85
		else
			L11_83 = A0_72._move_to_position
		end
	end
	for L16_88, L17_89 in L13_85(L14_86) do
		L19_91 = L17_89
		L18_90 = L17_89.possible_from_cover_point
		L18_90 = L18_90(L19_91, A4_76, L6_78)
		if L18_90 then
			L19_91 = L17_89
			L18_90 = L17_89.target_cover_point
			L18_90 = L18_90(L19_91, L6_78)
			L19_91 = L18_90.position
			L19_91 = L19_91(L18_90)
			if not managers.ai.cover_manager:is_cover_reserved(L17_89:target_cover(), L19_91) and (L19_91 - A2_74):length() > 0 and L12_84 > (L19_91 - L11_83):length() and (not L9_81 or L9_81 > (L19_91 - L11_83):length()) then
				L7_79 = L17_89
				L9_81, L8_80 = (L19_91 - L11_83):length(), L16_88
				L10_82 = L18_90
			end
		end
	end
	if L7_79 then
		L16_88 = L7_79
		L17_89 = L6_78
		L18_90 = L10_82
		if L13_85 then
			return L14_86, L15_87
		end
	end
	return L13_85
end
function PlayerAiNerveSystem._calculate_look_at_position(A0_92, A1_93, A2_94, A3_95, A4_96)
	local L5_97, L6_98, L7_99, L8_100
	L5_97 = 500
	L6_98 = nil
	if A4_96 then
		L6_98 = A4_96
	else
		L7_99 = A0_92._waypoint_rotation_look_at_position
		if L7_99 then
			L7_99 = A0_92._waypoint_rotation_look_at_position
			return L7_99
		else
			L7_99 = A0_92._move_to_position
			if L7_99 then
				L6_98 = A0_92._move_to_position
			else
				L7_99 = A0_92._ai_data
				L7_99 = L7_99.output
				L6_98 = L7_99.look_at_position
			end
		end
	end
	L7_99 = A0_92._next_update_eye_target
	if L7_99 then
		if L6_98 then
			A0_92._next_update_eye_target = nil
		else
			L6_98 = A0_92._next_update_eye_target
		end
	end
	if not L6_98 then
		L8_100 = A1_93
		L7_99 = A1_93.rotation
		L7_99 = L7_99(L8_100)
		L8_100 = L7_99
		L7_99 = L7_99.y
		L7_99 = L7_99(L8_100)
		L7_99 = 10000 * L7_99
		L6_98 = A2_94 + L7_99
	end
	L7_99 = mvector3
	L7_99 = L7_99.distance
	L8_100 = L6_98
	L7_99 = L7_99(L8_100, A2_94)
	if L5_97 < L7_99 then
		return L6_98
	end
	L8_100 = L6_98 - A2_94
	L8_100 = L8_100 + (L5_97 - L7_99) * L8_100:flat(math.UP):normalized()
	L7_99 = L5_97
	A0_92._look_at_rotation = Rotation:look_at(L8_100, math.UP)
	A0_92._look_at_distance = L7_99
	return A2_94 + A0_92._look_at_distance * A0_92._look_at_rotation:y()
end
function PlayerAiNerveSystem._burst_fire(A0_101, A1_102, A2_103, A3_104)
	local L4_105
	L4_105 = tweak_data
	L4_105 = L4_105.ai
	L4_105 = L4_105.humans
	L4_105 = L4_105.ai_player
	A0_101._burst_mean_time = L4_105.BURST_LENGTH
	A0_101._burst_standard_deviation_time = 2 * L4_105.BURST_LENGTH
	A0_101._burst_max_deviation_time = 0.4 * L4_105.BURST_LENGTH
	A0_101._burst_pause_mean_time = L4_105.TIME_BETWEEN_BURSTS
	A0_101._burst_pause_standard_deviation_time = 2 * L4_105.TIME_BETWEEN_BURSTS
	A0_101._burst_pause_max_deviation_time = 0.4 * L4_105.TIME_BETWEEN_BURSTS
	return AiNerveSystem._burst_fire(A0_101, A1_102, A2_103, A3_104)
end
function PlayerAiNerveSystem._is_dead(A0_106)
	return A0_106._unit:damage_data():is_fully_damaged() and not A0_106._unit:player_data().revive_when_fully_damaged
end
