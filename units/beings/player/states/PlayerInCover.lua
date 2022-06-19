local L0_0
L0_0 = require
L0_0("units/beings/player/states/PlayerMovementState")
L0_0 = require
L0_0("units/beings/player/states/PlayerOnGround")
L0_0 = require
L0_0("units/beings/player/states/PlayerQuickMove")
L0_0 = require
L0_0("units/beings/player/states/PlayerLeavingCover")
L0_0 = require
L0_0("units/beings/player/states/PlayerWounded")
L0_0 = require
L0_0("units/beings/player/states/PlayerConnected")
L0_0 = require
L0_0("units/beings/player/ScriptCoverUtils")
L0_0 = 0.001
PlayerInCover = PlayerInCover or class(PlayerMovementState)
PlayerInCover._MUST_FACE_DIRECTION_MIN_ANGLE = 40
PlayerInCover._MUST_FACE_DIRECTION_MAX_ANGLE = 150
PlayerInCover._PEEK_UP_ANGLE = {
	inner = {min = -80, max = 80},
	outer = {min = -83, max = 83}
}
PlayerInCover._PEEK_LEFT_ANGLE = {
	inner = {min = -80, max = 80},
	outer = {min = -83, max = 83}
}
PlayerInCover._PEEK_RIGHT_ANGLE = {
	inner = {min = -80, max = 80},
	outer = {min = -83, max = 83}
}
PlayerInCover._AIM_ANGLE = {
	inner = {min = 80, max = 280},
	outer = {min = 77, max = 283}
}
PlayerInCover._ROTATE_TO_NEW_COVER_DIRECTION_SPEED = 10
PlayerInCover._PEEK_LEFT_SIDE_OFFSET = -70
PlayerInCover._PEEK_LEFT_NORMAL_OFFSET = 30
PlayerInCover._PEEK_RIGHT_SIDE_OFFSET = 50
PlayerInCover._PEEK_RIGHT_NORMAL_OFFSET = 30
PlayerInCover.movement = {}
PlayerInCover.movement.IDLE = 0
PlayerInCover.movement.LEFT = 1
PlayerInCover.movement.RIGHT = 2
PlayerInCover.movement.FAST_LEFT = 3
PlayerInCover.movement.FAST_RIGHT = 4
PlayerInCover.movement.TURN_LEFT = 5
PlayerInCover.movement.TURN_RIGHT = 6
PlayerInCover.movement_redirects = {}
PlayerInCover.movement_redirects[PlayerInCover.movement.IDLE] = "move_idle"
PlayerInCover.movement_redirects[PlayerInCover.movement.LEFT] = "walk_left"
PlayerInCover.movement_redirects[PlayerInCover.movement.RIGHT] = "walk_right"
PlayerInCover.movement_redirects[PlayerInCover.movement.FAST_LEFT] = "run_left"
PlayerInCover.movement_redirects[PlayerInCover.movement.FAST_RIGHT] = "run_right"
PlayerInCover.movement_redirects[PlayerInCover.movement.TURN_LEFT] = "move_idle"
PlayerInCover.movement_redirects[PlayerInCover.movement.TURN_RIGHT] = "move_idle"
PlayerInCover.pose = {}
PlayerInCover.pose.NEUTRAL = 0
PlayerInCover.pose.AIM = 1
PlayerInCover.pose.PRECISION_AIM = 2
PlayerInCover.pose.PEEK_UP = 3
PlayerInCover.pose.PEEK_SIDE = 4
PlayerInCover.pose.BLIND_FIRE_UP = 5
PlayerInCover.pose.BLIND_FIRE_SIDE = 6
PlayerInCover.pose.BLIND_FIRE_GRENADE_UP = 7
PlayerInCover.pose.BLIND_FIRE_GRENADE_SIDE = 8
PlayerInCover.pose.FIRE_GRENADE_AWAY_FROM_COVER = 9
PlayerInCover.pose_redirects = {}
PlayerInCover.pose_redirects[PlayerInCover.pose.NEUTRAL] = "pose_idle"
PlayerInCover.pose_redirects[PlayerInCover.pose.AIM] = "aim"
PlayerInCover.pose_redirects[PlayerInCover.pose.PRECISION_AIM] = "zoom_aim"
PlayerInCover.pose_redirects[PlayerInCover.pose.PEEK_UP] = "peek_up"
PlayerInCover.pose_redirects[PlayerInCover.pose.PEEK_SIDE] = "peek_side"
PlayerInCover.pose_redirects[PlayerInCover.pose.BLIND_FIRE_UP] = "blind_fire_up"
PlayerInCover.pose_redirects[PlayerInCover.pose.BLIND_FIRE_SIDE] = "blind_fire_side"
PlayerInCover.pose_redirects[PlayerInCover.pose.BLIND_FIRE_GRENADE_UP] = "blind_fire_grenade_up"
PlayerInCover.pose_redirects[PlayerInCover.pose.BLIND_FIRE_GRENADE_SIDE] = "blind_fire_grenade_side"
PlayerInCover.pose_redirects[PlayerInCover.pose.FIRE_GRENADE_AWAY_FROM_COVER] = "idle_fire_grenade"
function PlayerInCover.init(A0_1, A1_2, A2_3, A3_4)
	PlayerMovementState.init(A0_1, A1_2, "PlayerInCover")
	A0_1._initial_cover = A2_3
	A0_1._initial_position = A3_4:position()
	A0_1._initial_cover_point = A3_4
	A0_1._selected_quickmove = nil
	A0_1._cover_data_retriever = A0_1._base._cover_data_retriever
	A0_1._cover_line_distance = nil
	A0_1._input = A1_2:input()
	A0_1._position_free_dynamic_slot_mask = managers.slot:get_mask("players", "enemies")
	A0_1._can_peek_left_offset = A2_3:right() * PlayerInCover._PEEK_LEFT_SIDE_OFFSET + A2_3:normal() * PlayerInCover._PEEK_LEFT_NORMAL_OFFSET
	A0_1._can_peek_right_offset = A2_3:right() * PlayerInCover._PEEK_RIGHT_SIDE_OFFSET + A2_3:normal() * PlayerInCover._PEEK_RIGHT_NORMAL_OFFSET
