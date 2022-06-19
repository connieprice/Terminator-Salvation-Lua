if not RailTank then
	RailTank = class(RailVehicle)
end
RailTank._AIM_OBJECT = "a_turret"
RailTank.init = function(l_1_0, l_1_1)
	RailVehicle.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._aim_object = l_1_0._unit:get_object(RailTank._AIM_OBJECT)
	l_1_0:_setup_primary_weapons()
	l_1_0:_setup_secondary_weapons()
	l_1_0._num_human_controlled = 0
	l_1_0._intersect_check_slots = managers.slot:get_mask("enemies", "statics")
	l_1_0._intersect_check_interval = 1
	l_1_0._intersect_check_prev = 0
	l_1_0._intersect_box_width = 1200
	l_1_0._intersect_box_length = 2600
	l_1_0._intersect_box_height = 1100
	l_1_0._intersect_box_offset_y = 100
	l_1_0._intersect_box_offset_z = 520
	l_1_0._sample_count = 10
	l_1_0._sample_delay = 20
	l_1_0._rot_angle_threshold_stick = 0.02
	l_1_0._rot_angle_threshold_other = 1
	l_1_0._rotation_angles = AverageOverTime:new(l_1_0._sample_count, 0)
	l_1_0._sample_delay_cnt = 0
	l_1_0._look_input_axis = nil
	l_1_0._turret_rotation_sound_instance = nil
	l_1_0._car_impact_sound_instance = nil
	l_1_0._machine_impact_sound_instance = nil
	l_1_0._drive_idle_sound_instance = nil
	l_1_0._drive_loop_sound_instance = nil
	l_1_0._drive_loop_end_sound_instance = nil
	l_1_0._power_up_l_sound_instance = nil
	l_1_0._power_up_r_sound_instance = nil
	l_1_0._ambience_sound_instance = nil
	l_1_0._health_alarm_sound_instance = nil
	l_1_0._drive_loop_end_sound_played = true
	l_1_0._coop_checking = true
	l_1_0._next_effect_hit = 0
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
end

RailTank._setup_primary_weapons = function(l_2_0)
	l_2_0._primary_weapon_l = World:spawn_unit(l_2_0._primary_weapon_class, l_2_0._unit:position(), l_2_0._unit:rotation())
	l_2_0._primary_weapon_l:base():setup(l_2_0._unit)
	l_2_0._primary_weapon_l:base():set_equiped(true)
	l_2_0._unit:link("a_primary_weapon_l", l_2_0._primary_weapon_l, "at_gatling_barrel")
	l_2_0._primary_weapon_r = World:spawn_unit(l_2_0._primary_weapon_class, l_2_0._unit:position(), l_2_0._unit:rotation())
	l_2_0._primary_weapon_r:base():setup(l_2_0._unit)
	l_2_0._primary_weapon_r:base():set_equiped(true)
	l_2_0._unit:link("a_primary_weapon_r", l_2_0._primary_weapon_r, "at_gatling_barrel")
end

RailTank._setup_secondary_weapons = function(l_3_0)
	l_3_0._secondary_weapon_l = World:spawn_unit(l_3_0._secondary_weapon_class, l_3_0._unit:position() + Vector3(0, -400, 0), l_3_0._unit:rotation())
	l_3_0._secondary_weapon_l:base():setup(l_3_0._unit, l_3_0._secondary_weapon_l_parent_object_names)
	l_3_0._secondary_weapon_l:base():set_equiped(true)
	l_3_0._secondary_weapon_r = World:spawn_unit(l_3_0._secondary_weapon_class, l_3_0._unit:position(), l_3_0._unit:rotation())
	l_3_0._secondary_weapon_r:base():setup(l_3_0._unit, l_3_0._secondary_weapon_r_parent_object_names)
	l_3_0._secondary_weapon_r:base():set_equiped(true)
end

RailTank._hide_weapons = function(l_4_0, l_4_1)
	l_4_0._primary_weapon_l:get_object("g_gatling_barrel"):set_visibility(not l_4_1)
	l_4_0._primary_weapon_r:get_object("g_gatling_barrel"):set_visibility(not l_4_1)
end

RailTank.get_primary_weapons = function(l_5_0)
	do
		local l_5_1 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		return l_5_1
	end
	 -- WARNING: undefined locals caused missing assignments!
end

RailTank.get_secondary_weapons = function(l_6_0)
	do
		local l_6_1 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		return l_6_1
	end
	 -- WARNING: undefined locals caused missing assignments!
end

RailTank.get_turret_object = function(l_7_0)
	local l_7_1, l_7_2 = l_7_0._unit:get_object, l_7_0._unit
	local l_7_3 = "a_turn_torso"
	return l_7_1(l_7_2, l_7_3)
