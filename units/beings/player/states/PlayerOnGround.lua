local L0_0
L0_0 = require
L0_0("units/beings/player/states/PlayerMovementState")
L0_0 = require
L0_0("units/beings/player/states/PlayerReviving")
L0_0 = require
L0_0("units/beings/player/states/PlayerPickingUp")
L0_0 = require
L0_0("units/beings/player/states/PlayerQuickMove")
L0_0 = require
L0_0("units/beings/player/states/PlayerWounded")
L0_0 = require
L0_0("units/beings/player/states/PlayerInStationaryWeapon")
L0_0 = require
L0_0("units/beings/player/states/PlayerInBackCover")
L0_0 = require
L0_0("units/beings/player/states/PlayerConnected")
L0_0 = require
L0_0("units/beings/player/ScriptCoverUtils")
L0_0 = PlayerOnGround
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0(PlayerMovementState)
end
PlayerOnGround = L0_0
L0_0 = PlayerOnGround
L0_0._SMALL_ROTATION_ANGLE = 45
L0_0 = PlayerOnGround
L0_0._BIG_ROTATION_ANGLE = 90
L0_0 = PlayerOnGround
L0_0._TURNS = {
	{
		start_angle = 45,
		end_angle = 67.5,
		animation_name = "45"
	},
	{
		start_angle = 67.5,
		end_angle = 112.5,
		animation_name = "90"
	},
	{
		start_angle = 112.5,
		end_angle = nil,
		animation_name = "135"
	}
}
L0_0 = PlayerOnGround
L0_0._AIM_REDIRECTS = {
	"idle_std",
	"idle_std_aim",
	"idle_std_zoom_aim"
}
L0_0 = PlayerOnGround
L0_0._TURN_REDIRECTS = {
	"turn_right_45",
	"turn_right_45_aim",
	"turn_right_45_zoom_aim",
	"turn_left_45",
	"turn_left_45_aim",
	"turn_left_45_zoom_aim"
}
L0_0 = PlayerOnGround
L0_0._MOVEMENT_REDIRECTS = {
	"walk_fwd_blend",
	"walk_fwd_aim",
	"walk_fwd_zoom_aim",
	"walk_bwd_blend",
	"walk_bwd_aim",
	"walk_bwd_zoom_aim",
	"walk_left_blend",
	"walk_left_aim",
	"walk_left_zoom_aim",
	"walk_right_blend",
	"walk_right_aim",
	"walk_right_zoom_aim",
	"run_fwd_blend",
	"run_fwd_aim",
	"run_fwd_zoom_aim",
	"run_bwd_blend",
	"run_bwd_aim",
	"run_bwd_zoom_aim",
	"run_left_blend",
	"run_left_aim",
	"run_left_zoom_aim",
	"run_right_blend",
	"run_right_aim",
	"run_right_zoom_aim"
}
L0_0 = PlayerOnGround
L0_0._ENTER_COVER_REDIRECTS = {
	"enter_cover_leap_crouch_left",
	"enter_cover_leap_crouch_right",
	"enter_cover_leap_stand_left",
	"enter_cover_leap_stand_right",
	"enter_cover_jump_crouch_left",
	"enter_cover_jump_crouch_right",
	"enter_cover_jump_stand_left",
	"enter_cover_jump_stand_right"
}
L0_0 = PlayerOnGround
L0_0._WALK = 1
L0_0 = PlayerOnGround
L0_0._RUN = 13
L0_0 = PlayerOnGround
L0_0._FWD = 0
L0_0 = PlayerOnGround
L0_0._BWD = 1
L0_0 = PlayerOnGround
L0_0._LEFT = 2
L0_0 = PlayerOnGround
L0_0._RIGHT = 3
L0_0 = PlayerOnGround
L0_0._IDLE = 1
L0_0 = PlayerOnGround
L0_0._AIM = 2
L0_0 = PlayerOnGround
L0_0._ZOOM_AIM = 3
L0_0 = PlayerOnGround
L0_0._NUM_AIM_REDIRECTS = 3
L0_0 = PlayerOnGround
L0_0._NUM_TURN_REDIRECTS = 3
L0_0 = PlayerOnGround
L0_0._MAX_SMALL_ANGLE_ROTATION = PlayerOnGround._SMALL_ROTATION_ANGLE * 2 / 3
L0_0 = PlayerOnGround
L0_0._MAX_BIG_ANGLE_ROTATION = PlayerOnGround._BIG_ROTATION_ANGLE * 2 / 3
function L0_0(A0_1, A1_2)
	local L2_3
	L2_3 = A0_1 - A1_2
	if L2_3 > 180 then
		L2_3 = L2_3 - 360
	elseif L2_3 < -180 then
		L2_3 = L2_3 + 360
	end
	return L2_3
