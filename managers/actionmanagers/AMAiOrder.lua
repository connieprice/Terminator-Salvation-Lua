if not AMAiOrder then
	AMAiOrder = class(CoreActionElement)
end
AMAiOrder.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMAiOrder.activate_now = function(l_2_0)
	managers.director.order:give_order(l_2_0.units, l_2_0.waypoint_paths, l_2_0.movement_options, l_2_0.order, l_2_0.area_cluster)
	l_2_0:deactivate_now()
end


