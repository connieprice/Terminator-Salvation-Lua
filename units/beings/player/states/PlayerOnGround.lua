require("units/beings/player/states/PlayerMovementState")
require("units/beings/player/states/PlayerReviving")
require("units/beings/player/states/PlayerPickingUp")
require("units/beings/player/states/PlayerQuickMove")
require("units/beings/player/states/PlayerWounded")
require("units/beings/player/states/PlayerInStationaryWeapon")
require("units/beings/player/states/PlayerInBackCover")
require("units/beings/player/states/PlayerConnected")
require("units/beings/player/ScriptCoverUtils")
if not PlayerOnGround then
	PlayerOnGround = class(PlayerMovementState)
end
PlayerOnGround._SMALL_ROTATION_ANGLE = 45
PlayerOnGround._BIG_ROTATION_ANGLE = 90
local l_0_0 = PlayerOnGround
local l_0_1 = {}
local l_0_2 = {}
l_0_2.start_angle = 45
l_0_2.end_angle = 67.5
l_0_2.animation_name = "45"
local l_0_3 = {}
l_0_3.start_angle = 67.5
l_0_3.end_angle = 112.5
l_0_3.animation_name = "90"
local l_0_4 = {}
l_0_4.start_angle = 112.5
l_0_4.end_angle = nil
l_0_4.animation_name = "135"
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

l_0_0._TURNS = l_0_1
l_0_0 = PlayerOnGround
l_0_2 = "idle_std"
l_0_3 = "idle_std_aim"
l_0_4 = "idle_std_zoom_aim"
l_0_0._AIM_REDIRECTS, l_0_1 = l_0_1, {l_0_2, l_0_3, l_0_4}
l_0_0 = PlayerOnGround
l_0_2 = "turn_right_45"
l_0_3 = "turn_right_45_aim"
l_0_4 = "turn_right_45_zoom_aim"
l_0_0._TURN_REDIRECTS, l_0_1 = l_0_1, {l_0_2, l_0_3, l_0_4, "turn_left_45", "turn_left_45_aim", "turn_left_45_zoom_aim"}
l_0_0 = PlayerOnGround
l_0_2 = "walk_fwd_blend"
l_0_3 = "walk_fwd_aim"
l_0_4 = "walk_fwd_zoom_aim"
l_0_0._MOVEMENT_REDIRECTS, l_0_1 = l_0_1, {l_0_2, l_0_3, l_0_4, "walk_bwd_blend", "walk_bwd_aim", "walk_bwd_zoom_aim", "walk_left_blend", "walk_left_aim", "walk_left_zoom_aim", "walk_right_blend", "walk_right_aim", "walk_right_zoom_aim", "run_fwd_blend", "run_fwd_aim", "run_fwd_zoom_aim", "run_bwd_blend", "run_bwd_aim", "run_bwd_zoom_aim", "run_left_blend", "run_left_aim", "run_left_zoom_aim", "run_right_blend", "run_right_aim", "run_right_zoom_aim"}
l_0_0 = PlayerOnGround
l_0_2 = "enter_cover_leap_crouch_left"
l_0_3 = "enter_cover_leap_crouch_right"
l_0_4 = "enter_cover_leap_stand_left"
l_0_0._ENTER_COVER_REDIRECTS, l_0_1 = l_0_1, {l_0_2, l_0_3, l_0_4, "enter_cover_leap_stand_right", "enter_cover_jump_crouch_left", "enter_cover_jump_crouch_right", "enter_cover_jump_stand_left", "enter_cover_jump_stand_right"}
l_0_0 = PlayerOnGround
l_0_0._WALK = 1
l_0_0 = PlayerOnGround
l_0_0._RUN = 13
l_0_0 = PlayerOnGround
l_0_0._FWD = 0
l_0_0 = PlayerOnGround
l_0_0._BWD = 1
l_0_0 = PlayerOnGround
l_0_0._LEFT = 2
l_0_0 = PlayerOnGround
l_0_0._RIGHT = 3
l_0_0 = PlayerOnGround
l_0_0._IDLE = 1
l_0_0 = PlayerOnGround
l_0_0._AIM = 2
l_0_0 = PlayerOnGround
l_0_0._ZOOM_AIM = 3
l_0_0 = PlayerOnGround
l_0_0._NUM_AIM_REDIRECTS = 3
l_0_0 = PlayerOnGround
l_0_0._NUM_TURN_REDIRECTS = 3
l_0_0 = PlayerOnGround
l_0_1 = PlayerOnGround
l_0_1 = l_0_1._SMALL_ROTATION_ANGLE
l_0_1 = l_0_1 * 2
l_0_1 = l_0_1 / 3
l_0_0._MAX_SMALL_ANGLE_ROTATION = l_0_1
l_0_0 = PlayerOnGround
l_0_1 = PlayerOnGround
l_0_1 = l_0_1._BIG_ROTATION_ANGLE
l_0_1 = l_0_1 * 2
l_0_1 = l_0_1 / 3
l_0_0._MAX_BIG_ANGLE_ROTATION = l_0_1
l_0_0 = function(l_1_0, l_1_1)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		if l_1_0 - l_1_1 > 180 then
			local l_1_2 = l_1_0 - l_1_1 - 360
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_1_2 < -180 then
		local l_1_3 = l_1_2 + 360
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_1_3
end

