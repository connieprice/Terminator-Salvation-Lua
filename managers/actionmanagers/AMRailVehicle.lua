if not AMRailVehicle then
	AMRailVehicle = class(CoreActionElement)
end
AMRailVehicle.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	if l_1_0._mode == "spawn" or l_1_0._mode == "do all" or l_1_0._mode == "do all quick" then
		cat_debug("rail", "AMRailVehicle spawn_vehicle=", l_1_0.spawn_vehicle, " mode=", l_1_0._mode)
		if not l_1_0.spawn_vehicle then
			l_1_0.spawn_vehicle = "rail_vehicle_pickup"
		end
		managers.unit_scripting:define_unit(l_1_0._name, "no_group")
	end
	tweak_data.rail.rail_level = true
	l_1_0._seats = RailVehicle:read_seats(l_1_0.spawn_vehicle)
	managers.sequence:get(l_1_0.spawn_vehicle, true, true)
end

AMRailVehicle.activate_now = function(l_2_0)
	if l_2_0._mode == "do all" and not managers.unit_scripting:unit_exists(l_2_0._name) then
		l_2_0:_spawn()
		l_2_0:_board()
		l_2_0:_start()
	elseif l_2_0._mode == "spawn" and not managers.unit_scripting:unit_exists(l_2_0._name) then
		l_2_0:_spawn()
	elseif l_2_0._mode == "remove" then
		l_2_0:_remove()
	elseif l_2_0._mode == "kill" then
		l_2_0:_kill()
	elseif l_2_0._mode == "board" then
		l_2_0:_board()
	elseif l_2_0._mode == "start" then
		l_2_0:_start()
	elseif l_2_0._mode == "do all quick" and not managers.unit_scripting:unit_exists(l_2_0._name) then
		l_2_0:_spawn()
		l_2_0:_board(true)
		l_2_0:_start()
	end
	l_2_0:deactivate_now()
end

AMRailVehicle._spawn = function(l_3_0)
	l_3_0._unit = World:spawn_unit(l_3_0.spawn_vehicle, l_3_0.position, l_3_0.rotation)
	l_3_0._unit:base():set_seats(l_3_0._seats)
	if not l_3_0.dont_spawn_drivers then
		l_3_0._unit:base():spawn_driver_and_passenger(l_3_0.spawn_driver_name, l_3_0.spawn_passenger_name)
	end
	l_3_0._unit:base():start("idle")
	managers.unit_scripting:register_unit(l_3_0._name, l_3_0._unit)
	if l_3_0._unit:ai_nerve_system() and l_3_0._unit:ai_data() then
		l_3_0._unit:ai_nerve_system():enable()
		l_3_0._unit:ai_nerve_system():setup("rail")
	end
	l_3_0:deactivate_now()
end

AMRailVehicle._remove = function(l_4_0)
	local l_4_1 = managers.unit_scripting:get_unit_by_name(l_4_0._name)
	if alive(l_4_1) then
		World:delete_unit(managers.unit_scripting:get_unit_by_name(l_4_0._name))
	end
	l_4_0:deactivate_now()
end

AMRailVehicle._kill = function(l_5_0)
	local l_5_1 = managers.unit_scripting:get_unit_by_name(l_5_0._name)
	if alive(l_5_1) then
		local l_5_2 = l_5_1:damage()
	if not l_5_2:check_god_mode() then
		end
		l_5_2:set_fully_damaged()
	end
	l_5_0:deactivate_now()
end

AMRailVehicle._board = function(l_6_0, l_6_1)
	local l_6_2 = managers.unit_scripting:get_unit_by_name(l_6_0._name)
	if l_6_2 == nil then
		cat_debug("rail", "\t Vehicle has not spawned yet, cannot board it. ")
		return 
	end
	for l_6_6 = 1, 4 do
		if l_6_0["player_slot_" .. l_6_6] then
			local l_6_7 = managers.player_slot:slot(l_6_6)
			if l_6_7 then
				local l_6_8 = l_6_7:spawned_unit()
			if l_6_8 then
				end
				local l_6_9 = l_6_0["preferred_seat_" .. l_6_6]
				if l_6_1 then
					l_6_9 = "turret_seat"
				elseif not l_6_9 then
					l_6_9 = "random"
					cat_debug("rail", "\t No prefered seat, defualting to 'random' seat")
				end
				l_6_8:rail():enter_vehicle(l_6_2, l_6_9)
			end
		else
			cat_debug("rail", "\t Cannot enter vehicle, player slot ", l_6_6, " not found.")
		end
	end
	l_6_0:deactivate_now()
end

AMRailVehicle._start = function(l_7_0)
	cat_debug("rail", "AMRailVehicle - start animation =", l_7_0.animation_state)
	if l_7_0.animation_state then
		local l_7_1 = managers.unit_scripting:get_unit_by_name(l_7_0._name)
		if alive(l_7_1) then
			l_7_1:base():transition(l_7_0.animation_state, l_7_0.animation_time)
			l_7_1:base():fill_connector_callbacks(l_7_0.hub_callbacks)
		end
	else
		assert(false, "Cannot start, no vehicle found!")
		cat_debug("rail", "\t Cannot start, no vehicle found!")
	end
	l_7_0:deactivate_now()
end


