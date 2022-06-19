if not RailWheeledVehicle then
	RailWheeledVehicle = class(RailVehicle)
end
RailWheeledVehicle.init = function(l_1_0, l_1_1)
	RailVehicle.init(l_1_0, l_1_1)
	l_1_0:_init_effects()
end

RailWheeledVehicle._init_effects = function(l_2_0)
	l_2_0._looping_effects = {}
	local l_2_1 = {}
	local l_2_2 = {}
	l_2_2.speed_from = 1
	l_2_2.speed_to = 15
	l_2_2.effect_value = 8
	local l_2_3 = {}
	l_2_3.speed_from = 15
	l_2_3.speed_to = 30
	l_2_3.effect_value = 7
	local l_2_4 = {}
	l_2_4.speed_from = 30
	l_2_4.speed_to = 45
	l_2_4.effect_value = 6
	local l_2_5 = {}
	l_2_5.speed_from = 45
	l_2_5.speed_to = 60
	l_2_5.effect_value = 5
	local l_2_6 = {}
	l_2_6.speed_from = 60
	l_2_6.speed_to = 75
	l_2_6.effect_value = 4
	local l_2_7 = {}
	l_2_7.speed_from = 75
	l_2_7.speed_to = 90
	l_2_7.effect_value = 3
	local l_2_8 = {}
	l_2_8.speed_from = 90
	l_2_8.speed_to = 105
	l_2_8.effect_value = 2
	local l_2_9 = {}
	l_2_9.speed_from = 105
	l_2_9.speed_to = 10000
	l_2_9.effect_value = 1
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_2_0._exhaust_effect_parameters = l_2_1
	l_2_4, l_2_3, l_2_2 = {acc_from = 30, acc_to = 10000, effect = "car_gravel_medium"}, {acc_from = 20, acc_to = 30, effect = "car_gravel_medium"}, {acc_from = 10, acc_to = 20, effect = "car_gravel_small"}
	l_2_0._gravel_effects_parameters, l_2_1 = l_2_1, {l_2_2, l_2_3, l_2_4}
end

