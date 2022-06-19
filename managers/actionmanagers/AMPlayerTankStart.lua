require("managers/actionmanagers/AiUnitSpawn")
AMPlayerTankStart = AMPlayerTankStart or class(AiUnitSpawn)
function AMPlayerTankStart.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	AiUnitSpawn.init(A0_0, A1_1, A2_2, A3_3)
	A4_4 = A4_4 or "player_tank"
	A0_0:setup(A4_4)
	A0_0._is_persistent = true
end
function AMPlayerTankStart._spawn(A0_5)
	local L1_6, L2_7, L3_8, L4_9
	L1_6 = A0_5._player_slot
	if not L1_6 then
		A0_5._player_slot = 1
	end
	L1_6 = nil
	L2_7 = A0_5._is_persistent
	if L2_7 then
		L2_7 = managers
		L2_7 = L2_7.drama_scene
		L3_8 = L2_7
		L2_7 = L2_7.unit_name_to_script_name
		L4_9 = A0_5._spawn_unit_name
		L2_7 = L2_7(L3_8, L4_9)
		if L2_7 then
			L3_8 = managers
			L3_8 = L3_8.unit_scripting
			L4_9 = L3_8
			L3_8 = L3_8.get_unit_by_name
			L3_8 = L3_8(L4_9, L2_7)
			L1_6 = L3_8
		end
	else
		L2_7 = managers
		L2_7 = L2_7.unit_scripting
		L3_8 = L2_7
		L2_7 = L2_7.get_unit_by_name
		L4_9 = A0_5._name
		L2_7 = L2_7(L3_8, L4_9)
		L1_6 = L2_7
	end
	L2_7, L3_8 = nil, nil
	L4_9 = UnitSpawnUtility
	L4_9 = L4_9.spawn_position
	L3_8, L4_9 = A0_5.waypoint_paths, L4_9(A0_5.waypoint_paths, A0_5.position, A0_5.rotation)
	L2_7 = L4_9
	L4_9 = alive
	L4_9 = L4_9(L1_6)
	if L4_9 then
		L4_9 = managers
		L4_9 = L4_9.unit_scripting
		L4_9 = L4_9.unit_script_name
		L4_9 = L4_9(L4_9, L1_6)
		managers.unit_scripting:register_new_unit_name(L4_9, A0_5._name, L1_6)
		managers.drama_scene:set_unit_name_to_script_name(A0_5._spawn_unit_name, A0_5._name)
		A0_5:deactivate_now()
		return
	end
	L4_9 = World
	L4_9 = L4_9.spawn_unit
	L4_9 = L4_9(L4_9, A0_5._spawn_unit_name, L2_7, L3_8)
	L1_6 = L4_9
	L4_9 = A0_5._player_slot
	if L4_9 then
		L4_9 = assert
		L4_9(not managers.player_slot:slot(A0_5._player_slot):spawned_unit())
		L4_9 = managers
		L4_9 = L4_9.player_slot
		L4_9 = L4_9.set_unit
		L4_9(L4_9, A0_5._player_slot, L1_6, L1_6:name(), L2_7, L3_8, false, true)
	end
	L4_9 = managers
	L4_9 = L4_9.unit_scripting
	L4_9 = L4_9.register_unit
	L4_9(L4_9, A0_5._name, L1_6)
	L4_9 = managers
	L4_9 = L4_9.drama_scene
	L4_9 = L4_9.set_unit_name_to_script_name
	L4_9(L4_9, A0_5._spawn_unit_name, A0_5._name)
	L4_9 = A0_5.deactivate_now
	L4_9(A0_5)
end
