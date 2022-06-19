require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerOnGround")
require("units/beings/player/states/PlayerQuickMove")
require("units/beings/player/states/PlayerLeavingCover")
require("units/beings/player/states/PlayerWounded")
require("units/beings/player/states/PlayerConnected")
require("units/beings/player/ScriptCoverUtils")
local l_0_0 = 0.001
if not PlayerInCover then
	PlayerInCover = class(PlayerMovementState)
end
PlayerInCover._MUST_FACE_DIRECTION_MIN_ANGLE = 40
PlayerInCover._MUST_FACE_DIRECTION_MAX_ANGLE = 150
local l_0_1 = PlayerInCover
local l_0_2 = {}
local l_0_3 = {}
l_0_3.min = -80
l_0_3.max = 80
l_0_2.inner = l_0_3
l_0_2.outer, l_0_3 = l_0_3, {min = -83, max = 83}
l_0_1._PEEK_UP_ANGLE = l_0_2
l_0_1 = PlayerInCover
l_0_3 = {min = -80, max = 80}
l_0_3 = {min = -83, max = 83}
l_0_1._PEEK_LEFT_ANGLE, l_0_2 = l_0_2, {inner = l_0_3, outer = l_0_3}
l_0_1 = PlayerInCover
l_0_3 = {min = -80, max = 80}
l_0_3 = {min = -83, max = 83}
l_0_1._PEEK_RIGHT_ANGLE, l_0_2 = l_0_2, {inner = l_0_3, outer = l_0_3}
l_0_1 = PlayerInCover
l_0_3 = {min = 80, max = 280}
l_0_3 = {min = 77, max = 283}
l_0_1._AIM_ANGLE, l_0_2 = l_0_2, {inner = l_0_3, outer = l_0_3}
l_0_1 = PlayerInCover
l_0_1._ROTATE_TO_NEW_COVER_DIRECTION_SPEED = 10
l_0_1 = PlayerInCover
l_0_1._PEEK_LEFT_SIDE_OFFSET = -70
l_0_1 = PlayerInCover
l_0_1._PEEK_LEFT_NORMAL_OFFSET = 30
l_0_1 = PlayerInCover
l_0_1._PEEK_RIGHT_SIDE_OFFSET = 50
l_0_1 = PlayerInCover
l_0_1._PEEK_RIGHT_NORMAL_OFFSET = 30
l_0_1 = PlayerInCover
l_0_1.movement, l_0_2 = l_0_2, {}
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement
l_0_1.IDLE = 0
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement
l_0_1.LEFT = 1
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement
l_0_1.RIGHT = 2
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement
l_0_1.FAST_LEFT = 3
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement
l_0_1.FAST_RIGHT = 4
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement
l_0_1.TURN_LEFT = 5
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement
l_0_1.TURN_RIGHT = 6
l_0_1 = PlayerInCover
l_0_1.movement_redirects, l_0_2 = l_0_2, {}
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.movement
l_0_2 = l_0_2.IDLE
l_0_1[l_0_2] = "move_idle"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.movement
l_0_2 = l_0_2.LEFT
l_0_1[l_0_2] = "walk_left"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.movement
l_0_2 = l_0_2.RIGHT
l_0_1[l_0_2] = "walk_right"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.movement
l_0_2 = l_0_2.FAST_LEFT
l_0_1[l_0_2] = "run_left"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.movement
l_0_2 = l_0_2.FAST_RIGHT
l_0_1[l_0_2] = "run_right"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.movement
l_0_2 = l_0_2.TURN_LEFT
l_0_1[l_0_2] = "move_idle"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.movement_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.movement
l_0_2 = l_0_2.TURN_RIGHT
l_0_1[l_0_2] = "move_idle"
l_0_1 = PlayerInCover
l_0_1.pose, l_0_2 = l_0_2, {}
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.NEUTRAL = 0
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.AIM = 1
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.PRECISION_AIM = 2
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.PEEK_UP = 3
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.PEEK_SIDE = 4
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.BLIND_FIRE_UP = 5
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.BLIND_FIRE_SIDE = 6
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.BLIND_FIRE_GRENADE_UP = 7
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.BLIND_FIRE_GRENADE_SIDE = 8
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose
l_0_1.FIRE_GRENADE_AWAY_FROM_COVER = 9
l_0_1 = PlayerInCover
l_0_1.pose_redirects, l_0_2 = l_0_2, {}
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.NEUTRAL
l_0_1[l_0_2] = "pose_idle"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.AIM
l_0_1[l_0_2] = "aim"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.PRECISION_AIM
l_0_1[l_0_2] = "zoom_aim"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.PEEK_UP
l_0_1[l_0_2] = "peek_up"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.PEEK_SIDE
l_0_1[l_0_2] = "peek_side"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.BLIND_FIRE_UP
l_0_1[l_0_2] = "blind_fire_up"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.BLIND_FIRE_SIDE
l_0_1[l_0_2] = "blind_fire_side"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.BLIND_FIRE_GRENADE_UP
l_0_1[l_0_2] = "blind_fire_grenade_up"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.BLIND_FIRE_GRENADE_SIDE
l_0_1[l_0_2] = "blind_fire_grenade_side"
l_0_1 = PlayerInCover
l_0_1 = l_0_1.pose_redirects
l_0_2 = PlayerInCover
l_0_2 = l_0_2.pose
l_0_2 = l_0_2.FIRE_GRENADE_AWAY_FROM_COVER
l_0_1[l_0_2] = "idle_fire_grenade"
l_0_1 = PlayerInCover
l_0_2 = function(l_1_0, l_1_1, l_1_2, l_1_3)
	PlayerMovementState.init(l_1_0, l_1_1, "PlayerInCover")
	l_1_0._initial_cover = l_1_2
	l_1_0._initial_position = l_1_3:position()
	l_1_0._initial_cover_point = l_1_3
	l_1_0._selected_quickmove = nil
	l_1_0._cover_data_retriever = l_1_0._base._cover_data_retriever
	l_1_0._cover_line_distance = nil
	l_1_0._input = l_1_1:input()
	l_1_0._position_free_dynamic_slot_mask = managers.slot:get_mask("players", "enemies")
	local l_1_4 = l_1_2:right()
	local l_1_5 = l_1_2:normal()
	l_1_0._can_peek_left_offset = l_1_4 * PlayerInCover._PEEK_LEFT_SIDE_OFFSET + l_1_5 * PlayerInCover._PEEK_LEFT_NORMAL_OFFSET
	l_1_0._can_peek_right_offset = l_1_4 * PlayerInCover._PEEK_RIGHT_SIDE_OFFSET + l_1_5 * PlayerInCover._PEEK_RIGHT_NORMAL_OFFSET