l_0_1 = function(l_2_0, l_2_1, l_2_2)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		if l_2_1 - l_2_0 > 180 and l_2_0 < 0 and l_2_1 > 0 then
			local l_2_3 = l_2_1 - l_2_0 - 360
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_2_3 < -180 and l_2_1 < 0 and l_2_0 > 0 then
		local l_2_4, l_2_5, l_2_7 = l_2_3 + 360
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	do
		if l_2_0 + l_2_4 * math.min(l_2_2, 1) > 180 then
			local l_2_6 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_2_0 + l_2_4 * math.min(l_2_2, 1) - 360 <= -180 then
		local l_2_8 = nil
	end
	return l_2_0 + l_2_4 * math.min(l_2_2, 1) - 360 + 360
end

l_0_2 = PlayerOnGround
l_0_3 = function(l_3_0, l_3_1)
	PlayerMovementState.init(l_3_0, l_3_1, "PlayerOnGround")
	l_3_0._torso = l_3_0._machine:get_modifier("ik_torso")
	l_3_0._right_hand_aim = l_3_0._machine:get_modifier("ik_right_hand_aim")
	l_3_0._align_object = l_3_0._unit:get_object("a_weapon_right_back")
	l_3_0._running_time = 0
	l_3_0._prev_move_dir = 1
	l_3_0._source_rotation = Rotation()
	l_3_0._move_transition_time = 0
	l_3_0._players_slot_mask = managers.slot:get_mask("players")
	l_3_0._input = l_3_1:input()
	l_3_0._aim_rotation = l_3_0._unit:rotation():roll()
	l_3_0._move_rotation = 0
	l_3_0._is_turning = false
	l_3_0._aim_object = l_3_1:get_object("aim")
	l_3_0._aiming_smoothing = tweak_data.player.aiming.aiming_smoothing
	l_3_0._precision_aim_smoothing_factor = tweak_data.player.aiming.precision_aim_smoothing_factor
	l_3_0._movement_smoothing = tweak_data.player.movement.movement_smoothing
	l_3_0._yaw_smoothing = tweak_data.player.aiming.yaw_smoothing
	l_3_0._pitch_smoothing = tweak_data.player.aiming.pitch_smoothing
	l_3_0._max_yaw = tweak_data.player.aiming.max_yaw
	l_3_0._min_yaw = tweak_data.player.aiming.min_yaw
	l_3_0._walking_fwd_speed = tweak_data.player.movement.speed.walking_fwd
	l_3_0._running_fwd_speed = tweak_data.player.movement.speed.running_fwd
	l_3_0._stick_limit_run = tweak_data.player.movement.STICK_LIMIT_RUN
	l_3_0._fire_trigger_threshold = tweak_data.player.weapon.FIRE_TRIGGER_THRESHOLD
	l_3_0._polar_to_target = nil
	l_3_0._input = l_3_0._unit:input()
end

l_0_2.init = l_0_3
l_0_2 = PlayerOnGround
l_0_3 = function(l_4_0)
	PlayerMovementState.enter(l_4_0)
	l_4_0._base:activate_mover("stand")
	l_4_0._player_data.global_aiming = true
	l_4_0._prev_move_dir = 0
	l_4_0._aim_rotation = l_4_0._unit:rotation():roll()
	l_4_0._is_turning = false
	l_4_0._player_data.can_enter_cover = false
	l_4_0._player_to_revive = nil
	l_4_0._was_moving = l_4_0._player_data.move_dir ~= 0
	if l_4_0._was_moving then
		local l_4_3 = l_4_0._input:normalized_movement()
		l_4_0._move_rotation = Rotation(l_4_3, math.UP):roll()
	end
