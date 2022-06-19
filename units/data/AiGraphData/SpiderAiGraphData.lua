require("units/data/AiGraphData/SurfaceAiGraphData")
SpiderAiGraphData = SpiderAiGraphData or class(AiGraphData)
function SpiderAiGraphData.init(A0_0, A1_1)
	AiGraphData.init(A0_0, A1_1)
	A0_0.ray_type_string = "body ai_graph_blocker ai_graph_spider_blocker"
	A0_0.ray_radius = 150
	A0_0.min_height = 0.5 * A0_0.ray_radius
	A0_0.slam_up_offset = 0.5 * A0_0.ray_radius + 2
	A0_0.slam_down_offset = 250
	A0_0.merge_expand = 150
	A0_0.min_expand_distance = 25
	A0_0.max_expand_distance = 250
	A0_0.max_step_height = 75
end
