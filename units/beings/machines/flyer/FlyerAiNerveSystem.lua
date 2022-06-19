require("units/beings/AiNerveSystem")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
if not FlyerAiNerveSystem then
	FlyerAiNerveSystem = class(AiNerveSystem)
end
FlyerAiNerveSystem.NORMAL_MOVE_SPEED = 1
FlyerAiNerveSystem.init = function(l_1_0, l_1_1)
	AiNerveSystem.init(l_1_0, l_1_1)
	l_1_0._locked_firing_target = nil
	l_1_0._chassi_body = l_1_1:body("default_body")
	assert(l_1_0._chassi_body)
	local l_1_2 = math.rand(0.8, 1.2)
	l_1_0._flyer_movement = FlyerMovement:new(l_1_0._chassi_body, l_1_2)
	l_1_0._dead_acceleration = nil
	l_1_0._dead_approach_acceleration = Vector3(0, 0, 0)
	l_1_0._dead_angular_acceleration = nil
	l_1_0._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_1_0.low_frequency_update, "flyer_nervesystem"))
	l_1_0._velocity_fraction = 0
	l_1_0._look_at_position = nil
	l_1_0._next_pos = nil
	l_1_0._physics_timer = TimerManager:physics()
	l_1_0._damage_data = l_1_1:damage_data()
end

FlyerAiNerveSystem.destroy = function(l_2_0)
	l_2_0._low_frequency:remove()
	AiNerveSystem.destroy(l_2_0)
end

FlyerAiNerveSystem.init_default_ai_data = function(l_3_0)
	l_3_0._ai_data.input.speed = l_3_0._ai_data.default_speed
end

FlyerAiNerveSystem._end_stun = function(l_4_0)
	l_4_0._flyer_movement:reset()
end

FlyerAiNerveSystem._stun_update = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_4 = l_5_1:input()
	l_5_4:clear()
	local l_5_5 = l_5_0._chassi_body:position():with_z(l_5_0._last_target_pos.z)
	local l_5_6, l_5_7 = l_5_0._flyer_movement:update(l_5_3, nil, false, false, 0, l_5_5, nil)
	l_5_4:set_acceleration(l_5_6)
	l_5_4:set_angular_acceleration(l_5_7)
end

FlyerAiNerveSystem.update = function(l_6_0, l_6_1, l_6_2, l_6_3)
	if l_6_0._damage_data.fully_damaged then
		l_6_0:_update_dead(l_6_1, l_6_2, l_6_3)
		return 
	end
	if not AiNerveSystem.update(l_6_0, l_6_1, l_6_2, l_6_3) then
		l_6_1:input():clear()
		return 
	end
	if l_6_0._waypoint_options and l_6_0._waypoint_options.speed then
		l_6_0._velocity_fraction = l_6_0._waypoint_options.speed
	else
		l_6_0._velocity_fraction = l_6_0._ai_data.output.move_speed
	end
	local l_6_4, l_6_5 = l_6_0._low_frequency:update(l_6_0, l_6_3, l_6_1, l_6_2)
	if not l_6_5 then
		l_6_0:_update_move(l_6_1, l_6_2, l_6_3, false)
	end
end

