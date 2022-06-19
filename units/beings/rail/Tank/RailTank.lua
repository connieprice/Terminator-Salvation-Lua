RailTank = RailTank or class(RailVehicle)
RailTank._AIM_OBJECT = "a_turret"
function RailTank.init(A0_0, A1_1)
	RailVehicle.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._aim_object = A0_0._unit:get_object(RailTank._AIM_OBJECT)
	A0_0:_setup_primary_weapons()
	A0_0:_setup_secondary_weapons()
	A0_0._num_human_controlled = 0
	A0_0._intersect_check_slots = managers.slot:get_mask("enemies", "statics")
	A0_0._intersect_check_interval = 1
	A0_0._intersect_check_prev = 0
	A0_0._intersect_box_width = 1200
	A0_0._intersect_box_length = 2600
	A0_0._intersect_box_height = 1100
	A0_0._intersect_box_offset_y = 100
	A0_0._intersect_box_offset_z = 520
	A0_0._sample_count = 10
	A0_0._sample_delay = 20
	A0_0._rot_angle_threshold_stick = 0.02
	A0_0._rot_angle_threshold_other = 1
	A0_0._rotation_angles = AverageOverTime:new(A0_0._sample_count, 0)
	A0_0._sample_delay_cnt = 0
	A0_0._look_input_axis = nil
	A0_0._turret_rotation_sound_instance = nil
	A0_0._car_impact_sound_instance = nil
	A0_0._machine_impact_sound_instance = nil
	A0_0._drive_idle_sound_instance = nil
	A0_0._drive_loop_sound_instance = nil
	A0_0._drive_loop_end_sound_instance = nil
	A0_0._power_up_l_sound_instance = nil
	A0_0._power_up_r_sound_instance = nil
	A0_0._ambience_sound_instance = nil
	A0_0._health_alarm_sound_instance = nil
	A0_0._drive_loop_end_sound_played = true
	A0_0._coop_checking = true
	A0_0._next_effect_hit = 0
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
end
function RailTank._setup_primary_weapons(A0_2)
	A0_2._primary_weapon_l = World:spawn_unit(A0_2._primary_weapon_class, A0_2._unit:position(), A0_2._unit:rotation())
	A0_2._primary_weapon_l:base():setup(A0_2._unit)
	A0_2._primary_weapon_l:base():set_equiped(true)
	A0_2._unit:link("a_primary_weapon_l", A0_2._primary_weapon_l, "at_gatling_barrel")
	A0_2._primary_weapon_r = World:spawn_unit(A0_2._primary_weapon_class, A0_2._unit:position(), A0_2._unit:rotation())
	A0_2._primary_weapon_r:base():setup(A0_2._unit)
	A0_2._primary_weapon_r:base():set_equiped(true)
	A0_2._unit:link("a_primary_weapon_r", A0_2._primary_weapon_r, "at_gatling_barrel")
end
function RailTank._setup_secondary_weapons(A0_3)
	A0_3._secondary_weapon_l = World:spawn_unit(A0_3._secondary_weapon_class, A0_3._unit:position() + Vector3(0, -400, 0), A0_3._unit:rotation())
	A0_3._secondary_weapon_l:base():setup(A0_3._unit, A0_3._secondary_weapon_l_parent_object_names)
	A0_3._secondary_weapon_l:base():set_equiped(true)
	A0_3._secondary_weapon_r = World:spawn_unit(A0_3._secondary_weapon_class, A0_3._unit:position(), A0_3._unit:rotation())
	A0_3._secondary_weapon_r:base():setup(A0_3._unit, A0_3._secondary_weapon_r_parent_object_names)
	A0_3._secondary_weapon_r:base():set_equiped(true)
end
function RailTank._hide_weapons(A0_4, A1_5)
	A0_4._primary_weapon_l:get_object("g_gatling_barrel"):set_visibility(not A1_5)
	A0_4._primary_weapon_r:get_object("g_gatling_barrel"):set_visibility(not A1_5)
