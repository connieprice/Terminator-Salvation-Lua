require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerInCover")
require("shared/FiniteStateMachineState")
PlayerQuickMove = PlayerQuickMove or class(PlayerMovementState)
PlayerQuickMove.ANIM_FRAME = 0.033333335
PlayerQuickMove.BASE_SEGMENT = "body_base"
function PlayerQuickMove.init(A0_0, A1_1, A2_2, A3_3)
	PlayerMovementState.init(A0_0, A1_1, "PlayerQuickMove")
	A0_0._target_cover = A2_2
	A0_0._target_cover_point = A3_3
	A0_0._pre_leap_rotation = false
	A0_0._pre_leap_start = false
	A0_0._post_leap_rotation_start = false
	A0_0._leap_stretch = false
	A0_0._previous_unit_position = Vector3(0, 0, 0)
	A0_0._target_cover_rotation = Rotation(-A0_0._target_cover:normal(), math.UP)
	A0_0._unit_position = Vector3(0, 0, 0)
	A0_0._unit_rotation = Rotation(0, 0, 0)
	A0_0._animation_set = AnimationManager:animation_set(A1_1:base()._opt_anim_set or "player")
	A0_0._anim_lenght = 0
	A0_0._anim_duration = 0
	A0_0._anim_speed = 0
end
function PlayerQuickMove.enter(A0_4)
	PlayerMovementState.enter(A0_4)
	A0_4._base._cover_data_retriever:enter_cover(A0_4._target_cover)
	A0_4._player_data.quick_moving = true
	A0_4._length = (A0_4._target_cover_point:position() - A0_4._unit:position()):length()
	A0_4._player_data.quick_move_target_cover = A0_4._target_cover
	A0_4._player_data.quick_moving_relative_length = 0
	A0_4:_update_distance_to_cover_edge()
end
function PlayerQuickMove.leave(A0_5)
	PlayerMovementState.leave(A0_5)
	A0_5._player_data.quick_moving_relative_length = 1
	A0_5._player_data.quick_moving = false
	A0_5._player_data.quick_move_target_cover = nil
	A0_5._player_data.distance_to_left_cover_edge = nil
	A0_5._player_data.distance_to_right_cover_edge = nil
	A0_5._player_data.quick_moving_leap_stretch = false
end
function PlayerQuickMove.pre_leap_rotation(A0_6, A1_7)
	A0_6._anim_duration = A0_6._animation_set:animation_total_duration(A1_7)
	A0_6._anim_speed = A0_6:_segment_speed()
	assert(A0_6._anim_duration > 0)
	A0_6._pre_leap_rotation = true
	A0_6._pre_leap_start = false
	A0_6._unit_rotation = A0_6._unit:rotation()
end
function PlayerQuickMove.pre_leap_exit(A0_8)
	A0_8._pre_leap_rotation = false
end
function PlayerQuickMove.leap_stretch(A0_9, A1_10)
	local L2_11
	L2_11 = tweak_data
	L2_11 = L2_11.player
	L2_11 = L2_11.animation_distance
	L2_11 = L2_11[A1_10]
	A0_9._anim_duration = A0_9._animation_set:animation_total_duration(A1_10)
	A0_9._anim_speed = A0_9:_segment_speed()
	assert(A0_9._anim_duration > 0)
	assert(L2_11 ~= nil and L2_11 > 0)
	A0_9._leap_stretch = true
	A0_9._previous_unit_position = A0_9._unit:position()
	A0_9._root_stretch = (A0_9._target_cover_point:position() - A0_9._unit:position()):length() / L2_11
	A0_9._player_data.quick_moving_leap_stretch = true
end
function PlayerQuickMove.leap_post_rotation(A0_12, A1_13)
	A0_12._leap_post_rotation = true
	A0_12._slerp_start_time = A0_12:_segment_real_time()
	A0_12._unit_position = A0_12._unit:position()
	A0_12._unit_rotation = A0_12._unit:rotation()
end
function PlayerQuickMove.leap_exit(A0_14)
	A0_14._leap_stretch = false
	A0_14._leap_post_rotation = false
	A0_14._player_data.quick_moving_leap_stretch = false
	A0_14._unit:set_driving("animation")
end
function PlayerQuickMove._segment_real_time(A0_15)
	return (A0_15._unit:anim_state_machine():segment_real_time(PlayerQuickMove.BASE_SEGMENT))
end
function PlayerQuickMove._segment_speed(A0_16)
	local L1_17, L2_18
	L1_17 = A0_16._unit
	L2_18 = L1_17
	L1_17 = L1_17.anim_state_machine
	L1_17 = L1_17(L2_18)
	L2_18 = L1_17.segment_state
	L2_18 = L2_18(L1_17, PlayerQuickMove.BASE_SEGMENT)
	return L1_17:get_speed(L2_18)