end
function PlayerInCover.enter(A0_5)
	local L1_6, L2_7
	L1_6 = PlayerMovementState
	L1_6 = L1_6.enter
	L2_7 = A0_5
	L1_6(L2_7)
	L2_7 = A0_5
	L1_6 = A0_5._set_cover
	L1_6(L2_7, A0_5._initial_cover)
	A0_5._initial_cover = nil
	L1_6 = A0_5._cover_normal
	L2_7 = A0_5._unit
	L2_7 = L2_7.set_position
	L2_7(L2_7, A0_5._initial_position)
	L2_7 = A0_5._unit
	L2_7 = L2_7.mover
	L2_7 = L2_7(L2_7)
	L2_7 = L2_7 ~= nil
	A0_5._mover_activated = L2_7
	L2_7 = A0_5._update_mover_activation
	L2_7(A0_5)
	L2_7 = A0_5._unit
	L2_7 = L2_7.get_object
	L2_7 = L2_7(L2_7, "a_weapon_right_back")
	A0_5._weapon_right_align_object = L2_7
	L2_7 = A0_5._unit
	L2_7 = L2_7.get_object
	L2_7 = L2_7(L2_7, "a_weapon_left_back")
	A0_5._weapon_left_align_object = L2_7
	L2_7 = A0_5._unit
	L2_7 = L2_7.separate_distance
	L2_7 = L2_7(L2_7)
	A0_5._position_free_dynamic_radius = L2_7
	L2_7 = A0_5._unit
	L2_7 = L2_7.mover_by_name
	L2_7 = L2_7(L2_7, "in_cover")
	L2_7 = L2_7.height
	L2_7 = L2_7(L2_7)
	A0_5._position_free_dynamic_height = L2_7
	A0_5._can_move_to_left_cover = true
	A0_5._can_move_to_right_cover = true
	L2_7 = A0_5._cover_data_retriever
	A0_5._player_data.distance_to_left_cover_edge = A0_5._base:distance_to_cover_edge(L2_7, true, true, A0_5._initial_cover_point, nil).result_is_valid and A0_5._base:distance_to_cover_edge(L2_7, true, true, A0_5._initial_cover_point, nil).distance_to_left_cover_edge
	A0_5._player_data.distance_to_right_cover_edge = A0_5._base:distance_to_cover_edge(L2_7, true, true, A0_5._initial_cover_point, nil).result_is_valid and A0_5._base:distance_to_cover_edge(L2_7, true, true, A0_5._initial_cover_point, nil).distance_to_right_cover_edge
	A0_5:_clear_input()
end
function PlayerInCover.leave(A0_8)
	PlayerMovementState.leave(A0_8)
	A0_8._player_data.cover_point = nil
	A0_8._player_data.cover = nil
	A0_8._cover_data_retriever:leave_cover()
	A0_8._player_data.quick_move_info_index = 0
	A0_8._player_data.quick_move_infos = {}
	A0_8._player_data.quick_move_infos_id = 0
	A0_8._unit:look():reset_constraints()
	A0_8._player_data.min_yaw_angle = nil
	A0_8._player_data.max_yaw_angle = nil
	A0_8._player_data.min_pitch_angle = nil
	A0_8._player_data.max_pitch_angle = nil
end
function PlayerInCover._update_mover_activation(A0_9)
	local L1_10
	L1_10 = A0_9._mover_activated
	if not L1_10 then
		L1_10 = "in_cover"
		A0_9._base:activate_mover(L1_10)
		A0_9._mover_activated = true
	end
end
function PlayerInCover._set_cover(A0_11, A1_12)
	local L2_13
	L2_13 = A0_11._player_data
	A0_11._cover_normal = A1_12:normal()
	A0_11._player_data.cover_normal = A1_12:normal()
	A0_11._player_data.cover = A1_12
	A0_11._cover = A1_12
end
function PlayerInCover._leave_cover_normal_redirect(A0_14)
	local L1_15
	L1_15 = "leave_idle_bwd"
	return L1_15
end
function PlayerInCover._leave_cover_redirect(A0_16, A1_17, A2_18, A3_19, A4_20, A5_21)
	local L6_22, L7_23, L8_24, L9_25, L10_26, L11_27, L12_28, L13_29, L14_30
	L6_22 = A0_16._input
	L8_24 = L6_22
	L7_23 = L6_22.normalized_movement
	L7_23 = L7_23(L8_24)
	L9_25 = L7_23
	L8_24 = L7_23.length
	L8_24 = L8_24(L9_25)
	L9_25 = A0_16._cover
	L10_26 = L9_25
	L9_25 = L9_25.normal
	L9_25 = L9_25(L10_26)
	L10_26 = math
	L10_26 = L10_26.dot
	L11_27 = L7_23
	L12_28 = L9_25
	L10_26 = L10_26(L11_27, L12_28)
	L11_27 = L10_26 < 0
	L13_29 = L6_22
	L12_28 = L6_22.eye_target_position
	L12_28 = L12_28(L13_29)
	L13_29 = A0_16._pos
	L12_28 = L12_28 - L13_29
	L13_29 = L12_28
	L12_28 = L12_28.with_z
	L14_30 = 0
	L12_28 = L12_28(L13_29, L14_30)
	L13_29 = L12_28
	L12_28 = L12_28.normalized
	L12_28 = L12_28(L13_29)
	if L8_24 > 0 and L11_27 then
		L13_29 = A0_16._player_data
		L14_30 = L13_29.facing_right_in_cover
		if L14_30 then
			L14_30 = CoverEdgeType
			L14_30 = L14_30.RIGHT
		else
			if A1_17 ~= L14_30 or not A5_21 or A4_20 then
				L14_30 = L13_29.facing_right_in_cover
				if not L14_30 then
					L14_30 = CoverEdgeType
					L14_30 = L14_30.LEFT
				end
		end
		elseif A1_17 == L14_30 and A3_19 and not A2_18 then
			L14_30 = iff
			L14_30 = L14_30(L13_29.facing_right_in_cover, "right_forward", "left_forward")
			if ScriptCoverUtils.can_leave_cover(A0_16._unit, L9_25, A0_16._cover:right(), L14_30) then
				return "break_fwd"
			end
		end
	end
	L14_30 = L12_28
	L13_29 = L12_28.dot
	L13_29 = L13_29(L14_30, L9_25)
	if L8_24 == 0 or L11_27 then
		if L13_29 <= 0 then
			L14_30 = "leave_cover_idle_bwd"
			return L14_30
		else
			L14_30 = "leave_cover_idle_fwd"
			return L14_30
		end
	else
		L14_30 = math
		L14_30 = L14_30.abs
		L14_30 = L14_30(L13_29)
		if L14_30 < 0.707 then
			L14_30 = L12_28.dot
			L14_30 = L14_30(L12_28, L7_23)
			if L14_30 > 0.5 then
				return "leave_cover_strafe_walk_fwd"
			elseif L14_30 < -0.5 then
				return "leave_cover_strafe_walk_bwd"
			elseif not L11_27 then
				return "leave_cover_strafe"
			end
		elseif L13_29 < 0 then
			L14_30 = L12_28.dot
			L14_30 = L14_30(L12_28, L7_23)
			if math.abs(L14_30) < 0.707 then
				if 0 <= L12_28:cross(math.UP):dot(L7_23) then
					return "leave_cover_walk_bwd_strafe_rt"
				else
					return "leave_cover_walk_bwd_strafe_lt"
				end
			elseif not L11_27 then
				return "leave_cover_walk_bwd"
			end
		else
			L14_30 = L12_28.dot
			L14_30 = L14_30(L12_28, L7_23)
			if math.abs(L14_30) < 0.707 then
				if 0 <= L12_28:cross(math.UP):dot(L7_23) then
					return "leave_cover_walk_fwd_strafe_rt"
				else
					return "leave_cover_walk_fwd_strafe_lt"
				end
			elseif not L11_27 then
				return "leave_cover_walk_fwd"
			end
		end
	end
