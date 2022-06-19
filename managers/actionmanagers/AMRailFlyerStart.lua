if not AMRailFlyerStart then
	AMRailFlyerStart = class(CoreActionElement)
end
AMRailFlyerStart.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	if l_1_0._mode == "spawn" or l_1_0._mode == "" then
		World:preload_unit("flyer")
		managers.unit_scripting:define_unit(l_1_0._name, "no_group")
	end
end

AMRailFlyerStart.activate_now = function(l_2_0)
	if l_2_0._mode == "spawn" then
		l_2_0:_spawn()
	elseif l_2_0._mode == "despawn" then
		l_2_0:_despawn()
	elseif l_2_0._mode == "kill" then
		l_2_0:_kill()
	else
		l_2_0:_spawn()
	end
end

AMRailFlyerStart._remove = function(l_3_0)
	local l_3_1 = managers.unit_scripting:get_unit_by_name(l_3_0._name)
	if alive(l_3_1) then
		World:delete_unit(managers.unit_scripting:get_unit_by_name(l_3_0._name))
	end
	l_3_0:deactivate_now()
end

AMRailFlyerStart._kill = function(l_4_0)
	local l_4_1 = managers.unit_scripting:get_unit_by_name(l_4_0._name)
	if alive(l_4_1) then
		l_4_1:damage():set_fully_damaged()
	end
	l_4_0:deactivate_now()
end

AMRailFlyerStart._despawn = function(l_5_0)
	local l_5_1 = managers.unit_scripting:get_unit_by_name(l_5_0._name)
	if alive(l_5_1) then
		local l_5_2 = managers.unit_scripting:get_unit_by_name(l_5_0._name)
		l_5_2:set_slot(0)
	end
	l_5_0:deactivate_now()
end

AMRailFlyerStart._spawn = function(l_6_0)
	local l_6_1 = World:spawn_unit("flyer", l_6_0.position, l_6_0.rotation)
	l_6_1:effects():use_simple_effects(true)
	l_6_1:control():set_ai_controlled()
	local l_6_2 = l_6_1:ai_data()
	l_6_0:setup_rail_flier(l_6_1, l_6_2)
	l_6_1:ai_nerve_system():setup("rail")
	local l_6_3 = l_6_1:damage_data()
	if l_6_3 and tweak_data.rail.enemy.flyer then
		local l_6_4 = ""
		if managers.player_slot:number_of_occupied_slots() == 2 then
			l_6_4 = "_COOP"
		end
		if not tweak_data.rail.enemy.flyer["HEALTH" .. l_6_4] then
			l_6_3.health = tweak_data.rail.enemy.flyer.HEALTH
		end
	end
	l_6_2._combat.targets = {}
	l_6_2._move._closest_track = l_6_0.closest_track
	l_6_2.no_max_fire_velocity = true
	l_6_2._move.displacement = Vector3(0, 0, 0)
	if l_6_0.displacement_x ~= nil then
		l_6_2._move.displacement = l_6_2._move.displacement:with_x(l_6_0.displacement_x * 100)
	end
	if l_6_0.displacement_y ~= nil then
		l_6_2._move.displacement = l_6_2._move.displacement:with_z(l_6_0.displacement_y * 100)
	end
	l_6_0._unit = l_6_1
	l_6_0:deactivate_now()
	managers.unit_scripting:register_unit(l_6_0._name, l_6_1)
end

AMRailFlyerStart.setup_rail_flier = function(l_7_0, l_7_1, l_7_2)
	l_7_2.default_waypoints = l_7_0.waypoints
	l_7_2.default_speed = l_7_0.speed
	l_7_2.default_loop_waypoints = l_7_0.loop_waypoints
	l_7_2.default_waypoint_pause_time = l_7_0.waypoint_pause_time
	l_7_2.default_threat_behavior = "ignore"
	l_7_2.allowed_to_move_and_shoot = true
	l_7_2.input.enemy_slot_mask = "rail_vehicles"
	if l_7_0.target_distance == nil then
		l_7_0.target_distance = 40
	end
	l_7_2.input.target_range = l_7_0.target_distance * 100
end