end

RailTank.set_turret_rotation = function(l_8_0, l_8_1, l_8_2)
	l_8_0._unit:get_object("a_turn_torso"):set_rotation(l_8_1)
	l_8_0._unit:set_moving()
	l_8_0._look_input_axis = l_8_2
end

RailTank.destroy = function(l_9_0)
	RailVehicle.destroy(l_9_0)
	l_9_0:_destroy_weapons()
	l_9_0:_stop_sounds()
	managers.action_event:unregister_listener(l_9_0)
end

RailTank._stop_sounds = function(l_10_0)
	if l_10_0._turret_rotation_sound_instance and l_10_0._turret_rotation_sound_instance:is_playing() then
		l_10_0._turret_rotation_sound_instance:stop()
	end
	if l_10_0._car_impact_sound_instance and l_10_0._car_impact_sound_instance:is_playing() then
		l_10_0._car_impact_sound_instance:stop()
	end
	if l_10_0._machine_impact_sound_instance and l_10_0._machine_impact_sound_instance:is_playing() then
		l_10_0._machine_impact_sound_instance:stop()
	end
	if l_10_0._drive_idle_sound_instance and l_10_0._drive_idle_sound_instance:is_playing() then
		l_10_0._drive_idle_sound_instance:stop()
	end
	if l_10_0._drive_loop_sound_instance and l_10_0._drive_loop_sound_instance:is_playing() then
		l_10_0._drive_loop_sound_instance:stop()
	end
	if l_10_0._drive_loop_end_sound_instance and l_10_0._drive_loop_end_sound_instance:is_playing() then
		l_10_0._drive_loop_end_sound_instance:stop()
	end
	if l_10_0._ambience_sound_instance and l_10_0._ambience_sound_instance:is_playing() then
		l_10_0._ambience_sound_instance:stop()
	end
	if l_10_0._health_alarm_sound_instance and l_10_0._health_alarm_sound_instance:is_playing() then
		l_10_0._health_alarm_sound_instance:stop()
	end
end

RailTank._destroy_weapons = function(l_11_0)
	if alive(l_11_0._primary_weapon_l) then
		l_11_0._primary_weapon_l:set_slot(0)
	end
	l_11_0._primary_weapon_l = nil
	if alive(l_11_0._primary_weapon_r) then
		l_11_0._primary_weapon_r:set_slot(0)
	end
	l_11_0._primary_weapon_r = nil
	if alive(l_11_0._secondary_weapon_l) then
		l_11_0._secondary_weapon_l:set_slot(0)
	end
	l_11_0._secondary_weapon_l = nil
	if alive(l_11_0._secondary_weapon_r) then
		l_11_0._secondary_weapon_r:set_slot(0)
	end
	l_11_0._secondary_weapon_r = nil
end

RailTank.update = function(l_12_0, l_12_1, l_12_2, l_12_3)
	RailVehicle.update(l_12_0, l_12_1, l_12_2, l_12_3)
	if l_12_0._coop_checking then
		l_12_0:_check_for_coop()
	end
	if l_12_0._intersect_check_prev + l_12_0._intersect_check_interval <= l_12_2 then
		l_12_0:_check_for_enemy_intersection()
		l_12_0._intersect_check_prev = l_12_2
	end
	l_12_0:_update_engine_rumble(l_12_1, l_12_2, l_12_3)
	l_12_0:_update_turret_sound(l_12_1, l_12_2, l_12_3)
	l_12_0:_update_engine_sound(l_12_1, l_12_2, l_12_3)
	l_12_0:_update_health_alarm_sound(l_12_1, l_12_2, l_12_3)
	if not alive(l_12_0._ambience_sound_instance) then
		l_12_0._ambience_sound_instance = l_12_0._unit:play("tank_ambience")
	end
end

RailTank._update_health_alarm_sound = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_4 = l_13_0._unit:damage_data()
	local l_13_5 = l_13_4.damage / l_13_4.health
	local l_13_6 = math.clamp(l_13_5, 0, 1)
	if not alive(l_13_0._health_alarm_sound_instance) then
		l_13_0._health_alarm_sound_instance = l_13_0._unit:play("tank_alarm")
	end
	l_13_0._health_alarm_sound_instance:set_control("t", l_13_6)
end

