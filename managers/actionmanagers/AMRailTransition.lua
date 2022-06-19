if not AMRailTransition then
	AMRailTransition = class(CoreActionElement)
end
AMRailTransition.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMRailTransition.activate_now = function(l_2_0)
	if l_2_0.units.script_name then
		l_2_0._vehicle_unit = managers.unit_scripting:get_unit_by_name(l_2_0.units.script_name)
		if not l_2_0._vehicle_unit then
			l_2_0:deactivate_now()
			return 
		end
		assert(l_2_0._vehicle_unit, "vehicle_unit " .. l_2_0.units.script_name .. " not found in AMRailTransition")
		if l_2_0.animation_state and l_2_0.animation_state ~= "" then
			l_2_0._vehicle_unit:base():fill_connector_callbacks(l_2_0.hub_callbacks)
			if l_2_0.new_keep_vehicle_position then
				local l_2_5, l_2_7, l_2_11, l_2_12, l_2_13 = l_2_0._vehicle_unit:base():set_animation_start, l_2_0._vehicle_unit:base(), l_2_0._vehicle_unit:position(), l_2_0._vehicle_unit:rotation(), .end
				l_2_5(l_2_7, l_2_11, l_2_12, l_2_13)
			elseif not l_2_0.keep_vehicle_position then
				l_2_0._vehicle_unit:base():set_animation_start(l_2_0.animation_start_position, l_2_0.animation_start_rotation)
			end
			l_2_0._vehicle_unit:base():transition(l_2_0.animation_state, l_2_0.animation_time)
		end
		if not l_2_0.animation_speed then
			l_2_0.animation_speed = not l_2_0.animation_speed_transition_time or l_2_0.animation_speed_transition_time <= 0 or 1
		end
		do
			local l_2_4, l_2_6 = l_2_0._vehicle_unit:base():set_animation_speed_interpolator_target, l_2_0._vehicle_unit:base()
			l_2_4(l_2_6, l_2_0.animation_speed, l_2_0.animation_speed_transition_time)
		end
		if l_2_0.behaviors then
			for i_0,i_1 in pairs(l_2_0.behaviors) do
				for l_2_21,l_2_22 in pairs(i_1) do
					local l_2_25, l_2_26, l_2_27, l_2_28 = nil
					l_2_25 = l_2_0[l_2_23]
					local l_2_14 = nil
					l_2_26 = l_2_25
					l_2_27 = l_2_0
					l_2_28 = l_2_24
					l_2_26(l_2_27, l_2_28)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
		end
		if l_2_0:_rail_vehicle_uses_ai() then
			local l_2_15 = nil
			if l_2_0.targets then
				l_2_0._vehicle_unit:ai_data().default_forced_target_units = l_2_0:_get_units_by_names(l_2_0.targets)
			end
			if l_2_0.target_locations then
				l_2_0._vehicle_unit:ai_data().default_forced_target_locations = l_2_0.target_locations
			end
			l_2_0._vehicle_unit:ai_nerve_system():init_default_ai_data()
		end
	if not TableAlgorithms.is_empty(l_2_0.escort_units) then
		end
		local l_2_16 = nil
		local l_2_17 = nil
		for l_2_16,l_2_17 in pairs(l_2_0._vehicle_unit:base():get_players_in_vehicle()) do
			do
				local l_2_18, l_2_19, l_2_20 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_2_18.rail_player_escort_unit = managers.unit_scripting:get_unit_by_name(l_2_0.escort_units.script_name)
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_2_20 = "PLAYER UNIT"
				l_2_18(l_2_19, l_2_20, l_2_17:name(), "IS NOW ESCORTING UNIT", managers.unit_scripting:get_unit_by_name(l_2_0.escort_units.script_name):name())
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AMRailTransition.ai_forced_target_selection = function(l_3_0, l_3_1)
	l_3_0._vehicle_unit:ai_data().default_forced_target_selection = l_3_1
end

AMRailTransition.ai_forced_primary_attack = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._vehicle_unit:ai_data()
	if l_4_1 and l_4_1 ~= "" then
		local l_4_3 = l_4_0:_split_forced_attacks(l_4_1)
		l_4_2.default_primary_attack_properties = l_4_3
		l_4_2.default_forced_primary_attacks = l_4_0
	end
end

AMRailTransition.ai_forced_secondary_attack = function(l_5_0, l_5_1)
	local l_5_2 = l_5_0._vehicle_unit:ai_data()
	if l_5_1 and l_5_1 ~= "" then
		local l_5_3 = l_5_0:_split_forced_attacks(l_5_1)
		l_5_2.default_secondary_attack_properties = l_5_3
		l_5_2.default_forced_secondary_attacks = l_5_0
	end
end