end

l_0_2.enter = l_0_3
l_0_2 = PlayerOnGround
l_0_3 = function(l_5_0)
	PlayerMovementState.leave(l_5_0)
	l_5_0._player_data.global_aiming = false
	l_5_0._is_turning = false
	l_5_0._player_data._mounted_weapon = nil
	l_5_0._player_data.can_enter_cover = false
end

l_0_2.leave = l_0_3
l_0_2 = PlayerOnGround
l_0_3 = function(l_6_0)
	local l_6_1 = l_6_0._players_slot_mask
	local l_6_2 = l_6_0._pos
	local l_6_3 = (l_6_0._unit:rotation():y())
	local l_6_4, l_6_5 = nil, nil
	local l_6_10 = l_6_0._unit:find_units_quick
	local l_6_11 = l_6_0._unit
	l_6_10 = l_6_10(l_6_11, "sphere", l_6_2, tweak_data.player.revive.MAX_REVIVE_DISTANCE, l_6_1)
	local l_6_6 = nil
	l_6_11 = pairs
	l_6_6 = l_6_10
	l_6_11 = l_6_11(l_6_6)
	for i_0,i_1 in l_6_11 do
		if l_6_9:base():can_be_revived() then
			local l_6_12 = l_6_9:position() - l_6_2
			local l_6_13 = math.dot(l_6_12, l_6_12)
			if l_6_13 < 0.01 then
				return l_6_9
			end
			local l_6_14 = math.dot(l_6_3, l_6_12:normalized())
		if math.acos(l_6_14) <= tweak_data.player.revive.MAX_REVIVE_ANGLE and (not l_6_5 or l_6_13 < l_6_5) then
			end
			l_6_4 = l_6_9
			l_6_5 = l_6_13
		end
	end
	return l_6_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_2._get_player_to_revive = l_0_3
l_0_2 = function(l_7_0, l_7_1)
	local l_7_2 = l_7_1:cover()
	local l_7_3 = l_7_2:right()
	local l_7_4 = false
	if math.dot(l_7_0, l_7_3) > 0 then
		l_7_4 = true
	end
	local l_7_5 = l_7_1:closest_cover_point():edge()
	local l_7_6, l_7_7 = managers.cover:get_adjacent_covers(l_7_2, tweak_data.player.cover.MAX_ADJACENT_EDGE_TO_EDGE_DISTANCE, tweak_data.player.cover.MIN_ADJACENT_ANGLE, tweak_data.player.cover.MAX_ADJACENT_ANGLE)
	do
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if (l_7_5 ~= CoverEdgeType.LEFT or l_7_6 ~= nil) and (l_7_5 ~= CoverEdgeType.RIGHT or l_7_7 ~= nil) then
			local l_7_8 = l_7_4
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_7_8
	end
end

l_0_3 = PlayerOnGround
l_0_4 = function(l_8_0)
	l_8_0._player_data.can_revive = false
	local l_8_1 = l_8_0:_get_player_to_revive()
	local l_8_2 = l_8_0._player_data
	l_8_2.can_revive = l_8_1 ~= nil
	l_8_2 = l_8_0._revive_input
	if l_8_2 and l_8_1 then
		l_8_2 = l_8_0._unit
		l_8_2(l_8_2, "revive")
		l_8_0._player_to_revive = l_8_1
		 -- DECOMPILER ERROR: Overwrote pending register.

		return l_8_2
	end
end

l_0_3._check_if_revive_requested = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_9_0)
	if l_9_0._fire_grenade_input and l_9_0._base:can_secondary_fire() then
		l_9_0._unit:play_redirect("idle_fire_grenade")
	else
		if l_9_0._player_data._mounted_weapon then
			l_9_0._unit:play_redirect("enter_stationary_weapon")
		end
	end
end

