require("units/beings/AiNerveSystem")
require("shared/updatescheduler/UpdateSchedulerDtMethod")
if not SpiderAiNerveSystem then
	SpiderAiNerveSystem = class(AiNerveSystem)
end
SpiderAiNerveSystem.init = function(l_1_0, l_1_1)
	AiNerveSystem.init(l_1_0, l_1_1)
	l_1_0._num_scans = -1
	l_1_0._low_frequency = UpdateSchedulerDtMethod:new(managers.update_scheduler:add_function(l_1_0.low_frequency_update, "spider_nervesystem"))
end

SpiderAiNerveSystem.destroy = function(l_2_0)
	l_2_0._low_frequency:remove()
	AiNerveSystem.destroy(l_2_0)
end

SpiderAiNerveSystem.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if not AiNerveSystem.update(l_3_0, l_3_1, l_3_2, l_3_3) then
		l_3_1:input():clear()
		return 
	end
	l_3_0._low_frequency:update(l_3_0, l_3_3, l_3_1, l_3_2)
end

SpiderAiNerveSystem.low_frequency_update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	AiNerveSystem.low_frequency_update(l_4_0, l_4_2, l_4_3, l_4_1)
	local l_4_4, l_4_5 = nil, nil
	local l_4_6 = l_4_0._ai_data.output.attack_mode
	local l_4_7 = nil
	local l_4_8 = false
	local l_4_9 = nil
	local l_4_10 = l_4_0._ai_data:is_scan_requested()
	local l_4_11 = l_4_2:enemy_data()
	local l_4_12 = l_4_0._ai_data.output
	if l_4_0._move_to_position and not l_4_0._movement_blocked then
		local l_4_13 = nil
		if l_4_0._waypoint_options and l_4_0._waypoint_options.speed and l_4_0._ai_data.SPEEDS then
			l_4_13 = l_4_0._ai_data.SPEEDS[l_4_0._waypoint_options.speed]
			assert(l_4_13)
		else
			l_4_13 = l_4_12.move_speed
		end
		l_4_5 = l_4_13 * l_4_0._move_to_position - l_4_0._unit_position:normalized()
	end
	if l_4_12.allowed_to_fire then
		if alive(l_4_12.firing_target) then
			local l_4_14 = l_4_12.firing_target:targeting_info()
			if l_4_14 then
				l_4_4 = l_4_14:primary_target_position()
			else
				local l_4_15 = l_4_12.firing_target:oobb()
				l_4_4 = l_4_15:center()
			end
			l_4_9 = l_4_12.firing_target
			if mvector3.distance(l_4_9:position(), l_4_0._unit_position) < tweak_data.ai.machines.spider.CHARGE_MAX_DISTANCE then
				local l_4_16 = NavigationGraphUtilities.ai_check_can_move_there
				local l_4_17 = l_4_2
				local l_4_18 = l_4_9:position()
				local l_4_19 = {}
				 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_4_16 = l_4_16(l_4_17, l_4_18, l_4_19, l_4_9)
			if l_4_16 then
				end
				l_4_8 = true
				l_4_7 = false
			else
				l_4_7 = true
			end
		elseif l_4_12.firing_target_position then
			l_4_4 = l_4_12.firing_target_position
			l_4_9 = nil
			l_4_7 = true
		end
		if l_4_7 and IntelUtilities.ai_friendly_fire(l_4_2, l_4_4) then
			l_4_7 = false
		end
	elseif l_4_12.look_at_position then
		l_4_4 = l_4_12.look_at_position
	else
		l_4_4 = l_4_0._waypoint_rotation_look_at_position
	end
	l_4_7 = l_4_0:_burst_fire(l_4_3, l_4_7, l_4_11.firing)
	l_4_0._ai_data:set_is_scanning(l_4_11.scanning or l_4_10)
	local l_4_20 = l_4_2:input()
	l_4_20:clear()
	l_4_20:set_aim_target_position(l_4_4)
	l_4_20:set_eye_target_position(l_4_4)
	l_4_20:set_aim_target_unit(l_4_9)
	l_4_20:set_attack_mode(l_4_6)
	l_4_20:set_is_scanning(l_4_10)
	if l_4_5 then
		l_4_20:set_movement(l_4_5)
	end
	if l_4_7 then
		l_4_20:set_fire()
		local l_4_21, l_4_22 = l_4_0:_update_weapons_dispersions, l_4_0
		local l_4_23 = l_4_2
		local l_4_24 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_4_21 = l_4_21(l_4_22, l_4_23, l_4_24, l_4_9)
		l_4_22, l_4_23 = l_4_20:set_miss_dispersion, l_4_20
		l_4_24 = l_4_21[1]
		l_4_22(l_4_23, l_4_24)
	elseif l_4_8 then
		local l_4_28, l_4_29, l_4_30, l_4_31 = l_4_20:set_charge_direction, l_4_20, l_4_9:position() - l_4_0._unit_position:normalized(), .end
		l_4_28(l_4_29, l_4_30, l_4_31)
	end
	for i_0,i_1 in pairs(l_4_0._ai_data.UNIT_WEAPONS) do
		i_1.enabled = l_4_2:base():is_weapon_enabled(i_1.id)
	end
	if not l_4_11.preparing_to_fire then
		l_4_0._ai_data.input.is_firing = l_4_11.is_firing
	end
	l_4_0._ai_data.input.is_charging = l_4_8
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

SpiderAiNerveSystem._update_weapons_dispersions = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_4 = tweak_data.ai.machines.spider
	l_5_0._miss_max_dispersion = l_5_4.MISS_MAX_DISPERSION
	l_5_0._miss_timer_speed = l_5_4.MISS_TIMER_SPEED
	l_5_0._number_of_dispersion_weapons = l_5_4.NUMBER_OF_DISPERSION_WEAPONS
	local l_5_5 = AiNerveSystem._update_weapons_dispersions
	local l_5_6 = l_5_0
	local l_5_7 = l_5_1
	local l_5_8 = l_5_2
	local l_5_9 = l_5_3
	return l_5_5(l_5_6, l_5_7, l_5_8, l_5_9)
end

SpiderAiNerveSystem._burst_fire = function(l_6_0, l_6_1, l_6_2, l_6_3)
	local l_6_4 = tweak_data.ai.machines.spider
	l_6_0._burst_mean_time = l_6_4.BURST_LENGTH
	l_6_0._burst_standard_deviation_time = 2 * l_6_4.BURST_LENGTH
	l_6_0._burst_max_deviation_time = 0.4 * l_6_4.BURST_LENGTH
	l_6_0._burst_pause_mean_time = l_6_4.TIME_BETWEEN_BURSTS
	l_6_0._burst_pause_standard_deviation_time = 2 * l_6_4.TIME_BETWEEN_BURSTS
	l_6_0._burst_pause_max_deviation_time = 0.4 * l_6_4.TIME_BETWEEN_BURSTS
	local l_6_5 = AiNerveSystem._burst_fire
	local l_6_6 = l_6_0
	local l_6_7 = l_6_1
	local l_6_8 = l_6_2
	local l_6_9 = l_6_3
	return l_6_5(l_6_6, l_6_7, l_6_8, l_6_9)
end


