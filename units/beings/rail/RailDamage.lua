require("units/UnitDamage")
if not RailDamage then
	RailDamage = class(UnitDamage)
end
RailDamage.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	UnitDamage.init(l_1_0, l_1_1, BodyDamage, l_1_3, l_1_4, l_1_5, l_1_6)
	l_1_1:set_extension_update_enabled("damage", true)
	l_1_0._damage_data = l_1_1:damage_data()
	l_1_0._transl = {}
	l_1_0._group_damage = {}
	l_1_0._group_destroyed = {}
	l_1_0._hit_zones = 0
	l_1_0._time_until_next_hurt = 0
	l_1_0._time_since_damage = 1000000
	l_1_0._damage_unit = false
	l_1_0._health_regen_multiplier = 1
	l_1_0:register_damage_callback(function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5)
		-- upvalues: l_1_0
		l_1_0:_on_damage(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5)
  end)
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
	l_1_0:setup_tweaked_data()
end

RailDamage.setup_tweaked_data = function(l_2_0)
	local l_2_1 = tweak_data.rail.vehicle[l_2_0._unit:name()]
	if l_2_1 then
		local l_2_2 = ""
		if managers.player_slot:number_of_occupied_slots() == 2 then
			l_2_2 = "_COOP"
		end
		if not l_2_1["HEALTH" .. l_2_2] then
			local l_2_3, l_2_4, l_2_5, l_2_6 = l_2_1.HEALTH
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_2_3 then
			l_2_0._unit:damage_data().health = l_2_3
		end
		if not l_2_1["PERCENT_HEALTH_REGEN_PER_SECOND" .. l_2_2] then
			l_2_0._percent_health_regen_per_second = l_2_1.PERCENT_HEALTH_REGEN_PER_SECOND
		end
		l_2_0._health_regen_delay = l_2_1["HEALTH_REGEN_DELAY" .. l_2_2] or l_2_1.HEALTH_REGEN_DELAY or 0
		if tweak_data.rail.vehicle.DEBUG then
			local l_2_7 = nil
			if l_2_0._percent_health_regen_per_second then
				cat_debug("rail", "SPAWNING" .. l_2_2 .. " " .. l_2_0._unit:name() .. " HEALTH" .. l_2_2 .. "=" .. l_2_0._unit:damage_data().health .. ", PERCENT_HEALTH_REGEN_PER_SECOND" .. l_2_2 .. "=" .. string.format("%.3f", l_2_0._percent_health_regen_per_second) .. ", HEALTH_REGEN_DELAY" .. l_2_2 .. "=" .. string.format("%.3f", l_2_0._health_regen_delay))
			end
		else
			Application:debug(l_2_0._unit:name() .. " was not found in tweak_data. It will not be tweaked depending on difficulty-level.")
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 91 
end

RailDamage.set_health_param_value = function(l_3_0, l_3_1)
	if not managers.save:has_primary_user() then
		return 
	end
	do
		local l_3_2, l_3_3 = managers.save:profile().difficulty_level or 2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_3_4 = nil
	if ((managers.player_slot:number_of_occupied_slots() == 2 and tonumber(l_3_1[l_3_4 + 3])) or tonumber(l_3_1[l_3_2])) and l_3_0._health_param_type and l_3_0._health_param_type ~= "" then
		if l_3_0._health_param_type == "HEALTH" then
			l_3_0._unit:damage_data().health = tonumber(l_3_1[l_3_2])
			l_3_0._unit:damage_data().damage = 0
		end
	elseif l_3_0._health_param_type == "PERCENT_HEALTH_REGEN_PER_SECOND" then
		l_3_0._percent_health_regen_per_second = tonumber(l_3_1[l_3_2])
	elseif l_3_0._health_param_type == "HEALTH_REGEN_DELAY" then
		l_3_0._health_regen_delay = tonumber(l_3_1[l_3_2])
	end
	l_3_0._health_param_type = nil
end

RailDamage.set_health_param_type = function(l_4_0, l_4_1)
	l_4_0._health_param_type = l_4_1
end