FlyerAiNerveSystem.low_frequency_update = function(l_7_0, l_7_1, l_7_2, l_7_3)
	AiNerveSystem.low_frequency_update(l_7_0, l_7_2, l_7_3, l_7_1)
	local l_7_4 = l_7_2:enemy_data()
	local l_7_5 = l_7_0._ai_data.output
	local l_7_6, l_7_7, l_7_8, l_7_9 = nil, nil, nil, nil
	if (not l_7_4.preparing_to_fire and not l_7_4.is_firing) or not l_7_0._locked_firing_target then
		l_7_0._locked_firing_target = l_7_5.firing_target
	end
	if l_7_5.allowed_to_fire and (l_7_0._chassi_body:velocity():length() < tweak_data.ai.machines.flyer.MAX_FIRE_VELOCITY or l_7_0._ai_data.no_max_fire_velocity) then
		if alive(l_7_0._locked_firing_target) then
			local l_7_10 = l_7_0._locked_firing_target:targeting_info()
			if l_7_10 then
				l_7_6 = l_7_10:primary_target_position()
			else
				l_7_6 = l_7_0._locked_firing_target:oobb():center()
			end
			l_7_7 = true
		else
			if l_7_0._ai_data.output.firing_target_position then
				l_7_6 = l_7_5.firing_target_position
				l_7_7 = true
			end
		end
	if l_7_7 then
		end
	if IntelUtilities.ai_friendly_fire(l_7_2, l_7_6) then
		end
		l_7_7 = false
	end
	l_7_7 = l_7_0:_burst_fire(l_7_3, l_7_7, l_7_4.firing)
	l_7_0._look_at_position = l_7_0:_get_look_at_position(l_7_0._next_pos, l_7_6)
	if not l_7_6 then
		l_7_6 = l_7_0._look_at_position
	end
	local l_7_11 = l_7_2:input()
	l_7_11:clear()
	l_7_0:_update_move(l_7_2, l_7_3, l_7_1, true)
	l_7_11:set_aim_target_position(l_7_6)
	if l_7_7 then
		l_7_11:set_fire()
		local l_7_12, l_7_13 = l_7_0:_update_weapons_dispersions, l_7_0
		local l_7_14 = l_7_2
		local l_7_15 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_7_12 = l_7_12(l_7_13, l_7_14, l_7_15, l_7_0._locked_firing_target)
		l_7_13, l_7_14 = l_7_11:set_miss_dispersion, l_7_11
		l_7_15 = l_7_12[1]
		l_7_13(l_7_14, l_7_15)
	end
	l_7_11:set_defensive(l_7_5.defensive)
	if not l_7_4.preparing_to_fire then
		l_7_0._ai_data.input.is_firing = l_7_4.is_firing
	end
	if l_7_5.self_destroy then
		l_7_11:set_self_destroy()
	end
end