end
function PlayerOnGround.init(A0_4, A1_5)
	PlayerMovementState.init(A0_4, A1_5, "PlayerOnGround")
	A0_4._torso = A0_4._machine:get_modifier("ik_torso")
	A0_4._right_hand_aim = A0_4._machine:get_modifier("ik_right_hand_aim")
	A0_4._align_object = A0_4._unit:get_object("a_weapon_right_back")
	A0_4._running_time = 0
	A0_4._prev_move_dir = 1
	A0_4._source_rotation = Rotation()
	A0_4._move_transition_time = 0
	A0_4._players_slot_mask = managers.slot:get_mask("players")
	A0_4._input = A1_5:input()
	A0_4._aim_rotation = A0_4._unit:rotation():roll()
	A0_4._move_rotation = 0
	A0_4._is_turning = false
	A0_4._aim_object = A1_5:get_object("aim")
	A0_4._aiming_smoothing = tweak_data.player.aiming.aiming_smoothing
	A0_4._precision_aim_smoothing_factor = tweak_data.player.aiming.precision_aim_smoothing_factor
	A0_4._movement_smoothing = tweak_data.player.movement.movement_smoothing
	A0_4._yaw_smoothing = tweak_data.player.aiming.yaw_smoothing
	A0_4._pitch_smoothing = tweak_data.player.aiming.pitch_smoothing
	A0_4._max_yaw = tweak_data.player.aiming.max_yaw
	A0_4._min_yaw = tweak_data.player.aiming.min_yaw
	A0_4._walking_fwd_speed = tweak_data.player.movement.speed.walking_fwd
	A0_4._running_fwd_speed = tweak_data.player.movement.speed.running_fwd
	A0_4._stick_limit_run = tweak_data.player.movement.STICK_LIMIT_RUN
	A0_4._fire_trigger_threshold = tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD
	A0_4._polar_to_target = nil
	A0_4._input = A0_4._unit:input()
end
function PlayerOnGround.enter(A0_6)
	local L1_7
	L1_7 = PlayerMovementState
	L1_7 = L1_7.enter
	L1_7(A0_6)
	L1_7 = A0_6._base
	L1_7 = L1_7.activate_mover
	L1_7(L1_7, "stand")
	L1_7 = A0_6._player_data
	L1_7.global_aiming = true
	A0_6._prev_move_dir = 0
	L1_7 = A0_6._unit
	L1_7 = L1_7.rotation
	L1_7 = L1_7(L1_7)
	L1_7 = L1_7.roll
	L1_7 = L1_7(L1_7)
	A0_6._aim_rotation = L1_7
	A0_6._is_turning = false
	L1_7 = A0_6._player_data
	L1_7.can_enter_cover = false
	A0_6._player_to_revive = nil
	L1_7 = A0_6._player_data
	L1_7 = L1_7.move_dir
	L1_7 = L1_7 ~= 0
	A0_6._was_moving = L1_7
	L1_7 = A0_6._was_moving
	if L1_7 then
		L1_7 = A0_6._input
		L1_7 = L1_7.normalized_movement
		L1_7 = L1_7(L1_7)
		A0_6._move_rotation = Rotation(L1_7, math.UP):roll()
	end
end
function PlayerOnGround.leave(A0_8)
	PlayerMovementState.leave(A0_8)
	A0_8._player_data.global_aiming = false
	A0_8._is_turning = false
	A0_8._player_data._mounted_weapon = nil
	A0_8._player_data.can_enter_cover = false