l_0_3._check_if_grenade_requested = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0._enter_cover_input
	local l_10_3 = l_10_0._target_cover_info_input
	local l_10_4 = l_10_0._player_data
	if l_10_3 ~= nil then
		local l_10_5 = not l_10_0._player_data.in_cover
	else
		l_10_4.can_enter_cover = false
		if not l_10_2 then
			return 
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_10_3 and l_10_4 then
			local l_10_6 = managers.cover_util:high_cover(l_10_3:cover())
			local l_10_7 = l_10_1 - l_10_0._unit:position():with_z(0):normalized()
			do
				local l_10_11 = l_10_3:cover():right():dot(l_10_7) > 0
			do
				end
				local l_10_12 = nil
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			do
				local l_10_13 = nil
			end
			local l_10_14 = nil
			local l_10_15 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_10_0._unit:play_redirect(PlayerOnGround._ENTER_COVER_REDIRECTS[(l_10_4 < 100 and 1 or 5) + (l_10_6 and 2 or 0) + (l_10_12 and 1 or 0)]) ~= "" and l_10_0._unit:play_redirect(PlayerOnGround._ENTER_COVER_REDIRECTS[(l_10_4 < 100 and 1 or 5) + (l_10_6 and 2 or 0) + (l_10_12 and 1 or 0)]) ~= nil then
			end
			l_10_0._quickmove_target_cover = l_10_3:cover()
			l_10_0._quickmove_target_cover_point = l_10_3:closest_cover_point()
			local l_10_16 = nil
			l_10_0._quickmove_target_cover_point:set_position(ScriptCoverUtils.ground_position(l_10_0._quickmove_target_cover_point, l_10_0._incover_mover_radius))
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 12 
end

l_0_3._check_if_enter_cover_requested = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_11_0)
	local l_11_1 = l_11_0._player_data
	if l_11_1.entering_cover or l_11_1.quickmove or l_11_1.in_cover then
		l_11_1.current_interactable = nil
	end
	if not l_11_1.switching_weapon and not l_11_1.picking_up and alive(l_11_1.current_interactable) then
		if l_11_0._interact_input then
			local l_11_2 = l_11_1.current_interactable
			l_11_2:interact():request_interact(l_11_0._unit)
		end
	elseif not l_11_1.interact_use then
		local l_11_3 = l_11_1.current_interactable
		local l_11_4 = l_11_3:interact()
		local l_11_5 = l_11_0._base:inventory()
		local l_11_6 = l_11_5:item(l_11_1.current_interactable_weapon_name)
		if l_11_6 then
			l_11_4:request_interact(l_11_0._unit)
		end
	else
		if l_11_4:interactable_type() == "weapon" then
			local l_11_7 = l_11_0._base:weapon_type(l_11_1.current_interactable_weapon_name)
			local l_11_8 = l_11_5:find_free_slot(l_11_7)
		if l_11_8 ~= nil then
			end
			l_11_4:request_interact(l_11_0._unit)
		end
	end
end

l_0_3._check_if_interact_requested = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_12_0)
	local l_12_1 = l_12_0._input
	if not l_12_0._revive_input then
		l_12_0._revive_input = l_12_1:revive()
	end
	if not l_12_0._fire_grenade_input then
		l_12_0._fire_grenade_input = l_12_1:fire_grenade()
	end
	if not l_12_0._interact_input then
		l_12_0._interact_input = l_12_1:interact()
	end
	if not l_12_0._enter_cover_input then
		l_12_0._enter_cover_input = l_12_1:enter_cover()
	end
	if not l_12_1:target_cover_info() then
		l_12_0._target_cover_info_input = l_12_0._target_cover_info_input
	end
end

l_0_3._update_input = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_13_0)
	l_13_0._revive_input = nil
	l_13_0._fire_grenade_input = nil
	l_13_0._interact_input = nil
	l_13_0._enter_cover_input = nil
	l_13_0._target_cover_info_input = nil
end

l_0_3._clear_input = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_14_0)
	if l_14_0:_check_if_revive_requested() then
		return 
	end
	l_14_0:_check_if_grenade_requested()
	l_14_0:_check_if_enter_cover_requested(l_14_0._input:eye_target_position())
	l_14_0:_check_if_interact_requested()
end

