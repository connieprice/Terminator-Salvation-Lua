if not Rail2WheeledVehicle then
	Rail2WheeledVehicle = class(RailVehicle)
end
Rail2WheeledVehicle.init = function(l_1_0, l_1_1)
	RailVehicle.init(l_1_0, l_1_1)
	l_1_0._wheel_offset_position = Vector3(0, 0, -(l_1_0._wheel_radius + 25))
	l_1_0._wheel_to_ground_slot_mask = managers.slot:get_mask("solid_objects")
	local l_1_2 = {}
	local l_1_3 = {}
	l_1_3.object = l_1_0._unit:get_object("at_susp_wheel_b_center")
	l_1_3.on_ground = true
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_1_0._wheels = l_1_2
	l_1_0._looping_effects, l_1_2 = l_1_2, {}
	l_1_0._update_on_ground_delay = 0.1
	l_1_0._update_on_ground_time = 0
end

Rail2WheeledVehicle.update = function(l_2_0, l_2_1, l_2_2, l_2_3)
	RailVehicle.update(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0:_update_wheels(l_2_1, l_2_2, l_2_3)
	l_2_0:_update_wheel_effects()
end

Rail2WheeledVehicle._update_wheels = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0:_update_on_ground(l_3_1, l_3_2, l_3_3)
end

Rail2WheeledVehicle._update_wheel_effects = function(l_4_0)
	l_4_0:_update_cruising_effect()
end

Rail2WheeledVehicle._update_on_ground = function(l_5_0, l_5_1, l_5_2, l_5_3)
	local l_5_7, l_5_8, l_5_9, l_5_10 = nil
	if l_5_0._update_on_ground_time <= l_5_2 then
		for i_0,i_1 in ipairs(l_5_0._wheels) do
			if l_5_0._unit:raycast("ray", i_1.object:position() - l_5_0._wheel_offset_position, i_1.object:position() + l_5_0._wheel_offset_position, "slot_mask", l_5_0._wheel_to_ground_slot_mask) then
				i_1.on_ground = true
			else
				i_1.on_ground = false
			end
		end
		l_5_0._update_on_ground_time = l_5_2 + l_5_0._update_on_ground_delay
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Rail2WheeledVehicle._update_cruising_effect = function(l_6_0)
	if l_6_0:get_speed_kmh() < 0.5 or not l_6_0._wheels[1].on_ground then
		l_6_0:_remove_looping_effect("biker_gravel")
	else
		local l_6_1 = l_6_0._unit:get_object("e_wheel_dust_back")
		local l_6_2 = Vector3(0, 1, 0)
	if l_6_1 then
		end
		l_6_0:_add_looping_effect("biker_gravel", "biker_gravel", l_6_1, nil, l_6_2)
	end
end

Rail2WheeledVehicle._add_looping_effect = function(l_7_0, l_7_1, l_7_2, l_7_3, l_7_4, l_7_5)
	if not l_7_0._looping_effects[l_7_1] then
		local l_7_6 = l_7_0._looping_effects
		local l_7_7, l_7_8 = World:effect_manager():spawn, World:effect_manager()
		local l_7_9 = {}
		l_7_9.effect = l_7_2
		l_7_9.parent = l_7_3
		l_7_9.rotation = l_7_4
		l_7_9.normal = l_7_5
		l_7_9.force_synch = false
		l_7_7 = l_7_7(l_7_8, l_7_9)
		l_7_6[l_7_1] = l_7_7
	end
end

Rail2WheeledVehicle._remove_looping_effect = function(l_8_0, l_8_1)
	if l_8_0._looping_effects[l_8_1] then
		World:effect_manager():fade_kill(l_8_0._looping_effects[l_8_1])
		l_8_0._looping_effects[l_8_1] = nil
	end
end

Rail2WheeledVehicle.destroy = function(l_9_0)
	RailVehicle.destroy(l_9_0)
	table.foreach(l_9_0._looping_effects, function(l_10_0, l_10_1)
		World:effect_manager():kill(l_10_1)
  end)
end