end
function PlayerInCover._update_leave_cover(A0_31, A1_32, A2_33)
	local L3_34, L4_35, L5_36, L6_37, L7_38, L8_39, L9_40, L10_41, L11_42, L12_43
	L3_34 = A0_31._leave_cover_input
	if L3_34 then
		L3_34 = A0_31._pos
		L4_35 = A0_31._cover
		L5_36 = L4_35
		L4_35 = L4_35.closest_cover_point
		L6_37 = L3_34
		L7_38 = tweak_data
		L7_38 = L7_38.player
		L7_38 = L7_38.cover
		L7_38 = L7_38.DISTANCE_TO
		L8_39 = tweak_data
		L8_39 = L8_39.player
		L8_39 = L8_39.cover
		L8_39 = L8_39.DISTANCE_FROM_EDGE
		L9_40 = 2
		L4_35 = L4_35(L5_36, L6_37, L7_38, L8_39, L9_40)
		L6_37 = L4_35
		L5_36 = L4_35.edge
		L5_36 = L5_36(L6_37)
		L6_37 = true
		L8_39 = A2_33
		L7_38 = A2_33.quick_move_info_index
		L7_38 = L7_38(L8_39)
		if L7_38 ~= 0 then
			L7_38 = A0_31._player_data
			L7_38 = L7_38.quick_move_infos
			L9_40 = A2_33
			L8_39 = A2_33.quick_move_info_index
			L8_39 = L8_39(L9_40)
			L7_38 = L7_38[L8_39]
			if L7_38 then
				L8_39 = A0_31._unit
				L9_40 = L8_39
				L8_39 = L8_39.play_redirect
				L11_42 = L7_38
				L10_41 = L7_38.redirect
				L12_43 = A0_31._player_data
				L12_43 = L12_43.facing_right_in_cover
				L12_43 = not L12_43
				L12_43 = L10_41(L11_42, L12_43, L4_35)
				L8_39 = L8_39(L9_40, L10_41, L11_42, L12_43, L10_41(L11_42, L12_43, L4_35))
				L10_41 = L7_38
				L9_40 = L7_38.target_cover_point
				L11_42 = L4_35
				L9_40 = L9_40(L10_41, L11_42)
				A0_31._quickmove_target_cover_point = L9_40
				L9_40 = ScriptCoverUtils
				L9_40 = L9_40.ground_position
				L10_41 = A0_31._quickmove_target_cover_point
				L11_42 = A0_31._incover_mover_radius
				L9_40 = L9_40(L10_41, L11_42)
				L10_41 = A0_31._quickmove_target_cover_point
				L11_42 = L10_41
				L10_41 = L10_41.set_position
				L12_43 = L9_40
				L10_41(L11_42, L12_43)
				if L8_39 ~= "" and L8_39 ~= nil then
					L6_37 = false
					L11_42 = L7_38
					L10_41 = L7_38.target_cover
					L10_41 = L10_41(L11_42)
					A0_31._quickmove_target_cover = L10_41
					L10_41 = true
					return L10_41
				end
			end
		end
		if L6_37 then
			L8_39 = A0_31
			L7_38 = A0_31._update_adjacent_covers
			L9_40 = A1_32
			L11_42 = L7_38(L8_39, L9_40)
			L12_43 = A0_31._leave_cover_redirect
			L12_43 = L12_43(A0_31, L5_36, L8_39, L9_40, L10_41, L11_42)
			if L12_43 and A0_31._unit:play_redirect(L12_43) ~= "" and A0_31._unit:play_redirect(L12_43) ~= nil then
				return true
			end
		end
	end
	L3_34 = false
	return L3_34
end
function PlayerInCover._update_enter_outer_cover(A0_44)
	if A0_44._enter_outer_cover_position_input and A0_44._unit:play_redirect("enter_outer_cover") ~= "" and A0_44._unit:play_redirect("enter_outer_cover") ~= nil then
		return true
	end
end
function PlayerInCover._update_quick_move_infos(A0_45, A1_46, A2_47)
	local L3_48, L5_49, L6_50, L7_51
	L3_48 = A0_45._player_data
	L5_49 = A0_45._cover_data_retriever
	L6_50 = L5_49.quick_move_infos
	L7_51 = L6_50.is_valid
	if L7_51 then
		L7_51 = L6_50.id
		if L3_48.quick_move_infos_id ~= L7_51 then
			L3_48.quick_move_infos = L6_50.value
			L3_48.quick_move_infos_id = L7_51
		end
	else
		L7_51 = {}
		L3_48.quick_move_infos = L7_51
		L3_48.quick_move_infos_id = 0
	end
	L7_51 = L3_48.quick_move_infos_id
	if A2_47 == L7_51 then
		L3_48.quick_move_info_index = A1_46
	else
		L3_48.quick_move_info_index = 0
	end
