AiUnitSpawn = AiUnitSpawn or class(CoreActionElement)
require("units/UnitSpawnUtility")
require("units/editor/PredefinedUnits")
require("units/editor/RailOptimizedUnits")
function AiUnitSpawn.init(A0_0, A1_1, A2_2, A3_3)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	A0_0._player_slot = nil
	A0_0._is_persistent = nil
end
function AiUnitSpawn.setup(A0_4, A1_5)
	A0_4._spawn_unit_name = A1_5
	if PredefinedUnits.unit_order_type_name_exceptions[A0_4._spawn_unit_name] then
		A0_4._player_slot = PredefinedUnits.unit_order_type_name_exceptions[A0_4._spawn_unit_name].player_slot
		if not A0_4.warp_radius then
			A0_4.warp_radius = tweak_data.checkpoint.PLAYERS_DEFAULT_WARP_RADIUS
		end
	else
		A0_4._player_slot = nil
		if not A0_4.warp_radius then
			A0_4.warp_radius = tweak_data.checkpoint.NPCS_DEFAULT_WARP_RADIUS
		end
	end
	if A0_4._player_slot then
		A0_4._alias_name = "character_slot" .. A0_4._player_slot
	end
	if A0_4._mode == "spawn" or A0_4._mode == "" then
		World:preload_unit(A0_4:_get_spawn_name(A0_4._spawn_unit_name))
		managers.unit_scripting:define_unit(A0_4._name)
	end
end
function AiUnitSpawn.activate_now(A0_6)
	if A0_6._mode == "spawn" then
		A0_6:_spawn()
	elseif A0_6._mode == "despawn" then
		A0_6:_despawn()
	elseif A0_6._mode == "kill" then
		A0_6:_kill()
	else
		Application:error("No action for unit spawner! (" .. A0_6._name .. ")")
	end
end
function AiUnitSpawn._spawn(A0_7)
	local L1_8, L2_9, L3_10, L4_11, L5_12
	L2_9 = A0_7._name
	L3_10 = A0_7._is_persistent
	if L3_10 then
		L3_10 = managers
		L3_10 = L3_10.drama_scene
		L4_11 = L3_10
		L3_10 = L3_10.unit_name_to_script_name
		L5_12 = A0_7._spawn_unit_name
		L3_10 = L3_10(L4_11, L5_12)
		L2_9 = L3_10
	end
	L3_10 = managers
	L3_10 = L3_10.unit_scripting
	L4_11 = L3_10
	L3_10 = L3_10.unit_exists
	L5_12 = L2_9
	L3_10 = L3_10(L4_11, L5_12)
	if L3_10 then
		L3_10 = managers
		L3_10 = L3_10.unit_scripting
		L4_11 = L3_10
		L3_10 = L3_10.get_unit_by_name
		L5_12 = L2_9
		L3_10 = L3_10(L4_11, L5_12)
		L1_8 = L3_10
	end
	L3_10, L4_11 = nil, nil
	L5_12 = UnitSpawnUtility
	L5_12 = L5_12.spawn_position
	L4_11, L5_12 = A0_7.waypoint_paths, L5_12(A0_7.waypoint_paths, A0_7.position, A0_7.rotation)
	L3_10 = L5_12
	L5_12 = alive
	L5_12 = L5_12(L1_8)
	if L5_12 then
		L5_12 = A0_7.warp_radius
		if L5_12 then
			L5_12 = mvector3
			L5_12 = L5_12.distance
			L5_12 = L5_12(L3_10, L1_8:position())
			if L5_12 > A0_7.warp_radius then
				L5_12 = UnitSpawnUtility
				L5_12 = L5_12.warp_to
				L5_12(L1_8, L4_11, L3_10)
			end
		end
		L5_12 = managers
		L5_12 = L5_12.unit_scripting
		L5_12 = L5_12.unit_script_name
		L5_12 = L5_12(L5_12, L1_8)
		managers.unit_scripting:register_new_unit_name(L5_12, A0_7._name, L1_8)
		managers.drama_scene:set_unit_name_to_script_name(A0_7._spawn_unit_name, A0_7._name)
		if A0_7._alias_name then
			managers.unit_scripting:register_alias(A0_7._name, A0_7._alias_name)
		end
		A0_7:_give_ai_orders(L1_8)
		A0_7:deactivate_now()
		return
	end
	L5_12 = World
	L5_12 = L5_12.spawn_unit
	L5_12 = L5_12(L5_12, A0_7:_get_spawn_name(A0_7._spawn_unit_name), L3_10, L4_11)
	L1_8 = L5_12
	L5_12 = L1_8.control
	L5_12 = L5_12(L1_8)
	L5_12 = L5_12.set_ai_controlled
	L5_12(L5_12)
	L5_12 = A0_7._player_slot
	if L5_12 then
		L5_12 = assert
		L5_12(not managers.player_slot:slot(A0_7._player_slot):spawned_unit())
		L5_12 = managers
		L5_12 = L5_12.player_slot
		L5_12 = L5_12.set_unit
		L5_12(L5_12, A0_7._player_slot, L1_8, L1_8:name(), L3_10, L4_11, true, true)
	end
	L5_12 = managers
	L5_12 = L5_12.unit_scripting
	L5_12 = L5_12.register_unit
	L5_12(L5_12, A0_7._name, L1_8)
	L5_12 = A0_7._alias_name
	if L5_12 then
		L5_12 = managers
		L5_12 = L5_12.unit_scripting
		L5_12 = L5_12.register_alias
		L5_12(L5_12, A0_7._name, A0_7._alias_name)
	end
	L5_12 = managers
	L5_12 = L5_12.drama_scene
	L5_12 = L5_12.set_unit_name_to_script_name
	L5_12(L5_12, A0_7._spawn_unit_name, A0_7._name)
	L5_12 = A0_7._setup_ai
	L5_12(A0_7, L1_8)
	L5_12 = A0_7._setup_health
	L5_12(A0_7, L1_8)
	L5_12 = A0_7.deactivate_now
	L5_12(A0_7)