end
function RailTank.get_primary_weapons(A0_6)
	local L1_7
	L1_7 = {
		A0_6._primary_weapon_l,
		A0_6._primary_weapon_r
	}
	return L1_7
end
function RailTank.get_secondary_weapons(A0_8)
	local L1_9
	L1_9 = {
		A0_8._secondary_weapon_l,
		A0_8._secondary_weapon_r
	}
	return L1_9
end
function RailTank.get_turret_object(A0_10)
	return A0_10._unit:get_object("a_turn_torso")
end
function RailTank.set_turret_rotation(A0_11, A1_12, A2_13)
	A0_11._unit:get_object("a_turn_torso"):set_rotation(A1_12)
	A0_11._unit:set_moving()
	A0_11._look_input_axis = A2_13
end
function RailTank.destroy(A0_14)
	RailVehicle.destroy(A0_14)
	A0_14:_destroy_weapons()
	A0_14:_stop_sounds()
	managers.action_event:unregister_listener(A0_14)
end
function RailTank._stop_sounds(A0_15)
	if A0_15._turret_rotation_sound_instance and A0_15._turret_rotation_sound_instance:is_playing() then
		A0_15._turret_rotation_sound_instance:stop()
	end
	if A0_15._car_impact_sound_instance and A0_15._car_impact_sound_instance:is_playing() then
		A0_15._car_impact_sound_instance:stop()
	end
	if A0_15._machine_impact_sound_instance and A0_15._machine_impact_sound_instance:is_playing() then
		A0_15._machine_impact_sound_instance:stop()
	end
	if A0_15._drive_idle_sound_instance and A0_15._drive_idle_sound_instance:is_playing() then
		A0_15._drive_idle_sound_instance:stop()
	end
	if A0_15._drive_loop_sound_instance and A0_15._drive_loop_sound_instance:is_playing() then
		A0_15._drive_loop_sound_instance:stop()
	end
	if A0_15._drive_loop_end_sound_instance and A0_15._drive_loop_end_sound_instance:is_playing() then
		A0_15._drive_loop_end_sound_instance:stop()
	end
	if A0_15._ambience_sound_instance and A0_15._ambience_sound_instance:is_playing() then
		A0_15._ambience_sound_instance:stop()
	end
	if A0_15._health_alarm_sound_instance and A0_15._health_alarm_sound_instance:is_playing() then
		A0_15._health_alarm_sound_instance:stop()
	end
end
function RailTank._destroy_weapons(A0_16)
	if alive(A0_16._primary_weapon_l) then
		A0_16._primary_weapon_l:set_slot(0)
	end
	A0_16._primary_weapon_l = nil
	if alive(A0_16._primary_weapon_r) then
		A0_16._primary_weapon_r:set_slot(0)
	end
	A0_16._primary_weapon_r = nil
	if alive(A0_16._secondary_weapon_l) then
		A0_16._secondary_weapon_l:set_slot(0)
	end
	A0_16._secondary_weapon_l = nil
	if alive(A0_16._secondary_weapon_r) then
		A0_16._secondary_weapon_r:set_slot(0)
	end
	A0_16._secondary_weapon_r = nil
end
function RailTank.update(A0_17, A1_18, A2_19, A3_20)
	RailVehicle.update(A0_17, A1_18, A2_19, A3_20)
	if A0_17._coop_checking then
		A0_17:_check_for_coop()
	end
	if A2_19 >= A0_17._intersect_check_prev + A0_17._intersect_check_interval then
		A0_17:_check_for_enemy_intersection()
		A0_17._intersect_check_prev = A2_19
	end
	A0_17:_update_engine_rumble(A1_18, A2_19, A3_20)
	A0_17:_update_turret_sound(A1_18, A2_19, A3_20)
	A0_17:_update_engine_sound(A1_18, A2_19, A3_20)
	A0_17:_update_health_alarm_sound(A1_18, A2_19, A3_20)
	if not alive(A0_17._ambience_sound_instance) then
		A0_17._ambience_sound_instance = A0_17._unit:play("tank_ambience")
	end