end
function PlayerInCover._update_adjacent_covers(A0_52, A1_53)
	local L2_54, L3_55, L4_56, L5_57, L6_58, L7_59, L8_60, L9_61, L10_62, L11_63, L12_64, L13_65, L14_66, L15_67, L16_68, L17_69, L18_70, L19_71, L20_72, L21_73, L22_74, L23_75, L24_76, L25_77, L26_78, L27_79, L28_80, L29_81, L30_82, L31_83
	L2_54 = A0_52._player_data
	L3_55 = A0_52._cover_data_retriever
	L4_56 = L3_55.cover_line
	L5_57 = assert
	L6_58 = L4_56.is_valid
	L5_57(L6_58)
	L5_57 = A0_52._unit
	L6_58 = A0_52._pos
	L7_59 = L4_56.value
	L8_60 = L3_55.left_cover
	L9_61 = L8_60.value
	L10_62 = L8_60.is_valid
	L11_63 = L3_55.right_cover
	L12_64 = L11_63.value
	L13_65 = L11_63.is_valid
	L14_66 = L3_55.change_to_left_cover_distance
	L15_67 = L3_55.change_to_right_cover_distance
	L16_68 = A0_52._base
	L17_69 = L16_68
	L16_68 = L16_68.distance_to_cover_edge
	L18_70 = L3_55
	L19_71 = A0_52._can_move_to_left_cover
	L20_72 = A0_52._can_move_to_right_cover
	L21_73 = nil
	L22_74 = L6_58
	L16_68 = L16_68(L17_69, L18_70, L19_71, L20_72, L21_73, L22_74)
	L17_69 = L16_68.cover_point
	L18_70 = L16_68.cover_line_distance
	L19_71 = L16_68.cover_line_length
	L20_72 = L16_68.clamp_at_left_edge
	L21_73 = L16_68.clamp_at_right_edge
	L22_74 = L16_68.distance_to_left_edge
	A0_52._distance_to_left_edge = L22_74
	L22_74 = L16_68.distance_to_right_edge
	A0_52._distance_to_right_edge = L22_74
	L22_74 = L16_68.distance_to_clamped_left_edge
	A0_52._distance_to_clamped_left_edge = L22_74
	L22_74 = L16_68.distance_to_clamped_right_edge
	A0_52._distance_to_clamped_right_edge = L22_74
	L22_74 = L16_68.result_is_valid
	L22_74 = L22_74 and L16_68.distance_to_left_cover_edge
	L2_54.distance_to_left_cover_edge = L22_74
	L22_74 = L16_68.result_is_valid
	L22_74 = L22_74 and L16_68.distance_to_right_cover_edge
	L2_54.distance_to_right_cover_edge = L22_74
	L22_74 = L3_55.change_to_left_cover_distance
	L22_74 = L22_74.value
	L23_75 = L3_55.change_to_right_cover_distance
	L23_75 = L23_75.value
	L24_76, L25_77, L26_78, L27_79, L28_80 = nil, nil, nil, nil, nil
	L29_81 = A0_52._can_move_to_left_cover
	if L29_81 and not L20_72 then
		L29_81 = L14_66.is_valid
		if L29_81 and L22_74 then
			L29_81 = -L22_74
			if L18_70 <= L29_81 then
				L24_76 = L9_61
				L29_81 = -L22_74
				L27_79 = L29_81 - L18_70
				L25_77 = true
				L26_78 = false
				L28_80 = true
			end
		end
	else
		L29_81 = A0_52._can_move_to_right_cover
		if L29_81 and not L21_73 then
			L29_81 = L15_67.is_valid
			if L29_81 and L23_75 then
				L29_81 = L19_71 + L23_75
				if L18_70 >= L29_81 then
					L24_76 = L12_64
					L29_81 = L19_71 + L23_75
					L27_79 = L18_70 - L29_81
					L25_77 = false
					L26_78 = true
					L28_80 = false
				end
			end
		end
	end
	if L24_76 then
		L30_82 = A0_52
		L29_81 = A0_52._set_cover
		L31_83 = L24_76
		L29_81(L30_82, L31_83)
		L30_82 = L3_55
		L29_81 = L3_55.enter_cover
		L31_83 = L24_76
		L29_81(L30_82, L31_83)
		L4_56 = L3_55.cover_line
		L29_81 = assert
		L30_82 = L4_56.is_valid
		L29_81(L30_82)
		L7_59 = L4_56.value
		L30_82 = L7_59
		L29_81 = L7_59.length
		L29_81 = L29_81(L30_82)
		L19_71 = L29_81
		if L28_80 then
			L29_81 = L19_71 + L22_74
			L18_70 = L29_81 - L27_79
		else
			L29_81 = -L23_75
			L18_70 = L29_81 + L27_79
		end
		L30_82 = L7_59
		L29_81 = L7_59.cover_point_at_distance
		L31_83 = L18_70
		L29_81 = L29_81(L30_82, L31_83, L25_77 and tweak_data.player.cover.DISTANCE_FROM_EDGE, L26_78 and tweak_data.player.cover.DISTANCE_FROM_EDGE)
		L17_69 = L29_81
		L29_81 = CoverEdgeType
		L29_81 = L29_81.NOT_EDGE
		L2_54.cover_point_edge = L29_81
		L29_81 = L3_55.left_cover
		L10_62 = L29_81.is_valid
		L29_81 = L3_55.left_cover
		L9_61 = L29_81.value
		L29_81 = L3_55.right_cover
		L13_65 = L29_81.is_valid
		L29_81 = L3_55.right_cover
		L12_64 = L29_81.value
		A0_52._distance_to_left_edge = L18_70
		L29_81 = L19_71 - L18_70
		A0_52._distance_to_right_edge = L29_81
		A0_52._distance_to_clamped_left_edge = L18_70
		L29_81 = L19_71 - L18_70
		A0_52._distance_to_clamped_right_edge = L29_81
	else
		L30_82 = L17_69
		L29_81 = L17_69.edge
		L29_81 = L29_81(L30_82)
		L30_82 = CoverEdgeType
		L30_82 = L30_82.LEFT
		if L29_81 == L30_82 and L10_62 and not L9_61 then
			L30_82 = CoverEdgeType
			L30_82 = L30_82.LEFT
			L2_54.cover_point_edge = L30_82
		else
			L30_82 = CoverEdgeType
			L30_82 = L30_82.RIGHT
			if L29_81 == L30_82 and L13_65 and not L12_64 then
				L30_82 = CoverEdgeType
				L30_82 = L30_82.RIGHT
				L2_54.cover_point_edge = L30_82
			else
				L30_82 = CoverEdgeType
				L30_82 = L30_82.NOT_EDGE
				L2_54.cover_point_edge = L30_82
			end
		end
	end
	L30_82 = L17_69
	L29_81 = L17_69.position
	L29_81 = L29_81(L30_82)
	L30_82 = L29_81
	L29_81 = L29_81.with_z
	L31_83 = L6_58.z
	L29_81 = L29_81(L30_82, L31_83)
	L30_82 = Rotation
	L31_83 = L17_69.normal
	L31_83 = L31_83(L17_69)
	L31_83 = -L31_83
	L30_82 = L30_82(L31_83, math.UP)
	L31_83 = L5_57.rotation
	L31_83 = L31_83(L5_57)
	L31_83 = L31_83.slerp
	L31_83 = L31_83(L31_83, L30_82, A1_53 * PlayerInCover._ROTATE_TO_NEW_COVER_DIRECTION_SPEED)
	L5_57:set_position(L29_81)
	L5_57:set_rotation(L31_83)
	return L17_69, L9_61, L10_62, L12_64, L13_65
