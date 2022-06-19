require("units/data/AiGraphData/AiGraphData")
if not SurfaceAiGraphData then
	SurfaceAiGraphData = class(AiGraphData)
end
SurfaceAiGraphData.init = function(l_1_0, l_1_1)
	AiGraphData.init(l_1_0, l_1_1)
	l_1_0.ray_type_string = "body ai_graph_blocker ai_graph_human_blocker"
	l_1_0.ray_radius = 60
	l_1_0.min_height = 0.5 * l_1_0.ray_radius
	l_1_0.slam_up_offset = 0.5 * l_1_0.ray_radius + 2
	l_1_0.slam_down_offset = 170
	l_1_0.merge_expand = 60
	l_1_0.min_expand_distance = 25
	l_1_0.max_expand_distance = 200
	l_1_0.max_step_height = 75
end


