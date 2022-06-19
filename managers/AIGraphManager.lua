Killer = Killer or class()
AIGraphManager = AIGraphManager or class()
AIGraphManager._ai_graph_types = {
	human = "surface",
	spider = "surface",
	flyer = "air"
}
function AIGraphManager.init(A0_0)
	A0_0._ai_unit_slot = managers.slot:get_mask("ai_editor")
	A0_0._name = nil
	A0_0._is_air_graph = nil
	A0_0._zones = {}
	A0_0._nodes_list = {
		{},
		{}
	}
	A0_0._nodes_list_not_connex = {}
	A0_0._flat_nodes_list = {}
	A0_0._root_points_list = {}
	A0_0._current_root_index = 0
	A0_0._current_root = nil
	A0_0._current_root_position = nil
	A0_0:low_priority()
	A0_0._engine_version = true
	A0_0._last_garbage_collector_time = os.clock()
	A0_0._navigation_graph = nil
	A0_0._calculated_step = 0
	A0_0._next_node_merge = nil
	A0_0._draw_debug = false
	A0_0._linked = false
	A0_0._expand_count = 0
	A0_0._merge_count = 0
	A0_0._num_links = 0
end
function AIGraphManager.setup_data(A0_1, A1_2)
	local L2_3, L3_4, L4_5
	L2_3 = Killer
	L3_4 = Killer
	L3_4 = L3_4.graph_data
	L3_4 = L3_4 or {}
	L2_3.graph_data = L3_4
	L2_3 = Killer
	L2_3 = L2_3.graph_data
	L3_4 = A1_2.slot_mask
	L2_3.slot_mask = L3_4
	L3_4 = A1_2.slam_up_offset
	L2_3.MAX_HEIGH_GOING_UP = L3_4
	L3_4 = A1_2.ray_radius
	L2_3._radius = L3_4
	L3_4 = A1_2.min_height
	L2_3._min_high = L3_4
	L3_4 = A1_2.slam_down_offset
	L2_3._max_high = L3_4
	L3_4 = A1_2.slot_mask
	L2_3._slot = L3_4
	L3_4 = A1_2.ray_type_string
	L2_3._ray_type = L3_4
	L3_4 = A1_2.max_step_height
	L2_3.max_step_height = L3_4
	L3_4 = A1_2.max_slope_angle
	L2_3.max_slope_angle = L3_4
	L3_4 = A1_2.merge_expand
	L2_3.MERGE_EXPAND = L3_4
	L3_4 = A1_2.min_expand_distance
	L2_3.MIN_EXPAND_DISTANCE = L3_4
	L3_4 = A1_2.max_expand_distance
	L2_3.MAX_EXPAND_DISTANCE = L3_4
	L3_4 = Killer
	L4_5 = Killer
	L4_5 = L4_5.move_data
	L4_5 = L4_5 or {}
	L3_4.move_data = L4_5
	L3_4 = Killer
	L2_3 = L3_4.move_data
	L3_4 = A1_2.ray_radius
	L2_3._radius = L3_4
	L3_4 = A1_2.graph_slot_mask
	L2_3._slot = L3_4
	L3_4 = A1_2.ray_type_string
	L2_3._ray_type = L3_4
end
function AIGraphManager.clear(A0_6)
	A0_6._nodes_list = {
		{},
		{}
	}
	A0_6._nodes_list_not_connex = {}
	A0_6._root_points_list = {}
	A0_6._current_root_index = 0
	A0_6._current_root = nil
	A0_6._current_root_position = nil
	nodes_to_explote = {}
	A0_6._last_garbage_collector_time = os.clock()
	A0_6._covered = {}
	A0_6._navigation_graph = nil
	A0_6._expand_count = 0
	A0_6._merge_count = 0
	A0_6._num_links = 0
	A0_6:remove_all_nodes()
	Draw:pen("permanent", 0, 0, 0):clear()
end
function AIGraphManager.create(A0_7, A1_8)
	A0_7._graph_data = A1_8
	A0_7:setup()
end
function AIGraphManager.setup(A0_9)
	local L1_10, L2_11, L3_12
	L1_10 = A0_9._graph_data
	L1_10 = L1_10[1]
	L1_10 = L1_10.name
	L2_11 = A0_9._graph_data
	L2_11 = L2_11[1]
	L2_11 = L2_11.type
	L3_12 = A0_9._graph_data
	L3_12 = L3_12[1]
	L3_12 = L3_12.ref_object
	A0_9._name = L1_10
	A0_9._is_air_graph = L2_11 == "air"
	A0_9:clear()
	if L3_12 then
		A0_9:add_root_point(L3_12, true)
	else
		A0_9:find_root_points(L2_11)
	end
	if #A0_9._root_points_list > 0 then
		A0_9._calculated_step = 1
	else
		A0_9._calculated_step = 0
	end