end

l_0_1.init = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_2_0)
	PlayerMovementState.enter(l_2_0)
	l_2_0:_set_cover(l_2_0._initial_cover)
	l_2_0._initial_cover = nil
	local l_2_1 = l_2_0._cover_normal
	l_2_0._unit:set_position(l_2_0._initial_position)
	l_2_0._mover_activated = l_2_0._unit:mover() ~= nil
	l_2_0:_update_mover_activation()
	l_2_0._weapon_right_align_object = l_2_0._unit:get_object("a_weapon_right_back")
	l_2_0._weapon_left_align_object = l_2_0._unit:get_object("a_weapon_left_back")
	l_2_0._position_free_dynamic_radius = l_2_0._unit:separate_distance()
	l_2_0._position_free_dynamic_height = l_2_0._unit:mover_by_name("in_cover"):height()
	l_2_0._can_move_to_left_cover = true
	l_2_0._can_move_to_right_cover = true
	local l_2_4 = l_2_0._cover_data_retriever
	local l_2_5 = l_2_0._base:distance_to_cover_edge(l_2_4, true, true, l_2_0._initial_cover_point, nil)
	if l_2_5.result_is_valid then
		l_2_0._player_data.distance_to_left_cover_edge = l_2_5.distance_to_left_cover_edge
	end
	if l_2_5.result_is_valid then
		l_2_0._player_data.distance_to_right_cover_edge = l_2_5.distance_to_right_cover_edge
	end
	l_2_0:_clear_input()
end

l_0_1.enter = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_3_0)
	PlayerMovementState.leave(l_3_0)
	local l_3_1 = l_3_0._player_data
	l_3_1.cover_point = nil
	l_3_1.cover = nil
	l_3_0._cover_data_retriever:leave_cover()
	l_3_1.quick_move_info_index = 0
	l_3_1.quick_move_infos = {}
	l_3_1.quick_move_infos_id = 0
	l_3_0._unit:look():reset_constraints()
	l_3_1.min_yaw_angle = nil
	l_3_1.max_yaw_angle = nil
	l_3_1.min_pitch_angle = nil
	l_3_1.max_pitch_angle = nil
end

l_0_1.leave = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_4_0)
	if not l_4_0._mover_activated then
		local l_4_1 = "in_cover"
		l_4_0._base:activate_mover(l_4_1)
		l_4_0._mover_activated = true
	end
end

l_0_1._update_mover_activation = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_5_0, l_5_1)
	local l_5_2 = l_5_0._player_data
	local l_5_3 = l_5_1:normal()
	l_5_0._cover_normal = l_5_3
	l_5_0._player_data.cover_normal = l_5_3
	l_5_0._player_data.cover = l_5_1
	l_5_0._cover = l_5_1
end

l_0_1._set_cover = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_6_0)
	return "leave_idle_bwd"
end

l_0_1._leave_cover_normal_redirect = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5)
	local l_7_6 = l_7_0._input
	local l_7_7 = l_7_6:normalized_movement()
	local l_7_8 = l_7_7:length()
	local l_7_9 = l_7_0._cover:normal()
	local l_7_10 = math.dot(l_7_7, l_7_9)
	local l_7_14 = l_7_10 < 0
	if l_7_8 > 0 and l_7_14 then
		local l_7_15 = l_7_6:eye_target_position() - l_7_0._pos:with_z(0):normalized()
		 -- DECOMPILER ERROR: Confused about usage of registers!

	if (not l_7_0._player_data.facing_right_in_cover or l_7_1 ~= CoverEdgeType.RIGHT or not l_7_5 or l_7_4) and not l_7_0._player_data.facing_right_in_cover then
		end
	if l_7_1 == CoverEdgeType.LEFT and l_7_3 and not l_7_2 then
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_7_16 = nil
	if ScriptCoverUtils.can_leave_cover(l_7_0._unit, l_7_9, l_7_0._cover:right(), iff(l_7_0._player_data.facing_right_in_cover, "right_forward", "left_forward")) then
		end
		return "break_fwd"
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_7_17 = nil
	if l_7_8 == 0 or l_7_14 then
		if l_7_15:dot(l_7_9) <= 0 then
			return "leave_cover_idle_bwd"
		else
			return "leave_cover_idle_fwd"
		end
	else
		if math.abs(l_7_15:dot(l_7_9)) < 0.707 then
			local l_7_18 = nil
			if l_7_17:dot(l_7_7) > 0.5 then
				return "leave_cover_strafe_walk_fwd"
			end
		elseif l_7_17:dot(l_7_7) < -0.5 then
			return "leave_cover_strafe_walk_bwd"
		elseif not l_7_14 then
			return "leave_cover_strafe"
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_7_18 < 0 then
		local l_7_19 = nil
		if math.abs(l_7_17:dot(l_7_7)) < 0.707 then
			local l_7_20 = nil
			if l_7_17:cross(math.UP):dot(l_7_7) >= 0 then
				return "leave_cover_walk_bwd_strafe_rt"
			else
				return "leave_cover_walk_bwd_strafe_lt"
			end
		elseif not l_7_14 then
			return "leave_cover_walk_bwd"
		end
	else
		local l_7_21 = nil
		if math.abs(l_7_17:dot(l_7_7)) < 0.707 then
			local l_7_22 = nil
			if l_7_17:cross(math.UP):dot(l_7_7) >= 0 then
				return "leave_cover_walk_fwd_strafe_rt"
			end
		else
			return "leave_cover_walk_fwd_strafe_lt"
		end
	elseif not l_7_14 then
		return "leave_cover_walk_fwd"
	end
