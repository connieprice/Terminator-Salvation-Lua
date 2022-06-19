require("units/beings/AiNerveSystem")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
if not WalkerAiNerveSystem then
	WalkerAiNerveSystem = class(AiNerveSystem)
end
WalkerAiNerveSystem.init = function(l_1_0, l_1_1)
	AiNerveSystem.init(l_1_0, l_1_1)
	l_1_0._time_since_last_fire = 999999
	l_1_0:_setup_aimers()
	l_1_0._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_1_0.low_frequency_update, "walker_nervesystem"))
end

WalkerAiNerveSystem.destroy = function(l_2_0)
	l_2_0._low_frequency:remove()
	AiNerveSystem.destroy(l_2_0)
end

WalkerAiNerveSystem.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if not AiNerveSystem.update(l_3_0, l_3_1, l_3_2, l_3_3) then
		l_3_1:input():clear()
		return 
	end
	l_3_0._low_frequency:update(l_3_0, l_3_3, l_3_1, l_3_2)
end

WalkerAiNerveSystem.low_frequency_update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	AiNerveSystem.low_frequency_update(l_4_0, l_4_2, l_4_3, l_4_1)
	local l_4_4 = l_4_0._ai_data
	local l_4_5 = l_4_2:input()
	l_4_5:clear()
	local l_4_6, l_4_7 = l_4_0:_update_weapons_dispersions, l_4_0
	local l_4_8 = l_4_2
	local l_4_9 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_7(l_4_8, l_4_9)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_7(l_4_8, l_4_9, l_4_5, nil)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_9(l_4_0, l_4_4, l_4_5, l_4_0._unit_position, l_4_2)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_9(l_4_0, l_4_1, l_4_4, l_4_5, l_4_2, l_4_0._unit_position, l_4_7, R17_PC49)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_9(l_4_0, l_4_4, l_4_4.output.moving_to_execute_target, false)
end

WalkerAiNerveSystem._stun_update = function(l_5_0, l_5_1, l_5_2, l_5_3)
	AiNerveSystem._stun_update(l_5_0, l_5_1, l_5_2, l_5_3)
	l_5_0:_update_execution(l_5_0._ai_data, nil, true)
	l_5_0._ai_data.input.abort_execution = true
end

WalkerAiNerveSystem._update_movement = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_6_0._move_to_position and not l_6_0._movement_blocked then
		if l_6_0._waypoint_options and l_6_0._waypoint_options.speed and l_6_1.SPEEDS then
			assert(nil)
		else
			l_6_4 = l_6_1.output.move_speed * l_6_0._move_to_position - l_6_3:normalized()
		end
		if l_6_4 then
			l_6_2:set_movement(l_6_4)
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 28 
end

WalkerAiNerveSystem._update_execution = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if alive(l_7_2) and not l_7_0._paralyzed_target then
		l_7_0._paralyzed_target = l_7_2
		local l_7_4 = l_7_0._paralyzed_target:ai_data()
	if l_7_4 then
		end
		l_7_4.external.paralyzed_by_unit = l_7_0._unit
	end
	do return end
	if alive(l_7_0._paralyzed_target) then
		local l_7_5 = l_7_0._paralyzed_target:ai_data()
	if l_7_5 then
		end
		l_7_5.external.paralyzed_by_unit = nil
	end
	if l_7_1.input.abort_execution and not l_7_3 and not l_7_2 then
		l_7_1.input.abort_execution = false
	end
end

WalkerAiNerveSystem._update_aiming = function(l_8_0, l_8_1, l_8_2, l_8_3, l_8_4)
	local l_8_5, l_8_6, l_8_7 = nil, nil, nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_8_2.output.allowed_to_fire and l_8_2.output.moving_to_execute_target and l_8_2.output.firing_target_position and l_8_0._move_to_position then
		local l_8_8 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if WalkerTweakData.MIN_EXECUTION_AREA_FIRE_DOT < math.dot(l_8_2.output.firing_target_position - l_8_4:normalized(), l_8_0._move_to_position - l_8_4:normalized()) then
		l_8_5 = l_8_0:_find_firing_position(l_8_8.firing_target, l_8_8.firing_target_position)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_8_6 = l_8_0:_find_firing_position(l_8_8.secondary_weapon_firing_target, l_8_8.secondary_weapon_firing_target_position, true)
		l_8_7 = l_8_5
	elseif l_8_0._waypoint_rotation_look_at_position then
		l_8_7 = l_8_0._waypoint_rotation_look_at_position
		l_8_5 = l_8_0._waypoint_rotation_look_at_position
	elseif l_8_0._move_to_position then
		l_8_7 = l_8_0._move_to_position + math.UP * WalkerTweakData.MOVE_TO_LOOK_AT_HEIGHT
		l_8_5 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_8_8.look_at_position then
		l_8_7 = l_8_8.look_at_position
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if not l_8_0._move_to_position then
			l_8_5 = l_8_8.look_at_position
		else
			l_8_7 = nil
			l_8_5 = nil
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_8_0._primary_aimer and l_8_5 then
			do return end
			 -- DECOMPILER ERROR: Overwrote pending register.

		end
		l_8_3:set_aim_target_position(nil)
		do
			local l_8_9 = nil
			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_8_0._secondary_aimer and l_8_6 then
				do return end
				 -- DECOMPILER ERROR: Overwrote pending register.

			end
			l_8_3:set_secondary_aim_target_position(nil)
			l_8_7 = l_8_0:_calculate_good_look_at_position(l_8_1, l_8_7)
			l_8_3:set_eye_target_position(l_8_7)
			return l_8_5, l_8_6
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 74 
end