RailWheeledVehicle.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	RailVehicle.update(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0:_update_wheel_rotation()
	l_3_0:_update_effects(l_3_1, l_3_2, l_3_3)
end

RailWheeledVehicle._update_wheel_rotation = function(l_4_0)
	if l_4_0._unit:get_object("at_wheel_lb") then
		local l_4_1 = angle_from_signed(l_4_0._unit:get_object("at_wheel_lb"):new_local_rotation():yaw())
		local l_4_2 = math.abs(l_4_1 - l_4_0._last_wheel_rot)
		if l_4_1 - 360 >= l_4_0._last_wheel_rot then
			l_4_0._forward = l_4_2 <= 180
			do return end
			l_4_0._forward = l_4_1 < l_4_0._last_wheel_rot
			l_4_0._last_wheel_rot = l_4_1
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 29 
end

RailWheeledVehicle._update_effects = function(l_5_0, l_5_1, l_5_2, l_5_3)
end

RailWheeledVehicle._update_exhaust_effect = function(l_6_0)
	if l_6_0:get_speed_kmh() < 0.5 then
		l_6_0:_remove_looping_effect("car_exhaust")
	else
		local l_6_1 = l_6_0._unit:get_object("e_exhaust")
	if l_6_1 then
		end
		l_6_0:_add_looping_effect("car_exhaust", "car_exhaust", l_6_1, nil)
	end
end

RailWheeledVehicle._update_cruising_effect = function(l_7_0)
	local l_7_1 = l_7_0:get_speed_kmh()
	if l_7_1 <= l_7_0._exhaust_effect_parameters[1].speed_from then
		l_7_0:_remove_looping_effect("car_cruising_lb")
		l_7_0:_remove_looping_effect("car_cruising_rb")
	else
		local l_7_2 = l_7_0._unit:get_object("e_wheel_lb")
		local l_7_3 = l_7_0._unit:get_object("e_wheel_rb")
	if l_7_2 and l_7_3 then
		end
		local l_7_4 = Rotation(Vector3(0, -1, 0), l_7_2:rotation():y())
		local l_7_5 = Rotation(Vector3(0, -1, 0), l_7_3:rotation():y())
		l_7_0:_add_looping_effect("car_cruising_lb", "car_cruising", l_7_2, l_7_4)
		local l_7_9 = l_7_0:_add_looping_effect
		local l_7_10 = l_7_0
		l_7_9(l_7_10, "car_cruising_rb", "car_cruising", l_7_3, l_7_5)
		l_7_9 = pairs
		l_7_10 = l_7_0._exhaust_effect_parameters
		l_7_9 = l_7_9(l_7_10)
		for i_0,i_1 in l_7_9 do
			if l_7_8.speed_from < l_7_1 and l_7_1 <= l_7_8.speed_to then
				World:effect_manager():set_simulator_var_float(l_7_0._looping_effects.car_cruising_lb, "smokah", "smokah_teleporter", "particle_lifetime", l_7_8.effect_value)
				World:effect_manager():set_simulator_var_float(l_7_0._looping_effects.car_cruising_rb, "smokah", "smokah_teleporter", "particle_lifetime", l_7_8.effect_value)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

RailWheeledVehicle._update_gravel_effect = function(l_8_0)
	local l_8_1 = l_8_0:get_acceleration_kmh()
	if l_8_1 <= l_8_0._gravel_effects_parameters[1].acc_from then
		l_8_0:_remove_looping_effect("car_gravel_lb")
		l_8_0:_remove_looping_effect("car_gravel_rb")
	else
		local l_8_2 = l_8_0._unit:get_object("e_wheel_lb")
		local l_8_3 = l_8_0._unit:get_object("e_wheel_rb")
	if l_8_2 and l_8_3 then
		end
		local l_8_4 = Rotation(Vector3(0, 1, 0), l_8_2:rotation():y())
		local l_8_9, l_8_10 = Rotation, Vector3(0, 1, 0)
		l_8_9 = l_8_9(l_8_10, l_8_3:rotation():y())
		local l_8_5 = nil
		l_8_10 = pairs
		l_8_5 = l_8_0._gravel_effects_parameters
		l_8_10 = l_8_10(l_8_5)
		for i_0,i_1 in l_8_10 do
			if l_8_8.acc_from < l_8_1 and l_8_1 <= l_8_8.acc_to then
				l_8_0:_add_looping_effect("car_gravel_lb", l_8_8.effect, l_8_2, l_8_4)
				l_8_0:_add_looping_effect("car_gravel_rb", l_8_8.effect, l_8_3, l_8_9)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

RailWheeledVehicle._add_looping_effect = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4)
	if not l_9_0._looping_effects[l_9_1] then
		local l_9_5 = l_9_0._looping_effects
		local l_9_6, l_9_7 = World:effect_manager():spawn, World:effect_manager()
		local l_9_8 = {}
		l_9_8.effect = l_9_2
		l_9_8.parent = l_9_3
		l_9_8.rotation = l_9_4
		l_9_8.force_synch = false
		l_9_6 = l_9_6(l_9_7, l_9_8)
		l_9_5[l_9_1] = l_9_6
	end
end

RailWheeledVehicle._remove_looping_effect = function(l_10_0, l_10_1)
	if l_10_0._looping_effects[l_10_1] then
		World:effect_manager():kill(l_10_0._looping_effects[l_10_1])
		l_10_0._looping_effects[l_10_1] = nil
	end
end

RailWheeledVehicle.destroy = function(l_11_0)
	RailVehicle.destroy(l_11_0)
	table.foreach(l_11_0._looping_effects, function(l_12_0, l_12_1)
		World:effect_manager():kill(l_12_1)
  end)
end