end

l_0_1._leave_cover_redirect = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_8_0, l_8_1, l_8_2)
	if l_8_0._leave_cover_input then
		local l_8_3 = l_8_0._pos
		local l_8_4 = l_8_0._cover:closest_cover_point(l_8_3, tweak_data.player.cover.DISTANCE_TO, tweak_data.player.cover.DISTANCE_FROM_EDGE, 2)
		local l_8_5 = l_8_4:edge()
		local l_8_6 = true
		if l_8_2:quick_move_info_index() ~= 0 then
			local l_8_7 = l_8_0._player_data.quick_move_infos[l_8_2:quick_move_info_index()]
		if l_8_7 then
			end
			local l_8_8 = l_8_0._unit:play_redirect(l_8_7:redirect(not l_8_0._player_data.facing_right_in_cover, l_8_4))
			l_8_0._quickmove_target_cover_point = l_8_7:target_cover_point(l_8_4)
			local l_8_9 = ScriptCoverUtils.ground_position(l_8_0._quickmove_target_cover_point, l_8_0._incover_mover_radius)
			l_8_0._quickmove_target_cover_point:set_position(l_8_9)
		if l_8_8 ~= "" and l_8_8 ~= nil then
			end
			l_8_6 = false
			l_8_0._quickmove_target_cover = l_8_7:target_cover()
			return true
		end
	if l_8_6 then
		end
		local l_8_10, l_8_11, l_8_12, l_8_13, l_8_14 = l_8_0:_update_adjacent_covers(l_8_1)
		local l_8_15 = l_8_0:_leave_cover_redirect(l_8_5, l_8_11, l_8_12, l_8_13, l_8_14)
	if l_8_15 then
		end
		local l_8_16 = l_8_0._unit:play_redirect(l_8_15)
	if l_8_16 ~= "" and l_8_16 ~= nil then
		end
		return true
	end
	return false
end

l_0_1._update_leave_cover = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_9_0)
	if l_9_0._enter_outer_cover_position_input then
		local l_9_1 = l_9_0._unit:play_redirect("enter_outer_cover")
	if l_9_1 ~= "" and l_9_1 ~= nil then
		end
		return true
	end
end

l_0_1._update_enter_outer_cover = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = l_10_0._player_data
	local l_10_4 = l_10_0._cover_data_retriever
	local l_10_5 = l_10_4.quick_move_infos
	if l_10_5.is_valid then
		local l_10_6 = l_10_5.id
		if l_10_3.quick_move_infos_id ~= l_10_6 then
			l_10_3.quick_move_infos = l_10_5.value
			l_10_3.quick_move_infos_id = l_10_6
		end
	else
		l_10_3.quick_move_infos = {}
		l_10_3.quick_move_infos_id = 0
	end
	if l_10_2 == l_10_3.quick_move_infos_id then
		l_10_3.quick_move_info_index = l_10_1
	else
		l_10_3.quick_move_info_index = 0
	end
end