end
function PlayerInCover._in_range(A0_84, A1_85, A2_86)
	local L3_87, L4_88, L5_89
	if A1_85 < 0 then
		L3_87 = A1_85 + 360
		L4_88 = A1_85
	else
		L3_87 = A1_85
		L4_88 = A1_85 - 360
	end
	L5_89 = A2_86.min
	if L3_87 > L5_89 then
		L5_89 = A2_86.max
	L5_89 = L3_87 < L5_89 or A2_86.max
	return L5_89
end
function PlayerInCover._clear_input(A0_90)
	local L1_91
	A0_90._fire_grenade_input = nil
	A0_90._leave_cover_input = nil
	A0_90._enter_outer_cover_position_input = nil
end
function PlayerInCover._update_input(A0_92)
	local L1_93
	L1_93 = A0_92._input
	A0_92._fire_grenade_input = L1_93:fire_grenade() or A0_92._fire_grenade_input
	A0_92._leave_cover_input = L1_93:leave_cover() or A0_92._leave_cover_input
	A0_92._enter_outer_cover_position_input = L1_93:enter_outer_cover_position() or A0_92._enter_outer_cover_position_input
end
function PlayerInCover._update_movement_and_pose(A0_94, A1_95, A2_96, A3_97, A4_98, A5_99, A6_100)
	local L7_101, L8_102, L9_103, L10_104, L11_105, L12_106, L13_107, L14_108, L15_109, L16_110, L17_111, L18_112, L19_113, L20_114, L21_115, L22_116, L23_117, L24_118, L25_119, L26_120, L27_121, L28_122, L29_123, L30_124, L31_125, L32_126, L33_127, L34_128, L35_129, L36_130, L37_131, L38_132, L39_133, L40_134, L41_135, L42_136, L43_137, L44_138, L45_139, L46_140, L47_141, L48_142, L49_143, L50_144, L51_145, L52_146, L53_147, L54_148, L55_149, L56_150, L57_151, L58_152, L59_153, L60_154, L61_155, L62_156, L63_157, L64_158, L65_159, L66_160, L67_161, L68_162, L69_163, L70_164, L71_165, L72_166, L73_167, L74_168, L75_169, L76_170, L77_171, L78_172, L79_173, L80_174, L81_175, L82_176, L83_177, L84_178
	L7_101 = A0_94._player_data
	L8_102 = L7_101.cover_point
	L9_103 = A0_94._cover_data_retriever
	L10_104 = L9_103.left_cover
	L11_105 = L10_104.value
	L12_106 = L10_104.is_valid
	L13_107 = L9_103.right_cover
	L14_108 = L13_107.value
	L15_109 = L13_107.is_valid
	L16_110 = nil
	L17_111 = false
	L18_112 = A0_94._base
	L19_113 = L18_112
	L18_112 = L18_112.weapon
	L18_112 = L18_112(L19_113)
	if L18_112 ~= nil then
		L20_114 = L18_112
		L19_113 = L18_112.weapon_data
		L19_113 = L19_113(L20_114)
		L20_114 = L19_113._reload_ready
		if L20_114 then
			L20_114 = L19_113._reload_required
			if L20_114 then
				L17_111 = true
			end
		end
	end
	L19_113 = A0_94._unit
	L20_114 = A0_94._pos
	L21_115 = A0_94._input
	L22_116 = A0_94._cover
	L24_118 = L21_115
	L23_117 = L21_115.eye_target_position
	L23_117 = L23_117(L24_118)
	L24_118 = L23_117
	L26_120 = L8_102
	L25_119 = L8_102.edge
	L25_119 = L25_119(L26_120)
	L26_120 = managers
	L26_120 = L26_120.cover_util
	L27_121 = L26_120
	L26_120 = L26_120.high_cover
	L28_122 = L22_116
	L26_120 = L26_120(L27_121, L28_122)
	L28_122 = L22_116
	L27_121 = L22_116.normal
	L27_121 = L27_121(L28_122)
	L29_123 = L22_116
	L28_122 = L22_116.right
	L28_122 = L28_122(L29_123)
	L30_124 = L21_115
	L29_123 = L21_115.precision_aiming
	L29_123 = L29_123(L30_124)
	L30_124 = L24_118 - L20_114
	L32_126 = L30_124
	L31_125 = L30_124.to_polar_with_reference
	L33_127 = -L27_121
	L34_128 = math
	L34_128 = L34_128.UP
	L31_125 = L31_125(L32_126, L33_127, L34_128)
	L31_125 = L31_125.spin
	L32_126 = math
	L32_126 = L32_126.abs
	L33_127 = L31_125
	L32_126 = L32_126(L33_127)
	L34_128 = L21_115
	L33_127 = L21_115.movement
	L33_127 = L33_127(L34_128)
	L35_129 = L21_115
	L34_128 = L21_115.normalized_movement
	L34_128 = L34_128(L35_129)
	L36_130 = L21_115
	L35_129 = L21_115.movement_length
	L35_129 = L35_129(L36_130)
	L36_130 = nil
	L37_131 = math
	L37_131 = L37_131.dot
	L38_132 = L34_128
	L39_133 = L28_122
	L37_131 = L37_131(L38_132, L39_133)
	L38_132 = tweak_data
	L38_132 = L38_132.player
	L38_132 = L38_132.movement
	L38_132 = L38_132.STICK_LIMIT_COVER_MOVEMENT
	L38_132 = L35_129 > L38_132
	L39_133 = L38_132 and L37_131 < -0.5
	L40_134 = L38_132 and L37_131 > 0.5
	L41_135 = tweak_data
	L41_135 = L41_135.player
	L41_135 = L41_135.movement
	L41_135 = L41_135.STICK_LIMIT_FAST_COVER_MOVEMENT
	L41_135 = L35_129 > L41_135 and not L41_135
	L42_136 = L7_101.facing_right_in_cover
	L43_137 = L7_101.peeking_up
	L43_137 = L43_137 or L7_101.blind_firing_up
	L44_138 = L7_101.peeking_side
	if not L44_138 then
		L44_138 = L7_101.blind_firing_side
	elseif L44_138 then
		L44_138 = L7_101.facing_right_in_cover
		L44_138 = not L44_138
	end
	L45_139 = L7_101.peeking_side
	if not L45_139 then
		L45_139 = L7_101.blind_firing_side
	else
		L45_139 = L45_139 and L7_101.facing_right_in_cover
	end
	L46_140 = L7_101.is_aiming
	if not L46_140 then
		L46_140 = L7_101.is_precision_aiming
	else
		L46_140 = L46_140 and not L43_137 and not L44_138 and not L45_139
	end
	L48_142 = L21_115
	L47_141 = L21_115.fire
	L47_141 = L47_141(L48_142)
	L48_142 = A0_94._base
	L50_144 = L48_142
	L49_143 = L48_142.can_secondary_fire
	L49_143 = L49_143(L50_144)
	L51_145 = L21_115
	L50_144 = L21_115.fire_grenade
	L50_144 = L50_144(L51_145)
	L51_145 = L7_101.side_transition_in_cover
	L51_145 = not L51_145 and not L26_120 and L51_145(L52_146, L53_147, L54_148)
	L52_146 = L7_101.reloading
	L52_146 = not L52_146 and not L17_111 and L29_123 and L51_145
	L53_147 = L9_103.can_peek_at_left_edge
	L54_148 = L7_101.side_transition_in_cover
	L54_148 = not L54_148 and L54_148 and L54_148 and L25_119 == L54_148 and not L42_136 and L54_148(L55_149, L56_150, L57_151)
	L55_149 = L7_101.reloading
	L55_149 = not L55_149 and not L17_111 and L29_123 and L54_148 and L55_149(L56_150)
	L56_150 = L9_103.can_peek_at_right_edge
	L57_151 = L7_101.side_transition_in_cover
	L57_151 = not L57_151 and L57_151 and L57_151 and L25_119 == L57_151 and L42_136 and L57_151(L58_152, L59_153, L60_154)
	L58_152 = L7_101.reloading
	L58_152 = not L58_152 and not L17_111 and L29_123 and L57_151 and L58_152(L59_153)
	if L46_140 then
		L60_154 = A0_94
		L59_153 = A0_94._in_range
		L61_155 = L31_125
		L62_156 = PlayerInCover
		L62_156 = L62_156._AIM_ANGLE
		L62_156 = L62_156.outer
		L59_153 = L59_153(L60_154, L61_155, L62_156)
	elseif not L59_153 then
		L60_154 = A0_94
		L59_153 = A0_94._in_range
		L61_155 = L31_125
		L62_156 = PlayerInCover
		L62_156 = L62_156._AIM_ANGLE
		L62_156 = L62_156.inner
		L59_153 = L59_153(L60_154, L61_155, L62_156)
	end
	L60_154 = L7_101.reloading
	L60_154 = not L60_154 and L29_123 and L59_153
	L61_155 = L59_153 and L50_144 and L49_143
	L62_156 = not L17_111 and L47_141 > L62_156 and L51_145
	L63_157 = not L17_111 and L47_141 > L63_157 and L54_148
	L64_158 = not L17_111 and L47_141 > L64_158 and L57_151
	L65_159 = L51_145 and L50_144 and L49_143
	L66_160 = L54_148 and L50_144 and L49_143
	L67_161 = L57_151 and L50_144 and L49_143
	L68_162 = L12_106 and L11_105 and (not L68_162 or not L68_162)
	L69_163 = L15_109 and L14_108 and (not L69_163 or not L69_163)
	L70_164 = A0_94._distance_to_clamped_left_edge
	if L70_164 then
		L70_164 = A0_94._distance_to_clamped_left_edge
		L70_164 = L70_164 > 0.5
	end
	L71_165 = A0_94._distance_to_clamped_right_edge
	if L71_165 then
		L71_165 = A0_94._distance_to_clamped_right_edge
		L71_165 = L71_165 > 0.5
	end
	L72_166 = L9_103.left_edge_position
	L73_167 = L9_103.right_edge_position
	L74_168 = A0_94._distance_to_left_edge
	L75_169 = A0_94._distance_to_right_edge
	do break end
	L76_170 = peeking
	L76_170 = not L76_170 and L76_170 and L76_170(L77_171, L78_172)
	L77_171 = 50
	L78_172 = L76_170 and L25_119 ~= L78_172 and L74_168 < L77_171 and L54_148 and L31_125 > 0
	L79_173 = L76_170 and L25_119 ~= L79_173 and L75_169 < L77_171 and L57_151 and L31_125 < 0
	L80_174 = L70_164 and (L39_133 or L78_172)
	L81_175 = not L80_174 and L71_165 and (L40_134 or L79_173)
	L82_176 = L7_101.peeking_up
	if L82_176 then
		if L12_106 and L11_105 then
			L82_176 = managers
			L82_176 = L82_176.cover_util
			L83_177 = L82_176
			L82_176 = L82_176.high_cover
			L84_178 = L11_105
			L82_176 = L82_176(L83_177, L84_178)
			if L82_176 then
				A0_94._can_move_to_left_cover = false
			end
		else
			A0_94._can_move_to_left_cover = true
		end
		if L15_109 and L14_108 then
			L82_176 = managers
			L82_176 = L82_176.cover_util
			L83_177 = L82_176
			L82_176 = L82_176.high_cover
			L84_178 = L14_108
			L82_176 = L82_176(L83_177, L84_178)
			if L82_176 then
				A0_94._can_move_to_right_cover = false
			end
		else
			A0_94._can_move_to_right_cover = true
		end
	else
		A0_94._can_move_to_left_cover = true
		A0_94._can_move_to_right_cover = true
	end
	L82_176 = nil
	if L80_174 then
		if L41_135 then
			L83_177 = PlayerInCover
			L83_177 = L83_177.movement
			L82_176 = L83_177.FAST_LEFT
		else
			L83_177 = PlayerInCover
			L83_177 = L83_177.movement
			L82_176 = L83_177.LEFT
		end
	elseif L81_175 then
		if L41_135 then
			L83_177 = PlayerInCover
			L83_177 = L83_177.movement
			L82_176 = L83_177.FAST_RIGHT
		else
			L83_177 = PlayerInCover
			L83_177 = L83_177.movement
			L82_176 = L83_177.RIGHT
		end
	else
		L83_177 = CoverEdgeType
		L83_177 = L83_177.LEFT
		if L25_119 == L83_177 and L42_136 and L39_133 then
			L83_177 = L7_101.peeking_up
			if not L83_177 then
				L83_177 = PlayerInCover
				L83_177 = L83_177.movement
				L82_176 = L83_177.TURN_LEFT
			end
		else
			L83_177 = CoverEdgeType
			L83_177 = L83_177.RIGHT
			if L25_119 == L83_177 and not L42_136 and L40_134 then
				L83_177 = L7_101.peeking_up
				if not L83_177 then
					L83_177 = PlayerInCover
					L83_177 = L83_177.movement
					L82_176 = L83_177.TURN_RIGHT
				end
			else
				L83_177 = PlayerInCover
				L83_177 = L83_177.movement
				L82_176 = L83_177.IDLE
			end
		end
	end
	L83_177 = CoverEdgeType
	L83_177 = L83_177.LEFT
	if L25_119 == L83_177 then
		L83_177 = PlayerData
		L83_177 = L83_177.IN_COVER_POSITION_AT_LEFT_EDGE
		L7_101.in_cover_position = L83_177
	else
		L83_177 = CoverEdgeType
		L83_177 = L83_177.RIGHT
		if L25_119 == L83_177 then
			L83_177 = PlayerData
			L83_177 = L83_177.IN_COVER_POSITION_AT_RIGHT_EDGE
			L7_101.in_cover_position = L83_177
		else
			L83_177 = PlayerData
			L83_177 = L83_177.IN_COVER_POSITION_NOT_AT_EDGE
			L7_101.in_cover_position = L83_177
		end
	end
	L84_178 = A0_94
	L83_177 = A0_94._should_face_right
	L83_177 = L83_177(L84_178, L82_176, L31_125, L32_126)
	L84_178 = managers
	L84_178 = L84_178.cover_util
	L84_178 = L84_178.high_cover
	L84_178 = L84_178(L84_178, A0_94._cover)
	L84_178 = not L84_178
	if L55_149 or L58_152 then
		L16_110 = PlayerInCover.pose.PEEK_SIDE
	elseif L63_157 or L64_158 then
		L16_110 = PlayerInCover.pose.BLIND_FIRE_SIDE
	elseif L66_160 or L67_161 then
		L16_110 = PlayerInCover.pose.BLIND_FIRE_GRENADE_SIDE
	elseif L52_146 then
		L16_110 = PlayerInCover.pose.PEEK_UP
	elseif L62_156 then
		L16_110 = PlayerInCover.pose.BLIND_FIRE_UP
	elseif L65_159 then
		L16_110 = PlayerInCover.pose.BLIND_FIRE_GRENADE_UP
	elseif L61_155 then
		L16_110 = PlayerInCover.pose.FIRE_GRENADE_AWAY_FROM_COVER
	elseif L60_154 then
		L16_110 = PlayerInCover.pose.PRECISION_AIM
	elseif A0_94._player_data.can_aim and L59_153 then
		L16_110 = PlayerInCover.pose.AIM
	else
		L16_110 = PlayerInCover.pose.NEUTRAL
	end
	A0_94:_update_movement_animation(L82_176, L83_177, L84_178)
	A0_94:_update_pose_animation(L16_110)
