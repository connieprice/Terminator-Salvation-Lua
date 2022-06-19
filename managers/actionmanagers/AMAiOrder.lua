AMAiOrder = AMAiOrder or class(CoreActionElement)
function AMAiOrder.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMAiOrder.activate_now(A0_3)
	managers.director.order:give_order(A0_3.units, A0_3.waypoint_paths, A0_3.movement_options, A0_3.order, A0_3.area_cluster)
	A0_3:deactivate_now()
end
