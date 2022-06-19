require("units/data/AiGraphData/SurfaceAiGraphData")
if not SpiderAiGraphData then
	SpiderAiGraphData = class(AiGraphData)
end
SpiderAiGraphData.init = function(l_1_0, l_1_1)
	AiGraphData.init(l_1_0, l_1_1)
	l_1_0.ray_type_string = "body ai_graph_blocker ai_graph_spider_blocker"
	l_1_0.ray_radius = 150
	l_1_0.min_height = 0.5 * l_1_0.ray_radius
	l_1_0.slam_up_offset = 0.5 * l_1_0.ray_radius + 2
	l_1_0.slam_down_offset = 250
	l_1_0.merge_expand = 150
	l_1_0.min_expand_distance = 25
	l_1_0.max_expand_distance = 250
	l_1_0.max_step_height = 75
end


