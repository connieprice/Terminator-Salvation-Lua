AiGraphData = AiGraphData or class()
function AiGraphData.init(A0_0, A1_1)
	A0_0.radius = 10000
	A0_0.height = nil
	A0_0.slot_mask = managers.slot:get_mask("ai_graph")
	A0_0.graph_slot_mask = managers.slot:get_mask("ai_graph_game")
	A0_0.ray_type_string = "low_quality_collision ai_graph_blocker"
	A0_0.ray_radius = nil
	A0_0.min_height = nil
	A0_0.max_height = nil
	A0_0.slam_up_offset = nil
	A0_0.slam_down_offset = nil
	A0_0.merge_expand = nil
	A0_0.min_expand_distance = nil
	A0_0.max_expand_distance = nil
	A0_0.max_step_height = nil
	A0_0.max_slope_angle = 30
end
