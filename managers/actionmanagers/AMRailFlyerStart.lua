AMRailFlyerStart = AMRailFlyerStart or class(CoreActionElement)
function AMRailFlyerStart.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	if A0_0._mode == "spawn" or A0_0._mode == "" then
		World:preload_unit("flyer")
		managers.unit_scripting:define_unit(A0_0._name, "no_group")
	end
end
function AMRailFlyerStart.activate_now(A0_3)
	if A0_3._mode == "spawn" then
		A0_3:_spawn()
	elseif A0_3._mode == "despawn" then
		A0_3:_despawn()
	elseif A0_3._mode == "kill" then
		A0_3:_kill()
	else
		A0_3:_spawn()
	end
end
function AMRailFlyerStart._remove(A0_4)
	local L1_5
	L1_5 = managers
	L1_5 = L1_5.unit_scripting
	L1_5 = L1_5.get_unit_by_name
	L1_5 = L1_5(L1_5, A0_4._name)
	if alive(L1_5) then
		World:delete_unit(managers.unit_scripting:get_unit_by_name(A0_4._name))
	end
	A0_4:deactivate_now()
end
function AMRailFlyerStart._kill(A0_6)
	local L1_7
	L1_7 = managers
	L1_7 = L1_7.unit_scripting
	L1_7 = L1_7.get_unit_by_name
	L1_7 = L1_7(L1_7, A0_6._name)
	if alive(L1_7) then
		L1_7:damage():set_fully_damaged()
	end
	A0_6:deactivate_now()
end
function AMRailFlyerStart._despawn(A0_8)
	local L1_9
	L1_9 = managers
	L1_9 = L1_9.unit_scripting
	L1_9 = L1_9.get_unit_by_name
	L1_9 = L1_9(L1_9, A0_8._name)
	if alive(L1_9) then
		managers.unit_scripting:get_unit_by_name(A0_8._name):set_slot(0)
	end
	A0_8:deactivate_now()
end
function AMRailFlyerStart._spawn(A0_10)
	local L1_11, L2_12, L3_13, L4_14
	L1_11 = World
	L2_12 = L1_11
	L1_11 = L1_11.spawn_unit
	L3_13 = "flyer"
	L4_14 = A0_10.position
	L1_11 = L1_11(L2_12, L3_13, L4_14, A0_10.rotation)
	L3_13 = L1_11
	L2_12 = L1_11.effects
	L2_12 = L2_12(L3_13)
	L3_13 = L2_12
	L2_12 = L2_12.use_simple_effects
	L4_14 = true
	L2_12(L3_13, L4_14)
	L3_13 = L1_11
	L2_12 = L1_11.control
	L2_12 = L2_12(L3_13)
	L3_13 = L2_12
	L2_12 = L2_12.set_ai_controlled
	L2_12(L3_13)
	L3_13 = L1_11
	L2_12 = L1_11.ai_data
	L2_12 = L2_12(L3_13)
	L4_14 = A0_10
	L3_13 = A0_10.setup_rail_flier
	L3_13(L4_14, L1_11, L2_12)
	L4_14 = L1_11
	L3_13 = L1_11.ai_nerve_system
	L3_13 = L3_13(L4_14)
	L4_14 = L3_13
	L3_13 = L3_13.setup
	L3_13(L4_14, "rail")
	L4_14 = L1_11
	L3_13 = L1_11.damage_data
	L3_13 = L3_13(L4_14)
	if L3_13 then
		L4_14 = tweak_data
		L4_14 = L4_14.rail
		L4_14 = L4_14.enemy
		L4_14 = L4_14.flyer
		if L4_14 then
			L4_14 = ""
			if managers.player_slot:number_of_occupied_slots() == 2 then
				L4_14 = "_COOP"
			end
			L3_13.health = tweak_data.rail.enemy.flyer["HEALTH" .. L4_14] or tweak_data.rail.enemy.flyer.HEALTH
		end
	end
	L4_14 = L2_12._combat
	L4_14.targets = {}
	L4_14 = L2_12._move
	L4_14._closest_track = A0_10.closest_track
	L2_12.no_max_fire_velocity = true
	L4_14 = L2_12._move
	L4_14.displacement = Vector3(0, 0, 0)
	L4_14 = A0_10.displacement_x
	if L4_14 ~= nil then
		L4_14 = L2_12._move
		L4_14.displacement = L2_12._move.displacement:with_x(A0_10.displacement_x * 100)
	end
	L4_14 = A0_10.displacement_y
	if L4_14 ~= nil then
		L4_14 = L2_12._move
		L4_14.displacement = L2_12._move.displacement:with_z(A0_10.displacement_y * 100)
	end
	A0_10._unit = L1_11
	L4_14 = A0_10.deactivate_now
	L4_14(A0_10)
	L4_14 = managers
	L4_14 = L4_14.unit_scripting
	L4_14 = L4_14.register_unit
	L4_14(L4_14, A0_10._name, L1_11)
end
function AMRailFlyerStart.setup_rail_flier(A0_15, A1_16, A2_17)
	local L3_18, L4_19
	L3_18 = A0_15.waypoints
	A2_17.default_waypoints = L3_18
	L3_18 = A0_15.speed
	A2_17.default_speed = L3_18
	L3_18 = A0_15.loop_waypoints
	A2_17.default_loop_waypoints = L3_18
	L3_18 = A0_15.waypoint_pause_time
	A2_17.default_waypoint_pause_time = L3_18
	A2_17.default_threat_behavior = "ignore"
	A2_17.allowed_to_move_and_shoot = true
	L3_18 = A2_17.input
	L3_18.enemy_slot_mask = "rail_vehicles"
	L3_18 = A0_15.target_distance
	if L3_18 == nil then
		A0_15.target_distance = 40
	end
	L3_18 = A2_17.input
	L4_19 = A0_15.target_distance
	L4_19 = L4_19 * 100
	L3_18.target_range = L4_19
end
