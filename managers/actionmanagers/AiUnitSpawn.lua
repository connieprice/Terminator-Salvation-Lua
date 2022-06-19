if not AiUnitSpawn then
	AiUnitSpawn = class(CoreActionElement)
end
require("units/UnitSpawnUtility")
require("units/editor/PredefinedUnits")
require("units/editor/RailOptimizedUnits")
AiUnitSpawn.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	l_1_0._player_slot = nil
	l_1_0._is_persistent = nil
end

AiUnitSpawn.setup = function(l_2_0, l_2_1)
	l_2_0._spawn_unit_name = l_2_1
	if PredefinedUnits.unit_order_type_name_exceptions[l_2_0._spawn_unit_name] then
		l_2_0._player_slot = PredefinedUnits.unit_order_type_name_exceptions[l_2_0._spawn_unit_name].player_slot
		if not l_2_0.warp_radius then
			l_2_0.warp_radius = tweak_data.checkpoint.PLAYERS_DEFAULT_WARP_RADIUS
		end
	else
		l_2_0._player_slot = nil
	if not l_2_0.warp_radius then
		end
		l_2_0.warp_radius = tweak_data.checkpoint.NPCS_DEFAULT_WARP_RADIUS
	end
	if l_2_0._player_slot then
		l_2_0._alias_name = "character_slot" .. l_2_0._player_slot
	end
	if l_2_0._mode == "spawn" or l_2_0._mode == "" then
		World:preload_unit(l_2_0:_get_spawn_name(l_2_0._spawn_unit_name))
		managers.unit_scripting:define_unit(l_2_0._name)
	end
end

AiUnitSpawn.activate_now = function(l_3_0)
	if l_3_0._mode == "spawn" then
		l_3_0:_spawn()
	elseif l_3_0._mode == "despawn" then
		l_3_0:_despawn()
	elseif l_3_0._mode == "kill" then
		l_3_0:_kill()
	else
		Application:error("No action for unit spawner! (" .. l_3_0._name .. ")")
	end
end

AiUnitSpawn._spawn = function(l_4_0)
	local l_4_1 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_4_0._is_persistent or managers.unit_scripting:unit_exists(l_4_0._name) then
		l_4_1 = managers.unit_scripting:get_unit_by_name(l_4_0._name)
	end
	local l_4_2, l_4_3 = , nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if alive(l_4_1) then
		if l_4_0.warp_radius and l_4_0.warp_radius < mvector3.distance(l_4_3, l_4_1:position()) then
			UnitSpawnUtility.warp_to(l_4_1, nil, l_4_3)
		end
		local l_4_4 = nil
		managers.unit_scripting:register_new_unit_name(managers.unit_scripting:unit_script_name(l_4_1), l_4_0._name, l_4_1)
		managers.drama_scene:set_unit_name_to_script_name(l_4_0._spawn_unit_name, l_4_0._name)
		if l_4_0._alias_name then
			managers.unit_scripting:register_alias(l_4_0._name, l_4_0._alias_name)
		end
		l_4_0:_give_ai_orders(l_4_1)
		l_4_0:deactivate_now()
		return 
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_4_1 = World:spawn_unit(l_4_0:_get_spawn_name(l_4_0._spawn_unit_name), l_4_3, l_4_4)
	l_4_1:control():set_ai_controlled()
	if l_4_0._player_slot then
		assert(not managers.player_slot:slot(l_4_0._player_slot):spawned_unit())
		 -- DECOMPILER ERROR: Confused about usage of registers!

		managers.player_slot:set_unit(l_4_0._player_slot, l_4_1, l_4_1:name(), l_4_3, l_4_4, true, true)
	end
	managers.unit_scripting:register_unit(l_4_0._name, l_4_1)
	if l_4_0._alias_name then
		managers.unit_scripting:register_alias(l_4_0._name, l_4_0._alias_name)
	end
	managers.drama_scene:set_unit_name_to_script_name(l_4_0._spawn_unit_name, l_4_0._name)
	l_4_0:_setup_ai(l_4_1)
	l_4_0:_setup_health(l_4_1)
	l_4_0:deactivate_now()
end

AiUnitSpawn._despawn = function(l_5_0)
	local l_5_1 = managers.unit_scripting:get_unit_by_name(l_5_0._name)
	if alive(l_5_1) then
		local l_5_2 = managers.unit_scripting:get_unit_by_name(l_5_0._name)
		l_5_2:set_slot(0)
	end
	l_5_0:deactivate_now()
end

AiUnitSpawn._kill = function(l_6_0)
	local l_6_1 = managers.unit_scripting:get_unit_by_name(l_6_0._name)
	if alive(l_6_1) then
		l_6_1:damage():set_fully_damaged()
	end
	l_6_0:deactivate_now()
end

AiUnitSpawn._setup_health = function(l_7_0, l_7_1)
	if l_7_0.brain_name == "rail" then
		local l_7_2 = l_7_1:damage_data()
		local l_7_3 = tweak_data.rail.enemy[l_7_1:name()]
	if l_7_3 then
		end
		local l_7_4 = ""
		if managers.player_slot:number_of_occupied_slots() == 2 then
			l_7_4 = "_COOP"
		end
		if not l_7_3["HEALTH" .. l_7_4] and not l_7_3.HEALTH and not l_7_2.health_rail then
			l_7_2.health = l_7_2.health
		end
	end
end

AiUnitSpawn._setup_ai = function(l_8_0, l_8_1)
	l_8_0:_give_ai_orders(l_8_1)
end

AiUnitSpawn._give_ai_orders = function(l_9_0, l_9_1)
	managers.director.order:give_order(l_9_0.units, l_9_0.waypoint_paths, l_9_0.movement_options, l_9_0.order, l_9_0.area_cluster)
end

AiUnitSpawn._get_spawn_name = function(l_10_0, l_10_1)
	if tweak_data.rail.USE_OPTIMIZED_UNITS and l_10_0.brain_name == "rail" and RailOptimizedUnits.optimized_unit_translation[l_10_1] then
		return RailOptimizedUnits.optimized_unit_translation[l_10_1]
	end
	return l_10_1
end