end
function PlayerOnGround._get_player_to_revive(A0_9)
	local L1_10, L2_11, L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18, L10_19, L11_20, L12_21, L13_22, L14_23
	L1_10 = A0_9._players_slot_mask
	L2_11 = A0_9._pos
	L3_12 = A0_9._unit
	L4_13 = L3_12
	L3_12 = L3_12.rotation
	L3_12 = L3_12(L4_13)
	L4_13 = L3_12
	L3_12 = L3_12.y
	L3_12 = L3_12(L4_13)
	L4_13, L5_14 = nil, nil
	L6_15 = A0_9._unit
	L6_15 = L6_15.find_units_quick
	L10_19 = tweak_data
	L10_19 = L10_19.player
	L10_19 = L10_19.revive
	L10_19 = L10_19.MAX_REVIVE_DISTANCE
	L11_20 = L1_10
	L6_15 = L6_15(L7_16, L8_17, L9_18, L10_19, L11_20)
	for L10_19, L11_20 in L7_16(L8_17) do
		L13_22 = L11_20
		L12_21 = L11_20.base
		L12_21 = L12_21(L13_22)
		L13_22 = L12_21
		L12_21 = L12_21.can_be_revived
		L12_21 = L12_21(L13_22)
		if L12_21 then
			L13_22 = L11_20
			L12_21 = L11_20.position
			L12_21 = L12_21(L13_22)
			L12_21 = L12_21 - L2_11
			L13_22 = math
			L13_22 = L13_22.dot
			L14_23 = L12_21
			L13_22 = L13_22(L14_23, L12_21)
			if L13_22 < 0.01 then
				return L11_20
			end
			L14_23 = math
			L14_23 = L14_23.dot
			L14_23 = L14_23(L3_12, L12_21:normalized())
			if math.acos(L14_23) <= tweak_data.player.revive.MAX_REVIVE_ANGLE and (not L5_14 or L5_14 > L13_22) then
				L4_13 = L11_20
				L5_14 = L13_22
			end
		end
	end
	return L4_13
end
function PlayerOnGround._check_if_revive_requested(A0_24)
	A0_24._player_data.can_revive = false
	A0_24._player_data.can_revive = A0_24:_get_player_to_revive() ~= nil
	if A0_24._revive_input and A0_24:_get_player_to_revive() then
		A0_24._unit:play_redirect("revive")
		A0_24._player_to_revive = A0_24:_get_player_to_revive()
		return true
	end
end
function PlayerOnGround._check_if_grenade_requested(A0_25)
	if A0_25._fire_grenade_input and A0_25._base:can_secondary_fire() then
		A0_25._unit:play_redirect("idle_fire_grenade")
	elseif A0_25._player_data._mounted_weapon then
		A0_25._unit:play_redirect("enter_stationary_weapon")
	end
