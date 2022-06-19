require("shared/updatescheduler/UpdateSchedulerDtMethod")
if not PlayerMovementState then
	PlayerMovementState = class()
end
PlayerMovementState.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._unit = l_1_1
	l_1_0._name = l_1_2
	l_1_0._base = l_1_1:base()
	l_1_0._slotmask_standable = managers.slot:get_mask("standable")
	l_1_0._machine = l_1_0._unit:anim_state_machine()
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0._idle_time = 0
	l_1_0:_update_time_until_idle_animation()
	l_1_0._base_state = "onground/rifle/idle/std"
	l_1_0._pos = l_1_1:position()
	local l_1_3 = l_1_0._unit:mover_by_name("in_cover")
	assert(l_1_3)
	l_1_0._incover_mover_radius = l_1_3:radius()
	l_1_0._was_upperbody_idle = false
end

PlayerMovementState.enter = function(l_2_0)
end

PlayerMovementState.leave = function(l_3_0)
end

PlayerMovementState.name = function(l_4_0)
	return l_4_0._name
end

PlayerMovementState.update = function(l_5_0, l_5_1, l_5_2)
	l_5_0:update_common(l_5_1, l_5_2)
end

PlayerMovementState.variable_frequency_post_update = function(l_6_0, l_6_1)
	l_6_0:_update_idle(l_6_1)
end

PlayerMovementState.update_common = function(l_7_0, l_7_1, l_7_2)
	l_7_0._pos = l_7_0._unit:position()
end

PlayerMovementState._limit_aim_acceleration = function(l_8_0)
	local l_8_1 = l_8_0._player_data
	if l_8_1.can_shoot then
		if not l_8_1.turning_left then
			local l_8_2 = not l_8_1.turning_right
		end
	else
		return false
	end
end

PlayerMovementState._update_aim_parameters = function(l_9_0, l_9_1)
	local l_9_2, l_9_3, l_9_4, l_9_5 = l_9_0:_get_aim_constraints()
	local l_9_6 = l_9_0._player_data
	local l_9_7 = l_9_0:_limit_aim_acceleration()
	l_9_0._base:_update_aim_parameters(l_9_1, l_9_2, l_9_3, l_9_4, l_9_5, false, l_9_7)
end

PlayerMovementState._get_aim_constraints = function(l_10_0, l_10_1)
	local l_10_2 = l_10_0._player_data
	return l_10_2.pitch_neg_angle, l_10_2.pitch_pos_angle, l_10_2.yaw_neg_angle, l_10_2.yaw_pos_angle
end

PlayerMovementState._play_random_redirect = function(l_11_0, l_11_1)
	local l_11_2 = #l_11_1
	if l_11_2 > 0 then
		local l_11_3 = math.random(1, l_11_2)
		local l_11_4 = l_11_1[l_11_3]
		l_11_0._unit:play_redirect(l_11_4)
	end
end

PlayerMovementState._update_idle = function(l_12_0, l_12_1)
	local l_12_2 = l_12_0._player_data
	if l_12_2.idle and l_12_2.upperbody_idle and not l_12_2.turning_left and not l_12_2.turning_right then
		l_12_0._idle_time = l_12_0._idle_time + l_12_1
	else
		l_12_0._idle_time = 0
	end
	if l_12_2.under_fire_reactions_enabled and l_12_0:_update_idle_under_fire(l_12_1, l_12_2) then
		l_12_0._idle_time = 0
	else
		if l_12_0._time_until_idle_animation < l_12_0._idle_time then
			local l_12_3 = l_12_0:_idle_redirects()
			l_12_0:_play_random_redirect(l_12_3)
			l_12_0._idle_time = 0
			l_12_0:_update_time_until_idle_animation()
		end
	end
	l_12_0:_update_upper_body_idle()
end

PlayerMovementState._update_upper_body_idle = function(l_13_0)
	local l_13_1 = l_13_0._player_data
	if l_13_1.upperbody_idle then
		if not l_13_1.turning_left then
			local l_13_2 = not l_13_1.turning_right
		end
	else
		local l_13_3, l_13_4 = false
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_13_3 and l_13_0._was_upperbody_idle then
		l_13_0._unit:play_redirect("exit_idle")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_13_0._was_upperbody_idle = l_13_3
end

PlayerMovementState._update_idle_under_fire = function(l_14_0, l_14_1, l_14_2)
	local l_14_6 = l_14_2.time_since_incoming_fire < tweak_data.player.idle.UNDER_FIRE_TIMEOUT
	if l_14_6 and not l_14_2.animation_under_fire then
		local l_14_7 = nil
		l_14_0:_play_random_redirect(l_14_0:_idle_under_fire_redirects())
	end
	do return end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_14_7 then
		l_14_0._unit:play_redirect("exit_idle_under_fire")
	end
	return l_14_6
end

PlayerMovementState._idle_redirects = function(l_15_0)
	return {}
end

PlayerMovementState._idle_under_fire_redirects = function(l_16_0)
	return {}
end

PlayerMovementState._update_time_until_idle_animation = function(l_17_0)
	l_17_0._time_until_idle_animation = math.random(tweak_data.player.idle.MIN_TIME_UNTIL_IDLE_ANIMATION, tweak_data.player.idle.MAX_TIME_UNTIL_IDLE_ANIMATION)
end