end
function PlayerQuickMove._update_relative_length(A0_19, A1_20)
	local L2_21, L3_22, L4_23
	L2_21 = A0_19._player_data
	L3_22 = A0_19._length
	if L3_22 > 0 then
		L4_23 = A0_19._target_cover_point
		L4_23 = L4_23.position
		L4_23 = L4_23(L4_23)
		L4_23 = L4_23 - A1_20
		L4_23 = L4_23.length
		L4_23 = L4_23(L4_23)
		L4_23 = L4_23 / L3_22
		L4_23 = 1 - L4_23
		L2_21.quick_moving_relative_length = math.clamp(L4_23, 0, 1)
	else
		L2_21.quick_moving_relative_length = 1
	end
end
function PlayerQuickMove._update_pre_leap_rotation(A0_24, A1_25, A2_26, A3_27)
	local L4_28, L5_29, L6_30, L7_31, L8_32, L9_33, L10_34, L11_35, L12_36, L13_37
	L4_28 = A0_24._pre_leap_rotation
	if L4_28 then
		L4_28 = A3_27
		L5_29 = TimerManager
		L6_30 = L5_29
		L5_29 = L5_29.game_animation
		L5_29 = L5_29(L6_30)
		L6_30 = L5_29
		L5_29 = L5_29.multiplier
		L5_29 = L5_29(L6_30)
		L6_30 = PlayerQuickMove
		L6_30 = L6_30.ANIM_FRAME
		L7_31 = A0_24._anim_duration
		L8_32 = PlayerQuickMove
		L8_32 = L8_32.ANIM_FRAME
		L8_32 = 2 * L8_32
		L7_31 = L7_31 - L8_32
		L8_32 = L7_31 - L6_30
		L9_33 = nil
		L10_34 = PlayerQuickMove
		L10_34 = L10_34.ANIM_FRAME
		L10_34 = L10_34 * 0.5
		if L8_32 < L10_34 then
			L9_33 = 1
			L10_34 = A0_24._anim_duration
			L9_33 = L4_28 / L10_34
		else
			L10_34 = L4_28 - L6_30
			L9_33 = L10_34 / L8_32
		end
		if L9_33 >= 0 then
			L10_34 = math
			L10_34 = L10_34.sin
			L11_35 = math
			L11_35 = L11_35.clamp
			L12_36 = L9_33
			L13_37 = 0
			L11_35 = L11_35(L12_36, L13_37, 1)
			L11_35 = L11_35 * 90
			L10_34 = L10_34(L11_35)
			L11_35 = A0_24._pre_leap_start
			if not L11_35 then
				L11_35 = A0_24._unit
				L12_36 = L11_35
				L11_35 = L11_35.rotation
				L11_35 = L11_35(L12_36)
				A0_24._unit_rotation = L11_35
				A0_24._pre_leap_start = true
			end
			L11_35 = A0_24._unit
			L12_36 = L11_35
			L11_35 = L11_35.position
			L11_35 = L11_35(L12_36)
			L12_36 = A0_24._target_cover_point
			L13_37 = L12_36
			L12_36 = L12_36.position
			L12_36 = L12_36(L13_37)
			L13_37 = L12_36 - L11_35
			L13_37 = L13_37.normalized
			L13_37 = L13_37(L13_37)
			A0_24._unit:set_rotation(A0_24._unit_rotation:slerp(Rotation(L13_37, math.UP), L10_34))
		end
	end
end
function PlayerQuickMove._update_leap_stretch(A0_38, A1_39, A2_40)
	local L3_41, L4_42, L5_43, L6_44, L7_45
	L3_41 = A0_38._leap_stretch
	if L3_41 then
		L3_41 = A0_38._unit
		L4_42 = L3_41
		L3_41 = L3_41.get_animation_delta_position
		L3_41 = L3_41(L4_42)
		L5_43 = L3_41
		L4_42 = L3_41.length
		L4_42 = L4_42(L5_43)
		if L4_42 > 0 then
			L5_43 = L3_41 / L4_42
			L6_44 = A0_38._root_stretch
			L6_44 = L6_44 - 1
			L6_44 = L4_42 * L6_44
			L7_45 = A0_38._unit
			L7_45 = L7_45.position
			L7_45 = L7_45(L7_45)
			L7_45 = L7_45 + L5_43 * L6_44
			A0_38._unit:set_position(L7_45)
		end
	end
