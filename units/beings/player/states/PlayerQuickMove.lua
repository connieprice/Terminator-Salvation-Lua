require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerInCover")
require("shared/FiniteStateMachineState")
if not PlayerQuickMove then
	PlayerQuickMove = class(PlayerMovementState)
end
PlayerQuickMove.ANIM_FRAME = 0.033333335
PlayerQuickMove.BASE_SEGMENT = "body_base"
PlayerQuickMove.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerQuickMove")
	l_1_0._target_cover = l_1_2
	l_1_0._target_cover_point = l_1_3
	l_1_0._pre_leap_rotation = false
	l_1_0._pre_leap_start = false
	l_1_0._post_leap_rotation_start = false
	l_1_0._leap_stretch = false
	l_1_0._previous_unit_position = Vector3(0, 0, 0)
	l_1_0._target_cover_rotation = Rotation(-l_1_0._target_cover:normal(), math.UP)
	l_1_0._unit_position = Vector3(0, 0, 0)
	l_1_0._unit_rotation = Rotation(0, 0, 0)
	l_1_0._animation_set = AnimationManager:animation_set(l_1_1:base()._opt_anim_set or "player")
	l_1_0._anim_lenght = 0
	l_1_0._anim_duration = 0
	l_1_0._anim_speed = 0
end

PlayerQuickMove.enter = function(l_2_0)
	PlayerMovementState.enter(l_2_0)
	l_2_0._base._cover_data_retriever:enter_cover(l_2_0._target_cover)
	l_2_0._player_data.quick_moving = true
	local l_2_1 = l_2_0._unit:position()
	l_2_0._length = l_2_0._target_cover_point:position() - l_2_1:length()
	l_2_0._player_data.quick_move_target_cover = l_2_0._target_cover
	l_2_0._player_data.quick_moving_relative_length = 0
	l_2_0:_update_distance_to_cover_edge()
end

PlayerQuickMove.leave = function(l_3_0)
	PlayerMovementState.leave(l_3_0)
	l_3_0._player_data.quick_moving_relative_length = 1
	l_3_0._player_data.quick_moving = false
	l_3_0._player_data.quick_move_target_cover = nil
	l_3_0._player_data.distance_to_left_cover_edge = nil
	l_3_0._player_data.distance_to_right_cover_edge = nil
	l_3_0._player_data.quick_moving_leap_stretch = false
end

PlayerQuickMove.pre_leap_rotation = function(l_4_0, l_4_1)
	l_4_0._anim_duration = l_4_0._animation_set:animation_total_duration(l_4_1)
	l_4_0._anim_speed = l_4_0:_segment_speed()
	local l_4_2 = assert
	l_4_2(l_4_0._anim_duration > 0)
	l_4_0._pre_leap_rotation = true
	l_4_0._pre_leap_start = false
	l_4_2 = l_4_0._unit
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_0._unit_rotation = l_4_2
end

PlayerQuickMove.pre_leap_exit = function(l_5_0)
	l_5_0._pre_leap_rotation = false
	 -- WARNING: undefined locals caused missing assignments!
end

PlayerQuickMove.leap_stretch = function(l_6_0, l_6_1)
	local l_6_2 = tweak_data.player.animation_distance[l_6_1]
	l_6_0._anim_duration = l_6_0._animation_set:animation_total_duration(l_6_1)
	l_6_0._anim_speed = l_6_0:_segment_speed()
	local l_6_3 = assert
	l_6_3(l_6_0._anim_duration > 0)
	l_6_3 = assert
	l_6_3(l_6_2 ~= nil and l_6_2 > 0)
	l_6_0._leap_stretch = true
	l_6_3 = l_6_0._unit
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_6_8 = l_6_0._target_cover_point:position()
	local l_6_9 = l_6_8 - l_6_3:length()
	l_6_0._previous_unit_position = l_6_3
	l_6_0._root_stretch = l_6_9 / l_6_2
	l_6_0._player_data.quick_moving_leap_stretch = true
end

PlayerQuickMove.leap_post_rotation = function(l_7_0, l_7_1)
	l_7_0._leap_post_rotation = true
	l_7_0._slerp_start_time = l_7_0:_segment_real_time()
	l_7_0._unit_position = l_7_0._unit:position()
	l_7_0._unit_rotation = l_7_0._unit:rotation()
end

PlayerQuickMove.leap_exit = function(l_8_0)
	l_8_0._leap_stretch = false
	l_8_0._leap_post_rotation = false
	l_8_0._player_data.quick_moving_leap_stretch = false
	l_8_0._unit:set_driving("animation")
end

PlayerQuickMove._segment_real_time = function(l_9_0)
	local l_9_1 = l_9_0._unit:anim_state_machine()
	return l_9_1:segment_real_time(PlayerQuickMove.BASE_SEGMENT)
end

PlayerQuickMove._segment_speed = function(l_10_0)
	local l_10_1 = l_10_0._unit:anim_state_machine()
	local l_10_2 = l_10_1:segment_state(PlayerQuickMove.BASE_SEGMENT)
	local l_10_3, l_10_4 = l_10_1:get_speed, l_10_1
	local l_10_5 = l_10_2
	return l_10_3(l_10_4, l_10_5)
end

PlayerQuickMove._update_relative_length = function(l_11_0, l_11_1)
	local l_11_2 = l_11_0._player_data
	local l_11_3 = l_11_0._length
	if l_11_3 > 0 then
		local l_11_4 = 1 - l_11_0._target_cover_point:position() - l_11_1:length() / l_11_3
		l_11_2.quick_moving_relative_length = math.clamp(l_11_4, 0, 1)
	else
		l_11_2.quick_moving_relative_length = 1
	end