l_0_1._update_quick_move_infos = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_11_0, l_11_1)
	local l_11_2 = l_11_0._player_data
	local l_11_3 = l_11_0._cover_data_retriever
	local l_11_4 = l_11_3.cover_line
	assert(l_11_4.is_valid)
	local l_11_5 = l_11_0._unit
	local l_11_6 = l_11_0._pos
	local l_11_7 = l_11_4.value
	local l_11_8 = l_11_3.left_cover
	local l_11_9 = l_11_8.value
	local l_11_10 = l_11_8.is_valid
	local l_11_11 = l_11_3.right_cover
	local l_11_12 = l_11_11.value
	local l_11_13 = l_11_11.is_valid
	local l_11_14 = l_11_3.change_to_left_cover_distance
	local l_11_15 = l_11_3.change_to_right_cover_distance
	local l_11_16 = l_11_0._base:distance_to_cover_edge(l_11_3, l_11_0._can_move_to_left_cover, l_11_0._can_move_to_right_cover, nil, l_11_6)
	local l_11_17 = l_11_16.cover_point
	local l_11_18 = l_11_16.cover_line_distance
	local l_11_19 = l_11_16.cover_line_length
	local l_11_20 = l_11_16.clamp_at_left_edge
	local l_11_21 = l_11_16.clamp_at_right_edge
	l_11_0._distance_to_left_edge = l_11_16.distance_to_left_edge
	l_11_0._distance_to_right_edge = l_11_16.distance_to_right_edge
	l_11_0._distance_to_clamped_left_edge = l_11_16.distance_to_clamped_left_edge
	l_11_0._distance_to_clamped_right_edge = l_11_16.distance_to_clamped_right_edge
	if l_11_16.result_is_valid then
		l_11_2.distance_to_left_cover_edge = l_11_16.distance_to_left_cover_edge
	end
	if l_11_16.result_is_valid then
		l_11_2.distance_to_right_cover_edge = l_11_16.distance_to_right_cover_edge
	end
	local l_11_22 = l_11_3.change_to_left_cover_distance.value
	local l_11_23 = l_11_3.change_to_right_cover_distance.value
	local l_11_24, l_11_25, l_11_26, l_11_27, l_11_28 = nil, nil, nil, nil, nil
	if l_11_0._can_move_to_left_cover and not l_11_20 and l_11_14.is_valid and l_11_22 and l_11_18 <= -l_11_22 then
		l_11_24 = l_11_9
		l_11_27 = -l_11_22 - l_11_18
		l_11_25 = true
		l_11_26 = false
		l_11_28 = true
	elseif l_11_0._can_move_to_right_cover and not l_11_21 and l_11_15.is_valid and l_11_23 and l_11_19 + l_11_23 <= l_11_18 then
		l_11_24 = l_11_12
		l_11_27 = l_11_18 - (l_11_19 + l_11_23)
		l_11_25 = false
		l_11_26 = true
		l_11_28 = false
	end
	if l_11_24 then
		l_11_0:_set_cover(l_11_24)
		l_11_3:enter_cover(l_11_24)
		l_11_4 = l_11_3.cover_line
		assert(l_11_4.is_valid)
		l_11_7 = l_11_4.value
		l_11_19 = l_11_7:length()
		if l_11_28 then
			l_11_18 = l_11_19 + l_11_22 - (l_11_27)
		else
			l_11_18 = -l_11_23 + (l_11_27)
		end
		local l_11_29, l_11_30 = l_11_7:cover_point_at_distance, l_11_7
		local l_11_31 = l_11_18
		if not l_11_25 or l_11_26 then
			l_11_29 = l_11_29(l_11_30, l_11_31, tweak_data.player.cover.DISTANCE_FROM_EDGE, tweak_data.player.cover.DISTANCE_FROM_EDGE)
		end
		l_11_17 = l_11_29
		l_11_29 = CoverEdgeType
		l_11_29 = l_11_29.NOT_EDGE
		l_11_2.cover_point_edge = l_11_29
		l_11_29 = l_11_3.left_cover
		l_11_10 = l_11_29.is_valid
		l_11_29 = l_11_3.left_cover
		l_11_9 = l_11_29.value
		l_11_29 = l_11_3.right_cover
		l_11_13 = l_11_29.is_valid
		l_11_29 = l_11_3.right_cover
		l_11_12 = l_11_29.value
		l_11_0._distance_to_left_edge = l_11_18
		l_11_29 = l_11_19 - (l_11_18)
		l_11_0._distance_to_right_edge = l_11_29
		l_11_0._distance_to_clamped_left_edge = l_11_18
		l_11_29 = l_11_19 - (l_11_18)
		l_11_0._distance_to_clamped_right_edge = l_11_29
	else
		local l_11_34 = nil
		if l_11_17:edge() == CoverEdgeType.LEFT and l_11_10 and not l_11_9 then
			l_11_2.cover_point_edge = CoverEdgeType.LEFT
		end
	else
		if l_11_17:edge() == CoverEdgeType.RIGHT and l_11_13 and not l_11_12 then
			l_11_2.cover_point_edge = CoverEdgeType.RIGHT
		end
	else
		l_11_2.cover_point_edge = CoverEdgeType.NOT_EDGE
	end
	local l_11_35 = nil
	local l_11_36 = nil
	do
		local l_11_37 = l_11_17:position():with_z(l_11_6.z)
		l_11_5:set_position(l_11_37)
		l_11_5:set_rotation(l_11_5:rotation():slerp(Rotation(-l_11_17:normal(), math.UP), l_11_1 * PlayerInCover._ROTATE_TO_NEW_COVER_DIRECTION_SPEED))
		return l_11_17, l_11_9, l_11_10, l_11_12, l_11_13
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1._update_adjacent_covers = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_12_0, l_12_1, l_12_2)
	if l_12_1 < 0 then
		local l_12_3, l_12_4, l_12_6, l_12_7, l_12_8, l_12_10, l_12_12, l_12_15 = l_12_1 + 360
		l_12_4 = l_12_1
		do
			local l_12_5, l_12_9, l_12_11, l_12_13, l_12_16 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		return (l_12_2.min < l_12_1 and l_12_1 < l_12_2.max) or (l_12_2.min < l_12_1 - 360 and l_12_1 - 360 < l_12_2.max)
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 8 
end

l_0_1._in_range = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_13_0)
	l_13_0._fire_grenade_input = nil
	l_13_0._leave_cover_input = nil
	l_13_0._enter_outer_cover_position_input = nil
end

l_0_1._clear_input = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_14_0)
	local l_14_1 = l_14_0._input
	if not l_14_1:fire_grenade() then
		l_14_0._fire_grenade_input = l_14_0._fire_grenade_input
	end
	if not l_14_1:leave_cover() then
		l_14_0._leave_cover_input = l_14_0._leave_cover_input
	end
	if not l_14_1:enter_outer_cover_position() then
		l_14_0._enter_outer_cover_position_input = l_14_0._enter_outer_cover_position_input
	end
end