end
function PlayerQuickMove._update_leap_post_rotation(A0_46, A1_47, A2_48, A3_49)
	local L4_50, L5_51, L6_52, L7_53, L8_54, L9_55, L10_56, L11_57, L12_58, L13_59
	L4_50 = A0_46._leap_post_rotation
	if L4_50 then
		L4_50 = A3_49
		L5_51 = A0_46._slerp_start_time
		L6_52 = A0_46._anim_duration
		L7_53 = PlayerQuickMove
		L7_53 = L7_53.ANIM_FRAME
		L7_53 = 2 * L7_53
		L6_52 = L6_52 - L7_53
		L7_53 = L6_52 - L5_51
		L8_54 = L4_50 - L5_51
		L8_54 = L8_54 / L7_53
		L9_55 = math
		L9_55 = L9_55.clamp
		L10_56 = L8_54
		L11_57 = 0
		L12_58 = 1
		L9_55 = L9_55(L10_56, L11_57, L12_58)
		L10_56 = A0_46._unit
		L11_57 = L10_56
		L10_56 = L10_56.set_driving
		L12_58 = "script"
		L10_56(L11_57, L12_58)
		L10_56 = A0_46._post_leap_rotation_start
		if not L10_56 then
			L10_56 = A0_46._unit
			L11_57 = L10_56
			L10_56 = L10_56.position
			L10_56 = L10_56(L11_57)
			A0_46._unit_position = L10_56
			L10_56 = A0_46._unit
			L11_57 = L10_56
			L10_56 = L10_56.rotation
			L10_56 = L10_56(L11_57)
			A0_46._unit_rotation = L10_56
			A0_46._post_leap_rotation_start = true
		end
		L10_56 = A0_46._unit_rotation
		L11_57 = L10_56
		L10_56 = L10_56.slerp
		L12_58 = A0_46._target_cover_rotation
		L13_59 = math
		L13_59 = L13_59.sin
		L13_59 = L13_59(L9_55 * 90)
		L10_56 = L10_56(L11_57, L12_58, L13_59, L13_59(L9_55 * 90))
		L11_57 = A0_46._target_cover_point
		L12_58 = L11_57
		L11_57 = L11_57.position
		L11_57 = L11_57(L12_58)
		L12_58 = L9_55
		L13_59 = A0_46._unit_position
		L13_59 = L13_59 + (L11_57 - A0_46._unit_position) * L12_58
		A0_46._unit:set_rotation(L10_56)
		A0_46._unit:set_position(L13_59)
	end
end
function PlayerQuickMove.update(A0_60, A1_61, A2_62)
	local L3_63, L4_64
	L3_63 = A0_60._base
	L4_64 = L3_63
	L3_63 = L3_63.check_fully_damaged
	L3_63 = L3_63(L4_64)
	if L3_63 then
		return L3_63
	end
	L4_64 = A0_60._segment_real_time
	L4_64 = L4_64(A0_60)
	A0_60:_update_relative_length(A0_60._unit:position())
	A0_60:_update_pre_leap_rotation(A1_61, A2_62, L4_64)
	A0_60:_update_leap_stretch(A1_61, A2_62)
	A0_60:_update_leap_post_rotation(A1_61, A2_62, L4_64)
	if A0_60._player_data.in_cover then
		return PlayerInCover:new(A0_60._unit, A0_60._target_cover, A0_60._target_cover_point)
	end
	assert(A0_60._player_data.quickmove)
end
function PlayerQuickMove.variable_frequency_post_update(A0_65, A1_66)
	PlayerMovementState.variable_frequency_post_update(A0_65, A1_66)
	A0_65:_update_distance_to_cover_edge()
end
function PlayerQuickMove._update_distance_to_cover_edge(A0_67)
	local L1_68
	L1_68 = A0_67._base
	L1_68 = L1_68._cover_data_retriever
	A0_67._player_data.quick_move_target_distance_to_left_cover_edge = A0_67._unit:base():distance_to_cover_edge(L1_68, true, true, A0_67._target_cover_point, nil).result_is_valid and A0_67._unit:base():distance_to_cover_edge(L1_68, true, true, A0_67._target_cover_point, nil).distance_to_left_cover_edge
	A0_67._player_data.quick_move_target_distance_to_right_cover_edge = A0_67._unit:base():distance_to_cover_edge(L1_68, true, true, A0_67._target_cover_point, nil).result_is_valid and A0_67._unit:base():distance_to_cover_edge(L1_68, true, true, A0_67._target_cover_point, nil).distance_to_right_cover_edge
	A0_67._player_data.quick_moving_facing_right = A0_67._player_data.quick_moving_to_facing_right
end