RailTank._update_turret_sound = function(l_14_0, l_14_1, l_14_2, l_14_3)
	if l_14_0._sample_delay_cnt <= l_14_0._sample_delay then
		l_14_0._rotation_angles:add(0, 1)
		l_14_0._sample_delay_cnt = l_14_0._sample_delay_cnt + 1
	else
		if not alive(l_14_0._turret_rotation_sound_instance) then
			l_14_0._turret_rotation_sound_instance = l_14_0._unit:play("tank_turret_loop")
		end
		if l_14_0._look_input_axis then
			if not l_14_0._first_linked_player then
				l_14_0._first_linked_player = l_14_0:get_first_linked_player()
			end
			local l_14_4 = l_14_0._unit:get_object("a_turn_torso"):new_local_rotation():y()
			local l_14_5 = l_14_0._prev_turret_rot:y()
			local l_14_6 = (l_14_5:angle(l_14_4))
			local l_14_7 = nil
			if l_14_0._look_input_axis:length() > 0 and l_14_0._first_linked_player:base():player_has_control() then
				l_14_7 = l_14_0._rot_angle_threshold_stick
			else
				l_14_7 = l_14_0._rot_angle_threshold_other
			end
			if l_14_7 <= l_14_6 then
				l_14_0._rotation_angles:add(1, 1)
			else
				l_14_0._rotation_angles:add(0, 1)
			end
		else
			l_14_0._rotation_angles:add(0, 1)
		end
		local l_14_8 = math.clamp(l_14_0._rotation_angles:value(), 0, 1)
		l_14_0._turret_rotation_sound_instance:set_control("t", l_14_8)
	end
	l_14_0._prev_turret_rot = l_14_0._unit:get_object("a_turn_torso"):new_local_rotation()
end

RailTank._update_engine_rumble = function(l_15_0, l_15_1, l_15_2, l_15_3)
	local l_15_4 = l_15_0._unit:unit_rumble()
	if l_15_4 and l_15_0.is_main_tank then
		if managers.worldcamera:current_world_camera() or l_15_0:get_speed_kmh() < 1 or l_15_0._unit:damage_data():is_fully_damaged() then
			l_15_4:stop()
		end
	else
		if not l_15_4:is_playing() then
			l_15_4:play()
		end
	end
end

RailTank._update_engine_sound = function(l_16_0, l_16_1, l_16_2, l_16_3)
	if l_16_0:get_speed_kmh() < 1 then
		if alive(l_16_0._drive_loop_sound_instance) then
			l_16_0._drive_loop_sound_instance:stop()
		end
		if not alive(l_16_0._drive_idle_sound_instance) then
			l_16_0._drive_idle_sound_instance = l_16_0._unit:play("tank_drive_idle")
		end
	if not alive(l_16_0._drive_loop_end_sound_instance) then
		end
	if not l_16_0._drive_loop_end_sound_played then
		end
		l_16_0._drive_loop_end_sound_instance = l_16_0._unit:play("tank_drive_loop_end")
		l_16_0._drive_loop_end_sound_played = true
	end
	if l_16_0:get_speed_kmh() >= 1 then
		if alive(l_16_0._drive_idle_sound_instance) then
			l_16_0._drive_idle_sound_instance:stop()
		end
		if not alive(l_16_0._drive_loop_sound_instance) then
			l_16_0._drive_loop_sound_instance = l_16_0._unit:play("tank_drive_loop")
		end
		l_16_0._drive_loop_end_sound_played = false
	end
end

RailTank._check_for_coop = function(l_17_0)
	local l_17_7, l_17_8, l_17_9, l_17_10, l_17_13, l_17_14, l_17_15, l_17_16 = nil
	local l_17_1 = managers.player_slot:slots()
	local l_17_2 = {}
	local l_17_3 = 0
	for i_0,i_1 in ipairs(l_17_1) do
		if alive(i_1:spawned_unit()) then
			if i_1:spawned_unit():control():is_human_controlled() then
				l_17_3 = l_17_3 + 1
			end
			table.insert(l_17_2, i_1:spawned_unit())
		end
	end
	if l_17_0._num_human_controlled ~= l_17_3 then
		for i_0,i_1 in ipairs(l_17_2) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if i_1:player_data().on_rail_vehicle and i_1:player_data().on_rail_vehicle ~= l_17_0._unit then
				if l_17_3 == 2 then
					if i_1:name() == "player2_tank" then
						Application:debug("COOP: Hiding tank 2")
						 -- DECOMPILER ERROR: Confused about usage of registers!

						managers.sequence:run_sequence_simple("hide_2nd_player_tank", i_1:player_data().on_rail_vehicle)
						 -- DECOMPILER ERROR: Confused about usage of registers!

						i_1:player_data().on_rail_vehicle:base():_hide_weapons(true)
						l_17_0.is_main_tank = true
					else
						Application:debug("COOP: Hiding torso 1")
						 -- DECOMPILER ERROR: Confused about usage of registers!

						i_1:player_data().on_rail_vehicle:base():_hide_weapons(true)
						 -- DECOMPILER ERROR: Confused about usage of registers!

						managers.sequence:run_sequence_simple("hide_torso", i_1:player_data().on_rail_vehicle)
						l_17_0.is_main_tank = false
						 -- DECOMPILER ERROR: Confused about usage of registers!

						l_17_0.main_tank = i_1:player_data().on_rail_vehicle
					end
				else
					if i_1:name() == "player2_tank" then
						Application:debug("SINGLE: Hiding tank 2")
						l_17_0.is_main_tank = true
						l_17_0:_disable_player(i_1)
					end
				else
					Application:debug("SINGLE: show torso 1")
					 -- DECOMPILER ERROR: Confused about usage of registers!

					managers.sequence:run_sequence_simple("show_torso", i_1:player_data().on_rail_vehicle)
					 -- DECOMPILER ERROR: Confused about usage of registers!

					i_1:player_data().on_rail_vehicle:base():_hide_weapons(false)
					l_17_0.is_main_tank = false
					 -- DECOMPILER ERROR: Confused about usage of registers!

					l_17_0.main_tank = i_1:player_data().on_rail_vehicle
					l_17_0:_disable_tank()
				end
				l_17_0._coop_checking = false
			end
		end
		l_17_0._num_human_controlled = l_17_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