WalkerAiNerveSystem._calculate_good_look_at_position = function(l_9_0, l_9_1, l_9_2)
	if not l_9_2 then
		return 
	end
	local l_9_3 = 500
	local l_9_4 = mvector3.distance(l_9_2, l_9_0._unit_position)
	if l_9_3 < l_9_4 then
		return l_9_2
	end
	local l_9_5 = l_9_2 - l_9_0._unit_position
	l_9_5 = l_9_5 + (l_9_3 - l_9_4) * l_9_5:flat(math.UP):normalized()
	l_9_4 = l_9_3
	local l_9_6 = Rotation:look_at(l_9_5, math.UP)
	return l_9_0._unit_position + l_9_4 * l_9_6:y()
end

WalkerAiNerveSystem._update_prepare_fire = function(l_10_0, l_10_1, l_10_2, l_10_3)
	local l_10_4 = nil
	if l_10_1.output.currently_targeted_threat then
		if l_10_0._time_since_last_fire < tweak_data.ai.machines.walker.PREPARE_FIRE_END_TIME then
			l_10_4 = true
		end
	else
		if l_10_1:path() and #l_10_1:path() > 0 then
			local l_10_5 = nil
		if mvector3.distance(l_10_1:path()[#l_10_1:path()], l_10_3) < tweak_data.ai.machines.walker.PREPARE_FIRE_DISTANCE then
			end
			l_10_4 = true
		end
	end
	if l_10_4 then
		l_10_2:set_prepare_primary_fire()
		l_10_2:set_prepare_secondary_fire()
	end
end

WalkerAiNerveSystem._update_fire = function(l_11_0, l_11_1, l_11_2, l_11_3, l_11_4, l_11_5, l_11_6, l_11_7)
	local l_11_8 = l_11_0._unit:enemy_data()
	if not l_11_8.reaching_for_target and not l_11_8.reached_target then
		local l_11_9, l_11_10 = l_11_8.special_kill_strangul
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_11_2.input.is_executing = l_11_9
	if not l_11_2.output.allowed_to_fire then
		return 
	end
	local l_11_11 = nil
	local l_11_12 = false
	local l_11_13 = true
	local l_11_14 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if alive(l_11_2.output.moving_to_execute_target) then
		local l_11_15 = nil
	if l_11_2:current_path_completed() then
		end
		local l_11_16 = mvector3.distance(l_11_2.output.moving_to_execute_target:position(), l_11_5)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if (not l_11_15:player_data() or not l_11_15:player_data().in_cover or l_11_15:player_data().peeking_up) and l_11_16 < WalkerTweakData.EXECUTION_MAX_DISTANCE and not l_11_11 then
		end
		local l_11_17 = nil
		do
			local l_11_18 = nil
			if l_11_14.moving_to_execute_target:player_data() and l_11_14.moving_to_execute_target:player_data().cover_point and l_11_14.moving_to_execute_target:player_data().is_crouching then
				l_11_18 = "special_kill_in_cover"
			else
				l_11_18 = "special_kill_1"
			end
			if not l_11_14.moving_to_execute_position or not l_11_14.moving_to_execute_rotation then
				local l_11_19, l_11_20, l_11_21, l_11_22, l_11_23 = , nil, nil
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_11_3:set_special_kill(l_11_14.moving_to_execute_target, l_11_18, l_11_20, l_11_21)
			l_11_13 = false
		end
		do return end
	end
	do return end
	if l_11_16 < WalkerTweakData.STRIKE_OF_DEATH_DISTANCE then
		local l_11_24 = nil
		local l_11_25 = nil
		if mvector3.normalize(l_11_15:position() - l_11_5) < 0.01 then
			l_11_25 = l_11_4:rotation():y()
		end
		l_11_3:set_strike_of_death(l_11_25, l_11_15)
		l_11_13 = false
	end
	local l_11_26 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if alive(l_11_2.output.firing_target) and not l_11_2.output.firing_target:damage_data():is_fully_damaged() then
		local l_11_27 = nil
		if l_11_2.output.firing_target:damage() then
			local l_11_28 = nil
			do
				local l_11_29 = l_11_2.output.firing_target:damage():can_die()
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_11_29 then
			end
		if not l_11_2.output.moving_to_execute_target and not l_11_11 then
			end
			local l_11_30 = nil
			 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_11_2.output.firing_target:position() - l_11_5 then
			end
		if l_11_2.output.firing_target:position() - l_11_5:length() < WalkerTweakData.STRIKE_OF_DEATH_DISTANCE then
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_11_3:set_strike_of_death(l_11_2.output.firing_target:position() - l_11_5:normalized(), l_11_2.output.firing_target)
			l_11_13 = false
		end
		if l_11_13 and l_11_6 and l_11_2.output.allowed_to_fire and not IntelUtilities.ai_friendly_fire(l_11_4, l_11_6) then
			l_11_3:set_primary_fire()
			l_11_12 = true
		end
		if l_11_13 and l_11_7 and l_11_2.output.secondary_weapon_allowed_to_fire and not IntelUtilities.ai_friendly_fire(l_11_4, l_11_7) and WalkerTweakData.SECONDARY_WEAPON_MIN_FIRING_DISTANCE < mvector3.distance(l_11_0._unit_position, l_11_7) then
			l_11_3:set_secondary_fire()
			l_11_12 = true
		end
		if l_11_12 then
			l_11_0._time_since_last_fire = 0
		else
			l_11_0._time_since_last_fire = l_11_0._time_since_last_fire + l_11_1
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 128 
end

WalkerAiNerveSystem._find_firing_position = function(l_12_0, l_12_1, l_12_2, l_12_3)
	local l_12_4 = nil
	if alive(l_12_1) then
		if l_12_1:targeting_info() then
			l_12_4 = l_12_1:targeting_info():primary_target_position()
		else
			local l_12_5 = nil
			l_12_4 = l_12_1:oobb():center()
		end
	elseif l_12_2 then
		l_12_4 = l_12_2
	end
	if l_12_4 and l_12_3 then
		local l_12_6 = nil
	if World:raycast("ray", l_12_4, l_12_4 - math.UP * 500, "slot_mask", managers.slot:get_mask("statics"), "ignore_unit", l_12_0._unit) then
		end
		l_12_4 = World:raycast("ray", l_12_4, l_12_4 - math.UP * 500, "slot_mask", managers.slot:get_mask("statics"), "ignore_unit", l_12_0._unit).position
	end
	return l_12_4
end

WalkerAiNerveSystem._setup_aimers = function(l_13_0)
	local l_13_1 = l_13_0._primary_aimer_setup
	if l_13_1 then
		l_13_0:_setup_aimer(l_13_1, "_primary_aimer", "_primary_aim_object")
	end
	local l_13_2 = l_13_0._secondary_aimer_setup
	if l_13_2 then
		l_13_0:_setup_aimer(l_13_2, "_secondary_aimer", "_secondary_aim_object")
	end
end

WalkerAiNerveSystem._setup_aimer = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_4 = l_14_1.class_name
	local l_14_5 = assert
	l_14_5(not l_14_4 or l_14_4 ~= "")
	l_14_5 = rawget
	l_14_5 = l_14_5(_G, l_14_4)
	local l_14_7 = nil
	l_14_0[l_14_2] = l_14_5:new(l_14_1.data)
	local l_14_8 = nil
	local l_14_9 = l_14_1.aim_object_name
	do
		assert(not l_14_9 or l_14_9 ~= "")
		assert(l_14_0._unit:get_object(l_14_9), "Aim object '" .. l_14_9 .. "' doesn't exist")
		l_14_0[l_14_3] = l_14_0._unit:get_object(l_14_9)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WalkerAiNerveSystem._update_weapons_dispersions = function(l_15_0, l_15_1, l_15_2, l_15_3)
	local l_15_4 = tweak_data.ai.machines.walker
	l_15_0._miss_max_dispersion = l_15_4.MISS_MAX_DISPERSION
	l_15_0._miss_timer_speed = l_15_4.MISS_TIMER_SPEED
	l_15_0._number_of_dispersion_weapons = l_15_4.NUMBER_OF_DISPERSION_WEAPONS
	local l_15_5 = AiNerveSystem._update_weapons_dispersions
	local l_15_6 = l_15_0
	local l_15_7 = l_15_1
	local l_15_8 = l_15_2
	local l_15_9 = l_15_3
	return l_15_5(l_15_6, l_15_7, l_15_8, l_15_9)
end


