require("units/beings/AiNerveSystem")
if not HunterKillerAiNerveSystem then
	HunterKillerAiNerveSystem = class(AiNerveSystem)
end
HunterKillerAiNerveSystem.init = function(l_1_0, l_1_1)
	AiNerveSystem.init(l_1_0, l_1_1)
	l_1_0._locked_firing_target = nil
end

HunterKillerAiNerveSystem.init_default_ai_data = function(l_2_0)
	local l_2_1 = l_2_0._unit:ai_data()
	l_2_1.input.forced_target_selection = l_2_1.default_forced_target_selection
	l_2_1.input.forced_target_units = {}
	l_2_1.input.forced_target_units[1] = l_2_1.default_forced_target_units
	l_2_1.input.forced_target_units[2] = l_2_1.default_forced_target_units
	l_2_1.input.forced_target_locations = {}
	l_2_1.input.forced_target_locations[1] = l_2_1.default_forced_target_locations
	l_2_1.input.forced_target_locations[2] = l_2_1.default_forced_target_locations
	l_2_1.input.forced_attacks = {}
	if not l_2_1.default_forced_primary_attacks then
		l_2_1.input.forced_attacks[1] = {}
	end
	if not l_2_1.default_forced_secondary_attacks then
		l_2_1.input.forced_attacks[2] = {}
	end
	l_2_1.input.override_previous_forced_attacks = l_2_1.default_override_previous_forced_attacks
	if not l_2_1.default_forced_flares then
		l_2_1.input.forced_flares = {}
	end
	if l_2_1.default_primary_attack_properties then
		local l_2_2 = l_2_1.default_primary_attack_properties.clip
	if l_2_2 then
		end
	if tonumber(l_2_2) then
		end
		l_2_0._unit:base():set_number_of_primary_bolts(tonumber(l_2_2))
	end
	if l_2_1.default_secondary_attack_properties then
		local l_2_3 = l_2_1.default_secondary_attack_properties.clip
	if l_2_3 then
		end
	if tonumber(l_2_3) then
		end
		l_2_0._unit:base():set_number_of_secondary_bolts(tonumber(l_2_3))
	end
end

HunterKillerAiNerveSystem.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_1:damage_data():is_fully_damaged() then
		l_3_0:_update_dead(l_3_1, l_3_2, l_3_3)
		return 
	end
	if not AiNerveSystem.update(l_3_0, l_3_1, l_3_2, l_3_3) then
		return 
	end
	local l_3_4 = l_3_1:ai_data()
	local l_3_5 = l_3_1:enemy_data()
	local l_3_6 = l_3_1:input()
	local l_3_7 = l_3_1:base()
	local l_3_8 = l_3_1:base()._weapon_primary
	local l_3_9 = l_3_1:base()._weapon_secondary
	l_3_6:clear()
	if alive(l_3_8) and l_3_4.output.allowed_to_fire[1] then
		local l_3_10 = l_3_7._weapon_primary:base()._speed
		l_3_6:set_primary_aim_target_position(l_3_0:_get_aim_target_position(l_3_1, l_3_10, 1, l_3_0._unit:base()._aim_object[1]))
		l_3_6:set_primary_fire()
	end
	if alive(l_3_9) and l_3_4.output.allowed_to_fire[2] then
		local l_3_11 = l_3_7._weapon_secondary:base()._speed
		l_3_6:set_secondary_aim_target_position(l_3_0:_get_aim_target_position(l_3_1, l_3_11, 2, l_3_0._unit:base()._aim_object[2]))
		l_3_6:set_secondary_fire()
	end
	l_3_6:set_flare(l_3_4.output.allowed_to_release_flare)
end

HunterKillerAiNerveSystem._register = function(l_4_0)
	l_4_0._registered = true
end

HunterKillerAiNerveSystem._unregister = function(l_5_0)
	l_5_0._registered = false
end

HunterKillerAiNerveSystem._get_aim_target_position = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	local l_6_5 = (l_6_1:ai_data())
	local l_6_6 = nil
	if l_6_5.output.firing_target_unit[l_6_3] and alive(l_6_5.output.firing_target_unit[l_6_3]) then
		l_6_6 = l_6_0:_aim_moving_target2(l_6_0, l_6_5.output.firing_target_unit[l_6_3], l_6_2, l_6_4)
	else
		if l_6_5.output.firing_target_position[l_6_3] then
			l_6_6 = l_6_5.output.firing_target_position[l_6_3]
		end
	end
	return l_6_6
end

HunterKillerAiNerveSystem._aim_moving_target = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_4 = l_7_1:position()
	local l_7_5 = l_7_4 + l_7_1:velocity()
	local l_7_6 = l_7_5 - l_7_3:position()
	return l_7_4 + l_7_1:velocity() * (l_7_6:length() / l_7_2)
end

HunterKillerAiNerveSystem._aim_moving_target2 = function(l_8_0, l_8_1, l_8_2, l_8_3)
	local l_8_4 = l_8_3:position()
	local l_8_5 = l_8_1:position()
	local l_8_6 = l_8_5
	local l_8_7 = l_8_6
	local l_8_8 = l_8_1:velocity()
	local l_8_9 = 10000
	local l_8_10 = l_8_9
	do
		local l_8_11 = 0
		while l_8_9 >= 100 and 0 < 5 do
			l_8_10 = l_8_9
			l_8_7 = l_8_6
			l_8_11 = l_8_6 - l_8_4:length() / l_8_2
			l_8_6 = l_8_5 + l_8_8 * (l_8_11)
			l_8_9 = l_8_6 - l_8_7:length()
			if l_8_10 < l_8_9 then
				return l_8_7
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

		end
		return l_8_6
	end
	 -- WARNING: undefined locals caused missing assignments!
end

HunterKillerAiNerveSystem._is_dead = function(l_9_0)
	return l_9_0._unit:enemy_data().dead
end

HunterKillerAiNerveSystem._update_dead = function(l_10_0, l_10_1, l_10_2, l_10_3)
	if not l_10_0._braindead then
		l_10_0:_kill_brain()
	end
	AiNerveSystem.update(l_10_0, l_10_1, l_10_2, l_10_3)
	local l_10_4 = l_10_1:input()
	l_10_4:clear()
end


