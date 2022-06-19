AMRailVehicle = AMRailVehicle or class(CoreActionElement)
function AMRailVehicle.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	if A0_0._mode == "spawn" or A0_0._mode == "do all" or A0_0._mode == "do all quick" then
		cat_debug("rail", "AMRailVehicle spawn_vehicle=", A0_0.spawn_vehicle, " mode=", A0_0._mode)
		if not A0_0.spawn_vehicle then
			A0_0.spawn_vehicle = "rail_vehicle_pickup"
		end
		managers.unit_scripting:define_unit(A0_0._name, "no_group")
	end
	tweak_data.rail.rail_level = true
	A0_0._seats = RailVehicle:read_seats(A0_0.spawn_vehicle)
	managers.sequence:get(A0_0.spawn_vehicle, true, true)
end
function AMRailVehicle.activate_now(A0_3)
	if A0_3._mode == "do all" and not managers.unit_scripting:unit_exists(A0_3._name) then
		A0_3:_spawn()
		A0_3:_board()
		A0_3:_start()
	elseif A0_3._mode == "spawn" and not managers.unit_scripting:unit_exists(A0_3._name) then
		A0_3:_spawn()
	elseif A0_3._mode == "remove" then
		A0_3:_remove()
	elseif A0_3._mode == "kill" then
		A0_3:_kill()
	elseif A0_3._mode == "board" then
		A0_3:_board()
	elseif A0_3._mode == "start" then
		A0_3:_start()
	elseif A0_3._mode == "do all quick" and not managers.unit_scripting:unit_exists(A0_3._name) then
		A0_3:_spawn()
		A0_3:_board(true)
		A0_3:_start()
	end
	A0_3:deactivate_now()
end
function AMRailVehicle._spawn(A0_4)
	A0_4._unit = World:spawn_unit(A0_4.spawn_vehicle, A0_4.position, A0_4.rotation)
	A0_4._unit:base():set_seats(A0_4._seats)
	if not A0_4.dont_spawn_drivers then
		A0_4._unit:base():spawn_driver_and_passenger(A0_4.spawn_driver_name, A0_4.spawn_passenger_name)
	end
	A0_4._unit:base():start("idle")
	managers.unit_scripting:register_unit(A0_4._name, A0_4._unit)
	if A0_4._unit:ai_nerve_system() and A0_4._unit:ai_data() then
		A0_4._unit:ai_nerve_system():enable()
		A0_4._unit:ai_nerve_system():setup("rail")
	end
	A0_4:deactivate_now()
end
function AMRailVehicle._remove(A0_5)
	local L1_6
	L1_6 = managers
	L1_6 = L1_6.unit_scripting
	L1_6 = L1_6.get_unit_by_name
	L1_6 = L1_6(L1_6, A0_5._name)
	if alive(L1_6) then
		World:delete_unit(managers.unit_scripting:get_unit_by_name(A0_5._name))
	end
	A0_5:deactivate_now()
end
function AMRailVehicle._kill(A0_7)
	local L1_8
	L1_8 = managers
	L1_8 = L1_8.unit_scripting
	L1_8 = L1_8.get_unit_by_name
	L1_8 = L1_8(L1_8, A0_7._name)
	if alive(L1_8) and not L1_8:damage():check_god_mode() then
		L1_8:damage():set_fully_damaged()
	end
	A0_7:deactivate_now()
end
function AMRailVehicle._board(A0_9, A1_10)
	local L2_11, L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18
	L2_11 = managers
	L2_11 = L2_11.unit_scripting
	L2_11 = L2_11.get_unit_by_name
	L2_11 = L2_11(L3_12, L4_13)
	if L2_11 == nil then
		L3_12(L4_13, L5_14)
		return
	end
	for L6_15 = 1, 4 do
		L7_16 = "player_slot_"
		L8_17 = L6_15
		L7_16 = L7_16 .. L8_17
		L7_16 = A0_9[L7_16]
		if L7_16 then
			L7_16 = managers
			L7_16 = L7_16.player_slot
			L8_17 = L7_16
			L7_16 = L7_16.slot
			L9_18 = L6_15
			L7_16 = L7_16(L8_17, L9_18)
			if L7_16 then
				L9_18 = L7_16
				L8_17 = L7_16.spawned_unit
				L8_17 = L8_17(L9_18)
				if L8_17 then
					L9_18 = "preferred_seat_"
					L9_18 = L9_18 .. L6_15
					L9_18 = A0_9[L9_18]
					if A1_10 then
						L9_18 = "turret_seat"
					elseif not L9_18 then
						L9_18 = "random"
						cat_debug("rail", "\t No prefered seat, defualting to 'random' seat")
					end
					L8_17:rail():enter_vehicle(L2_11, L9_18)
				end
			else
				L8_17 = cat_debug
				L9_18 = "rail"
				L8_17(L9_18, "\t Cannot enter vehicle, player slot ", L6_15, " not found.")
			end
		end
	end
	L3_12(L4_13)
end
function AMRailVehicle._start(A0_19)
	local L1_20
	L1_20 = cat_debug
	L1_20("rail", "AMRailVehicle - start animation =", A0_19.animation_state)
	L1_20 = A0_19.animation_state
	if L1_20 then
		L1_20 = managers
		L1_20 = L1_20.unit_scripting
		L1_20 = L1_20.get_unit_by_name
		L1_20 = L1_20(L1_20, A0_19._name)
		if alive(L1_20) then
			L1_20:base():transition(A0_19.animation_state, A0_19.animation_time)
			L1_20:base():fill_connector_callbacks(A0_19.hub_callbacks)
		else
			assert(false, "Cannot start, no vehicle found!")
			cat_debug("rail", "\t Cannot start, no vehicle found!")
		end
	end
	L1_20 = A0_19.deactivate_now
	L1_20(A0_19)
end
