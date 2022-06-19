if not PlayerRail then
	PlayerRail = class()
end
PlayerRail.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._vehicle = nil
	l_1_0._player_data = l_1_1:player_data()
	l_1_0._align_rotation_to_camera = true
	l_1_0._unit:set_extension_update_enabled("rail", false)
end

PlayerRail.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	if alive(l_2_0._vehicle) then
		if not l_2_0._unit:base():player_has_control() then
			l_2_0._vehicle:damage_data().invulnerable = true
		else
			l_2_0._vehicle:damage_data().invulnerable = false
		end
		if not l_2_0._vehicle:base():get_ai_player_miss_dispersion_modifier() then
			l_2_0._player_data.vehicle_miss_dispersion_modifier = not managers.player or managers.player:is_human_player(l_2_0._unit) or 1
		end
		l_2_0._player_data.firing_from_vehicle = true
		l_2_0:update_align()
	end
	if not l_2_0._unmounted_vehicles_registered then
		l_2_0:_register_unmounted_vehicles()
		l_2_0._unmounted_vehicles_registered = true
	end
end

PlayerRail.destroy = function(l_3_0)
	l_3_0._unit = nil
end

PlayerRail.get_rail_state = function(l_4_0)
	if l_4_0._vehicle ~= nil then
		local l_4_1 = l_4_0._vehicle:base():get_seat(l_4_0._unit)
		assert(l_4_1)
		local l_4_2 = rawget(_G, l_4_1:get_state_name())
		assert(l_4_2)
		local l_4_3, l_4_4 = l_4_2:new, l_4_2
		local l_4_5 = l_4_0._unit
		return l_4_3(l_4_4, l_4_5)
	end
end

PlayerRail.enter_vehicle = function(l_5_0, l_5_1, l_5_2)
	if l_5_1 then
		l_5_0._vehicle = l_5_1
		local l_5_3 = false
		if l_5_2 == "random" then
			l_5_3 = l_5_0._vehicle:base():link_player_to_first_empty_seat(l_5_0._unit)
		else
			l_5_3 = l_5_0._vehicle:base():link_player_to_seat_name(l_5_0._unit, l_5_2)
		end
	if l_5_3 then
		end
		l_5_0._player_data.named_camera_targets.vehicle = l_5_1
		l_5_0._player_data.named_camera_targets.weapon = l_5_1:base():get_turret_unit()
		l_5_0._unit:base():enter_rail()
		l_5_0._player_data.on_rail_vehicle = l_5_0._vehicle
		l_5_0._player_data.rail_vehicle_camera = l_5_1:vehicle_data().default_camera
		l_5_0._unit:difficulty_level():enter_rail()
		l_5_0._unit:set_local_rotation(Rotation(0, 0, 0))
		l_5_0._unit:set_extension_update_enabled("rail", true)
		return true
	end
	return false
end

PlayerRail.exit_vehicle = function(l_6_0)
	l_6_0._unit:unlink()
	l_6_0._unit:play_redirect("idle_std")
	l_6_0._player_data.on_rail_vehicle = nil
	l_6_0._vehicle = nil
	l_6_0._unit:set_extension_update_enabled("rail", false)
end

PlayerRail.get_vehicle = function(l_7_0)
	return l_7_0._vehicle
end

PlayerRail.change_seat = function(l_8_0, l_8_1)
	l_8_0._vehicle:base():move_player_to_seat_name(l_8_0._unit, l_8_1)
end

PlayerRail.update_align = function(l_9_0)
	if not l_9_0._vehicle then
		return 
	end
	local l_9_1 = l_9_0._vehicle:base():get_seat(l_9_0._unit)
	assert(l_9_1)
	local l_9_2, l_9_3, l_9_4 = l_9_0._unit:camera():camera_constraints()
	if l_9_2 then
		l_9_2 = l_9_0._vehicle:rotation():inverse():rotate_with(l_9_2):roll()
		l_9_1:set_rotation(Rotation(0, 0, l_9_2))
	end
end

PlayerRail.align_rotation_to_camera = function(l_10_0, l_10_1)
	l_10_0._align_rotation_to_camera = l_10_1
end

PlayerRail.player_leave_vehicle = function(l_11_0)
	local l_11_1 = l_11_0._vehicle:base():get_first_linked_player()
	l_11_1:difficulty_level():exit_rail()
	l_11_1:rail():exit_vehicle()
	l_11_1:unlink()
end

PlayerRail._register_unmounted_vehicles = function(l_12_0)
	local l_12_5, l_12_6 = World:unit_manager():get_units, World:unit_manager()
	l_12_5 = l_12_5(l_12_6, managers.slot:get_mask("rail_vehicles"))
	local l_12_1 = nil
	l_12_6 = pairs
	l_12_1 = l_12_5
	l_12_6 = l_12_6(l_12_1)
	for i_0,i_1 in l_12_6 do
		if alive(l_12_4) and l_12_4:base()._unmounted_vehicle then
			l_12_0._unit:difficulty_level():register_unmounted_rail_vehicle(l_12_4)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


