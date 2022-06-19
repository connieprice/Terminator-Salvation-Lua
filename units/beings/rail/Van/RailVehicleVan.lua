RailVehicleVan = RailVehicleVan or class(RailWheeledVehicle)
function RailVehicleVan.init(A0_0, A1_1)
	RailWheeledVehicle.init(A0_0, A1_1)
	A0_0._unit:damage():set_immune_to_damage(true)
end
function RailVehicleVan.start_walker_event(A0_2)
	local L1_3
	L1_3 = "a_walker_landing"
	A0_2._walker = World:spawn_unit("rail_walker_driver", A0_2._unit:get_object(L1_3):position(), A0_2._unit:get_object(L1_3):rotation())
	A0_2._unit:link(L1_3, A0_2._walker, A0_2._walker:orientation_object():name())
	A0_2._walker:driver():set_vehicle(A0_2._unit)
	A0_2._walker:play_redirect("landing_on_vehicle")
	managers.sequence:run_sequence_simple("walker_jump_on_car", A0_2._unit)
	if alive(A0_2._driver) then
		World:delete_unit(A0_2._driver)
	end
	if alive(A0_2._passenger) then
		World:delete_unit(A0_2._passenger)
	end
	A0_2._unit:set_slot(5)
	A0_2:special_walker_event_init()
end
function RailVehicleVan.van_explosion_event(A0_4)
	local L1_5
	L1_5 = managers
	L1_5 = L1_5.sequence
	L1_5 = L1_5.run_sequence_simple
	L1_5(L1_5, "kill_vehicle", A0_4._unit)
	L1_5 = true
	A0_4:transition("r1e4_npc1_die", 0, L1_5)
	A0_4._walker:play_redirect("driving_die")
end
function RailVehicleVan.quick_start_walker_event(A0_6)
	local L1_7
	L1_7 = alive
	L1_7 = L1_7(A0_6._walker)
	if L1_7 then
		return
	end
	L1_7 = "a_walker_landing"
	A0_6._walker = World:spawn_unit("rail_walker_driver", A0_6._unit:get_object(L1_7):position(), A0_6._unit:get_object(L1_7):rotation())
	A0_6._unit:link(L1_7, A0_6._walker, A0_6._walker:orientation_object():name())
	A0_6._walker:driver():set_vehicle(A0_6._unit)
	A0_6._walker:play_redirect("quick_start_landing_on_vehicle")
	managers.sequence:run_sequence_simple("quick_start_walker_jump_on_car", A0_6._unit)
	if alive(A0_6._driver) then
		World:delete_unit(A0_6._driver)
	end
	if alive(A0_6._passenger) then
		World:delete_unit(A0_6._passenger)
	end
	A0_6._unit:set_slot(5)
	A0_6:special_walker_event_init()
end
function RailVehicleVan.update(A0_8, A1_9, A2_10, A3_11)
	RailWheeledVehicle.update(A0_8, A1_9, A2_10, A3_11)
	if A0_8._walker_event then
		A0_8:walker_event()
	end
end
function RailVehicleVan.destroy(A0_12)
	RailVehicle.destroy(A0_12)
	if alive(A0_12._walker) then
		World:delete_unit(A0_12._walker)
	end
end
function RailVehicleVan.special_walker_event_init(A0_13)
	A0_13._unit:damage():set_can_die(true)
	A0_13._walker_event = "running"
	A0_13._unit:damage():set_immune_to_damage(false)
end
function RailVehicleVan.walker_event(A0_14)
	if A0_14._unit:damage_data():is_fully_damaged() then
		A0_14._unit:base():set_animation_speed_interpolator_target(0, 1)
		A0_14._walker_event = nil
		A0_14._walker:driver():vehicle_destroyed()
	end
end
