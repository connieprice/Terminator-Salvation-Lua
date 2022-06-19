if not AiGraphData then
	AiGraphData = class()
end
AiGraphData.init = function(l_1_0, l_1_1)
	l_1_0.radius = 10000
	l_1_0.height = nil
	l_1_0.slot_mask = managers.slot:get_mask("ai_graph")
	l_1_0.graph_slot_mask = managers.slot:get_mask("ai_graph_game")
	l_1_0.ray_type_string = "low_quality_collision ai_graph_blocker"
	l_1_0.ray_radius = nil
	l_1_0.min_height = nil
	l_1_0.max_height = nil
	l_1_0.slam_up_offset = nil
	l_1_0.slam_down_offset = nil
	l_1_0.merge_expand = nil
	l_1_0.min_expand_distance = nil
	l_1_0.max_expand_distance = nil
	l_1_0.max_step_height = nil
	l_1_0.max_slope_angle = 30
end


