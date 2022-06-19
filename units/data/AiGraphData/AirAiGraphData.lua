require("units/data/AiGraphData/AiGraphData")
AirAiGraphData = AirAiGraphData or class(AiGraphData)
function AirAiGraphData.init(A0_0, A1_1)
	AiGraphData.init(A0_0, A1_1)
	A0_0.height = 2500
	A0_0.ray_type_string = "body ai_graph_blocker ai_graph_flyer_blocker"
	A0_0.ray_radius = 60
	A0_0.min_height = -A0_0.ray_radius
	A0_0.slam_up_offset = -A0_0.ray_radius
	A0_0.slam_down_offset = A0_0.ray_radius
	A0_0.merge_expand = 100
	A0_0.min_expand_distance = 50
	A0_0.max_expand_distance = 500
	A0_0.max_step_height = 75
end
