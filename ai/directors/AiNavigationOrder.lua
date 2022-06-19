AiNavigationOrder = AiNavigationOrder or class()
function AiNavigationOrder.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	A0_0._unit_infos = A1_1
	A0_0._waypoint_paths = A2_2
	A0_0._movement_options = A3_3
	A0_0._id = A4_4
	A0_0._area_cluster = A5_5
	A0_0._arrive_orders = A6_6
	A0_0._unit_waypoint_paths = {}
	A0_0._unit_type_lookup = {}
	for 