RailDamage.destroy = function(l_5_0)
	UnitDamage.destroy(l_5_0)
	l_5_0._emitter:destroy()
end

RailDamage.fully_damaged = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8)
	if l_6_0._damage_data.postpone_death then
		do return end
	end
	l_6_0._post_death_update = function()
		-- upvalues: l_6_7 , l_6_0 , l_6_2 , l_6_1 , l_6_3 , l_6_4 , l_6_5 , l_6_6 , l_6_8
		local l_7_0 = (l_6_7 or 1) / l_6_0._damage_data.health
		local l_7_1 = l_6_0._unit_destroyed_sequence
		if l_6_0._bullseye_kill_sequence and l_6_2 == "explosion" and l_7_0 >= 1 then
			l_7_1 = l_6_0._bullseye_kill_sequence
		end
		if l_7_1 then
			managers.sequence:run_sequence(l_7_1, l_6_2, l_6_1, l_6_0._unit, l_6_3, l_6_4, l_6_5, l_6_6, l_6_7, l_6_8, nil)
		end
  end
	l_6_0._unit:base():fully_damaged()
end

RailDamage._on_damage = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5, l_7_6)
	if l_7_6 then
		l_7_0._emitter:unit_damaged(l_7_0._unit, l_7_6, l_7_4)
	end
end