FlyerAiNerveSystem._update_move = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
	if not l_8_4 then
		l_8_0:_update_path(l_8_1, l_8_2)
	end
	if not l_8_0._look_at_position then
		l_8_0._look_at_position = l_8_0:_get_look_at_position(l_8_0._next_pos, nil)
	end
	if not l_8_0._move_to_position and not l_8_0._last_target_pos then
		l_8_0._last_target_pos = l_8_0._chassi_body:position()
	end
	if l_8_0._move_to_position and l_8_0._ai_data:path() then
		l_8_0._next_pos = l_8_0._ai_data:path()[l_8_0._current_path_index + 1]
	else
		l_8_0._next_pos = nil
	end
	local l_8_5 = l_8_0._physics_timer:delta_time()
	local l_8_6 = l_8_1:input()
	if l_8_0._velocity_fraction > 0.001 then
		local l_8_7 = l_8_0:_force_path()
		local l_8_11, l_8_12 = , l_8_0._flyer_movement:update(l_8_5, l_8_0._look_at_position, not l_8_0._ai_data.output.allowed_to_strafe or not l_8_0._ai_data:path() or #l_8_0._ai_data:path() == 1, l_8_7, l_8_0._velocity_fraction, l_8_0._last_target_pos, l_8_0._next_pos)
		l_8_6:set_acceleration(l_8_12)
		l_8_6:set_angular_acceleration(R13_PC84)
	else
		l_8_6:set_acceleration(Vector3(0, 0, 0))
		l_8_6:set_angular_acceleration(Vector3(0, 0, 0))
	end
end

FlyerAiNerveSystem._get_look_at_position = function(l_9_0, l_9_1, l_9_2)
	if l_9_2 then
		local l_9_3 = l_9_2
	else
		if l_9_0._ai_data.output.look_at_position then
			do return end
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_9_0._waypoint_rotation_look_at_position then
		local l_9_4 = l_9_0._ai_data.output.look_at_position
	elseif l_9_0._move_to_position then
		if l_9_1 then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		do
			local l_9_5, l_9_6 = math.lerp(l_9_1, l_9_0._move_to_position, math.min(1, l_9_0._chassi_body:position() - l_9_0._move_to_position:length() / 500))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		if l_9_0._chassi_body:position() - l_9_0._chassi_body:position():length() < 50 then
			local l_9_7 = l_9_0._chassi_body:position() + 500 * l_9_0._chassi_body:rotation():y()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		return l_9_7
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 49 
end

FlyerAiNerveSystem._update_dead = function(l_10_0, l_10_1, l_10_2, l_10_3)
	if not l_10_0._braindead then
		l_10_0:_kill_brain()
	end
	AiNerveSystem.update(l_10_0, l_10_1, l_10_2, l_10_3)
	local l_10_4 = l_10_1:input()
	l_10_4:clear()
	local l_10_5 = NavigationGraphUtilities.get_on_ground_position(l_10_0._unit_position)
	if l_10_5 and mvector3.distance(l_10_0._unit_position, l_10_5) < 100 then
		return 
	end
	local l_10_6 = l_10_0._chassi_body:rotation()
	if not l_10_0._dead_acceleration then
		local l_10_7 = l_10_6:y()
		local l_10_8 = l_10_6:z()
		local l_10_9 = l_10_6:x()
		local l_10_10 = math.rand(1000, 1200)
		local l_10_11 = l_10_10 / 180
		local l_10_12 = l_10_8:spread(20)
		if l_10_0._chassi_body:velocity():dot(l_10_7) > 500 then
			local l_10_13, l_10_14, l_10_15 = 0.1 * (l_10_10 * l_10_12)
			l_10_14 = l_10_0._chassi_body
			l_10_14, l_10_15 = l_10_14:velocity, l_10_14
			l_10_14 = l_10_14(l_10_15)
			l_10_14 = l_10_14 * 1
			l_10_0._dead_approach_acceleration = l_10_14
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_10_0._dead_acceleration = l_10_13
		l_10_0._dead_angular_acceleration = l_10_11 * l_10_12:cross(l_10_8):normalized()
	end
	l_10_4:set_acceleration(l_10_0._dead_acceleration:rotate_with(l_10_6) + l_10_0._dead_approach_acceleration)
	l_10_4:set_angular_acceleration(l_10_0._dead_angular_acceleration)
end

FlyerAiNerveSystem._update_weapons_dispersions = function(l_11_0, l_11_1, l_11_2, l_11_3)
	local l_11_4 = tweak_data.ai.machines.flyer
	l_11_0._miss_max_dispersion = l_11_4.MISS_MAX_DISPERSION
	l_11_0._miss_timer_speed = l_11_4.MISS_TIMER_SPEED
	l_11_0._number_of_dispersion_weapons = l_11_4.NUMBER_OF_DISPERSION_WEAPONS
	local l_11_5 = AiNerveSystem._update_weapons_dispersions
	local l_11_6 = l_11_0
	local l_11_7 = l_11_1
	local l_11_8 = l_11_2
	local l_11_9 = l_11_3
	return l_11_5(l_11_6, l_11_7, l_11_8, l_11_9)
end

FlyerAiNerveSystem._burst_fire = function(l_12_0, l_12_1, l_12_2, l_12_3)
	local l_12_4 = tweak_data.ai.machines.flyer
	l_12_0._burst_mean_time = l_12_4.BURST_LENGTH
	l_12_0._burst_standard_deviation_time = 2 * l_12_4.BURST_LENGTH
	l_12_0._burst_max_deviation_time = 0.4 * l_12_4.BURST_LENGTH
	l_12_0._burst_pause_mean_time = l_12_4.TIME_BETWEEN_BURSTS
	l_12_0._burst_pause_standard_deviation_time = 2 * l_12_4.TIME_BETWEEN_BURSTS
	l_12_0._burst_pause_max_deviation_time = 0.4 * l_12_4.TIME_BETWEEN_BURSTS
	local l_12_5 = AiNerveSystem._burst_fire
	local l_12_6 = l_12_0
	local l_12_7 = l_12_1
	local l_12_8 = l_12_2
	local l_12_9 = l_12_3
	return l_12_5(l_12_6, l_12_7, l_12_8, l_12_9)
end