end
function AIGraphManager.high_priority(A0_13)
	local L1_14
	A0_13._time_slice = 0.1
end
function AIGraphManager.low_priority(A0_15)
	local L1_16
	A0_15._time_slice = 0.016666668
end
function AIGraphManager.abort(A0_17)
	A0_17:clear()
	A0_17._calculated_step = 0
end
function AIGraphManager.working(A0_18)
	local L1_19
	L1_19 = A0_18._calculated_step
	L1_19 = L1_19 > 0 and L1_19 < 6
	return L1_19
end
function AIGraphManager.can_abort(A0_20)
	local L1_21
	L1_21 = A0_20._calculated_step
	L1_21 = L1_21 > 0 and L1_21 < 3
	return L1_21
end
function AIGraphManager.draw_debug(A0_22, A1_23)
	A0_22._draw_debug = A1_23
end
function AIGraphManager.status(A0_24)
	if A0_24._calculated_step == 0 and A0_24._name then
		return "Aborted [" .. A0_24._name .. "] "
	elseif A0_24._calculated_step == 1 then
		return "Calculating... [" .. A0_24._name .. "] " .. A0_24._current_root_index .. "/" .. #A0_24._root_points_list .. " : ~" .. A0_24:percentage() .. "% (" .. A0_24._expand_count .. ")"
	elseif A0_24._calculated_step == 2 then
		return "Merging... [" .. A0_24._name .. "] : " .. A0_24:percentage() .. "% (" .. A0_24._merge_count .. ")"
	elseif A0_24._calculated_step == 3 then
		return "Linking... [" .. A0_24._name .. "] : " .. A0_24:percentage() .. "% (" .. A0_24._num_links .. ")"
	elseif A0_24._calculated_step == 4 or A0_24._calculated_step == 5 then
		return "Finishing... [" .. A0_24._name .. "]"
	elseif A0_24._calculated_step == 6 then
		return "Finished [" .. A0_24._name .. "]"
	end
	return ""
end
function AIGraphManager.percentage(A0_25)
	local L1_26
	L1_26 = A0_25._calculated_step
	if L1_26 == 1 then
		L1_26 = A0_25._current_root_index
		if L1_26 then
			L1_26 = A0_25._root_points_list
			if L1_26 then
				L1_26 = A0_25._current_root_index
				if L1_26 ~= 0 then
					L1_26 = A0_25._root_points_list
					L1_26 = #L1_26
				end
			end
		elseif L1_26 == 0 then
			L1_26 = 0
			return L1_26
		end
		L1_26 = TableAlgorithms
		L1_26 = L1_26.count
		L1_26 = L1_26(A0_25._covered)
		if A0_25._is_air_graph then
			L1_26 = L1_26 * L1_26 * L1_26 / 10000
		else
			L1_26 = L1_26 * L1_26 / 100
		end
		L1_26 = math.round(100 * A0_25:get_root_point_measures() + L1_26 * A0_25:get_root_point_measures())
		return L1_26
	else
		L1_26 = A0_25._calculated_step
		if L1_26 ~= 2 then
			L1_26 = A0_25._calculated_step
		elseif L1_26 == 3 then
			L1_26 = A0_25._next_node_merge
			if L1_26 then
				L1_26 = A0_25._merge_nodes_list
			elseif not L1_26 then
				L1_26 = 0
				return L1_26
			end
			L1_26 = TableAlgorithms
			L1_26 = L1_26.count_to
			L1_26 = L1_26(A0_25._merge_nodes_list, A0_25._next_node_merge)
			return math.round(100 * L1_26 / TableAlgorithms.count(A0_25._merge_nodes_list))
		end
	end
	L1_26 = 0
	return L1_26
end
function AIGraphManager.get_root_point_measures(A0_27)
	local L1_28, L2_29, L3_30, L4_31, L5_32, L6_33, L7_34, L8_35
	L2_29 = 0
	L3_30 = 0
	for L7_34, L8_35 in L4_31(L5_32) do
		if L7_34 < A0_27._current_root_index then
			L3_30 = L3_30 + A0_27:root_point_size(L8_35)
		elseif L7_34 == A0_27._current_root_index then
			L1_28 = A0_27:root_point_size(L8_35)
		end
		L2_29 = L2_29 + A0_27:root_point_size(L8_35)
	end
	L7_34 = L5_32
	return L6_33, L7_34
