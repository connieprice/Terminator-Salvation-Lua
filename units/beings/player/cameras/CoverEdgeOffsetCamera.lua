require("shared/camera/SharedCamera")
if not CoverEdgeOffsetCamera then
	CoverEdgeOffsetCamera = class(SharedCamera)
end
CoverEdgeOffsetCamera.init = function(l_1_0, l_1_1)
	SharedCamera.init(l_1_0, l_1_1)
	l_1_0.offset_at_left_edge = false
	l_1_0.offset_at_right_edge = false
	l_1_0.left_edge_offset = 0
	l_1_0.right_edge_offset = 0
	l_1_0.start_edge_distance = 10
end

CoverEdgeOffsetCamera.activate = function(l_2_0)
	l_2_0._player_data = l_2_0._root_unit:player_data()
end

CoverEdgeOffsetCamera.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	SharedCamera.update(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4 = l_3_0._player_data
	local l_3_5 = 0
	if l_3_0.offset_at_left_edge then
		l_3_5 = -l_3_0:_near_edge_offset(l_3_4.distance_to_left_cover_edge, l_3_0.left_edge_offset)
	end
	if l_3_0.offset_at_right_edge then
		l_3_5 = l_3_5 + l_3_0:_near_edge_offset(l_3_4.distance_to_right_cover_edge, l_3_0.right_edge_offset)
	end
	local l_3_6 = Vector3(l_3_5, 0, 0)
	l_3_0._unit:set_local_position(l_3_6)
end

CoverEdgeOffsetCamera._near_edge_offset = function(l_4_0, l_4_1, l_4_2)
	if l_4_1 then
		local l_4_3, l_4_4 = (1 - math.clamp(l_4_1 / l_4_0.start_edge_distance, 0, 1)) * l_4_2
	else
		return 0
	end
end


