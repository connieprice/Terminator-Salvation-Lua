DebugAiOrder = DebugAiOrder or class()
function DebugAiOrder.init(A0_0)
	local L1_1
end
function DebugAiOrder.move_to_human_player(A0_2)
	local L1_3, L2_4, L3_5
	L1_3 = Vector3
	L2_4 = 0
	L3_5 = 0
	L1_3 = L1_3(L2_4, L3_5, 0)
	L2_4 = Rotation
	L3_5 = 0
	L2_4 = L2_4(L3_5, 0, 0)
	L3_5 = A0_2._setup_unit_infos
	L3_5(A0_2, L1_3, L2_4)
	L3_5 = A0_2._setup_movement_options
	L3_5(A0_2)
	L3_5 = A0_2._setup_area_cluster
	L3_5(A0_2, L1_3)
	L3_5 = nil
	managers.director.order:give_order(A0_2._unit_infos, A0_2._waypoint_paths, A0_2._movement_options, L3_5, A0_2._area_cluster)
end
function DebugAiOrder._setup_unit_infos(A0_6)
	local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12, L7_13, L8_14
	L1_7 = {}
	A0_6._unit_infos = L1_7
	L1_7, L2_8 = nil, nil
	L3_9 = {}
	L8_14 = L5_11(L6_12)
	for L7_13, L8_14 in L4_10(L5_11, L6_12, L7_13, L8_14, L5_11(L6_12)) do
		if not managers.player:is_human_player(L8_14) then
			L3_9[#L3_9 + 1] = L8_14
		else
			L1_7 = L8_14:position()
			L2_8 = L8_14:rotation()
		end
	end
	L4_10(L5_11)
	L4_10(L5_11)
	A0_6._waypoint_paths = L4_10
	for L7_13, L8_14 in L4_10(L5_11) do
		({}).script_name = managers.unit_scripting:unit_script_name(L8_14)
		A0_6._unit_infos[#A0_6._unit_infos + 1] = {}
		A0_6._waypoint_paths[L7_13] = A0_6:_setup_waypoint_path(L1_7, L2_8)
	end
end
function DebugAiOrder._setup_waypoint_path(A0_15, A1_16, A2_17)
	local L3_18, L4_19, L5_20
	L3_18 = {}
	L4_19 = {}
	L3_18.waypoints = L4_19
	L4_19 = {}
	L5_20 = {}
	L4_19.options = L5_20
	L5_20 = L4_19.options
	L5_20.loop_waypoints = false
	L4_19.position = A1_16
	L4_19.rotation = A2_17
	L5_20 = L3_18.waypoints
	L5_20[1] = L4_19
	return L3_18
end
function DebugAiOrder._setup_movement_options(A0_21)
	A0_21._movement_options = {}
end
function DebugAiOrder._setup_area_cluster(A0_22, A1_23)
	local L2_24
	L2_24 = {}
	A0_22._area_cluster = L2_24
	L2_24 = {}
	L2_24.position = A1_23
	A0_22._area_cluster[1] = L2_24
end
