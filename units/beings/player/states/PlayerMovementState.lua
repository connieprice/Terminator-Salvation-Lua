require("shared/updatescheduler/UpdateSchedulerDtMethod")
PlayerMovementState = PlayerMovementState or class()
function PlayerMovementState.init(A0_0, A1_1, A2_2)
	local L3_3
	A0_0._unit = A1_1
	A0_0._name = A2_2
	L3_3 = A1_1.base
	L3_3 = L3_3(A1_1)
	A0_0._base = L3_3
	L3_3 = managers
	L3_3 = L3_3.slot
	L3_3 = L3_3.get_mask
	L3_3 = L3_3(L3_3, "standable")
	A0_0._slotmask_standable = L3_3
	L3_3 = A0_0._unit
	L3_3 = L3_3.anim_state_machine
	L3_3 = L3_3(L3_3)
	A0_0._machine = L3_3
	L3_3 = A0_0._unit
	L3_3 = L3_3.player_data
	L3_3 = L3_3(L3_3)
	A0_0._player_data = L3_3
	A0_0._idle_time = 0
	L3_3 = A0_0._update_time_until_idle_animation
	L3_3(A0_0)
	A0_0._base_state = "onground/rifle/idle/std"
	L3_3 = A1_1.position
	L3_3 = L3_3(A1_1)
	A0_0._pos = L3_3
	L3_3 = A0_0._unit
	L3_3 = L3_3.mover_by_name
	L3_3 = L3_3(L3_3, "in_cover")
	assert(L3_3)
	A0_0._incover_mover_radius = L3_3:radius()
	A0_0._was_upperbody_idle = false
end
function PlayerMovementState.enter(A0_4)
	local L1_5
end
function PlayerMovementState.leave(A0_6)
	local L1_7
end
function PlayerMovementState.name(A0_8)
	local L1_9
	L1_9 = A0_8._name
	return L1_9
end
function PlayerMovementState.update(A0_10, A1_11, A2_12)
	A0_10:update_common(A1_11, A2_12)
end
function PlayerMovementState.variable_frequency_post_update(A0_13, A1_14)
	A0_13:_update_idle(A1_14)
end
function PlayerMovementState.update_common(A0_15, A1_16, A2_17)
	A0_15._pos = A0_15._unit:position()
end
function PlayerMovementState._limit_aim_acceleration(A0_18)
	local L1_19, L2_20
	L1_19 = A0_18._player_data
	L2_20 = L1_19.can_shoot
	L2_20 = L2_20 and not L2_20 and not L2_20
	return L2_20
end
function PlayerMovementState._update_aim_parameters(A0_21, A1_22)
	local L2_23, L3_24, L4_25, L5_26, L6_27, L7_28
	L3_24 = A0_21
	L2_23 = A0_21._get_aim_constraints
	L5_26 = L2_23(L3_24)
	L6_27 = A0_21._player_data
	L7_28 = A0_21._limit_aim_acceleration
	L7_28 = L7_28(A0_21)
	A0_21._base:_update_aim_parameters(A1_22, L2_23, L3_24, L4_25, L5_26, false, L7_28)
end
function PlayerMovementState._get_aim_constraints(A0_29, A1_30)
	local L2_31, L3_32, L4_33, L5_34, L6_35
	L2_31 = A0_29._player_data
	L3_32 = L2_31.pitch_neg_angle
	L4_33 = L2_31.pitch_pos_angle
	L5_34 = L2_31.yaw_neg_angle
	L6_35 = L2_31.yaw_pos_angle
	return L3_32, L4_33, L5_34, L6_35
end
function PlayerMovementState._play_random_redirect(A0_36, A1_37)
	local L2_38, L3_39, L4_40
	L2_38 = #A1_37
	if L2_38 > 0 then
		L3_39 = math
		L3_39 = L3_39.random
		L4_40 = 1
		L3_39 = L3_39(L4_40, L2_38)
		L4_40 = A1_37[L3_39]
		A0_36._unit:play_redirect(L4_40)
	end
end
function PlayerMovementState._update_idle(A0_41, A1_42)
	local L2_43, L3_44
	L2_43 = A0_41._player_data
	L3_44 = L2_43.idle
	if L3_44 then
		L3_44 = L2_43.upperbody_idle
		if L3_44 then
			L3_44 = L2_43.turning_left
			if not L3_44 then
				L3_44 = L2_43.turning_right
				if not L3_44 then
					L3_44 = A0_41._idle_time
					L3_44 = L3_44 + A1_42
					A0_41._idle_time = L3_44
				end
			end
		end
	else
		A0_41._idle_time = 0
	end
	L3_44 = L2_43.under_fire_reactions_enabled
	if L3_44 then
		L3_44 = A0_41._update_idle_under_fire
		L3_44 = L3_44(A0_41, A1_42, L2_43)
		if L3_44 then
			A0_41._idle_time = 0
		end
	else
		L3_44 = A0_41._idle_time
		if L3_44 > A0_41._time_until_idle_animation then
			L3_44 = A0_41._idle_redirects
			L3_44 = L3_44(A0_41)
			A0_41:_play_random_redirect(L3_44)
			A0_41._idle_time = 0
			A0_41:_update_time_until_idle_animation()
		end
	end
	L3_44 = A0_41._update_upper_body_idle
	L3_44(A0_41)
end
function PlayerMovementState._update_upper_body_idle(A0_45)
	local L1_46, L2_47
	L1_46 = A0_45._player_data
	L2_47 = L1_46.upperbody_idle
	L2_47 = L2_47 and not L2_47 and not L2_47
	if not L2_47 and A0_45._was_upperbody_idle then
		A0_45._unit:play_redirect("exit_idle")
	end
	A0_45._was_upperbody_idle = L2_47
end
function PlayerMovementState._update_idle_under_fire(A0_48, A1_49, A2_50)
	local L3_51, L4_52, L5_53
	L3_51 = A2_50.time_since_incoming_fire
	L4_52 = tweak_data
	L4_52 = L4_52.player
	L4_52 = L4_52.idle
	L4_52 = L4_52.UNDER_FIRE_TIMEOUT
	L3_51 = L3_51 < L4_52
	L4_52 = A2_50.animation_under_fire
	if L3_51 then
		if not L4_52 then
			L5_53 = A0_48._idle_under_fire_redirects
			L5_53 = L5_53(A0_48)
			A0_48:_play_random_redirect(L5_53)
		end
	elseif L4_52 then
		L5_53 = A0_48._unit
		L5_53 = L5_53.play_redirect
		L5_53(L5_53, "exit_idle_under_fire")
	end
	return L3_51
end
function PlayerMovementState._idle_redirects(A0_54)
	local L1_55
	L1_55 = {}
	return L1_55
end
function PlayerMovementState._idle_under_fire_redirects(A0_56)
	local L1_57
	L1_57 = {}
	return L1_57
end
function PlayerMovementState._update_time_until_idle_animation(A0_58)
	A0_58._time_until_idle_animation = math.random(tweak_data.player.idle.MIN_TIME_UNTIL_IDLE_ANIMATION, tweak_data.player.idle.MAX_TIME_UNTIL_IDLE_ANIMATION)
end