end
function RailTank._update_health_alarm_sound(A0_21, A1_22, A2_23, A3_24)
	local L4_25, L5_26, L6_27
	L4_25 = A0_21._unit
	L5_26 = L4_25
	L4_25 = L4_25.damage_data
	L4_25 = L4_25(L5_26)
	L5_26 = L4_25.damage
	L6_27 = L4_25.health
	L5_26 = L5_26 / L6_27
	L6_27 = math
	L6_27 = L6_27.clamp
	L6_27 = L6_27(L5_26, 0, 1)
	if not alive(A0_21._health_alarm_sound_instance) then
		A0_21._health_alarm_sound_instance = A0_21._unit:play("tank_alarm")
	end
	A0_21._health_alarm_sound_instance:set_control("t", L6_27)
end
function RailTank._update_turret_sound(A0_28, A1_29, A2_30, A3_31)
	local L4_32
	L4_32 = A0_28._sample_delay_cnt
	if L4_32 <= A0_28._sample_delay then
		L4_32 = A0_28._rotation_angles
		L4_32 = L4_32.add
		L4_32(L4_32, 0, 1)
		L4_32 = A0_28._sample_delay_cnt
		L4_32 = L4_32 + 1
		A0_28._sample_delay_cnt = L4_32
	else
		L4_32 = alive
		L4_32 = L4_32(A0_28._turret_rotation_sound_instance)
		if not L4_32 then
			L4_32 = A0_28._unit
			L4_32 = L4_32.play
			L4_32 = L4_32(L4_32, "tank_turret_loop")
			A0_28._turret_rotation_sound_instance = L4_32
		end
		L4_32 = A0_28._look_input_axis
		if L4_32 then
			L4_32 = A0_28._first_linked_player
			if not L4_32 then
				L4_32 = A0_28.get_first_linked_player
				L4_32 = L4_32(A0_28)
				A0_28._first_linked_player = L4_32
			end
			L4_32 = A0_28._unit
			L4_32 = L4_32.get_object
			L4_32 = L4_32(L4_32, "a_turn_torso")
			L4_32 = L4_32.new_local_rotation
			L4_32 = L4_32(L4_32)
			L4_32 = L4_32.y
			L4_32 = L4_32(L4_32)
			if 0 < A0_28._look_input_axis:length() and A0_28._first_linked_player:base():player_has_control() then
			else
			end
			if A0_28._prev_turret_rot:y():angle(L4_32) >= A0_28._rot_angle_threshold_other then
				A0_28._rotation_angles:add(1, 1)
			else
				A0_28._rotation_angles:add(0, 1)
			end
		else
			L4_32 = A0_28._rotation_angles
			L4_32 = L4_32.add
			L4_32(L4_32, 0, 1)
		end
		L4_32 = math
		L4_32 = L4_32.clamp
		L4_32 = L4_32(A0_28._rotation_angles:value(), 0, 1)
		A0_28._turret_rotation_sound_instance:set_control("t", L4_32)
	end
	L4_32 = A0_28._unit
	L4_32 = L4_32.get_object
	L4_32 = L4_32(L4_32, "a_turn_torso")
	L4_32 = L4_32.new_local_rotation
	L4_32 = L4_32(L4_32)
	A0_28._prev_turret_rot = L4_32
end
function RailTank._update_engine_rumble(A0_33, A1_34, A2_35, A3_36)
	if A0_33._unit:unit_rumble() and A0_33.is_main_tank then
		if managers.worldcamera:current_world_camera() or A0_33:get_speed_kmh() < 1 or A0_33._unit:damage_data():is_fully_damaged() then
			A0_33._unit:unit_rumble():stop()
		elseif not A0_33._unit:unit_rumble():is_playing() then
			A0_33._unit:unit_rumble():play()
		end
	end