RailDamage._setup_body_group = function(l_8_0, l_8_1)
	local l_8_5, l_8_6, l_8_7, l_8_8 = nil
	l_8_0._damage_struct = l_8_1
	l_8_0._damage_unit = l_8_1.damage_unit
	if l_8_1.bodies then
		for i_0,i_1 in pairs(l_8_1.bodies) do
			l_8_0._group_damage[i_1.name] = {}
			if l_8_10.zone then
				l_8_0._hit_zones = l_8_0._hit_zones + 1
				local l_8_11 = nil
				l_8_0._transl[l_8_0._hit_zones] = l_8_10.name
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			l_8_0._group_damage[l_8_10.name].zone = l_8_11
			local l_8_14 = nil
			local l_8_15 = l_8_0._group_damage[l_8_10.name]
			l_8_15.dmg = BodyDamageGroup:new(l_8_0._unit, l_8_0, l_8_10.destroyed_sequence_name, l_8_10.damaged_sequence_name, l_8_10.name, l_8_10.hp, function(l_9_0)
				-- upvalues: l_8_0
				l_8_0:body_group_destroyed(l_9_0)
      end, l_8_10.damage_steps)
			l_8_15 = pairs
			l_8_15 = l_8_15(l_8_10.body_names)
			for i_0,i_1 in l_8_15 do
				if not l_8_0._unit:body(i_1):extension() then
					l_8_0._unit:body(i_1):set_extension({})
				end
				l_8_0._unit:body(i_1):extension().damage = BodyDamageGroupMember:new(l_8_0._unit, l_8_0, l_8_0._unit:body(i_1), l_8_0._unit_element:get_body_element(i_1), l_8_0._group_damage[l_8_10.name].dmg, l_8_1.damage_unit)
			end
			l_8_0._group_destroyed[l_8_0._group_damage[l_8_10.name].dmg.name] = false
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	l_8_0._unit:damage_data().total_damage = l_8_0._unit:damage_data().damage
	l_8_0._unit_destroyed_sequence = l_8_1.unit_destroyed_sequence
	l_8_0._bullseye_kill_sequence = l_8_1.bullseye_kill_sequence
	l_8_0._current_step = {}
	l_8_0._current_step_tot = {}
	l_8_0:get_damage_step(l_8_1.unit_damage_steps, l_8_0._current_step, 0)
	l_8_0:get_damage_step(l_8_1.unit_damage_steps_total, l_8_0._current_step_tot, 0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailDamage.body_group_destroyed = function(l_9_0, l_9_1)
	assert(l_9_1)
	local l_9_2 = l_9_1.name
	l_9_0._group_destroyed[l_9_2] = true
	l_9_0._damage_data.damage = l_9_0._damage_data.damage + 1
end

RailDamage.is_body_group_destroyed = function(l_10_0, l_10_1)
	return l_10_0._group_destroyed[l_10_1]
end

RailDamage.zone_destroyed = function(l_11_0, l_11_1)
	return l_11_0._group_destroyed[l_11_0._transl[l_11_1]]
end

RailDamage.activate_body_group = function(l_12_0, l_12_1, l_12_2)
	local l_12_3 = l_12_0._transl[l_12_1]
	local l_12_4 = l_12_0._group_damage[l_12_3]
	if l_12_4 == nil or l_12_4.zone == nil then
		return 
	end
	l_12_4.dmg:activate(l_12_2)
	if l_12_2 == true then
		managers.sequence:run_sequence_simple("activate_hz_" .. l_12_4.zone, l_12_0._unit)
	else
		managers.sequence:run_sequence_simple("deactivate_hz_" .. l_12_4.zone, l_12_0._unit)
	end
end

RailDamage.check_god_mode = function(l_13_0)
	if not l_13_0._player_in_vehicle then
		l_13_0._player_in_vehicle = l_13_0._unit:base():get_players_in_vehicle()[1]
	end
	if l_13_0._player_in_vehicle then
		local l_13_1, l_13_2 = l_13_0._player_in_vehicle:damage():immune_to_damage, l_13_0._player_in_vehicle:damage()
		return l_13_1(l_13_2)
	else
		return false
	end
end

RailDamage.update = function(l_14_0, l_14_1, l_14_2, l_14_3)
	l_14_0._time_until_next_hurt = l_14_0._time_until_next_hurt - l_14_3
	if l_14_0._percent_health_regen_per_second then
		l_14_0:update_health_regen(l_14_2, l_14_3)
	end
	l_14_0:unit_damage_steps_current(l_14_0._damage_struct.unit_damage_steps)
	l_14_0:unit_damage_steps_total(l_14_0._damage_struct.unit_damage_steps_total)
	if l_14_0._post_death_update then
		l_14_0._post_death_update()
		l_14_0._post_death_update = nil
	end
end

RailDamage.set_health_regen_multiplier = function(l_15_0, l_15_1)
	l_15_0._health_regen_multiplier = l_15_1
end

RailDamage.update_health_regen = function(l_16_0, l_16_1, l_16_2)
	l_16_0._time_since_damage = l_16_0._time_since_damage + l_16_2
	if l_16_0._health_regen_delay < l_16_0._time_since_damage and l_16_0._damage_data.damage > 0 then
		l_16_0._damage_data.damage = l_16_0._damage_data.damage - l_16_2 * l_16_0._damage_data.health * l_16_0._percent_health_regen_per_second * l_16_0._health_regen_multiplier
	if l_16_0._damage_data.damage < 0 then
		end
		l_16_0._damage_data.damage = 0
	end
end

RailDamage.debug_draw = function(l_17_0)
	local l_17_5, l_17_6, l_17_7, l_17_8, l_17_9 = nil
	if tweak_data.enemy.hk.DEBUG_SHOW_HITZONES then
		local l_17_1 = Draw:pen("green")
		for i_0,i_1 in ipairs(l_17_0._transl) do
			if l_17_0._group_damage[i_1].dmg:is_active() then
				local l_17_12 = nil
				local l_17_13 = nil
				if l_17_0._unit:get_object(l_17_11) then
					local l_17_14 = l_17_0._unit:body(l_17_0._damage_struct.bodies[l_17_10].body_names[1])
					l_17_1:sphere(l_17_0._unit:get_object(l_17_11):position(), 200, 5, 2)
				end
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_17_14 then
				end
				local l_17_15 = nil
				l_17_1:sphere(l_17_14:center_of_mass(), 200, 5, 2)
			end
		end
	end
end

RailDamage.get_zone_names = function(l_18_0)
	return "\tThis vehicle has no hitzones\n"
end

RailDamage.damage_from_part = function(l_19_0, l_19_1, l_19_2)
	if l_19_0:check_god_mode() or l_19_0._unit:damage_data().invulnerable then
		return 
	end
	if l_19_0._damage_unit then
		l_19_0._damage_data.damage = l_19_0._damage_data.damage + l_19_1
	end
end

RailDamage.hit_zones_activation = function(l_20_0, l_20_1)
	local l_20_5, l_20_6, l_20_7, l_20_8, l_20_9, l_20_10, l_20_11, l_20_12 = nil
	for i_0,i_1 in pairs(l_20_1) do
		if i_1.id then
			l_20_0:activate_body_group(i_1.id, i_1.state)
		end
	end
end

RailDamage.unit_damage_steps_current = function(l_21_0, l_21_1)
	local l_21_2 = l_21_0._unit:damage_data()
	l_21_0:unit_damage_steps(l_21_1, l_21_0._current_step, l_21_2.damage, l_21_2.health)
	l_21_0:_unit_damage_step_transitions(l_21_1, l_21_0._current_step)
end

RailDamage.unit_damage_steps_total = function(l_22_0, l_22_1)
	local l_22_2 = l_22_0._unit:damage_data()
	l_22_0:unit_damage_steps(l_22_1, l_22_0._current_step_tot, l_22_2.total_damage, l_22_2.health)
end

RailDamage.unit_damage_steps = function(l_23_0, l_23_1, l_23_2, l_23_3, l_23_4)
	if not l_23_1 then
		return 
	end
	local l_23_5 = l_23_3 / l_23_4
	if l_23_2.dmg_B <= l_23_5 then
		l_23_0:get_damage_step(l_23_1, l_23_2, l_23_2.index + 1)
		if l_23_1[l_23_2.index] and l_23_1[l_23_2.index].sequence_name then
			managers.sequence:run_sequence_simple(l_23_1[l_23_2.index].sequence_name, l_23_0._unit)
		end
	elseif l_23_5 < l_23_2.dmg_A then
		l_23_0:get_damage_step(l_23_1, l_23_2, l_23_2.index - 1)
	if l_23_1[l_23_2.index] then
		end
	if l_23_1[l_23_2.index].sequence_name then
		end
		managers.sequence:run_sequence_simple(l_23_1[l_23_2.index].sequence_name, l_23_0._unit)
	end
end

RailDamage._unit_damage_step_transitions = function(l_24_0, l_24_1, l_24_2)
	local l_24_3 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_24_0._previous_step_index and l_24_2.index ~= l_24_0._previous_step_index then
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_24_1[l_24_0._previous_step_index] and l_24_0._previous_step_index < l_24_2.index then
			l_24_3 = l_24_1[l_24_0._previous_step_index].to_higher
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	else
		l_24_3 = l_24_1[l_24_0._previous_step_index].to_lower
	end
	if l_24_3 then
		managers.sequence:run_sequence_simple(l_24_3, l_24_0._unit)
	end
	l_24_0._previous_step_index = l_24_2.index
end

RailDamage.get_damage_step = function(l_25_0, l_25_1, l_25_2, l_25_3)
	if not l_25_1 then
		return 
	end
	l_25_2.index = l_25_3
	local l_25_4 = l_25_1[l_25_3 + 1]
	l_25_2.dmg_B = l_25_4 and l_25_4.damage or 88888
	local l_25_5 = l_25_1[l_25_3]
	l_25_2.dmg_A = l_25_5 and l_25_5.damage or -88888
end

RailDamage.add_damage = function(l_26_0, l_26_1, l_26_2, l_26_3, l_26_4, l_26_5, l_26_6, l_26_7, l_26_8)
	local l_26_9 = l_26_0._unit:damage_data()
	if l_26_9.invulnerable or l_26_0:check_god_mode() then
		return 
	end
	if l_26_9.no_lethal_damage and alive(l_26_0._unit) and l_26_0._unit:damage_data().health <= l_26_0._unit:damage_data().damage + l_26_7 then
		return 
	end
	l_26_0._time_since_damage = 0
	l_26_9.total_damage = l_26_9.total_damage + l_26_7
	UnitDamage.add_damage(l_26_0, l_26_1, l_26_2, l_26_3, l_26_4, l_26_5, l_26_6, l_26_7, l_26_8)
	l_26_0._last_hit_direction = l_26_6
end

RailDamage.get_time_since_damage = function(l_27_0)
	return l_27_0._time_since_damage
end