AMRailTransition._split_forced_attacks = function(l_6_0, l_6_1)
	local l_6_2 = {}
	local l_6_3 = {}
	if string.find(l_6_1, "[]%s]") then
		local l_6_8 = string.sub
		local l_6_9 = l_6_1
		l_6_8 = l_6_8(l_6_9, 2, string.find(l_6_1, "[]%s]") - 1)
		local l_6_4 = nil
		l_6_9 = String
		l_6_9 = l_6_9.split
		l_6_4 = l_6_8
		l_6_9 = l_6_9(l_6_4, "[,%s]")
		l_6_8 = l_6_9
		l_6_9 = pairs
		l_6_4 = l_6_8
		l_6_9 = l_6_9(l_6_4)
		for i_0,i_1 in l_6_9 do
			local l_6_10 = String.split(l_6_7, "[=%s]")
			local l_6_11 = l_6_10[1]
			l_6_2[l_6_11] = l_6_10[2]
		end
		l_6_3 = string.sub(l_6_1, string.find(l_6_1, "[]%s]") + 1, string.len(l_6_1))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	else
		l_6_3 = l_6_1
	end
	l_6_8 = String
	l_6_8 = l_6_8.split
	l_6_8 = l_6_8(l_6_3, "[,%s]")
	if not l_6_8 then
		l_6_3, l_6_8 = l_6_8, {}
	end
	l_6_8 = l_6_2
	return l_6_8, l_6_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AMRailTransition.ai_override_previous_forced_attacks = function(l_7_0, l_7_1)
	l_7_0._vehicle_unit:ai_data().default_override_previous_forced_attacks = string.find(l_7_1, "true")
end

AMRailTransition.base_primary_attack_damage = function(l_8_0, l_8_1)
	l_8_0._vehicle_unit:base().primary_attack_damage = tweak_data.rail.hunter_killer.damage[string.upper(l_8_1)]
end

AMRailTransition.base_secondary_attack_damage = function(l_9_0, l_9_1)
	l_9_0._vehicle_unit:base().secondary_attack_damage = tweak_data.rail.hunter_killer.damage[string.upper(l_9_1)]
end

AMRailTransition.ai_forced_flares = function(l_10_0, l_10_1)
	if l_10_1 and l_10_1 ~= "" then
		if not String.split(l_10_1, "[,%s]") then
			l_10_0._vehicle_unit:ai_data().default_forced_flares = {}
		end
	end
end

AMRailTransition._get_units_by_names = function(l_11_0, l_11_1)
	local l_11_6, l_11_7, l_11_8, l_11_9 = nil
	local l_11_2 = {}
	for i_0,i_1 in pairs(l_11_1) do
		table.insert(l_11_2, managers.unit_scripting:get_unit_by_name(i_1.script_name))
	end
	return l_11_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AMRailTransition._rail_vehicle_uses_ai = function(l_12_0)
	if l_12_0._vehicle_unit:ai_nerve_system() then
		return l_12_0._vehicle_unit:ai_data()
	end
end

AMRailTransition.hit_zones_activation = function(l_13_0, l_13_1)
	local l_13_6, l_13_7, l_13_8 = nil
	local l_13_2 = {}
	for i_0,i_1 in string.gmatch(l_13_1, "z(%d+)%s*=%s*(%a+)") do
		local l_13_11 = table.insert
		l_13_11(l_13_2, {id = tonumber(l_13_9), state = l_13_10 == "on"})
	end
	if #l_13_2 > 0 then
		l_13_0._vehicle_unit:damage():hit_zones_activation(l_13_2)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

AMRailTransition.call_vehicle_base_function = function(l_14_0, l_14_1)
	if l_14_1 ~= "no_event" then
		assert(l_14_0._vehicle_unit:base()[l_14_1], "Function name " .. l_14_1 .. " in vehicle unit not found!")
		local l_14_2 = l_14_0._vehicle_unit:base()
		local l_14_3 = l_14_2[l_14_1]
		l_14_3(l_14_2)
	end
end

AMRailTransition.ai_forced_attack_ranges = function(l_15_0, l_15_1)
	local l_15_6, l_15_7, l_15_8, l_15_9 = nil
	local l_15_2 = l_15_0._vehicle_unit:ai_data()
	if l_15_1 and l_15_1 ~= "" then
		if not String.split(l_15_1, "[,%s]") then
			l_15_1 = {}
		end
		for i_0,i_1 in pairs(l_15_1) do
			l_15_1[i_0] = tonumber(i_1) * 100
		end
		l_15_2.default_forced_attack_ranges = l_15_1
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

AMRailTransition.ai_forced_attack_fov = function(l_16_0, l_16_1)
	local l_16_6, l_16_7, l_16_8, l_16_9 = nil
	local l_16_2 = l_16_0._vehicle_unit:ai_data()
	if l_16_1 and l_16_1 ~= "" then
		if not String.split(l_16_1, "[,%s]") then
			l_16_1 = {}
		end
		for i_0,i_1 in pairs(l_16_1) do
			l_16_1[i_0] = tonumber(i_1)
		end
		l_16_2.default_forced_attack_fov = l_16_1
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

AMRailTransition.ai_target_range = function(l_17_0, l_17_1)
	if l_17_1 and l_17_1 ~= "" then
		l_17_0._vehicle_unit:ai_data().default_ai_target_range = l_17_1
	end
end

AMRailTransition.set_health_param_type = function(l_18_0, l_18_1)
	if alive(l_18_0._vehicle_unit) then
		l_18_0._vehicle_unit:damage():set_health_param_type(l_18_1)
	end
end

AMRailTransition.set_health_param_value = function(l_19_0, l_19_1)
	if l_19_1 and l_19_1 ~= "" then
		if not String.split(l_19_1, "[,%s]") then
			local l_19_2, l_19_3 = {}
		end
	if alive(l_19_0._vehicle_unit) then
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_19_0._vehicle_unit:damage():set_health_param_value(l_19_2)
	end
end


