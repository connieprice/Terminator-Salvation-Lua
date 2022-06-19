if not DebugAiOrder then
	DebugAiOrder = class()
end
DebugAiOrder.init = function(l_1_0)
end

DebugAiOrder.move_to_human_player = function(l_2_0)
	local l_2_1 = Vector3(0, 0, 0)
	local l_2_2 = Rotation(0, 0, 0)
	l_2_0:_setup_unit_infos(l_2_1, l_2_2)
	l_2_0:_setup_movement_options()
	l_2_0:_setup_area_cluster(l_2_1)
	local l_2_3 = nil
	managers.director.order:give_order(l_2_0._unit_infos, l_2_0._waypoint_paths, l_2_0._movement_options, l_2_3, l_2_0._area_cluster)
end

DebugAiOrder._setup_unit_infos = function(l_3_0)
	l_3_0._unit_infos = {}
	local l_3_1, l_3_2 = nil, nil
	local l_3_3 = {}
	local l_3_7, l_3_8 = pairs, managers.player:players()
	l_3_7 = l_3_7(l_3_8)
	for i_0,i_1 in l_3_7 do
		if not managers.player:is_human_player(l_3_6) then
			l_3_3[#l_3_3 + 1] = l_3_6
		else
			l_3_1 = l_3_6:position()
			l_3_2 = l_3_6:rotation()
		end
	end
	assert(l_3_1)
	assert(l_3_2)
	l_3_0._waypoint_paths = {}
	for i_0,i_1 in pairs(l_3_3) do
		do
			local l_3_9 = {}
			l_3_9.script_name = managers.unit_scripting:unit_script_name(i_1)
			l_3_0._unit_infos[#l_3_0._unit_infos + 1] = l_3_9
			l_3_0._waypoint_paths[i_0] = l_3_0:_setup_waypoint_path(l_3_1, l_3_2)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

DebugAiOrder._setup_waypoint_path = function(l_4_0, l_4_1, l_4_2)
	local l_4_3 = {}
	l_4_3.waypoints = {}
	local l_4_4 = {}
	l_4_4.options = {}
	l_4_4.options.loop_waypoints = false
	l_4_4.position = l_4_1
	l_4_4.rotation = l_4_2
	l_4_3.waypoints[1] = l_4_4
	return l_4_3
end

DebugAiOrder._setup_movement_options = function(l_5_0)
	l_5_0._movement_options = {}
end

DebugAiOrder._setup_area_cluster = function(l_6_0, l_6_1)
	l_6_0._area_cluster = {}
	local l_6_2 = {}
	l_6_2.position = l_6_1
	l_6_0._area_cluster[1] = l_6_2
end


