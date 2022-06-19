local L0_0, L1_1
L0_0 = UnitSpawnUtility
L0_0 = L0_0 or {}
UnitSpawnUtility = L0_0
L0_0 = UnitSpawnUtility
function L1_1(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7
	if A0_2 then
		L3_5 = #A0_2
		if L3_5 > 0 then
			L3_5 = A0_2[1]
			L3_5 = L3_5.waypoints
			L4_6 = UnitSpawnUtility
			L4_6 = L4_6.spawn_position_from_waypoints
			L5_7 = L3_5
			L5_7 = L4_6(L5_7)
			L5_7 = L5_7 or A2_4
			return L4_6, L5_7
		end
	end
	L3_5 = A1_3
	L4_6 = A2_4
	return L3_5, L4_6
end
L0_0.spawn_position = L1_1
L0_0 = UnitSpawnUtility
function L1_1(A0_8)
	local L1_9, L2_10, L3_11, L4_12
	L3_11 = A0_8[1]
	L1_9 = L3_11.position
	L3_11 = assert
	L4_12 = L1_9
	L3_11(L4_12, "there must be a position defined on the first waypoint")
	L3_11 = #A0_8
	if L3_11 ~= 1 then
		L3_11 = A0_8[1]
		L3_11 = L3_11.position
		L4_12 = A0_8[2]
		L4_12 = L4_12.position
		L2_10 = Rotation:look_at(L3_11, L4_12, math.UP)
	else
		L3_11 = A0_8[1]
		L2_10 = L3_11.rotation
	end
	L3_11 = L1_9
	L4_12 = L2_10
	return L3_11, L4_12
end
L0_0.spawn_position_from_waypoints = L1_1
L0_0 = UnitSpawnUtility
function L1_1(A0_13, A1_14, A2_15)
	if alive(A0_13) then
		if A0_13:base() and A0_13:base().warp_to then
			A0_13:base():warp_to(A1_14, A2_15)
		else
			A0_13:warp_to(A1_14, A2_15)
		end
		if A0_13:ai_nerve_system() then
			A0_13:ai_nerve_system():warp_to(A1_14, A2_15)
		end
	else
		Application:error("Unit not found!")
	end
end
L0_0.warp_to = L1_1
