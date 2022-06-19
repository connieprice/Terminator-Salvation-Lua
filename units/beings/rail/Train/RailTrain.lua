RailTrain = RailTrain or class(RailVehicle)
RailTrain._ENGINE_SOUNDBANK_NAME = "rs2_sound"
RailTrain._ENGINE_SOUND_NAME = "rs2a_trainloop"
RailTrain._ENGINE_SOUND_OUTPUT_OBJECT_NAME = "rp_vehicle"
function RailTrain.init(A0_0, A1_1)
	local L2_2
	L2_2 = RailVehicle
	L2_2 = L2_2.init
	L2_2(A0_0, A1_1)
	L2_2 = Sound
	L2_2 = L2_2.make_bank
	L2_2 = L2_2(L2_2, RailTrain._ENGINE_SOUNDBANK_NAME, RailTrain._ENGINE_SOUND_NAME)
	A0_0._engine_sound = L2_2
	L2_2 = A1_1.get_object
	L2_2 = L2_2(A1_1, RailTrain._ENGINE_SOUND_OUTPUT_OBJECT_NAME)
	assert(A0_0._engine_sound, "Sound not found.")
	A0_0._engine_sound:set_output(L2_2)
	A0_0._engine_sound:set_ambient(true)
	A0_0._player_cam_time = 0
	A0_0._spark_time = nil
	A0_0._spark_delay = nil
	A0_0._passenger_units = {}
end
function RailTrain.update(A0_3, A1_4, A2_5, A3_6)
	RailVehicle.update(A0_3, A1_4, A2_5, A3_6)
	if not managers.worldcamera:current_world_camera() then
		A0_3._player_cam_time = A0_3._player_cam_time + A3_6
	else
		A0_3._player_cam_time = 0
	end
	A0_3:_update_rumble(A1_4, A2_5, A3_6)
	A0_3:_update_sparks(A1_4, A2_5, A3_6)
end
function RailTrain._update_rumble(A0_7, A1_8, A2_9, A3_10)
	if A0_7._unit:unit_rumble() then
		if managers.worldcamera:current_world_camera() or A0_7:get_speed_kmh() < 1 or A0_7._unit:damage_data():is_fully_damaged() then
			A0_7._unit:unit_rumble():stop()
		elseif not A0_7._unit:unit_rumble():is_playing() and 1 < A0_7._player_cam_time then
			A0_7._unit:unit_rumble():play()
		end
	end
end
function RailTrain._update_sparks(A0_11, A1_12, A2_13, A3_14)
	if not A0_11._spark_delay then
		A0_11._spark_delay = A2_13 + A0_11:_get_spark_delay(A1_12, A2_13, A3_14)
	end
	if A2_13 >= A0_11._spark_delay and A0_11:get_speed_kmh() >= 70 and not A0_11._unit:damage_data():is_fully_damaged() and not A0_11._spark_show_time then
		managers.sequence:run_sequence_simple("recurring_sparks", A0_11._unit)
		A0_11._spark_show_time = A2_13 + A0_11:_get_spark_show_time(A1_12, A2_13, A3_14)
	end
	if A0_11._spark_show_time and A2_13 >= A0_11._spark_show_time then
		managers.sequence:run_sequence_simple("recurring_sparks_disable", A0_11._unit)
		A0_11._spark_delay = A2_13 + A0_11:_get_spark_delay(A1_12, A2_13, A3_14)
		A0_11._spark_show_time = nil
	end
end
function RailTrain._get_spark_show_time(A0_15, A1_16, A2_17, A3_18)
	return A0_15._spark_show_time_min + math.random() * (A0_15._spark_show_time_max - A0_15._spark_show_time_min)
end
function RailTrain._get_spark_delay(A0_19, A1_20, A2_21, A3_22)
	return A0_19._spark_delay_min + math.random() * (A0_19._spark_delay_max - A0_19._spark_delay_min)
end
function RailTrain.destroy(A0_23)
	RailVehicle.destroy(A0_23)
	A0_23._engine_sound:stop()
end
function RailTrain.spawn_driver_and_passenger(A0_24)
	local L1_25, L2_26, L3_27, L4_28, L5_29, L6_30, L7_31, L8_32, L9_33, L10_34, L11_35, L12_36
	L1_25 = 123
	if L2_26 then
		for L5_29, L6_30 in L2_26(L3_27) do
			L7_31 = A0_24._unit
			L8_32 = L7_31
			L7_31 = L7_31.get_object
			L9_33 = L6_30._align_object
			L7_31 = L7_31(L8_32, L9_33)
			L8_32 = math
			L8_32 = L8_32.string_to_vector
			L9_33 = L6_30._align_offset
			L8_32 = L8_32(L9_33)
			L9_33 = L6_30._unit_name
			L10_34 = L6_30._init_state
			L11_35 = World
			L12_36 = L11_35
			L11_35 = L11_35.spawn_unit
			L11_35 = L11_35(L12_36, L9_33, L7_31:position(), L7_31:rotation())
			L12_36 = L11_35.driver
			L12_36 = L12_36(L11_35)
			L12_36 = L12_36.setup
			L12_36(L12_36, false)
			L12_36 = table
			L12_36 = L12_36.insert
			L12_36(A0_24._passenger_units, L11_35)
			L12_36 = A0_24._unit
			L12_36 = L12_36.link
			L12_36(L12_36, L6_30._align_object, L11_35, L11_35:orientation_object():name())
			L12_36 = L11_35.move
			L12_36(L11_35, L8_32)
			L12_36 = L11_35.driver
			L12_36 = L12_36(L11_35)
			L12_36 = L12_36.set_vehicle
			L12_36(L12_36, A0_24._unit)
			L12_36 = L11_35.damage
			L12_36 = L12_36(L11_35)
			L12_36 = L12_36.set_immune_to_damage
			L12_36(L12_36, true)
			L12_36 = L11_35.driver
			L12_36 = L12_36(L11_35)
			L12_36 = L12_36.character_name
			if L12_36 then
				managers.unit_scripting:register_unit(L12_36, L11_35)
				managers.drama_scene:set_unit_name_to_script_name(L12_36, L12_36)
			end
			L11_35:play_redirect(L10_34)
		end
	end
end
function RailTrain.destroy(A0_37)
	local L1_38, L2_39, L3_40, L4_41, L5_42
	L1_38(L2_39)
	for L4_41, L5_42 in L1_38(L2_39) do
		if alive(L5_42) then
			L5_42:driver():remove()
		end
	end
	A0_37._passenger_units = nil
end
function RailTrain.apply_damage_settings(A0_43, A1_44, A2_45)
	if A1_44 == managers.unit_scripting:get_unit_by_name("character_slot1") then
		A0_43._unit:damage():set_damage_multiplier(A2_45.DAMAGE_MULTIPLIER)
		A0_43._unit:damage():set_health_regen_multiplier(A2_45.HEALTH_REGEN_MULTIPLIER)
		Application:debug("DAMAGE MULTIPLIER " .. A2_45.DAMAGE_MULTIPLIER .. " " .. A1_44:name() .. " -> " .. A0_43._unit:name())
	end
end
