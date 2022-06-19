require("shared/Angle")
if not RailVehicle then
	RailVehicle = class()
end
require("units/beings/rail/RailVehicleSeat")
require("units/beings/rail/cameras/RailCameraLinkInfo")
require("shared/Stack")
require("shared/TableAlgorithms")
RailVehicle._ROTATION_SAMPLE_COUNT = 10
RailVehicle.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._unit:set_driving("animation")
	l_1_0._seats = {}
	l_1_0._damage_callbacks = {}
	l_1_0._active_damage_callbacks = {}
	l_1_0._activated_callback_hubs = {}
	l_1_0._state_machine = l_1_0._unit:anim_state_machine()
	l_1_0._animation_set_name = l_1_0._unit:name()
	l_1_0._animation_set = AnimationManager:animation_set(l_1_0._animation_set_name)
	assert(l_1_0._animation_set, "The animation set must have the same name as the unit" .. l_1_0._animation_set_name)
	l_1_0._speed_vectors = AverageOverTime:new(25, Vector3(0, 0, 0))
	l_1_0._acceleration_vectors = AverageOverTime:new(25, Vector3(0, 0, 0))
	l_1_0._accelerations = AverageOverTime:new(10)
	l_1_0._total_current_rot = Vector3(0, 0, 0)
	l_1_0._current_position = l_1_0._unit:position()
	l_1_0._current_speed_vector = Vector3(0, 0, 0)
	l_1_0._current_acc_vector = Vector3(0, 0, 0)
	l_1_0._current_acc = 0
	l_1_0._start_rotation = l_1_0._unit:rotation()
	l_1_0._start_position = l_1_0._unit:position()
	l_1_0._unit:set_animation_lod(1, 1000000, 500, 1000000)
	l_1_0._current_state = nil
	l_1_0._current_anim_time = 0
	l_1_0._total_animation_time = 0
	l_1_0._animation_speed_mult = 1
	l_1_0._last_wheel_rot = 0
	l_1_0._transition = false
	l_1_0._ragdolled = false
	l_1_0._warp_to_start = true
	l_1_0._heavy_acc = false
	l_1_0._heavy_dec = false
	if l_1_0._turret_unit_name then
		l_1_0._turret_unit = World:spawn_unit(l_1_0._turret_unit_name, Vector3(0, 0, 0), Rotation(0, 0, 0))
		l_1_0:link_unit_to_vehicle(l_1_0._turret_unit, l_1_0._turret_align_object, true)
		l_1_0._turret_unit:turret():set_vehicle(l_1_0._unit)
	end
	l_1_0._emitter = managers.action_event:create_emitter(l_1_1)
end

RailVehicle.set_seats = function(l_2_0, l_2_1)
	l_2_0._seats = l_2_1
end

RailVehicle.spawn_driver_and_passenger = function(l_3_0, l_3_1, l_3_2)
	if l_3_1 ~= "empty seat" and l_3_0._driver_align_object then
		if l_3_1 and l_3_1 ~= "" then
			l_3_0._driver_name = l_3_1
		end
		l_3_0._driver = l_3_0:spawn_driver(l_3_0._driver_name, l_3_0._driver_align_object, true)
	end
	if l_3_2 ~= "empty seat" and l_3_0._passenger_align_object then
		if l_3_2 and l_3_2 ~= "" then
			l_3_0._passenger_name = l_3_2
		end
		l_3_0._passenger = l_3_0:spawn_driver(l_3_0._passenger_name, l_3_0._passenger_align_object, false)
	end
end

RailVehicle.spawn_driver = function(l_4_0, l_4_1, l_4_2, l_4_3)
	local l_4_4 = nil
	if l_4_1 then
		local l_4_5 = nil
		l_4_5 = World:spawn_unit(l_4_1, l_4_0._unit:get_object(l_4_2):position(), l_4_0._unit:get_object(l_4_2):rotation())
		l_4_5:driver():setup(l_4_3)
		l_4_0._unit:link(l_4_2, l_4_5, l_4_5:orientation_object():name())
		l_4_5:driver():set_vehicle(l_4_0._unit)
		l_4_5:damage():set_immune_to_damage(true)
		local l_4_6 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_4_5:driver().character_name then
			managers.unit_scripting:register_unit(l_4_5:driver().character_name, l_4_5)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			managers.drama_scene:set_unit_name_to_script_name(l_4_5:driver().character_name, l_4_5:driver().character_name)
		end
		return l_4_5
	end
