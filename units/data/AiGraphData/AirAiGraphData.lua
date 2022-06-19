require("units/data/AiGraphData/AiGraphData")
if not AirAiGraphData then
	AirAiGraphData = class(AiGraphData)
end
AirAiGraphData.init = function(l_1_0, l_1_1)
	AiGraphData.init(l_1_0, l_1_1)
	l_1_0.height = 2500
	l_1_0.ray_type_string = "body ai_graph_blocker ai_graph_flyer_blocker"
	l_1_0.ray_radius = 60
	l_1_0.min_height = -l_1_0.ray_radius
	l_1_0.slam_up_offset = -l_1_0.ray_radius
	l_1_0.slam_down_offset = l_1_0.ray_radius
	l_1_0.merge_expand = 100
	l_1_0.min_expand_distance = 50
	l_1_0.max_expand_distance = 500
	l_1_0.max_step_height = 75
end


