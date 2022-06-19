if not RailVehicleVan then
	RailVehicleVan = class(RailWheeledVehicle)
end
RailVehicleVan.init = function(l_1_0, l_1_1)
	RailWheeledVehicle.init(l_1_0, l_1_1)
	l_1_0._unit:damage():set_immune_to_damage(true)
end

RailVehicleVan.start_walker_event = function(l_2_0)
	local l_2_1 = "a_walker_landing"
	local l_2_2 = l_2_0._unit:get_object(l_2_1)
	l_2_0._walker = World:spawn_unit("rail_walker_driver", l_2_2:position(), l_2_2:rotation())
	l_2_0._unit:link(l_2_1, l_2_0._walker, l_2_0._walker:orientation_object():name())
	l_2_0._walker:driver():set_vehicle(l_2_0._unit)
	l_2_0._walker:play_redirect("landing_on_vehicle")
	managers.sequence:run_sequence_simple("walker_jump_on_car", l_2_0._unit)
	if alive(l_2_0._driver) then
		World:delete_unit(l_2_0._driver)
	end
	if alive(l_2_0._passenger) then
		World:delete_unit(l_2_0._passenger)
	end
	l_2_0._unit:set_slot(5)
	l_2_0:special_walker_event_init()
end

RailVehicleVan.van_explosion_event = function(l_3_0)
	managers.sequence:run_sequence_simple("kill_vehicle", l_3_0._unit)
	local l_3_1 = true
	l_3_0:transition("r1e4_npc1_die", 0, l_3_1)
	l_3_0._walker:play_redirect("driving_die")
end

RailVehicleVan.quick_start_walker_event = function(l_4_0)
	if alive(l_4_0._walker) then
		return 
	end
	local l_4_1 = "a_walker_landing"
	local l_4_2 = l_4_0._unit:get_object(l_4_1)
	l_4_0._walker = World:spawn_unit("rail_walker_driver", l_4_2:position(), l_4_2:rotation())
	l_4_0._unit:link(l_4_1, l_4_0._walker, l_4_0._walker:orientation_object():name())
	l_4_0._walker:driver():set_vehicle(l_4_0._unit)
	l_4_0._walker:play_redirect("quick_start_landing_on_vehicle")
	managers.sequence:run_sequence_simple("quick_start_walker_jump_on_car", l_4_0._unit)
	if alive(l_4_0._driver) then
		World:delete_unit(l_4_0._driver)
	end
	if alive(l_4_0._passenger) then
		World:delete_unit(l_4_0._passenger)
	end
	l_4_0._unit:set_slot(5)
	l_4_0:special_walker_event_init()
end

RailVehicleVan.update = function(l_5_0, l_5_1, l_5_2, l_5_3)
	RailWheeledVehicle.update(l_5_0, l_5_1, l_5_2, l_5_3)
	if l_5_0._walker_event then
		l_5_0:walker_event()
	end
end

RailVehicleVan.destroy = function(l_6_0)
	RailVehicle.destroy(l_6_0)
	if alive(l_6_0._walker) then
		World:delete_unit(l_6_0._walker)
	end
end

RailVehicleVan.special_walker_event_init = function(l_7_0)
	l_7_0._unit:damage():set_can_die(true)
	l_7_0._walker_event = "running"
	l_7_0._unit:damage():set_immune_to_damage(false)
end

RailVehicleVan.walker_event = function(l_8_0)
	if l_8_0._unit:damage_data():is_fully_damaged() then
		l_8_0._unit:base():set_animation_speed_interpolator_target(0, 1)
		l_8_0._walker_event = nil
		l_8_0._walker:driver():vehicle_destroyed()
	end
end