end

PlayerQuickMove._update_pre_leap_rotation = function(l_12_0, l_12_1, l_12_2, l_12_3)
	if l_12_0._pre_leap_rotation then
		local l_12_4 = l_12_3
		local l_12_5 = TimerManager:game_animation():multiplier()
		local l_12_6 = PlayerQuickMove.ANIM_FRAME
		local l_12_7 = l_12_0._anim_duration - 2 * PlayerQuickMove.ANIM_FRAME
		local l_12_8 = l_12_7 - l_12_6
		local l_12_9 = nil
		if l_12_8 < PlayerQuickMove.ANIM_FRAME * 0.5 then
			l_12_9 = 1
			l_12_9 = l_12_4 / l_12_0._anim_duration
		else
			l_12_9 = (l_12_4 - l_12_6) / l_12_8
		end
	if l_12_9 >= 0 then
		end
		local l_12_10 = math.sin(math.clamp(l_12_9, 0, 1) * 90)
		if not l_12_0._pre_leap_start then
			l_12_0._unit_rotation = l_12_0._unit:rotation()
			l_12_0._pre_leap_start = true
		end
		local l_12_11 = l_12_0._unit:position()
		local l_12_12 = l_12_0._target_cover_point:position()
		local l_12_13 = l_12_12 - l_12_11:normalized()
		l_12_0._unit:set_rotation(l_12_0._unit_rotation:slerp(Rotation(l_12_13, math.UP), l_12_10))
	end
end

PlayerQuickMove._update_leap_stretch = function(l_13_0, l_13_1, l_13_2)
	if l_13_0._leap_stretch then
		local l_13_3 = l_13_0._unit:get_animation_delta_position()
		local l_13_4 = l_13_3:length()
	if l_13_4 > 0 then
		end
		local l_13_5 = l_13_3 / l_13_4
		local l_13_6 = l_13_4 * (l_13_0._root_stretch - 1)
		local l_13_7 = l_13_0._unit:position() + l_13_5 * l_13_6
		l_13_0._unit:set_position(l_13_7)
	end
end

PlayerQuickMove._update_leap_post_rotation = function(l_14_0, l_14_1, l_14_2, l_14_3)
	if l_14_0._leap_post_rotation then
		local l_14_4 = l_14_3
		local l_14_5 = l_14_0._slerp_start_time
		local l_14_6 = l_14_0._anim_duration - 2 * PlayerQuickMove.ANIM_FRAME
		local l_14_7 = l_14_6 - l_14_5
		local l_14_8 = (l_14_4 - l_14_5) / l_14_7
		local l_14_9 = math.clamp(l_14_8, 0, 1)
		l_14_0._unit:set_driving("script")
		if not l_14_0._post_leap_rotation_start then
			l_14_0._unit_position = l_14_0._unit:position()
			l_14_0._unit_rotation = l_14_0._unit:rotation()
			l_14_0._post_leap_rotation_start = true
		end
		local l_14_10 = l_14_0._unit_rotation:slerp(l_14_0._target_cover_rotation, math.sin(l_14_9 * 90))
		local l_14_11 = l_14_0._target_cover_point:position()
		local l_14_12 = l_14_9
		local l_14_13 = l_14_0._unit_position + (l_14_11 - l_14_0._unit_position) * l_14_12
		l_14_0._unit:set_rotation(l_14_10)
		l_14_0._unit:set_position(l_14_13)
	end
end

PlayerQuickMove.update = function(l_15_0, l_15_1, l_15_2)
	local l_15_3 = l_15_0._base:check_fully_damaged()
	if l_15_3 then
		return l_15_3
	end
	local l_15_4 = l_15_0:_segment_real_time()
	l_15_0:_update_relative_length(l_15_0._unit:position())
	l_15_0:_update_pre_leap_rotation(l_15_1, l_15_2, l_15_4)
	l_15_0:_update_leap_stretch(l_15_1, l_15_2)
	l_15_0:_update_leap_post_rotation(l_15_1, l_15_2, l_15_4)
	if l_15_0._player_data.in_cover then
		local l_15_5, l_15_6 = PlayerInCover:new, PlayerInCover
		local l_15_7 = l_15_0._unit
		local l_15_8 = l_15_0._target_cover
		local l_15_9 = l_15_0._target_cover_point
		return l_15_5(l_15_6, l_15_7, l_15_8, l_15_9)
	end
	assert(l_15_0._player_data.quickmove)
end

PlayerQuickMove.variable_frequency_post_update = function(l_16_0, l_16_1)
	PlayerMovementState.variable_frequency_post_update(l_16_0, l_16_1)
	l_16_0:_update_distance_to_cover_edge()
end

local l_0_0 = function(l_17_0, l_17_1, l_17_2)
	if l_17_0 and not l_17_1 then
		local l_17_3, l_17_4 = l_17_2
	else
		return nil
	end
end

PlayerQuickMove._update_distance_to_cover_edge = function(l_18_0)
	local l_18_1 = l_18_0._base._cover_data_retriever
	local l_18_2 = l_18_0._unit:base():distance_to_cover_edge(l_18_1, true, true, l_18_0._target_cover_point, nil)
	if l_18_2.result_is_valid then
		l_18_0._player_data.quick_move_target_distance_to_left_cover_edge = l_18_2.distance_to_left_cover_edge
	end
	if l_18_2.result_is_valid then
		l_18_0._player_data.quick_move_target_distance_to_right_cover_edge = l_18_2.distance_to_right_cover_edge
	end
	l_18_0._player_data.quick_moving_facing_right = l_18_0._player_data.quick_moving_to_facing_right
end