end
function PlayerInCover.variable_frequency_post_update(A0_179, A1_180)
	local L2_181, L3_182, L4_183, L5_184, L6_185, L7_186, L8_187, L9_188, L10_189, L11_190, L12_191, L13_192, L14_193, L15_194, L16_195
	L2_181 = PlayerMovementState
	L2_181 = L2_181.variable_frequency_post_update
	L3_182 = A0_179
	L4_183 = A1_180
	L2_181(L3_182, L4_183)
	L2_181 = A0_179._input
	L4_183 = A0_179
	L3_182 = A0_179._update_quick_move_infos
	L6_185 = L2_181
	L5_184 = L2_181.quick_move_info_index
	L5_184 = L5_184(L6_185)
	L7_186 = L2_181
	L6_185 = L2_181.quick_move_infos_id
	L16_195 = L6_185(L7_186)
	L3_182(L4_183, L5_184, L6_185, L7_186, L8_187, L9_188, L10_189, L11_190, L12_191, L13_192, L14_193, L15_194, L16_195, L6_185(L7_186))
	L4_183 = A0_179
	L3_182 = A0_179._update_leave_cover
	L5_184 = A1_180
	L6_185 = L2_181
	L3_182 = L3_182(L4_183, L5_184, L6_185)
	if L3_182 then
		L5_184 = A0_179
		L4_183 = A0_179._clear_input
		L4_183(L5_184)
		return
	end
	L5_184 = A0_179
	L4_183 = A0_179._update_enter_outer_cover
	L4_183 = L4_183(L5_184)
	if L4_183 then
		L6_185 = A0_179
		L5_184 = A0_179._clear_input
		L5_184(L6_185)
		return
	end
	L5_184 = A0_179._cover_data_retriever
	L6_185 = L5_184.can_move_over_cover
	L7_186 = A0_179._player_data
	L8_187 = L6_185.is_valid
	if L8_187 then
		L8_187 = L6_185.value
		L7_186.can_move_over_cover = L8_187
	else
		L7_186.can_move_over_cover = false
	end
	L8_187 = A0_179._fire_grenade_input
	if L8_187 then
		L8_187 = A0_179._base
		L9_188 = L8_187
		L8_187 = L8_187.can_secondary_fire
		L8_187 = L8_187(L9_188)
	end
	L9_188 = L7_186.peeking_up
	L9_188 = L9_188 or L7_186.peeking_side
	if L8_187 and L9_188 then
		L10_189 = L7_186.peeking_up
		if L10_189 then
			L10_189 = "idle_fire_grenade"
		else
			L10_189 = L10_189 or "peek_fire_grenade"
		end
		L11_190 = A0_179._unit
		L12_191 = L11_190
		L11_190 = L11_190.play_redirect
		L13_192 = L10_189
		L11_190(L12_191, L13_192)
	else
		L11_190 = A0_179
		L10_189 = A0_179._update_movement_and_pose
		L12_191 = A1_180
		L10_189(L11_190, L12_191)
	end
	L10_189 = A0_179._cover_data_retriever
	L11_190 = L10_189.left_cover
	L12_191 = L11_190.value
	L13_192 = L11_190.is_valid
	L14_193 = L10_189.right_cover
	L15_194 = L14_193.value
	L16_195 = L14_193.is_valid
	A0_179:_update_aim_limitations(L13_192, L12_191, L16_195, L15_194, L7_186.peeking_up)
	A0_179:_clear_input()