end
function AiUnitSpawn._despawn(A0_13)
	local L1_14
	L1_14 = managers
	L1_14 = L1_14.unit_scripting
	L1_14 = L1_14.get_unit_by_name
	L1_14 = L1_14(L1_14, A0_13._name)
	if alive(L1_14) then
		managers.unit_scripting:get_unit_by_name(A0_13._name):set_slot(0)
	end
	A0_13:deactivate_now()
end
function AiUnitSpawn._kill(A0_15)
	local L1_16
	L1_16 = managers
	L1_16 = L1_16.unit_scripting
	L1_16 = L1_16.get_unit_by_name
	L1_16 = L1_16(L1_16, A0_15._name)
	if alive(L1_16) then
		L1_16:damage():set_fully_damaged()
	end
	A0_15:deactivate_now()
end
function AiUnitSpawn._setup_health(A0_17, A1_18)
	local L2_19, L3_20, L4_21
	L2_19 = A0_17.brain_name
	if L2_19 == "rail" then
		L3_20 = A1_18
		L2_19 = A1_18.damage_data
		L2_19 = L2_19(L3_20)
		L3_20 = tweak_data
		L3_20 = L3_20.rail
		L3_20 = L3_20.enemy
		L4_21 = A1_18.name
		L4_21 = L4_21(A1_18)
		L3_20 = L3_20[L4_21]
		if L3_20 then
			L4_21 = ""
			if managers.player_slot:number_of_occupied_slots() == 2 then
				L4_21 = "_COOP"
			end
			L2_19.health = L3_20["HEALTH" .. L4_21] or L3_20.HEALTH or L2_19.health_rail or L2_19.health
		end
	end
end
function AiUnitSpawn._setup_ai(A0_22, A1_23)
	A0_22:_give_ai_orders(A1_23)
end
function AiUnitSpawn._give_ai_orders(A0_24, A1_25)
	managers.director.order:give_order(A0_24.units, A0_24.waypoint_paths, A0_24.movement_options, A0_24.order, A0_24.area_cluster)
end
function AiUnitSpawn._get_spawn_name(A0_26, A1_27)
	local L2_28
	L2_28 = tweak_data
	L2_28 = L2_28.rail
	L2_28 = L2_28.USE_OPTIMIZED_UNITS
	if L2_28 then
		L2_28 = A0_26.brain_name
		if L2_28 == "rail" then
			L2_28 = RailOptimizedUnits
			L2_28 = L2_28.optimized_unit_translation
			L2_28 = L2_28[A1_27]
			if L2_28 then
				L2_28 = RailOptimizedUnits
				L2_28 = L2_28.optimized_unit_translation
				L2_28 = L2_28[A1_27]
				return L2_28
			end
		end
	end
	return A1_27
end