end
function RailTank._update_engine_sound(A0_37, A1_38, A2_39, A3_40)
	if A0_37:get_speed_kmh() < 1 then
		if alive(A0_37._drive_loop_sound_instance) then
			A0_37._drive_loop_sound_instance:stop()
		end
		if not alive(A0_37._drive_idle_sound_instance) then
			A0_37._drive_idle_sound_instance = A0_37._unit:play("tank_drive_idle")
		end
		if not alive(A0_37._drive_loop_end_sound_instance) and not A0_37._drive_loop_end_sound_played then
			A0_37._drive_loop_end_sound_instance = A0_37._unit:play("tank_drive_loop_end")
			A0_37._drive_loop_end_sound_played = true
		end
	end
	if A0_37:get_speed_kmh() >= 1 then
		if alive(A0_37._drive_idle_sound_instance) then
			A0_37._drive_idle_sound_instance:stop()
		end
		if not alive(A0_37._drive_loop_sound_instance) then
			A0_37._drive_loop_sound_instance = A0_37._unit:play("tank_drive_loop")
		end
		A0_37._drive_loop_end_sound_played = false
	end
end
function RailTank._check_for_coop(A0_41)
	local L1_42, L2_43, L3_44, L4_45, L5_46, L6_47, L7_48, L8_49, L9_50
	L1_42 = managers
	L1_42 = L1_42.player_slot
	L2_43 = L1_42
	L1_42 = L1_42.slots
	L1_42 = L1_42(L2_43)
	L2_43 = {}
	L3_44 = 0
	for L7_48, L8_49 in L4_45(L5_46) do
		L9_50 = L8_49.spawned_unit
		L9_50 = L9_50(L8_49)
		if alive(L9_50) then
			if L9_50:control():is_human_controlled() then
				L3_44 = L3_44 + 1
			end
			table.insert(L2_43, L9_50)
		end
	end
	if L4_45 ~= L3_44 then
		for L7_48, L8_49 in L4_45(L5_46) do
			L9_50 = L8_49.player_data
			L9_50 = L9_50(L8_49)
			L9_50 = L9_50.on_rail_vehicle
			if L9_50 and L9_50 ~= A0_41._unit then
				if L3_44 == 2 then
					if L8_49:name() == "player2_tank" then
						Application:debug("COOP: Hiding tank 2")
						managers.sequence:run_sequence_simple("hide_2nd_player_tank", L9_50)
						L9_50:base():_hide_weapons(true)
						A0_41.is_main_tank = true
					else
						Application:debug("COOP: Hiding torso 1")
						L9_50:base():_hide_weapons(true)
						managers.sequence:run_sequence_simple("hide_torso", L9_50)
						A0_41.is_main_tank = false
						A0_41.main_tank = L9_50
					end
				elseif L8_49:name() == "player2_tank" then
					Application:debug("SINGLE: Hiding tank 2")
					A0_41.is_main_tank = true
					A0_41:_disable_player(L8_49)
				else
					Application:debug("SINGLE: show torso 1")
					managers.sequence:run_sequence_simple("show_torso", L9_50)
					L9_50:base():_hide_weapons(false)
					A0_41.is_main_tank = false
					A0_41.main_tank = L9_50
					A0_41:_disable_tank()
				end
				A0_41._coop_checking = false
			end
		end
		A0_41._num_human_controlled = L3_44
	end
end
function RailTank._disable_player(A0_51, A1_52)
	local L2_53, L3_54, L4_55, L5_56, L6_57
	L6_57 = L3_54(L4_55)
	for L5_56, L6_57 in L2_53(L3_54, L4_55, L5_56, L6_57, L3_54(L4_55)) do
		A1_52:set_extension_update_enabled(L6_57, L6_57 == "drama")
	end
end
function RailTank._disable_tank(A0_58)
	A0_58:_destroy_weapons()
	A0_58:_stop_sounds()
	A0_58._unit:set_enabled(false)