end
function AIGraphManager.root_point_size(A0_36, A1_37)
	local L2_38, L3_39
	L2_38 = math
	L2_38 = L2_38.pi
	L2_38 = 4 * L2_38
	L3_39 = A1_37.ai_graph_data
	L3_39 = L3_39.radius
	L2_38 = L2_38 * L3_39
	L3_39 = A1_37.ai_graph_data
	L3_39 = L3_39.radius
	L2_38 = L2_38 * L3_39
	L3_39 = A0_36._is_air_graph
	if L3_39 then
		L3_39 = A1_37.ai_graph_data
		L3_39 = L3_39.height
		if L3_39 then
			L3_39 = A1_37.ai_graph_data
			L3_39 = L3_39.height
			L2_38 = L2_38 * L3_39
		else
			L3_39 = A1_37.ai_graph_data
			L3_39 = L3_39.radius
			L3_39 = L2_38 * L3_39
			L2_38 = L3_39 / 3
		end
	end
	return L2_38
end
function AIGraphManager.update(A0_40, A1_41, A2_42)
	if A0_40._calculated_step == 1 then
		A0_40:step_one()
		if not A0_40:have_nodes_to_explode() and not A0_40._root_points_list[A0_40._current_root_index] then
			A0_40._calculated_step = 2
			A0_40._engine_version = false
			A0_40._merge_nodes_list = nil
			A0_40._merge_count = 0
			A0_40:cleanup_nodes_list()
		end
	elseif A0_40._calculated_step == 2 then
		if not A0_40._merge_nodes_list then
			A0_40:step_two_prepare()
		end
		A0_40:step_two()
		if not A0_40._next_node_merge then
			A0_40._calculated_step = 3
			A0_40._merge_nodes_list = nil
		end
	elseif A0_40._calculated_step == 3 then
		if not A0_40._merge_nodes_list then
			A0_40:step_three_prepare()
		end
		A0_40:step_three()
		if not A0_40._next_node_merge then
			A0_40._calculated_step = 4
		end
	elseif A0_40._calculated_step == 4 then
		A0_40:step_four()
		A0_40._calculated_step = 5
	elseif A0_40._calculated_step == 5 then
		A0_40:step_five()
		A0_40._calculated_step = 6
		A0_40._engine_version = true
		managers.ai_graph:save(managers.editor:get_level_path())
		table.remove(A0_40._graph_data, 1)
		if A0_40._graph_data[1] then
			A0_40:setup()
		end
	end
