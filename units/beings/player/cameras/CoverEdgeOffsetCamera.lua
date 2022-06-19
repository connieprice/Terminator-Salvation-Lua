require("shared/camera/SharedCamera")
CoverEdgeOffsetCamera = CoverEdgeOffsetCamera or class(SharedCamera)
function CoverEdgeOffsetCamera.init(A0_0, A1_1)
	SharedCamera.init(A0_0, A1_1)
	A0_0.offset_at_left_edge = false
	A0_0.offset_at_right_edge = false
	A0_0.left_edge_offset = 0
	A0_0.right_edge_offset = 0
	A0_0.start_edge_distance = 10
end
function CoverEdgeOffsetCamera.activate(A0_2)
	A0_2._player_data = A0_2._root_unit:player_data()
end
function CoverEdgeOffsetCamera.update(A0_3, A1_4, A2_5, A3_6)
	local L4_7, L5_8, L6_9
	L4_7 = SharedCamera
	L4_7 = L4_7.update
	L5_8 = A0_3
	L6_9 = A1_4
	L4_7(L5_8, L6_9, A2_5, A3_6)
	L4_7 = A0_3._player_data
	L5_8 = 0
	L6_9 = A0_3.offset_at_left_edge
	if L6_9 then
		L6_9 = A0_3._near_edge_offset
		L6_9 = L6_9(A0_3, L4_7.distance_to_left_cover_edge, A0_3.left_edge_offset)
		L5_8 = -L6_9
	end
	L6_9 = A0_3.offset_at_right_edge
	if L6_9 then
		L6_9 = A0_3._near_edge_offset
		L6_9 = L6_9(A0_3, L4_7.distance_to_right_cover_edge, A0_3.right_edge_offset)
		L5_8 = L5_8 + L6_9
	end
	L6_9 = Vector3
	L6_9 = L6_9(L5_8, 0, 0)
	A0_3._unit:set_local_position(L6_9)
end
function CoverEdgeOffsetCamera._near_edge_offset(A0_10, A1_11, A2_12)
	if A1_11 then
	else
	end
	return 0
end