l_0_1._update_input = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_15_0, l_15_1, l_15_2, l_15_3, l_15_4, l_15_5, l_15_6)
	local l_15_7 = l_15_0._player_data
	local l_15_8 = l_15_7.cover_point
	local l_15_9 = l_15_0._cover_data_retriever
	local l_15_10 = l_15_9.left_cover
	local l_15_11 = l_15_10.value
	local l_15_12 = l_15_10.is_valid
	local l_15_13 = l_15_9.right_cover
	local l_15_14 = l_15_13.value
	local l_15_15 = l_15_13.is_valid
	local l_15_16 = nil
	local l_15_17 = false
	local l_15_18 = l_15_0._base:weapon()
	if l_15_18 ~= nil then
		local l_15_19 = l_15_18:weapon_data()
	if l_15_19._reload_ready then
		end
	if l_15_19._reload_required then
		end
		l_15_17 = true
	end
	local l_15_20 = l_15_0._unit
	local l_15_21 = l_15_0._pos
	local l_15_22 = l_15_0._input
	local l_15_23 = l_15_0._cover
	local l_15_24 = l_15_22:eye_target_position()
	local l_15_25 = l_15_24
	local l_15_26 = l_15_8:edge()
	local l_15_27 = managers.cover_util:high_cover(l_15_23)
	local l_15_28 = l_15_23:normal()
	local l_15_29 = l_15_23:right()
	local l_15_30 = l_15_22:precision_aiming()
	local l_15_31 = l_15_25 - l_15_21
	local l_15_32 = l_15_31:to_polar_with_reference(-l_15_28, math.UP).spin
	local l_15_33 = math.abs(l_15_32)
	local l_15_34 = l_15_22:movement()
	local l_15_35 = l_15_22:normalized_movement()
	local l_15_36 = (l_15_22:movement_length())
	local l_15_37 = nil
	local l_15_38 = math.dot(l_15_35, l_15_29)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if tweak_data.player.movement.STICK_LIMIT_FAST_COVER_MOVEMENT < l_15_36 then
		local l_15_44 = nil
	else
		local l_15_45 = nil
	end
	local l_15_46 = nil
	if not l_15_7.peeking_up then
		local l_15_47, l_15_51 = not tweak_data.player.movement.STICK_LIMIT_COVER_MOVEMENT < l_15_36 or l_15_38 < -0.5, not tweak_data.player.movement.STICK_LIMIT_COVER_MOVEMENT < l_15_36 or l_15_38 > 0.5
	end
	if l_15_7.peeking_side or l_15_7.blind_firing_side then
		local l_15_48, l_15_52 = nil
	end
	if l_15_7.peeking_side or l_15_7.blind_firing_side then
		local l_15_49, l_15_53 = nil
	end
	if l_15_7.is_aiming or l_15_7.is_precision_aiming then
		if not l_15_7.blind_firing_up and not not l_15_7.facing_right_in_cover then
			local l_15_50 = nil
		end
	else
		local l_15_54 = nil
	end
	local l_15_55 = nil
	local l_15_56 = nil
	local l_15_57 = false
	local l_15_58 = l_15_7.facing_right_in_cover
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_15_7.side_transition_in_cover and not l_15_27 and (not l_15_7.blind_firing_up or not l_15_0:_in_range(l_15_32, PlayerInCover._PEEK_UP_ANGLE.outer)) then
		local l_15_59 = nil
	end
	do
		local l_15_60, l_15_62, l_15_64 = nil
	end
	local l_15_66 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	local l_15_75 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not false or not l_15_0:_in_range(l_15_32, PlayerInCover._AIM_ANGLE.outer) then
		local l_15_84, l_15_88, l_15_92, l_15_95 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_15_17 and tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD < l_15_22:fire() then
		local l_15_98 = nil
	else
		local l_15_99, l_15_101, l_15_104 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_15_17 and tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD < l_15_22:fire() then
		local l_15_100 = nil
	else
		local l_15_102, l_15_105 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_15_17 and tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD < l_15_22:fire() then
		local l_15_103 = nil
	else
		local l_15_106 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_15_117 = nil
	local l_15_118 = nil
	local l_15_119 = nil
	local l_15_120 = nil
	do
		local l_15_122 = nil
	end
	local l_15_123 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		 -- DECOMPILER ERROR: Confused about usage of registers!

	end
	if l_15_7.peeking_up then
		if l_15_12 and l_15_11 and managers.cover_util:high_cover(l_15_11) then
			do return end
		end
		if l_15_15 and l_15_14 and managers.cover_util:high_cover(l_15_14) then
			do return end
		end
	else
		local l_15_130 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

		if not not l_15_0._distance_to_clamped_left_edge or l_15_0._distance_to_clamped_left_edge > 0.5 or l_15_55 or not false or (l_15_26 ~= CoverEdgeType.LEFT and l_15_0._distance_to_left_edge < 50 and not (l_15_7.side_transition_in_cover or l_15_9.can_peek_at_left_edge.is_valid) and ((not l_15_62 or not l_15_0:_in_range(l_15_32, PlayerInCover._PEEK_LEFT_ANGLE.outer)) and ((not l_15_27 and not l_15_55))) or l_15_32 > 0) then
			if l_15_57 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

		elseif (not not not l_15_0._distance_to_clamped_left_edge or l_15_0._distance_to_clamped_left_edge > 0.5 or l_15_55 or not false or (l_15_26 ~= CoverEdgeType.LEFT and l_15_0._distance_to_left_edge < 50 and not (l_15_7.side_transition_in_cover or l_15_9.can_peek_at_left_edge.is_valid) and ((not l_15_62 or not l_15_0:_in_range(l_15_32, PlayerInCover._PEEK_LEFT_ANGLE.outer)) and ((not l_15_27 and not l_15_55))) or l_15_32 > 0) and not not l_15_0._distance_to_clamped_right_edge or l_15_0._distance_to_clamped_right_edge > 0.5) then
			if l_15_57 then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

		else
			if l_15_26 == CoverEdgeType.LEFT and l_15_58 and l_15_55 and not l_15_7.peeking_up then
				do return end
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_15_26 == CoverEdgeType.RIGHT and not l_15_58 and l_15_66 and not l_15_7.peeking_up then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_15_26 == CoverEdgeType.LEFT then
			do return end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_15_26 == CoverEdgeType.RIGHT then
			do return end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_15_131 = nil
		do
			local l_15_132 = nil
			if (not l_15_7.reloading and not l_15_17 and not l_15_30) or (not l_15_7.reloading and not l_15_17 and not l_15_30) then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if false or false then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if not (l_15_7.side_transition_in_cover or l_15_9.can_peek_at_left_edge.is_valid) and ((not l_15_62 or not l_15_0:_in_range(l_15_32, PlayerInCover._PEEK_LEFT_ANGLE.outer)) and ((not l_15_27 and not l_15_55))) or not l_15_22:fire_grenade() or l_15_0._base:can_secondary_fire() or not (l_15_7.side_transition_in_cover or l_15_9.can_peek_at_right_edge.is_valid) and ((not l_15_64 or not l_15_0:_in_range(l_15_32, PlayerInCover._PEEK_RIGHT_ANGLE.outer)) and ((not l_15_27 and not l_15_66))) or not l_15_22:fire_grenade() or l_15_0._base:can_secondary_fire() then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if (not l_15_7.reloading and not l_15_17 and not l_15_30) then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if false then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if not l_15_0:_in_range(l_15_32, PlayerInCover._PEEK_UP_ANGLE.inner) or not l_15_22:fire_grenade() or l_15_0._base:can_secondary_fire() then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if not l_15_0:_in_range(l_15_32, PlayerInCover._AIM_ANGLE.inner) or not l_15_22:fire_grenade() or l_15_0._base:can_secondary_fire() then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if (not l_15_7.reloading and not l_15_30) then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_15_0._player_data.can_aim and l_15_0:_in_range(l_15_32, PlayerInCover._AIM_ANGLE.inner) then
				do return end
			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_15_0:_update_movement_animation(nil, l_15_0:_should_face_right(nil, l_15_32, l_15_33), not managers.cover_util:high_cover(l_15_0._cover))
			l_15_0:_update_pose_animation(l_15_16)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: undefined locals caused missing assignments!
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 512 
end