end
function PlayerInCover.transition(A0_196)
	if A0_196._base:check_fully_damaged() then
		return (A0_196._base:check_fully_damaged())
	end
	if A0_196._player_data.connected then
		return PlayerConnected:new(A0_196._unit)
	elseif A0_196._player_data.quickmove then
		return PlayerQuickMove:new(A0_196._unit, A0_196._quickmove_target_cover, A0_196._quickmove_target_cover_point)
	elseif A0_196._player_data.leaving_cover then
		return PlayerLeavingCover:new(A0_196._unit)
	elseif not A0_196._player_data.in_cover then
		return PlayerOnGround:new(A0_196._unit)
	elseif A0_196._player_data.cover_outer_position then
		return PlayerInBackCover:new(A0_196._unit, A0_196._cover, A0_196._player_data.cover_point, tweak_data.player.cover.OUTER_POSITION_OFFSET)
	end
end
function PlayerInCover.update(A0_197, A1_198, A2_199)
	if A0_197:transition() then
		return (A0_197:transition())
	end
	PlayerMovementState.update(A0_197, A1_198, A2_199)
	PlayerMovementState._update_aim_parameters(A0_197, A2_199)
	A0_197:_update_mover_activation()
	A0_197._player_data.cover_point = A0_197:_update_adjacent_covers(A2_199)
	A0_197:_update_input()
