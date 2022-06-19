if not RailTrain then
	RailTrain = class(RailVehicle)
end
RailTrain._ENGINE_SOUNDBANK_NAME = "rs2_sound"
RailTrain._ENGINE_SOUND_NAME = "rs2a_trainloop"
RailTrain._ENGINE_SOUND_OUTPUT_OBJECT_NAME = "rp_vehicle"
RailTrain.init = function(l_1_0, l_1_1)
	RailVehicle.init(l_1_0, l_1_1)
	l_1_0._engine_sound = Sound:make_bank(RailTrain._ENGINE_SOUNDBANK_NAME, RailTrain._ENGINE_SOUND_NAME)
	local l_1_2 = l_1_1:get_object(RailTrain._ENGINE_SOUND_OUTPUT_OBJECT_NAME)
	assert(l_1_0._engine_sound, "Sound not found.")
	l_1_0._engine_sound:set_output(l_1_2)
	l_1_0._engine_sound:set_ambient(true)
	l_1_0._player_cam_time = 0
	l_1_0._spark_time = nil
	l_1_0._spark_delay = nil
	l_1_0._passenger_units = {}
end

RailTrain.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	RailVehicle.update(l_2_0, l_2_1, l_2_2, l_2_3)
	if not managers.worldcamera:current_world_camera() then
		l_2_0._player_cam_time = l_2_0._player_cam_time + l_2_3
	else
		l_2_0._player_cam_time = 0
	end
	l_2_0:_update_rumble(l_2_1, l_2_2, l_2_3)
	l_2_0:_update_sparks(l_2_1, l_2_2, l_2_3)
end

RailTrain._update_rumble = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_0._unit:unit_rumble()
	if l_3_4 then
		if managers.worldcamera:current_world_camera() or l_3_0:get_speed_kmh() < 1 or l_3_0._unit:damage_data():is_fully_damaged() then
			l_3_4:stop()
		end
	else
		if not l_3_4:is_playing() and l_3_0._player_cam_time > 1 then
			l_3_4:play()
		end
	end
end

RailTrain._update_sparks = function(l_4_0, l_4_1, l_4_2, l_4_3)
	if not l_4_0._spark_delay then
		l_4_0._spark_delay = l_4_2 + l_4_0:_get_spark_delay(l_4_1, l_4_2, l_4_3)
	end
	if l_4_0._spark_delay <= l_4_2 and l_4_0:get_speed_kmh() >= 70 and not l_4_0._unit:damage_data():is_fully_damaged() and not l_4_0._spark_show_time then
		managers.sequence:run_sequence_simple("recurring_sparks", l_4_0._unit)
		l_4_0._spark_show_time = l_4_2 + l_4_0:_get_spark_show_time(l_4_1, l_4_2, l_4_3)
	end
	if l_4_0._spark_show_time and l_4_0._spark_show_time <= l_4_2 then
		managers.sequence:run_sequence_simple("recurring_sparks_disable", l_4_0._unit)
		l_4_0._spark_delay = l_4_2 + l_4_0:_get_spark_delay(l_4_1, l_4_2, l_4_3)
		l_4_0._spark_show_time = nil
	end
end

RailTrain._get_spark_show_time = function(l_5_0, l_5_1, l_5_2, l_5_3)
	return l_5_0._spark_show_time_min + math.random() * (l_5_0._spark_show_time_max - l_5_0._spark_show_time_min)
end

RailTrain._get_spark_delay = function(l_6_0, l_6_1, l_6_2, l_6_3)
	return l_6_0._spark_delay_min + math.random() * (l_6_0._spark_delay_max - l_6_0._spark_delay_min)
end

RailTrain.destroy = function(l_7_0)
	RailVehicle.destroy(l_7_0)
	l_7_0._engine_sound:stop()
end

RailTrain.spawn_driver_and_passenger = function(l_8_0)
	local l_8_5, l_8_6, l_8_7, l_8_8, l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14 = nil
	local l_8_1 = 123
	if l_8_0._passengers then
		for i_0,i_1 in pairs(l_8_0._passengers) do
			local l_8_17 = l_8_0._unit:get_object(i_1._align_object)
			local l_8_18 = math.string_to_vector(i_1._align_offset)
			local l_8_19 = nil
			World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):driver():setup(false)
			table.insert(l_8_0._passenger_units, World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()))
			l_8_0._unit:link(l_8_16._align_object, World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()), World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):orientation_object():name())
			World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):move(l_8_18)
			World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):driver():set_vehicle(l_8_0._unit)
			World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):damage():set_immune_to_damage(true)
			local l_8_20 = l_8_16._init_state
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):driver().character_name then
				managers.unit_scripting:register_unit(World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):driver().character_name, World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()))
				 -- DECOMPILER ERROR: Confused about usage of registers!

				 -- DECOMPILER ERROR: Confused about usage of registers!

				managers.drama_scene:set_unit_name_to_script_name(World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):driver().character_name, World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):driver().character_name)
			end
			World:spawn_unit(l_8_16._unit_name, l_8_17:position(), l_8_17:rotation()):play_redirect(l_8_20)
		end
	end
end

RailTrain.destroy = function(l_9_0)
	local l_9_4, l_9_5, l_9_6, l_9_7, l_9_8, l_9_9 = nil
	RailVehicle.destroy(l_9_0)
	for i_0,i_1 in ipairs(l_9_0._passenger_units) do
		if alive(i_1) then
			i_1:driver():remove()
		end
	end
	l_9_0._passenger_units = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailTrain.apply_damage_settings = function(l_10_0, l_10_1, l_10_2)
	local l_10_3 = managers.unit_scripting:get_unit_by_name("character_slot1")
	if l_10_1 == l_10_3 then
		l_10_0._unit:damage():set_damage_multiplier(l_10_2.DAMAGE_MULTIPLIER)
		l_10_0._unit:damage():set_health_regen_multiplier(l_10_2.HEALTH_REGEN_MULTIPLIER)
		Application:debug("DAMAGE MULTIPLIER " .. l_10_2.DAMAGE_MULTIPLIER .. " " .. l_10_1:name() .. " -> " .. l_10_0._unit:name())
	end
end