l_0_1._update_movement_and_pose = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_16_0, l_16_1)
	PlayerMovementState.variable_frequency_post_update(l_16_0, l_16_1)
	local l_16_2 = l_16_0._input
	l_16_0:_update_quick_move_infos(l_16_2:quick_move_info_index(), l_16_2:quick_move_infos_id())
	local l_16_3 = l_16_0:_update_leave_cover(l_16_1, l_16_2)
	if l_16_3 then
		l_16_0:_clear_input()
		return 
	end
	local l_16_4 = l_16_0:_update_enter_outer_cover()
	if l_16_4 then
		l_16_0:_clear_input()
		return 
	end
	local l_16_5 = l_16_0._cover_data_retriever
	local l_16_6 = l_16_5.can_move_over_cover
	local l_16_7 = l_16_0._player_data
	if l_16_6.is_valid then
		l_16_7.can_move_over_cover = l_16_6.value
	else
		l_16_7.can_move_over_cover = false
	end
	if l_16_0._fire_grenade_input then
		local l_16_8, l_16_11, l_16_14, l_16_16 = l_16_0._base:can_secondary_fire()
	end
	if not l_16_7.peeking_up then
		local l_16_9, l_16_12, l_16_15, l_16_17 = , l_16_7.peeking_side
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_16_7.peeking_up or not "idle_fire_grenade" then
		local l_16_10, l_16_13 = nil
	end
	l_16_0._unit:play_redirect(not l_16_9 or not l_16_12 or "peek_fire_grenade")
	do return end
	l_16_0:_update_movement_and_pose(l_16_1)
	local l_16_18 = nil
	local l_16_19 = nil
	local l_16_20 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_16_21 = nil
	local l_16_22 = l_16_0._cover_data_retriever.left_cover.value
	local l_16_23 = l_16_0._cover_data_retriever.left_cover.is_valid
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_16_24 = nil
	l_16_0:_update_aim_limitations(l_16_23, l_16_22, l_16_20.right_cover.is_valid, l_16_20.right_cover.value, l_16_7.peeking_up)
	l_16_0:_clear_input()
end

