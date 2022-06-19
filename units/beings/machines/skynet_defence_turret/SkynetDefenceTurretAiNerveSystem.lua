require("units/beings/AiNerveSystem")
if not SkynetDefenceTurretAiNerveSystem then
	SkynetDefenceTurretAiNerveSystem = class(AiNerveSystem)
end
SkynetDefenceTurretAiNerveSystem.init = function(l_1_0, l_1_1)
	AiNerveSystem.init(l_1_0, l_1_1)
	l_1_0._ai_data = l_1_0._unit:ai_data()
	l_1_0._input = l_1_1:input()
	l_1_0._aim_object_missile = l_1_1:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_MISSILE)
	l_1_0._aim_object_gatling = l_1_1:get_object(SkynetDefenceTurretBase._AIM_OBJECT_NAME_GATLING)
	l_1_0._low_frequency = managers.update_scheduler:add_function(l_1_0.low_frequency_update, "skynet_defence_turret_nervesystem")
end

SkynetDefenceTurretAiNerveSystem.init_default_ai_data = function(l_2_0)
	l_2_0._ai_data.input.attack_range = l_2_0._ai_data.default_attack_range
	l_2_0._ai_data.input.attack_delay = l_2_0._ai_data.default_attack_delay
	l_2_0._ai_data.input.forced_target_units = l_2_0._ai_data.default_forced_target_units
end

SkynetDefenceTurretAiNerveSystem.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_1:damage_data().fully_damaged then
		l_3_0:_update_dead(l_3_1, l_3_2, l_3_3)
		return 
	end
	if not AiNerveSystem.update(l_3_0, l_3_1, l_3_2, l_3_3) then
		l_3_0._input:clear()
		return 
	end
	l_3_0._low_frequency:update(l_3_0, l_3_1, l_3_2, l_3_3)
end

SkynetDefenceTurretAiNerveSystem.low_frequency_update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	AiNerveSystem.low_frequency_update(l_4_0, l_4_1, l_4_2, l_4_3)
	l_4_0._input:clear()
	local l_4_4 = l_4_0._ai_data.output.allowed_to_fire
	local l_4_5 = l_4_0._ai_data.output.firing_target
	local l_4_6 = l_4_0._ai_data.output.firing_target_position
	local l_4_7 = nil
	if l_4_6 and alive(l_4_5) then
		l_4_0._input:set_aim_target_position(l_4_6)
		if not l_4_0._missile_speed then
			l_4_0._missile_speed = l_4_1:base()._weapon_missile:base()._speed
		end
		l_4_7 = l_4_0:_aim_moving_target2(l_4_0, l_4_5, l_4_6, l_4_0._missile_speed, l_4_0._aim_object_missile)
		l_4_0._input:set_aim_target_position_missile(l_4_7)
	end
	if l_4_4 and alive(l_4_5) then
		if not IntelUtilities.ai_friendly_fire(l_4_1, l_4_7) and l_4_0:_target_angle(l_4_0._aim_object_missile, l_4_7) < l_4_0._max_fire_angle_missile then
			l_4_0._input:set_fire_missile()
		end
	if not IntelUtilities.ai_friendly_fire(l_4_1, l_4_6) then
		end
	if l_4_0:_target_angle(l_4_0._aim_object_gatling, l_4_6) < l_4_0._max_fire_angle_gatling then
		end
		l_4_0._input:set_fire_gatling()
	end
	local l_4_8, l_4_9 = l_4_0:_update_weapons_dispersions, l_4_0
	local l_4_10 = l_4_1
	local l_4_11 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_8 = l_4_8(l_4_9, l_4_10, l_4_11, l_4_5)
	l_4_9 = l_4_0._input
	l_4_9, l_4_10 = l_4_9:set_miss_dispersion, l_4_9
	l_4_11 = l_4_8[1]
	l_4_9(l_4_10, l_4_11)
end

SkynetDefenceTurretAiNerveSystem._target_angle = function(l_5_0, l_5_1, l_5_2)
	local l_5_3 = l_5_2 - l_5_1:position():length()
	local l_5_4 = l_5_1:position() + l_5_1:rotation():y() * l_5_3
	return l_5_2:angle(l_5_4)
end

SkynetDefenceTurretAiNerveSystem._aim_moving_target2 = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	local l_6_5 = l_6_4:position()
	local l_6_6 = l_6_2
	local l_6_7 = l_6_6
	local l_6_8 = l_6_7
	local l_6_9 = l_6_1:velocity()
	local l_6_10 = 10000
	local l_6_11 = l_6_10
	do
		local l_6_12 = 0
		while l_6_10 >= 100 and 0 < 5 do
			l_6_11 = l_6_10
			l_6_8 = l_6_7
			l_6_12 = l_6_7 - l_6_5:length() / l_6_3
			l_6_7 = l_6_6 + l_6_9 * (l_6_12)
			l_6_10 = l_6_7 - l_6_8:length()
			if l_6_11 < l_6_10 then
				return l_6_8
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

		end
		return l_6_7
	end
	 -- WARNING: undefined locals caused missing assignments!
end

SkynetDefenceTurretAiNerveSystem._register = function(l_7_0)
	l_7_0._registered = true
end

SkynetDefenceTurretAiNerveSystem._unregister = function(l_8_0)
	l_8_0._registered = false
end

SkynetDefenceTurretAiNerveSystem._is_dead = function(l_9_0)
	return l_9_0._unit:enemy_data().dead
end

SkynetDefenceTurretAiNerveSystem._update_dead = function(l_10_0, l_10_1, l_10_2, l_10_3)
	if not l_10_0._braindead then
		l_10_0:_kill_brain()
	end
	AiNerveSystem.update(l_10_0, l_10_1, l_10_2, l_10_3)
end

SkynetDefenceTurretAiNerveSystem._debug = function(l_11_0, l_11_1, l_11_2, l_11_3)
end