l_0_3._check_input = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_15_0)
	local l_15_7, l_15_8, l_15_13, l_15_18, l_15_23 = nil
	local l_15_1 = l_15_0._base
	local l_15_2 = l_15_1:check_fully_damaged()
	if l_15_2 then
		return l_15_2
	end
	local l_15_3 = l_15_0._player_data
	if l_15_3.is_down then
		l_15_0._unit:set_driving("animation")
		local l_15_4, l_15_5 = PlayerWounded:new, PlayerWounded
		local l_15_6 = l_15_0._unit
		return l_15_4(l_15_5, l_15_6)
	elseif l_15_3._in_stationary_weapon then
		l_15_0._unit:set_driving("animation")
		assert(l_15_3._mounted_weapon)
		local l_15_9, l_15_10 = PlayerInStationaryWeapon:new, PlayerInStationaryWeapon
		local l_15_11 = l_15_0._unit
		local l_15_12, l_15_17, l_15_22 = l_15_3._mounted_weapon
		return l_15_9(l_15_10, l_15_11, l_15_12)
	elseif l_15_3.picking_up then
		local l_15_14, l_15_15 = PlayerPickingUp:new, PlayerPickingUp
		local l_15_16 = l_15_0._unit
		return l_15_14(l_15_15, l_15_16)
	elseif l_15_3.connected then
		local l_15_19, l_15_20 = PlayerConnected:new, PlayerConnected
		local l_15_21 = l_15_0._unit
		return l_15_19(l_15_20, l_15_21)
	elseif l_15_3.quickmove then
		assert(l_15_0._quickmove_target_cover)
		assert(l_15_0._quickmove_target_cover_point)
		l_15_0._unit:set_driving("animation")
		local l_15_24, l_15_25 = PlayerQuickMove:new, PlayerQuickMove
		local l_15_26 = l_15_0._unit
		local l_15_27 = l_15_0._quickmove_target_cover
		local l_15_28, l_15_33 = l_15_0._quickmove_target_cover_point
		return l_15_24(l_15_25, l_15_26, l_15_27, l_15_28)
	elseif l_15_3.reviving then
		local l_15_29, l_15_30 = PlayerReviving:new, PlayerReviving
		local l_15_31 = l_15_0._unit
		local l_15_32 = l_15_0._player_to_revive
		return l_15_29(l_15_30, l_15_31, l_15_32)
	else
		local l_15_34 = l_15_1:check_enter_cover(l_15_0._cover_info, l_15_0._enter_cover_offset)
	if l_15_34 then
		end
		l_15_0._base._cover_data_retriever:enter_cover(l_15_0._cover_info:cover())
		return l_15_34
	end
end

l_0_3.transition = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_16_0, l_16_1, l_16_2)
	local l_16_3 = l_16_0:transition()
	if l_16_3 then
		return l_16_3
	end
	PlayerMovementState.update(l_16_0, l_16_1, l_16_2)
	l_16_0:update_move(l_16_2)
	l_16_0:_update_input()
end

l_0_3.update = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_17_0, l_17_1)
	PlayerMovementState.variable_frequency_post_update(l_17_0, l_17_1)
	l_17_0:_check_input()
	l_17_0:_clear_input()
end

l_0_3.variable_frequency_post_update = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_18_0, l_18_1)
	local l_18_2 = l_18_0._input:target_cover_use_outer_position()
	local l_18_3, l_18_4 = managers.cover_util:can_enter_cover, managers.cover_util
	local l_18_5 = l_18_0._unit
	local l_18_6 = l_18_1
	local l_18_7 = tweak_data.player.cover.MAX_ENTER_DISTANCE
	local l_18_8 = l_18_2
	return l_18_3(l_18_4, l_18_5, l_18_6, l_18_7, l_18_8)
end

l_0_3._can_enter_cover = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_19_0)
	local l_19_1 = l_19_0._input:aim_target_position()
	local l_19_2 = Draw:brush(1, 0, 0)
	l_19_2:sphere(l_19_1, 10)
end

l_0_3.debug_draw = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_20_0, l_20_1)
	local l_20_5, l_20_6, l_20_7, l_20_8, l_20_9, l_20_10, l_20_11, l_20_12 = nil
	for i_0,i_1 in ipairs(PlayerOnGround._TURNS) do
		if i_1.start_angle <= l_20_1 and (not i_1.end_angle or l_20_1 < i_1.end_angle) then
			return i_1
		end
	end
end