l_0_1.variable_frequency_post_update = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_17_0)
	local l_17_6, l_17_7, l_17_8, l_17_14, l_17_20, l_17_26 = nil
	local l_17_1 = l_17_0._base:check_fully_damaged()
	if l_17_1 then
		return l_17_1
	end
	local l_17_2 = l_17_0._player_data
	if l_17_2.connected then
		local l_17_3, l_17_4 = PlayerConnected:new, PlayerConnected
		local l_17_5 = l_17_0._unit
		return l_17_3(l_17_4, l_17_5)
	elseif l_17_2.quickmove then
		local l_17_9, l_17_10 = PlayerQuickMove:new, PlayerQuickMove
		local l_17_11 = l_17_0._unit
		local l_17_12, l_17_18, l_17_24 = l_17_0._quickmove_target_cover
		l_17_18 = l_17_0._quickmove_target_cover_point
		local l_17_13, l_17_19, l_17_25 = nil
		return l_17_9(l_17_10, l_17_11, l_17_12, l_17_18)
	elseif l_17_2.leaving_cover then
		local l_17_15, l_17_16 = PlayerLeavingCover:new, PlayerLeavingCover
		local l_17_17 = l_17_0._unit
		return l_17_15(l_17_16, l_17_17)
	elseif not l_17_2.in_cover then
		local l_17_21, l_17_22 = PlayerOnGround:new, PlayerOnGround
		local l_17_23 = l_17_0._unit
		return l_17_21(l_17_22, l_17_23)
	elseif l_17_2.cover_outer_position then
		local l_17_27, l_17_28 = PlayerInBackCover:new, PlayerInBackCover
		local l_17_29 = l_17_0._unit
		local l_17_30 = l_17_0._cover
		local l_17_31 = l_17_2.cover_point
		local l_17_32 = tweak_data.player.cover.OUTER_POSITION_OFFSET
		return l_17_27(l_17_28, l_17_29, l_17_30, l_17_31, l_17_32)
	end
end

l_0_1.transition = l_0_2
l_0_1 = PlayerInCover
l_0_2 = function(l_18_0, l_18_1, l_18_2)
	local l_18_3 = l_18_0:transition()
	if l_18_3 then
		return l_18_3
	end
	PlayerMovementState.update(l_18_0, l_18_1, l_18_2)
	PlayerMovementState._update_aim_parameters(l_18_0, l_18_2)
	l_18_0:_update_mover_activation()
	local l_18_4, l_18_5, l_18_6, l_18_7, l_18_8 = l_18_0:_update_adjacent_covers(l_18_2)
	local l_18_9 = l_18_4:position()
	local l_18_10 = l_18_0._player_data
	l_18_10.cover_point = l_18_4
	l_18_0:_update_input()
end

l_0_1.update = l_0_2
l_0_1 = function(l_19_0, l_19_1, l_19_2)
	local l_19_3 = 100
	if l_19_0 < l_19_3 then
		if not l_19_1 or l_19_2 and managers.cover_util:high_cover(l_19_2) then
			if l_19_0 <= 0 then
				return 0
			else
				return 90 - math.acos(l_19_0 / l_19_3)
			end
		else
			return nil
		end
	else
		return nil
	end
end

l_0_2 = PlayerInCover
l_0_3 = function(l_20_0, l_20_1, l_20_2, l_20_3, l_20_4, l_20_5)
	-- upvalues: l_0_1
	local l_20_6 = l_20_0._player_data
	if l_20_5 then
		local l_20_7 = 100
		local l_20_8 = 20
		if not l_20_0._distance_to_clamped_left_edge then
			local l_20_9 = l_20_0._distance_to_left_edge + l_20_8
		end
		if not l_20_0._distance_to_clamped_right_edge then
			local l_20_10 = l_20_0._distance_to_right_edge - l_20_8
			if l_20_10 < 0 and (not l_20_3 or not l_20_4 or managers.cover_util:high_cover(l_20_4)) then
				l_20_6.max_yaw_angle = l_20_10 * 25 / l_20_8
			else
				l_20_6.min_yaw_angle = l_0_1(l_20_9, l_20_1, l_20_2)
				if l_20_6.min_yaw_angle then
					l_20_6.min_yaw_angle = -l_20_6.min_yaw_angle
				end
				l_20_6.max_yaw_angle = l_0_1(l_20_10, l_20_3, l_20_4)
			end
			l_20_6.min_pitch_angle = tweak_data.player.cover.PEEK_UP_MIN_PITCH_ANGLE
		else
			l_20_6.min_yaw_angle = nil
			l_20_6.max_yaw_angle = nil
			l_20_6.min_pitch_angle = nil
			l_20_6.max_pitch_angle = nil
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

l_0_2._update_aim_limitations = l_0_3
l_0_2 = PlayerInCover
l_0_3 = function(l_21_0, l_21_1, l_21_2, l_21_3)
	local l_21_4 = l_21_0._player_data
	local l_21_5 = true
	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		if not PlayerInCover._MUST_FACE_DIRECTION_MIN_ANGLE <= l_21_3 and l_21_3 <= PlayerInCover._MUST_FACE_DIRECTION_MAX_ANGLE or l_21_2 < 0 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if not PlayerInCover._MUST_FACE_DIRECTION_MIN_ANGLE <= l_21_3 and l_21_3 <= PlayerInCover._MUST_FACE_DIRECTION_MAX_ANGLE or l_21_2 > 0 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		return l_21_5
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_2._should_face_right = l_0_3
l_0_2 = PlayerInCover
l_0_3 = function(l_22_0)
	return l_22_0._player_data.is_precision_aiming
end

l_0_2.is_precision_aiming = l_0_3
l_0_2 = function(l_23_0)
	return l_23_0 and PlayerInCover.movement_redirects[l_23_0] or "idle"
end

l_0_3 = PlayerInCover
l_0_3._update_pose_animation = function(l_24_0, l_24_1)
	local l_24_2 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_24_0._player_data.peeking_up and l_24_1 ~= PlayerInCover.pose.PEEK_UP and not l_24_0._player_data.throwing_grenade then
		l_24_2 = "peek_up_exit"
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_24_0._player_data.peeking_side and l_24_1 ~= PlayerInCover.pose.PEEK_SIDE and not l_24_0._player_data.throwing_grenade then
		l_24_2 = "peek_side_exit"
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_24_0._player_data.blind_firing_up and l_24_0._player_data.can_shoot and l_24_1 ~= PlayerInCover.pose.BLIND_FIRE_UP then
		l_24_2 = "blind_fire_up_exit"
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_24_0._player_data.blind_firing_side and l_24_0._player_data.can_shoot and l_24_1 ~= PlayerInCover.pose.BLIND_FIRE_SIDE then
		l_24_2 = "blind_fire_side_exit"
	else
		l_24_2 = PlayerInCover.pose_redirects[l_24_1]
	end
	l_24_0._unit:play_redirect(l_24_2)