end
function PlayerOnGround._check_if_enter_cover_requested(A0_26, A1_27)
	local L2_28, L3_29, L4_30, L5_31, L6_32, L7_33, L8_34, L9_35, L10_36, L11_37, L12_38, L13_39
	L2_28 = A0_26._enter_cover_input
	L3_29 = A0_26._target_cover_info_input
	L4_30 = A0_26._player_data
	L5_31 = L3_29 ~= nil and not L5_31
	L4_30.can_enter_cover = L5_31
	if not L2_28 then
		return
	end
	if L3_29 then
		L5_31 = A0_26
		L4_30 = A0_26._can_enter_cover
		L6_32 = L3_29
		L4_30 = L4_30(L5_31, L6_32)
		if L4_30 then
			L5_31 = L3_29
			L4_30 = L3_29.closest_cover_point
			L4_30 = L4_30(L5_31)
			L5_31 = L4_30
			L4_30 = L4_30.position
			L4_30 = L4_30(L5_31)
			L5_31 = A0_26._pos
			L4_30 = L4_30 - L5_31
			L5_31 = L4_30
			L4_30 = L4_30.length
			L4_30 = L4_30(L5_31)
			L5_31 = managers
			L5_31 = L5_31.cover_util
			L6_32 = L5_31
			L5_31 = L5_31.high_cover
			L8_34 = L3_29
			L7_33 = L3_29.cover
			L13_39 = L7_33(L8_34)
			L5_31 = L5_31(L6_32, L7_33, L8_34, L9_35, L10_36, L11_37, L12_38, L13_39, L7_33(L8_34))
			L6_32 = A0_26._unit
			L7_33 = L6_32
			L6_32 = L6_32.position
			L6_32 = L6_32(L7_33)
			L6_32 = A1_27 - L6_32
			L7_33 = L6_32
			L6_32 = L6_32.with_z
			L8_34 = 0
			L6_32 = L6_32(L7_33, L8_34)
			L7_33 = L6_32
			L6_32 = L6_32.normalized
			L6_32 = L6_32(L7_33)
			L8_34 = L3_29
			L7_33 = L3_29.cover
			L7_33 = L7_33(L8_34)
			L8_34 = L7_33
			L7_33 = L7_33.right
			L7_33 = L7_33(L8_34)
			L8_34 = L7_33
			L7_33 = L7_33.dot
			L9_35 = L6_32
			L7_33 = L7_33(L8_34, L9_35)
			L7_33 = L7_33 > 0
			if L4_30 < 100 then
				L8_34 = 1
			else
				L8_34 = L8_34 or 5
			end
			if L5_31 then
				L9_35 = 2
			else
				L9_35 = L9_35 or 0
			end
			if L7_33 then
				L10_36 = 1
			else
				L10_36 = L10_36 or 0
			end
			L11_37 = L8_34 + L9_35
			L11_37 = L11_37 + L10_36
			L12_38 = PlayerOnGround
			L12_38 = L12_38._ENTER_COVER_REDIRECTS
			L12_38 = L12_38[L11_37]
			L13_39 = A0_26._unit
			L13_39 = L13_39.play_redirect
			L13_39 = L13_39(L13_39, L12_38)
			L12_38 = L13_39
			if L12_38 ~= "" and L12_38 ~= nil then
				L13_39 = L3_29.cover
				L13_39 = L13_39(L3_29)
				A0_26._quickmove_target_cover = L13_39
				L13_39 = L3_29.closest_cover_point
				L13_39 = L13_39(L3_29)
				A0_26._quickmove_target_cover_point = L13_39
				L13_39 = ScriptCoverUtils
				L13_39 = L13_39.ground_position
				L13_39 = L13_39(A0_26._quickmove_target_cover_point, A0_26._incover_mover_radius)
				A0_26._quickmove_target_cover_point:set_position(L13_39)
			end
		end
	end
end
function PlayerOnGround._check_if_interact_requested(A0_40)
	local L1_41, L2_42, L3_43, L4_44, L5_45, L6_46
	L1_41 = A0_40._player_data
	L2_42 = L1_41.entering_cover
	if not L2_42 then
		L2_42 = L1_41.quickmove
		L2_42 = L2_42 or L1_41.in_cover
	elseif L2_42 then
		L1_41.current_interactable = nil
	end
	L2_42 = L1_41.switching_weapon
	if not L2_42 then
		L2_42 = L1_41.picking_up
		if not L2_42 then
			L2_42 = alive
			L3_43 = L1_41.current_interactable
			L2_42 = L2_42(L3_43)
			if L2_42 then
				L2_42 = A0_40._interact_input
				if L2_42 then
					L2_42 = L1_41.current_interactable
					L4_44 = L2_42
					L3_43 = L2_42.interact
					L3_43 = L3_43(L4_44)
					L4_44 = L3_43
					L3_43 = L3_43.request_interact
					L5_45 = A0_40._unit
					L3_43(L4_44, L5_45)
				else
					L2_42 = L1_41.interact_use
					if not L2_42 then
						L2_42 = L1_41.current_interactable
						L4_44 = L2_42
						L3_43 = L2_42.interact
						L3_43 = L3_43(L4_44)
						L4_44 = A0_40._base
						L5_45 = L4_44
						L4_44 = L4_44.inventory
						L4_44 = L4_44(L5_45)
						L6_46 = L4_44
						L5_45 = L4_44.item
						L5_45 = L5_45(L6_46, L1_41.current_interactable_weapon_name)
						if L5_45 then
							L6_46 = L3_43.request_interact
							L6_46(L3_43, A0_40._unit)
						else
							L6_46 = L3_43.interactable_type
							L6_46 = L6_46(L3_43)
							if L6_46 == "weapon" then
								L6_46 = A0_40._base
								L6_46 = L6_46.weapon_type
								L6_46 = L6_46(L6_46, L1_41.current_interactable_weapon_name)
								if L4_44:find_free_slot(L6_46) ~= nil then
									L3_43:request_interact(A0_40._unit)
								end
							end
						end
					end
				end
			end
		end
	end