end
function RailTank._check_for_enemy_intersection(A0_59)
	local L1_60, L2_61, L3_62, L4_63, L5_64, L6_65, L7_66, L8_67, L9_68, L10_69, L11_70, L12_71
	L1_60 = A0_59._unit
	L2_61 = L1_60
	L1_60 = L1_60.rotation
	L1_60 = L1_60(L2_61)
	L3_62 = L1_60
	L2_61 = L1_60.x
	L2_61 = L2_61(L3_62)
	L3_62 = A0_59._intersect_box_width
	L2_61 = L2_61 * L3_62
	L2_61 = L2_61 * 0.5
	L4_63 = L1_60
	L3_62 = L1_60.y
	L3_62 = L3_62(L4_63)
	L4_63 = A0_59._intersect_box_length
	L3_62 = L3_62 * L4_63
	L3_62 = L3_62 * 0.5
	L5_64 = L1_60
	L4_63 = L1_60.z
	L4_63 = L4_63(L5_64)
	L5_64 = A0_59._intersect_box_height
	L4_63 = L4_63 * L5_64
	L4_63 = L4_63 * 0.5
	L5_64 = A0_59._unit
	L6_65 = L5_64
	L5_64 = L5_64.position
	L5_64 = L5_64(L6_65)
	L7_66 = L1_60
	L6_65 = L1_60.y
	L6_65 = L6_65(L7_66)
	L7_66 = A0_59._intersect_box_offset_y
	L6_65 = L6_65 * L7_66
	L5_64 = L5_64 + L6_65
	L7_66 = L1_60
	L6_65 = L1_60.z
	L6_65 = L6_65(L7_66)
	L7_66 = A0_59._intersect_box_offset_z
	L6_65 = L6_65 * L7_66
	L5_64 = L5_64 + L6_65
	L6_65 = OOBB
	L7_66 = L5_64
	L6_65 = L6_65(L7_66, L8_67, L9_68, L10_69)
	L7_66 = A0_59._unit
	L7_66 = L7_66.find_units
	L11_70 = L2_61
	L12_71 = L3_62
	L7_66 = L7_66(L8_67, L9_68, L10_69, L11_70, L12_71, L4_63, A0_59._intersect_check_slots)
	if L7_66 then
		for L11_70, L12_71 in L8_67(L9_68) do
			if L12_71:in_slot(managers.slot:get_mask("enemies")) then
				L12_71:damage():set_fully_damaged()
				managers.rumble:play_preset("rail_tank_intersection", A0_59._unit:get_object("a_turn_torso"):position())
				A0_59._machine_impact_sound_instance = A0_59._unit:play("machine_impact")
			elseif L12_71:in_slot(managers.slot:get_mask("statics")) and L12_71:name() == "rail_sedan01_dented" then
				managers.sequence:run_sequence_simple("delay", L12_71)
				managers.rumble:play_preset("rail_tank_intersection", A0_59._unit:get_object("a_turn_torso"):position())
				A0_59._car_impact_sound_instance = A0_59._unit:play("car_impact")
			end
		end
	end
end
function RailTank.feedback_bullet_hit(A0_72, A1_73, A2_74, A3_75)
	local L4_76
	L4_76 = A0_72._unit
	if L4_76 == A1_73 then
		L4_76 = A2_74.unit
		if A3_75 ~= L4_76:slot() and A3_75 == 4 then
			managers.rumble:play_preset("rail_tank_gatling_killing_hit", A0_72._unit:get_object("a_turn_torso"):position())
		elseif L4_76:in_slot(managers.slot:get_mask("enemies")) then
			managers.rumble:play_preset("rail_tank_gatling_hit", A0_72._unit:get_object("a_turn_torso"):position())
		end
	end
end
function RailTank.show_bullet_hit(A0_77)
	if Application:time() >= A0_77._next_effect_hit then
		A0_77._next_effect_hit = Application:time() + (A0_77._next_effect_hit_duration or 0)
		return true
	end
	return false
end