end

l_0_3 = PlayerInCover
l_0_3._update_movement_animation = function(l_25_0, l_25_1, l_25_2, l_25_3)
	-- upvalues: l_0_2
	local l_25_4 = nil
	if not l_25_0._player_data.side_transition_in_cover then
		if l_25_2 ~= l_25_0._player_data.facing_right_in_cover then
			if l_25_2 then
				l_25_4 = "change_to_right"
			end
		else
			l_25_4 = "change_to_left"
		end
	else
		if l_25_3 ~= l_25_0._player_data.is_crouching then
			if l_25_3 then
				l_25_4 = "change_to_crouch"
			end
		end
	else
		l_25_4 = "change_to_stand"
	end
	if not l_25_0._player_data.side_transition_in_cover and not l_25_4 then
		l_25_4 = l_0_2(l_25_1)
	end
	if l_25_4 then
		l_25_0._unit:play_redirect(l_25_4)
	end
end

l_0_3 = PlayerInCover
l_0_3._position_free_dynamic = function(l_26_0, l_26_1, l_26_2)
	local l_26_3 = l_26_2
	local l_26_4 = l_26_0._position_free_dynamic_radius
	local l_26_5 = l_26_0._position_free_dynamic_height
	local l_26_6 = l_26_3 + math.UP * l_26_5
	local l_26_12 = l_26_1:find_units
	local l_26_13 = l_26_1
	l_26_12 = l_26_12(l_26_13, "cylinder", l_26_3, l_26_6, l_26_4, l_26_0._position_free_dynamic_slot_mask)
	local l_26_7 = nil
	l_26_13 = #l_26_12
	if l_26_13 == 0 then
		l_26_13 = true
		return l_26_13
	end
	l_26_13 = l_26_0._cover
	local l_26_8 = nil
	l_26_7 = pairs
	l_26_8 = l_26_12
	l_26_7 = l_26_7(l_26_8)
	for i_0,i_1 in l_26_7 do
		local l_26_14 = l_26_11:player_data()
		if l_26_14 and l_26_14.peek_side_obstacle then
			if l_26_14.cover ~= l_26_13 then
				local l_26_15 = not l_26_11:damage_data():is_fully_damaged()
			end
		else
			if false then
				return false
			end
		end
		return true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 43 
end

l_0_3 = PlayerInCover
l_0_3._can_peek_left_dynamic = function(l_27_0)
	local l_27_1 = l_27_0._unit
	local l_27_2, l_27_3 = l_27_0:_position_free_dynamic, l_27_0
	local l_27_4 = l_27_1
	local l_27_6 = l_27_0._pos
	l_27_6 = l_27_6 + l_27_0._can_peek_left_offset
	local l_27_5 = nil
	return l_27_2(l_27_3, l_27_4, l_27_6)
end

l_0_3 = PlayerInCover
l_0_3._can_peek_right_dynamic = function(l_28_0)
	local l_28_1 = l_28_0._unit
	local l_28_2, l_28_3 = l_28_0:_position_free_dynamic, l_28_0
	local l_28_4 = l_28_1
	local l_28_6 = l_28_0._pos
	l_28_6 = l_28_6 + l_28_0._can_peek_right_offset
	local l_28_5 = nil
	return l_28_2(l_28_3, l_28_4, l_28_6)
end

l_0_3 = PlayerInCover
l_0_3._idle_under_fire_redirects = function(l_29_0)
	local l_29_1 = {}
	local l_29_2 = l_29_0._cover
	local l_29_3 = managers.cover_util:high_cover(l_29_2)
	if not l_29_3 then
		table.insert(l_29_1, "idle_under_fire_from_above")
	end
	local l_29_4 = l_29_0._player_data
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_29_4.facing_right_in_cover and l_29_4.cover_point_edge == CoverEdgeType.RIGHT then
		table.insert(l_29_1, "idle_under_fire_from_right_1")
		table.insert(l_29_1, "idle_under_fire_from_right_2")
	if l_29_3 then
		end
		table.insert(l_29_1, "idle_under_fire_from_right_3")
	end
	do return end
	if l_29_4.cover_point_edge == CoverEdgeType.LEFT then
		table.insert(l_29_1, "idle_under_fire_from_left_1")
		table.insert(l_29_1, "idle_under_fire_from_left_2")
	if l_29_3 then
		end
		table.insert(l_29_1, "idle_under_fire_from_left_3")
	end
	return l_29_1
end

l_0_3 = PlayerInCover
l_0_3._idle_redirects = function(l_30_0)
	local l_30_1 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_30_2 = "idle_small"
	if l_30_2.large_idles_enabled then
		table.insert(l_30_1, "idle_large")
	end
	local l_30_3 = l_30_0._cover
	local l_30_4 = managers.cover_util:high_cover(l_30_3)
	if not l_30_4 then
		table.insert(l_30_1, "idle_peek_up")
	end
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_30_2.facing_right_in_cover and l_30_2.cover_point_edge == CoverEdgeType.RIGHT then
		table.insert(l_30_1, "idle_peek_right")
	end
	do return end
	if l_30_2.cover_point_edge == CoverEdgeType.LEFT then
		table.insert(l_30_1, "idle_peek_left")
	end
	return l_30_1
end


