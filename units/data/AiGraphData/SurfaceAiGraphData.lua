require("units/data/AiGraphData/AiGraphData")
SurfaceAiGraphData = SurfaceAiGraphData or class(AiGraphData)
function SurfaceAiGraphData.init(A0_0, A1_1)
	AiGraphData.init(A0_0, A1_1)
	A0_0.ray_type_string = "body ai_graph_blocker ai_graph_human_blocker"
	A0_0.ray_radius = 60
	A0_0.min_height = 0.5 * A0_0.ray_radius
	A0_0.slam_up_offset = 0.5 * A0_0.ray_radius + 2
	A0_0.slam_down_offset = 170
	A0_0.merge_expand = 60
	A0_0.min_expand_distance = 25
	A0_0.max_expand_distance = 200
	A0_0.max_step_height = 75
end