l_0_3._get_turn = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_21_0, l_21_1, l_21_2, l_21_3)
	-- upvalues: l_0_1 , l_0_0
	local l_21_4 = l_21_0._player_data
	local l_21_5 = PlayerOnGround._FWD
	local l_21_6 = l_21_0._input
	local l_21_7 = Rotation(l_21_2, math.UP):roll()
	local l_21_8 = 0
	if l_21_0._was_moving then
		l_21_0._move_rotation = l_0_1(l_21_0._move_rotation, l_21_7, l_21_1 * l_21_0._movement_smoothing)
		local l_21_9 = l_0_0(l_21_0._move_rotation, l_21_3)
		local l_21_10 = l_21_4.yaw_pos_angle
		local l_21_11 = l_21_4.yaw_neg_angle
		local l_21_12 = l_21_0._max_yaw
		local l_21_13 = l_21_0._min_yaw
		if l_21_9 > 0 and l_21_9 <= l_21_12 then
			l_21_8 = l_21_9 / l_21_10
			l_21_5 = PlayerOnGround._FWD
		elseif l_21_9 <= 0 and -l_21_13 <= l_21_9 then
			l_21_8 = l_21_9 / l_21_11
			l_21_5 = PlayerOnGround._FWD
		elseif 180 - l_21_12 < l_21_9 then
			l_21_8 = (l_21_9 - 180) / l_21_10
			l_21_5 = PlayerOnGround._BWD
		elseif l_21_9 < l_21_13 - 180 then
			l_21_8 = (180 + l_21_9) / l_21_11
			l_21_5 = PlayerOnGround._BWD
		elseif 90 - l_21_12 < l_21_9 and l_21_9 <= 90 then
			l_21_8 = (l_21_9 - 90) / l_21_10
			l_21_5 = PlayerOnGround._LEFT
		elseif l_21_9 > 90 and l_21_9 <= 180 - l_21_13 then
			l_21_8 = (l_21_9 - 90) / l_21_11
			l_21_5 = PlayerOnGround._LEFT
		elseif l_21_9 < l_21_13 - 90 and l_21_9 >= -90 then
			l_21_8 = (90 + l_21_9) / l_21_11
			l_21_5 = PlayerOnGround._RIGHT
		else
			l_21_8 = (90 + l_21_9) / l_21_10
			l_21_5 = PlayerOnGround._RIGHT
		end
	else
		l_21_0._move_rotation = l_21_7
	end
	l_21_4.local_yaw_normalized = l_21_8
	return l_21_5
end

l_0_3._update_movement_target = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_22_0, l_22_1, l_22_2)
	local l_22_3, l_22_4, l_22_5, l_22_6 = l_22_0:_get_aim_constraints()
	local l_22_7 = l_22_0._polar_to_target
	local l_22_8 = l_22_7.pitch
	if l_22_8 <= 0 or not l_22_8 / l_22_4 then
		local l_22_9 = l_22_8 / l_22_3
	end
	local l_22_10 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_22_0._player_data.local_pitch_normalized = l_22_0._player_data.local_pitch_normalized + (l_22_10 - l_22_0._player_data.local_pitch_normalized) * math.min(l_22_1 * l_22_0._pitch_smoothing * l_22_2, 1)
	local l_22_11 = nil
	l_22_0._base:_update_aim_parameters(l_22_1, l_22_3, l_22_4, l_22_5, l_22_6, false, l_22_0:_limit_aim_acceleration())
end

l_0_3._update_aim_parameters = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_23_0)
	local l_23_1 = Draw:brush()
	local l_23_2 = 5
	local l_23_3 = l_23_0._unit:look():eye_position()
	local l_23_4 = Color(0, 0, 1)
	local l_23_5 = Color(1, 0, 0)
	local l_23_6 = Color(1, 1, 1)
	local l_23_7 = Color(0, 1, 0)
	l_23_1:set_color(l_23_5)
	l_23_1:sphere(l_23_0._input:aim_target_position(), l_23_2)
	l_23_1:line(l_23_3, l_23_0._input:aim_target_position())
	l_23_1:set_color(l_23_7)
	local l_23_8 = l_23_0._input:normalized_movement()
	l_23_1:line(l_23_3, l_23_3 + l_23_8 * 200)
	l_23_1:sphere(l_23_3 + l_23_8 * 200, l_23_2)
end