end
function PlayerInCover._update_aim_limitations(A0_200, A1_201, A2_202, A3_203, A4_204, A5_205)
	local L6_206, L7_207, L8_208, L9_209, L10_210
	L6_206 = A0_200._player_data
	if A5_205 then
		L7_207 = 100
		L8_208 = 20
		L9_209 = A0_200._distance_to_clamped_left_edge
		L9_209 = L9_209 or A0_200._distance_to_left_edge
		L9_209 = L9_209 + L8_208
		L10_210 = A0_200._distance_to_clamped_right_edge
		L10_210 = L10_210 or A0_200._distance_to_right_edge
		L10_210 = L10_210 - L8_208
		if L10_210 < 0 and (not A3_203 or A4_204 and managers.cover_util:high_cover(A4_204)) then
			L6_206.max_yaw_angle, L6_206.min_yaw_angle = L10_210 * 25 / L8_208, nil
		else
			L6_206.min_yaw_angle = _UPVALUE0_(L9_209, A1_201, A2_202)
			if L6_206.min_yaw_angle then
				L6_206.min_yaw_angle = -L6_206.min_yaw_angle
			end
			L6_206.max_yaw_angle = _UPVALUE0_(L10_210, A3_203, A4_204)
		end
		L6_206.min_pitch_angle = tweak_data.player.cover.PEEK_UP_MIN_PITCH_ANGLE
	else
		L6_206.min_yaw_angle = nil
		L6_206.max_yaw_angle = nil
		L6_206.min_pitch_angle = nil
		L6_206.max_pitch_angle = nil
	end
end
function PlayerInCover._should_face_right(A0_211, A1_212, A2_213, A3_214)
	local L4_215, L5_216, L6_217, L9_218, L10_219, L11_220, L12_221, L13_222
	L4_215 = A0_211._player_data
	L5_216 = true
	L6_217 = PlayerInCover
	L6_217 = L6_217._MUST_FACE_DIRECTION_MIN_ANGLE
	L6_217 = A3_214 >= L6_217 and A3_214 <= L6_217
	L9_218 = L6_217 and A2_213 < 0
	L10_219 = L6_217 and A2_213 > 0
	if L9_218 then
		L5_216 = true
	elseif L10_219 then
		L5_216 = false
	else
		L11_220 = PlayerInCover
		L11_220 = L11_220.movement
		L11_220 = L11_220.RIGHT
		L11_220 = A1_212 == L11_220 or A1_212 == L11_220
		L12_221 = PlayerInCover
		L12_221 = L12_221.movement
		L12_221 = L12_221.LEFT
		L12_221 = A1_212 == L12_221 or A1_212 == L12_221
		L13_222 = PlayerInCover
		L13_222 = L13_222.movement
		L13_222 = L13_222.TURN_RIGHT
		L13_222 = A1_212 == L13_222
		L5_216 = (not L4_215.is_precision_aiming and L11_220 or L13_222 or L4_215.facing_right_in_cover) and (L4_215.is_precision_aiming or not L12_221) and not (A1_212 == PlayerInCover.movement.TURN_LEFT)
	end
	return L5_216
end
function PlayerInCover.is_precision_aiming(A0_223)
	return A0_223._player_data.is_precision_aiming
end
function PlayerInCover._update_pose_animation(A0_224, A1_225)
	local L2_226, L3_227
	L3_227 = A0_224._player_data
	if L3_227.peeking_up and A1_225 ~= PlayerInCover.pose.PEEK_UP and not L3_227.throwing_grenade then
		L2_226 = "peek_up_exit"
	elseif L3_227.peeking_side and A1_225 ~= PlayerInCover.pose.PEEK_SIDE and not L3_227.throwing_grenade then
		L2_226 = "peek_side_exit"
	elseif L3_227.blind_firing_up and L3_227.can_shoot and A1_225 ~= PlayerInCover.pose.BLIND_FIRE_UP then
		L2_226 = "blind_fire_up_exit"
	elseif L3_227.blind_firing_side and L3_227.can_shoot and A1_225 ~= PlayerInCover.pose.BLIND_FIRE_SIDE then
		L2_226 = "blind_fire_side_exit"
	else
		L2_226 = PlayerInCover.pose_redirects[A1_225]
	end
	A0_224._unit:play_redirect(L2_226)
end
function PlayerInCover._update_movement_animation(A0_228, A1_229, A2_230, A3_231)
	local L4_232
	if not A0_228._player_data.side_transition_in_cover then
		if A2_230 ~= A0_228._player_data.facing_right_in_cover then
			if A2_230 then
				L4_232 = "change_to_right"
			else
				L4_232 = "change_to_left"
			end
		elseif A3_231 ~= A0_228._player_data.is_crouching then
			if A3_231 then
				L4_232 = "change_to_crouch"
			else
				L4_232 = "change_to_stand"
			end
		end
	end
	if not A0_228._player_data.side_transition_in_cover and not L4_232 then
		L4_232 = _UPVALUE0_(A1_229)
	end
	if L4_232 then
		A0_228._unit:play_redirect(L4_232)
	end
end
function PlayerInCover._position_free_dynamic(A0_233, A1_234, A2_235)
	local L3_236, L4_237, L5_238, L6_239, L7_240
	L3_236 = A2_235
	L4_237 = A0_233._position_free_dynamic_radius
	L5_238 = A0_233._position_free_dynamic_height
	L6_239 = math
	L6_239 = L6_239.UP
	L6_239 = L6_239 * L5_238
	L6_239 = L3_236 + L6_239
	L7_240 = A1_234.find_units
	L7_240 = L7_240(A1_234, "cylinder", L3_236, L6_239, L4_237, A0_233._position_free_dynamic_slot_mask)
	if #L7_240 == 0 then
		return true
	end
	for 