RailTank._disable_player = function(l_18_0, l_18_1)
	local l_18_5, l_18_6 = ipairs, l_18_1:extensions()
	l_18_5 = l_18_5(l_18_6)
	for i_0,i_1 in l_18_5 do
		local l_18_7, l_18_8 = l_18_1:set_extension_update_enabled, l_18_1
		local l_18_9 = l_18_4
		l_18_7(l_18_8, l_18_9, l_18_4 == "drama")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailTank._disable_tank = function(l_19_0)
	l_19_0:_destroy_weapons()
	l_19_0:_stop_sounds()
	l_19_0._unit:set_enabled(false)
end

RailTank._check_for_enemy_intersection = function(l_20_0)
	local l_20_1 = l_20_0._unit:rotation()
	local l_20_2 = l_20_1:x() * l_20_0._intersect_box_width * 0.5
	local l_20_3 = l_20_1:y() * l_20_0._intersect_box_length * 0.5
	local l_20_4 = l_20_1:z() * l_20_0._intersect_box_height * 0.5
	local l_20_5 = l_20_0._unit:position() + l_20_1:y() * l_20_0._intersect_box_offset_y + l_20_1:z() * l_20_0._intersect_box_offset_z
	local l_20_6 = OOBB(l_20_5, l_20_2, l_20_3, l_20_4)
	local l_20_11 = l_20_0._unit:find_units
	local l_20_12 = l_20_0._unit
	l_20_11 = l_20_11(l_20_12, "obb", l_20_5, l_20_2, l_20_3, l_20_4, l_20_0._intersect_check_slots)
	local l_20_7 = nil
	if l_20_11 then
		l_20_12 = ipairs
		l_20_7 = l_20_11
		l_20_12 = l_20_12(l_20_7)
		for i_0,i_1 in l_20_12 do
			local l_20_13 = l_20_10:in_slot(managers.slot:get_mask("enemies"))
			local l_20_14 = l_20_10:in_slot(managers.slot:get_mask("statics"))
			if l_20_13 then
				l_20_10:damage():set_fully_damaged()
				managers.rumble:play_preset("rail_tank_intersection", l_20_0._unit:get_object("a_turn_torso"):position())
				l_20_0._machine_impact_sound_instance = l_20_0._unit:play("machine_impact")
			elseif l_20_14 and l_20_10:name() == "rail_sedan01_dented" then
				managers.sequence:run_sequence_simple("delay", l_20_10)
				managers.rumble:play_preset("rail_tank_intersection", l_20_0._unit:get_object("a_turn_torso"):position())
				l_20_0._car_impact_sound_instance = l_20_0._unit:play("car_impact")
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

RailTank.feedback_bullet_hit = function(l_21_0, l_21_1, l_21_2, l_21_3)
	if l_21_0._unit == l_21_1 then
		local l_21_4 = l_21_2.unit
		local l_21_5 = l_21_4:in_slot(managers.slot:get_mask("enemies"))
		if l_21_3 ~= l_21_4:slot() and l_21_3 == 4 then
			managers.rumble:play_preset("rail_tank_gatling_killing_hit", l_21_0._unit:get_object("a_turn_torso"):position())
		end
	elseif l_21_5 then
		managers.rumble:play_preset("rail_tank_gatling_hit", l_21_0._unit:get_object("a_turn_torso"):position())
	end
end

RailTank.show_bullet_hit = function(l_22_0)
	if not l_22_0._next_effect_hit_duration then
		l_22_0._next_effect_hit = Application:time() + (l_22_0._next_effect_hit > Application:time() or 0)
		return true
		return false
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 14 
end