end

RailVehicle.get_turret_unit = function(l_5_0)
	return l_5_0._turret_unit
end

RailVehicle.get_ai_player_miss_dispersion_modifier = function(l_6_0)
	return l_6_0._unit:vehicle_data()._ai_player_miss_dispersion_modifier
end

RailVehicle.update = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if l_7_0._ragdolled then
		return 
	end
	if l_7_0._transition then
		l_7_0:start(l_7_0._trans_anim, l_7_0._trans_time)
		l_7_0._transition = false
	else
		l_7_0:_update_animation(l_7_3)
	end
	l_7_0:calculate_speed(l_7_3)
	l_7_0:_update_damage_status()
	l_7_0:_update_connector_callbacks(l_7_2, l_7_3)
	l_7_0:_update_animation_speed_interpolator(l_7_3)
end

RailVehicle.transition = function(l_8_0, l_8_1, l_8_2, l_8_3)
	l_8_0._transition = true
	l_8_0._trans_anim = l_8_1
	l_8_0._trans_time = l_8_2
	if l_8_3 then
		l_8_0._warp_to_start = false
	end
end

RailVehicle.start = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = assert
	l_9_3(l_9_1 ~= nil, "No animation defined in rail-vehicle")
	l_9_3 = l_9_0._state_machine
	l_9_3(l_9_3, l_9_1)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_9_0._current_state = l_9_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_9_0._current_animation = l_9_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_9_3 then
		l_9_0._total_animation_time = l_9_3
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_9_3 then
		l_9_3(l_9_3, l_9_0._start_rotation, l_9_0._start_position)
	end
	if l_9_2 then
		l_9_0._current_anim_time = l_9_2
	else
		l_9_0._current_anim_time = 0
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_9_3(l_9_0, 0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_9_3(l_9_3, "script")
end

RailVehicle.set_animation_start = function(l_10_0, l_10_1, l_10_2)
	l_10_0._start_position = l_10_1
	l_10_0._start_rotation = l_10_2
end

RailVehicle._update_animation = function(l_11_0, l_11_1)
	l_11_0._unit:set_driving("animation")
	if l_11_0._total_animation_time > 0 then
		l_11_0._current_anim_time = l_11_0._current_anim_time + l_11_1 * l_11_0._animation_speed_mult
		l_11_0._state_machine:set_global("g_time", l_11_0._current_anim_time / l_11_0._total_animation_time)
	end
end

RailVehicle.set_animation_speed = function(l_12_0, l_12_1)
	l_12_0._animation_speed_mult = l_12_1
end

RailVehicle.set_animation_speed_interpolator_target = function(l_13_0, l_13_1, l_13_2)
	if not l_13_0._animation_speed_interpolator then
		l_13_0._animation_speed_interpolator = InterpolatorLinear:new(l_13_0._animation_speed_mult, 1 / l_13_2)
		l_13_0._animation_speed_interpolator:set_target(l_13_1)
	else
		l_13_0._animation_speed_interpolator:set_target(l_13_1)
		l_13_0._animation_speed_interpolator:set_speed(1 / l_13_2)
	end
end

RailVehicle._update_animation_speed_interpolator = function(l_14_0, l_14_1)
	if l_14_0._animation_speed_interpolator and not l_14_0._animation_speed_interpolator:has_reached_target() then
		l_14_0._animation_speed_interpolator:update(l_14_1)
		l_14_0._animation_speed_mult = l_14_0._animation_speed_interpolator:value()
	end
end

RailVehicle.link_player_to_first_empty_seat = function(l_15_0, l_15_1)
	local l_15_5, l_15_6, l_15_7, l_15_8, l_15_9, l_15_10 = nil
	for i_0,i_1 in pairs(l_15_0._seats) do
		if i_1:is_empty() then
			l_15_0:_link_player_to_seat(l_15_1, i_1)
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailVehicle.link_player_to_seat_name = function(l_16_0, l_16_1, l_16_2)
	assert(l_16_0._seats[l_16_2])
	local l_16_3 = l_16_0._seats[l_16_2]
	if l_16_3:is_empty() then
		l_16_0:_link_player_to_seat(l_16_1, l_16_3)
		return true
	end
	return false
end

RailVehicle._link_player_to_seat = function(l_17_0, l_17_1, l_17_2, l_17_3)
	local l_17_4 = nil
	l_17_1:unlink()
	if l_17_2:get_align_object() ~= nil then
		l_17_4 = l_17_2:get_align_object()
	else
		l_17_4 = l_17_0._align_object
	end
	if l_17_0._turret_unit then
		l_17_0:link_unit_to_turret(l_17_1, l_17_4, l_17_3)
		l_17_0:offset_player_position_on_vehicle(l_17_0._turret_unit, l_17_1, l_17_4, l_17_2, l_17_3)
	else
		l_17_1:base():kill_mover()
		l_17_0._unit:link(l_17_4, l_17_1, l_17_1:orientation_object():name())
	end
	l_17_2:set_unit(l_17_1)
end

RailVehicle.unlink_player = function(l_18_0, l_18_1)
	l_18_1:rail():exit_vehicle()
	l_18_1:unlink()
	l_18_1:play_redirect("idle_std")
end

RailVehicle.get_first_linked_player = function(l_19_0)
	local l_19_4, l_19_5, l_19_6, l_19_7, l_19_8, l_19_9 = nil
	for i_0,i_1 in pairs(l_19_0._seats) do
		if not i_1:is_empty() then
			return i_1:get_unit()
		end
	end
end

RailVehicle.fully_damaged = function(l_20_0)
	if l_20_0._enemy_data and not l_20_0._enemy_data.dead then
		l_20_0._enemy_data.dead = true
	end
	if l_20_0._unit:vehcile_data() then
		l_20_0._unit:vehicle_data().destroyed = true
	end
	l_20_0._emitter:unit_fully_damaged(l_20_0._unit)
	managers.unit_scripting:unit_dead(l_20_0._unit)
end

RailVehicle.destroy = function(l_21_0)
	managers.unit_scripting:unit_destroyed(l_21_0._unit)
	l_21_0:remove_turret()
	if alive(l_21_0._driver) then
		l_21_0._driver:driver():remove()
		l_21_0._driver = nil
	end
	if alive(l_21_0._passenger) then
		l_21_0._passenger:driver():remove()
		l_21_0._passenger = nil
	end
end

RailVehicle.link_unit_to_vehicle = function(l_22_0, l_22_1, l_22_2, l_22_3)
	l_22_1:kill_mover()
	if l_22_3 then
		l_22_1:set_rotation(l_22_0._unit:get_object(l_22_2):rotation())
	end
	l_22_0._unit:link(l_22_2, l_22_1, l_22_1:orientation_object():name())
end

RailVehicle.link_unit_to_turret = function(l_23_0, l_23_1, l_23_2, l_23_3)
	l_23_1:kill_mover()
	if l_23_3 then
		l_23_1:set_rotation(l_23_0._turret_unit:get_object(l_23_2):rotation())
	end
	l_23_0._turret_unit:link(l_23_2, l_23_1, l_23_1:orientation_object():name())
end

RailVehicle.get_seat = function(l_24_0, l_24_1)
	local l_24_5, l_24_6, l_24_7, l_24_8 = nil
	for i_0,i_1 in pairs(l_24_0._seats) do
		if i_1:get_unit() == l_24_1 then
			return i_1
		end
	end
end

RailVehicle.get_players_in_vehicle = function(l_25_0)
	local l_25_5, l_25_6, l_25_7, l_25_8, l_25_9, l_25_10 = nil
	local l_25_1 = {}
	for i_0,i_1 in pairs(l_25_0._seats) do
		if not i_1:is_empty() then
			table.insert(l_25_1, i_1:get_unit())
		end
	end
	return l_25_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailVehicle.move_player_to_seat_name = function(l_26_0, l_26_1, l_26_2)
	assert(l_26_0._seats[l_26_2])
	assert(l_26_0:link_player_to_seat_name(l_26_1, l_26_2))
	l_26_0:get_seat(l_26_1):remove_unit()
	l_26_0._seats[l_26_2]:set_unit(l_26_1)
end

RailVehicle.offset_player_position_on_vehicle = function(l_27_0, l_27_1, l_27_2, l_27_3, l_27_4, l_27_5)
	local l_27_6 = l_27_1:get_object(l_27_3)
	local l_27_7 = l_27_4:get_offset()
	if l_27_5 then
		l_27_7 = l_27_7:rotate_with(l_27_1:get_object(l_27_0._align_object):rotation())
	end
	l_27_2:set_position(l_27_6:position() + l_27_7)
end

RailVehicle.brace_needed = function(l_28_0)
	return false
end

RailVehicle.calculate_speed = function(l_29_0, l_29_1)
	local l_29_2 = l_29_0._unit:get_object(l_29_0._align_object)
	local l_29_3 = l_29_0._current_position
	l_29_0._current_position = l_29_2:position()
	local l_29_4 = l_29_0._current_position - l_29_3
	l_29_0._speed_vectors:add(l_29_4, l_29_1)
	local l_29_5 = l_29_0._current_speed_vector
	l_29_0._current_speed_vector = l_29_0._speed_vectors:value()
	if l_29_0._current_speed_vector == 0 then
		l_29_0._current_speed_vector = Vector3(0, 0, 0)
	end
	local l_29_6 = l_29_0._current_speed_vector - l_29_5
	l_29_0._acceleration_vectors:add(l_29_6, l_29_1)
	l_29_0._current_acc_vector = l_29_0._acceleration_vectors:value()
	l_29_0._accelerations:add(l_29_0._current_speed_vector:length() - l_29_5:length(), l_29_1)
	l_29_0._current_acc = l_29_0._accelerations:value() or 0
end

RailVehicle.get_speed_kmh = function(l_30_0)
	return l_30_0._current_speed_vector:length() * 3.6 / 100
end

RailVehicle.get_acceleration_kmh = function(l_31_0)
	return l_31_0._current_acc * 3.6 / 100
end

RailVehicle.get_speed_vector = function(l_32_0)
	return l_32_0._current_speed_vector
end

RailVehicle.get_acceleration_vec = function(l_33_0)
	return l_33_0._current_acc_vector
end

RailVehicle.read_seats = function(l_34_0, l_34_1)
	local l_34_8, l_34_9, l_34_10 = nil
	local l_34_2 = "data/rail/" .. l_34_1 .. "/seats.xml"
	local l_34_3 = {}
	if File:exists(l_34_2) then
		local l_34_4 = File:parse_xml(l_34_2)
		for i_0 in l_34_4:children() do
			l_34_3[i_0:parameter("name")] = RailVehicleSeat:new(l_34_11)
		end
	else
		cat_debug("rail", l_34_2, "not found!")
	end
	return l_34_3
end

RailVehicle.fill_connector_callbacks = function(l_35_0, l_35_1)
	local l_35_5, l_35_6, l_35_7, l_35_8, l_35_9, l_35_10, l_35_11, l_35_12 = nil
	l_35_0._current_callback = nil
	l_35_0._connector_callbacks = nil
	if l_35_1 and #l_35_1 > 0 then
		l_35_0._connector_callbacks = Stack:new()
		table.sort(l_35_1, function(l_36_0, l_36_1)
			return l_36_1.time < l_36_0.time
    end)
		for i_0,i_1 in pairs(l_35_1) do
			if i_1.hub_key and managers.world:current_stage():get_hub(i_1.hub_key.script_name) then
				l_35_0:_add_connector_callback(i_1.time, managers.world:current_stage():get_hub(i_1.hub_key.script_name), i_1.warp_time)
			end
		end
		l_35_0:_get_next_connector()
		l_35_0._connector_refill = true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

RailVehicle._add_connector_callback = function(l_36_0, l_36_1, l_36_2, l_36_3)
	local l_36_4 = {}
	l_36_4.time = l_36_1
	l_36_4.hub_element = l_36_2
	l_36_4.warp_time = l_36_3
	l_36_0._connector_callbacks:push(l_36_4)
end

RailVehicle.activate_status_callbacks = function(l_37_0, l_37_1)
	local l_37_5, l_37_6, l_37_7, l_37_8 = nil
	for i_0,i_1 in pairs(l_37_0._damage_callbacks) do
		if i_1.hub_element_name == l_37_1 then
			l_37_0._active_damage_callbacks[#l_37_0._active_damage_callbacks + 1] = i_1
		end
	end
	table.insert(l_37_0._activated_callback_hubs, l_37_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailVehicle._update_connector_callbacks = function(l_38_0, l_38_1, l_38_2)
	if l_38_0._current_callback then
		local l_38_3 = l_38_0._current_anim_time
		if not l_38_0._current_callback.warp_time then
			l_38_3 = l_38_0._unit:anim_state_machine():segment_real_time("body")
		end
	if l_38_0._current_callback.time <= l_38_3 then
		end
		if l_38_0._current_callback.hub_element then
			l_38_0._connector_refill = false
			l_38_0._current_callback.hub_element:activate()
			if l_38_0._connector_refill then
				return 
			end
		end
		l_38_0:_get_next_connector()
	end
end

RailVehicle._get_next_connector = function(l_39_0)
	if l_39_0._connector_callbacks and not l_39_0._connector_callbacks:is_empty() then
		l_39_0._current_callback = l_39_0._connector_callbacks:pop()
		return 
	end
	l_39_0._current_callback = nil
end

RailVehicle.register_status_callback = function(l_40_0, l_40_1)
	if l_40_1.status_type == "damage" or l_40_1.status_type == "health" or l_40_1.status_type == "hitzones" then
		if table.contains(l_40_0._activated_callback_hubs, l_40_1.hub_element_name) then
			local l_40_2 = #l_40_0._active_damage_callbacks + 1
			l_40_0._active_damage_callbacks[l_40_2] = l_40_1
		else
			local l_40_3 = #l_40_0._damage_callbacks + 1
			l_40_0._damage_callbacks[l_40_3] = l_40_1
		end
	else
		assert(false, "Unknown condition type" .. l_40_1.status_type)
	end
end

RailVehicle._update_damage_status = function(l_41_0)
	local l_41_7, l_41_8, l_41_9, l_41_10, l_41_11, l_41_12, l_41_13, l_41_14, l_41_15, l_41_16, l_41_17, l_41_18, l_41_19, l_41_20, l_41_21, l_41_22 = nil
	local l_41_1 = l_41_0._unit:damage_data().damage
	local l_41_2 = l_41_0._unit:damage_data().health - l_41_1
	local l_41_3 = false
	for i_0,i_1 in pairs(l_41_0._active_damage_callbacks) do
		if (i_1.status_type == "damage" and i_1.threshold < l_41_1) or i_1.status_type ~= "health" or i_1.status_type == "hitzones" and l_41_0:_hitzones_status(i_1.hitzones) then
			assert(i_1.callback)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			i_1.callback()
			l_41_0._active_damage_callbacks[l_41_23] = nil
			l_41_3 = true
		end
	end
	if l_41_3 then
		TableAlgorithms.restore_indices(l_41_0._active_damage_callbacks)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

RailVehicle._hitzones_status = function(l_42_0, l_42_1)
	local l_42_6, l_42_7, l_42_8, l_42_9 = nil
	local l_42_2 = l_42_0._unit:damage()
	for i_0,i_1 in ipairs(l_42_1.alive) do
		if l_42_2:zone_destroyed(i_1) then
			return false
		end
	end
	for i_0,i_1 in ipairs(l_42_1.destroyed) do
		if not l_42_2:zone_destroyed(i_1) then
			return false
		end
	end
	return true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

RailVehicle.remove_turret = function(l_43_0)
	if alive(l_43_0._turret_unit) then
		l_43_0._turret_unit:set_slot(0)
		l_43_0._turret_unit = nil
	end
end

RailVehicle.disable_anim_state_machine = function(l_44_0)
	l_44_0._unit:set_animations_enabled(false)
	l_44_0._unit:set_driving("orientation_object")
	if alive(l_44_0._driver) then
		if tweak_data.rail.USE_RAGDOLLS then
			l_44_0._driver:driver():ragdoll()
		end
	else
		l_44_0._driver:set_visible(false)
	end
	if alive(l_44_0._passenger) then
		if tweak_data.rail.USE_RAGDOLLS then
			l_44_0._passenger:driver():ragdoll()
		end
	else
		l_44_0._passenger:set_visible(false)
	end
	l_44_0._ragdolled = true
	l_44_0:_update_damage_status()
end

RailVehicle.run_sequence_on_vehicle = function(l_45_0, l_45_1, l_45_2)
	managers.sequence:run_sequence_simple(l_45_2, l_45_1)
end

RailVehicle.apply_damage_settings = function(l_46_0, l_46_1, l_46_2)
	l_46_0._unit:damage():set_damage_multiplier(l_46_2.DAMAGE_MULTIPLIER)
	l_46_0._unit:damage():set_health_regen_multiplier(l_46_2.HEALTH_REGEN_MULTIPLIER)
	Application:debug("DAMAGE MULTIPLIER " .. l_46_2.DAMAGE_MULTIPLIER .. " " .. l_46_1:name() .. " -> " .. l_46_0._unit:name())
end

RailVehicle.play_preset_rumble = function(l_47_0, l_47_1, l_47_2)
	managers.rumble:play_preset(l_47_1, l_47_0._unit:get_object(l_47_2):position())
end