l_0_3._debug_render_eye_target = l_0_4
l_0_3 = PlayerOnGround
l_0_4 = function(l_24_0, l_24_1)
	-- upvalues: l_0_1 , l_0_0
	local l_24_2 = l_24_0._player_data
	local l_24_3 = l_24_0._input
	l_24_0._polar_to_target = l_24_3:aim_target_position() - l_24_0._aim_object:position():to_polar()
	local l_24_4 = l_24_0._polar_to_target.spin - 90
	if not l_24_2.reloading and not l_24_3:precision_aiming() then
		if l_24_0._fire_trigger_threshold < l_24_3:fire() or l_24_0._fire_trigger_threshold < l_24_2.fire_input then
			local l_24_5 = not l_24_2.can_aim
		end
	else
		local l_24_6 = false
	end
	local l_24_7 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_24_7 then
		do return end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_24_0._aim_rotation = l_0_1(l_24_0._aim_rotation, l_24_4, l_24_1 * l_24_0._aiming_smoothing * nil)
	local l_24_8 = nil
	do
		local l_24_9 = l_24_3:aiming()
		if l_24_3:movement_length() <= 0 then
			local l_24_10 = nil
			if (not l_24_7 or not PlayerOnGround._ZOOM_AIM) and (not l_24_9 or not PlayerOnGround._AIM) then
				local l_24_11 = l_24_0._unit:rotation()
			end
			local l_24_12 = nil
			l_24_0._unit:play_redirect(PlayerOnGround._AIM_REDIRECTS[PlayerOnGround._IDLE])
			local l_24_13 = nil
			if not l_24_7 then
				local l_24_14 = nil
			else
				local l_24_15 = nil
			end
			local l_24_16 = nil
			if l_0_0(l_24_12:roll(), l_24_0._aim_rotation) >= 0 then
				local l_24_19 = nil
				l_24_0._unit:set_rotation(Rotation(0, 0, l_0_1(l_24_12:roll(), l_24_0._rotate_to, l_24_1 * l_24_0._rotate_with * l_24_8)))
				do
					local l_24_20 = false
					 -- DECOMPILER ERROR: Confused about usage of registers!

				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_0_1(l_24_12:roll(), l_24_0._rotate_to, l_24_1 * l_24_0._rotate_with * l_24_8) - l_24_0._rotate_to >= 1 or l_0_1(l_24_12:roll(), l_24_0._rotate_to, l_24_1 * l_24_0._rotate_with * l_24_8) - l_24_0._rotate_to <= -1 or l_24_19 >= 0 then
					do return end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Overwrote pending register.

				if l_24_19 < 0 then
					l_24_2.local_yaw_normalized = l_24_2.local_yaw_normalized + (0 - l_24_2.local_yaw_normalized) * math.min(l_24_1 * l_24_0._yaw_smoothing * l_24_8, 1)
					l_24_0._was_moving = false
					l_24_0._move_rotation = 0
				else
					local l_24_21 = nil
					if l_24_21 >= l_24_0._stick_limit_run then
						local l_24_22 = l_24_3:normalized_movement()
						do
							local l_24_23, l_24_24 = l_24_7
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						if not l_24_23 or not PlayerOnGround._WALK then
							local l_24_25 = nil
						end
						if (not l_24_7 or not PlayerOnGround._ZOOM_AIM) and (not l_24_9 or not PlayerOnGround._AIM) then
							local l_24_26 = nil
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						if not l_24_26 or not l_24_0._walking_fwd_speed * l_24_2.walking_speed then
							local l_24_27 = nil
						end
						local l_24_28 = nil
						local l_24_29 = PlayerOnGround._RUN
						 -- DECOMPILER ERROR: Overwrote pending register.

						if l_24_0._was_moving then
							do return end
						end
						 -- DECOMPILER ERROR: Confused about usage of registers!

						 -- DECOMPILER ERROR: Overwrote pending register.

						l_24_0._unit:play_redirect(nil)
						l_24_0._unit:set_rotation(Rotation(0, 0, l_24_0._aim_rotation))
						local l_24_30 = nil
						local l_24_31 = nil
						l_24_0._unit:move(Vector3(0, l_24_0._running_fwd_speed * l_24_2.running_speed * l_24_1, 0):rotate_with(Rotation(0, 0, l_24_0._move_rotation)))
						l_24_0._was_moving = true
						l_24_0._running_time = l_24_0._running_time + l_24_1
					if l_24_0._is_turning then
						end
						l_24_0._is_turning = false
					end
					l_24_0:_update_aim_parameters(l_24_1, l_24_8)
				end
				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 113 158 182 
end

l_0_3.update_move = l_0_4
l_0_4 = "idle_small"
l_0_4 = PlayerOnGround
l_0_4._idle_redirects = function(l_25_0)
	-- upvalues: l_0_3
	return l_0_3
end