end
function AIGraphManager.step_one(A0_43)
	local L1_44, L2_45
	L1_44 = A0_43._current_root_index
	if L1_44 == 0 then
		L1_44 = assert
		L2_45 = A0_43.have_nodes_to_explode
		L2_45 = L2_45(A0_43)
		L2_45 = not L2_45
		L1_44(L2_45)
		L1_44 = {}
		A0_43._nodes_list = L1_44
		L2_45 = A0_43
		L1_44 = A0_43.remove_all_nodes
		L1_44(L2_45)
	end
	L1_44 = A0_43._root_points_list
	L1_44 = #L1_44
	if L1_44 <= 0 then
		A0_43._calculated_step = 0
		return
	end
	L2_45 = A0_43
	L1_44 = A0_43.ai_graph_types
	L1_44 = L1_44(L2_45)
	L2_45 = A0_43._name
	L1_44 = L1_44[L2_45]
	L2_45 = assert
	L2_45(L1_44)
	L2_45 = A0_43.have_nodes_to_explode
	L2_45 = L2_45(A0_43)
	if not L2_45 then
		L2_45 = A0_43._current_root_index
		L2_45 = L2_45 + 1
		A0_43._current_root_index = L2_45
	end
	L2_45 = A0_43._root_points_list
	L2_45 = L2_45[A0_43._current_root_index]
	if not L2_45 then
		assert(not A0_43:have_nodes_to_explode())
		return
	end
	if not A0_43:have_nodes_to_explode() then
		A0_43._covered = {}
		Application:debug("Calculating " .. L1_44 .. " graph " .. A0_43._current_root_index .. "/" .. #A0_43._root_points_list .. " (" .. tostring(L2_45.point) .. ")")
		print(Application:date("[%X][AIGraphManager][step_one] calculating nodes..."))
	end
	A0_43:calculate(L2_45)
end
function AIGraphManager.step_two_prepare(A0_46)
	A0_46._merge_nodes_list = A0_46._flat_nodes_list
	A0_46._next_node_merge = next(A0_46._merge_nodes_list, nil)
end
function AIGraphManager.step_two(A0_47)
	A0_47:calculate_merge_closed_points()
end
function AIGraphManager.step_three_prepare(A0_48)
	local L1_49, L2_50, L3_51, L4_52, L5_53, L6_54, L7_55, L8_56
	L1_49 = A0_48._flat_nodes_list
	A0_48._merge_nodes_list = L1_49
	L1_49 = next
	L2_50 = A0_48._merge_nodes_list
	L3_51 = nil
	L1_49 = L1_49(L2_50, L3_51)
	A0_48._next_node_merge = L1_49
	A0_48._num_links = 0
	L1_49 = os
	L1_49 = L1_49.clock
	L1_49 = L1_49()
	A0_48._last_garbage_collector_time = L1_49
	L2_50 = A0_48
	L1_49 = A0_48.ai_graph_types
	L1_49 = L1_49(L2_50)
	L2_50 = A0_48._name
	L1_49 = L1_49[L2_50]
	L2_50 = Search
	L3_51 = L2_50
	L2_50 = L2_50.nav
	L2_50 = L2_50(L3_51, L4_52)
	A0_48._navigation_graph = L2_50
	L2_50 = A0_48._root_points_list
	L2_50 = L2_50[1]
	L2_50 = L2_50.is_selection
	if L2_50 then
		L2_50 = A0_48._root_points_list
		L2_50 = L2_50[1]
		L3_51 = nil
		if L4_52 then
			L7_55 = Vector3
			L8_56 = 0
			L7_55 = L7_55(L8_56, 0, L2_50.ai_graph_data.height)
			L7_55 = L2_50.ai_graph_data
			L7_55 = L7_55.radius
			L8_56 = L2_50.ai_graph_data
			L8_56 = L8_56.height
			L8_56 = 2 * L8_56
			L3_51 = L4_52
		else
			L7_55 = L2_50.ai_graph_data
			L7_55 = L7_55.radius
			L3_51 = L4_52
		end
		for L7_55, L8_56 in L4_52(L5_53) do
			A0_48._navigation_graph:remove_node(L8_56)
		end
	else
		L2_50 = A0_48._navigation_graph
		L3_51 = L2_50
		L2_50 = L2_50.clear_manual
		L2_50(L3_51)
		L2_50 = A0_48._navigation_graph
		L3_51 = L2_50
		L2_50 = L2_50.clear_static
		L2_50(L3_51)
	end
	L2_50 = A0_48._engine_version
	if L2_50 then
		L2_50 = print
		L3_51 = "[AIGraphManager][step_three_prepare] adding static points..."
		L2_50(L3_51)
		L3_51 = A0_48
		L2_50 = A0_48.add_static_points
		L2_50(L3_51)
	end
	L2_50 = print
	L3_51 = Application
	L3_51 = L3_51.date
	L8_56 = L3_51(L4_52, L5_53)
	L2_50(L3_51, L4_52, L5_53, L6_54, L7_55, L8_56, L3_51(L4_52, L5_53))
	L2_50 = A0_48._navigation_graph
	L3_51 = L2_50
	L2_50 = L2_50.set_slot_mask
	L2_50(L3_51, L4_52)
	L2_50 = A0_48._navigation_graph
	L3_51 = L2_50
	L2_50 = L2_50.set_slam_slot_mask
	L2_50(L3_51, L4_52)
	L2_50 = math
	L2_50 = L2_50.sqrt
	L3_51 = Killer
	L3_51 = L3_51.graph_data
	L3_51 = L3_51.MAX_EXPAND_DISTANCE
	L3_51 = L3_51 * L4_52
	L3_51 = L3_51 * 2
	L3_51 = L3_51 + 2
	L2_50 = L2_50(L3_51)
	L3_51 = A0_48._navigation_graph
	L3_51 = L3_51.set_ray_height
	L7_55 = 3
	L3_51(L4_52, L5_53, L6_54, L7_55)
	L3_51 = A0_48._navigation_graph
	L3_51 = L3_51.set_walk_test_parameters
	L7_55 = 100
	L8_56 = Killer
	L8_56 = L8_56.move_data
	L8_56 = L8_56._radius
	L3_51(L4_52, L5_53, L6_54, L7_55, L8_56)
	L3_51 = A0_48._navigation_graph
	L3_51 = L3_51.set_autolink
	L3_51(L4_52, L5_53, L6_54)
	L3_51 = A0_48._navigation_graph
	L3_51 = L3_51.set_sphere_cast_radius
	L3_51(L4_52, L5_53)
	L3_51 = A0_48._navigation_graph
	L3_51 = L3_51.set_slam
	L3_51(L4_52, L5_53, L6_54)
	L3_51 = A0_48._navigation_graph
	L3_51 = L3_51.set_ray_type
	L3_51(L4_52, L5_53)
end
function AIGraphManager.step_three(A0_57)
	if not A0_57._engine_version then
		A0_57:build_static_step(A0_57._navigation_graph)
	end
end
function AIGraphManager.step_four(A0_58)
	A0_58._navigation_graph:build_static(A0_58._root_points_list[1].point)
	A0_58._navigation_graph:set_max_search_nodes(10000)
	A0_58._nodes_list_not_connex = A0_58._navigation_graph:manual_nodes()
	for 