end
function PlayerOnGround._update_input(A0_47)
	local L1_48
	L1_48 = A0_47._input
	A0_47._revive_input = A0_47._revive_input or L1_48:revive()
	A0_47._fire_grenade_input = A0_47._fire_grenade_input or L1_48:fire_grenade()
	A0_47._interact_input = A0_47._interact_input or L1_48:interact()
	A0_47._enter_cover_input = A0_47._enter_cover_input or L1_48:enter_cover()
	A0_47._target_cover_info_input = L1_48:target_cover_info() or A0_47._target_cover_info_input
end
function PlayerOnGround._clear_input(A0_49)
	local L1_50
	A0_49._revive_input = nil
	A0_49._fire_grenade_input = nil
	A0_49._interact_input = nil
	A0_49._enter_cover_input = nil
	A0_49._target_cover_info_input = nil
end
function PlayerOnGround._check_input(A0_51)
	if A0_51:_check_if_revive_requested() then
		return
	end
	A0_51:_check_if_grenade_requested()
	A0_51:_check_if_enter_cover_requested(A0_51._input:eye_target_position())
	A0_51:_check_if_interact_requested()
end
function PlayerOnGround.transition(A0_52)
	local L1_53
	L1_53 = A0_52._base
	if L1_53:check_fully_damaged() then
		return (L1_53:check_fully_damaged())
	end
	if A0_52._player_data.is_down then
		A0_52._unit:set_driving("animation")
		return PlayerWounded:new(A0_52._unit)
	elseif A0_52._player_data._in_stationary_weapon then
		A0_52._unit:set_driving("animation")
		assert(A0_52._player_data._mounted_weapon)
		return PlayerInStationaryWeapon:new(A0_52._unit, A0_52._player_data._mounted_weapon)
	elseif A0_52._player_data.picking_up then
		return PlayerPickingUp:new(A0_52._unit)
	elseif A0_52._player_data.connected then
		return PlayerConnected:new(A0_52._unit)
	elseif A0_52._player_data.quickmove then
		assert(A0_52._quickmove_target_cover)
		assert(A0_52._quickmove_target_cover_point)
		A0_52._unit:set_driving("animation")
		return PlayerQuickMove:new(A0_52._unit, A0_52._quickmove_target_cover, A0_52._quickmove_target_cover_point)
	elseif A0_52._player_data.reviving then
		return PlayerReviving:new(A0_52._unit, A0_52._player_to_revive)
	elseif L1_53:check_enter_cover(A0_52._cover_info, A0_52._enter_cover_offset) then
		A0_52._base._cover_data_retriever:enter_cover(A0_52._cover_info:cover())
		return (L1_53:check_enter_cover(A0_52._cover_info, A0_52._enter_cover_offset))
	end
end
function PlayerOnGround.update(A0_54, A1_55, A2_56)
	if A0_54:transition() then
		return (A0_54:transition())
	end
	PlayerMovementState.update(A0_54, A1_55, A2_56)
	A0_54:update_move(A2_56)
	A0_54:_update_input()
end
function PlayerOnGround.variable_frequency_post_update(A0_57, A1_58)
	PlayerMovementState.variable_frequency_post_update(A0_57, A1_58)
	A0_57:_check_input()
	A0_57:_clear_input()
end
function PlayerOnGround._can_enter_cover(A0_59, A1_60)
	local L2_61
	L2_61 = A0_59._input
	L2_61 = L2_61.target_cover_use_outer_position
	L2_61 = L2_61(L2_61)
	return managers.cover_util:can_enter_cover(A0_59._unit, A1_60, tweak_data.player.cover.MAX_ENTER_DISTANCE, L2_61)
end
function PlayerOnGround.debug_draw(A0_62)
	local L1_63
	L1_63 = A0_62._input
	L1_63 = L1_63.aim_target_position
	L1_63 = L1_63(L1_63)
	Draw:brush(1, 0, 0):sphere(L1_63, 10)
end
function PlayerOnGround._get_turn(A0_64, A1_65)
	for 