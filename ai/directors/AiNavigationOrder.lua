if not AiNavigationOrder then
	AiNavigationOrder = class()
end
AiNavigationOrder.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6)
	local l_1_10, l_1_11, l_1_12, l_1_13, l_1_14, l_1_15 = nil
	l_1_0._unit_infos = l_1_1
	l_1_0._waypoint_paths = l_1_2
	l_1_0._movement_options = l_1_3
	l_1_0._id = l_1_4
	l_1_0._area_cluster = l_1_5
	l_1_0._arrive_orders = l_1_6
	l_1_0._unit_waypoint_paths = {}
	l_1_0._unit_type_lookup = {}
	for i_0,i_1 in pairs(l_1_1) do
		l_1_0._unit_type_lookup[i_1.script_name] = l_1_17.type_name
	end
	l_1_0:_assign_waypoint_paths()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiNavigationOrder._assign_waypoint_paths = function(l_2_0)
	l_2_0:_assign_manual_waypoint_paths()
	l_2_0:_assign_automatic_waypoint_paths()
end

AiNavigationOrder._assign_manual_waypoint_paths = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7 = nil
	for i_0,i_1 in ipairs(l_3_0._waypoint_paths) do
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if i_1.assigned_unit_script_name and l_3_0:_unit_exists(i_1.assigned_unit_script_name) then
			l_3_0._unit_waypoint_paths[i_1.assigned_unit_script_name] = i_1
		end
	end
end

AiNavigationOrder._unit_exists = function(l_4_0, l_4_1)
	local l_4_2, l_4_3 = managers.unit_scripting:unit_exists, managers.unit_scripting
	local l_4_4 = l_4_1
	return l_4_2(l_4_3, l_4_4)
end

AiNavigationOrder._assign_automatic_waypoint_paths = function(l_5_0)
	local l_5_18, l_5_19, l_5_20, l_5_21 = nil
	local l_5_1 = {}
	local l_5_2 = {}
	local l_5_3 = TableAlgorithms.copy_if_key(l_5_0._unit_infos, function(l_6_0, l_6_1)
		-- upvalues: l_5_0
		return not l_5_0:_unit_exists(l_6_1.script_name) or l_5_0._unit_waypoint_paths[l_6_1.script_name] == nil
  end)
	if TableAlgorithms.is_empty(l_5_3) then
		return 
	end
	local l_5_4 = l_5_0:_waypoint_paths_unit_distances(l_5_3)
	local l_5_5 = TableAlgorithms.count(l_5_3)
	local l_5_6 = #l_5_0._waypoint_paths - TableAlgorithms.count(l_5_0._unit_waypoint_paths)
	if l_5_6 < l_5_5 then
		Application:error("Not enough waypoint paths for navigation target!")
		return 
	end
	local l_5_7 = l_5_6 - l_5_5
	for l_5_11 = 1, l_5_6 do
		local l_5_12, l_5_13, l_5_14 = nil, nil, nil
		for i_0,i_1 in ipairs(l_5_0._waypoint_paths) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if (not i_1.assigned_unit_script_name or not l_5_0:_unit_exists(i_1.assigned_unit_script_name)) and not l_5_2[i_1] then
				local l_5_24, l_5_25 = nil
			if not l_5_13 or l_5_13 < l_5_0 then
				end
				l_5_14 = l_5_0:_closest_available_waypoint_path_unit(l_5_4[i_1], l_5_1)
			end
		end
		if l_5_7 > 0 then
			l_5_7 = l_5_7 - 1
		else
			l_5_0._unit_waypoint_paths[l_5_14] = l_5_12
			l_5_1[l_5_14] = true
		end
		l_5_2[l_5_12] = true
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiNavigationOrder._waypoint_paths_unit_distances = function(l_6_0, l_6_1)
	local l_6_6, l_6_7, l_6_8, l_6_9, l_6_13, l_6_20, l_6_22 = nil
	local l_6_2 = {}
	for i_0,i_1 in pairs(l_6_1) do
		local l_6_19, l_6_21 = , assert
		l_6_21(managers.unit_scripting:get_unit_by_name(i_1.script_name), "Unit " .. l_6_14.script_name .. " not found!")
		l_6_21 = l_6_14.script_name
		local l_6_11 = nil
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_6_2[l_6_21] = l_6_11
	end
	for i_0,i_1 in ipairs(l_6_0._waypoint_paths) do
		do
			 -- DECOMPILER ERROR: Overwrote pending register.

			for i_0,i_1 in l_6_11(l_6_1) do
				local l_6_17 = {}
				ArrayAlgorithms.insert_sorted(l_6_17, {script_name = i_1.script_name, distance = mvector3.distance(l_6_2[i_1.script_name], l_6_16.waypoints[1].position)}, function(l_7_0, l_7_1)
				return l_7_0.distance < l_7_1.distance
      end)
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
		return {[l_6_16] = l_6_17}
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiNavigationOrder._closest_available_waypoint_path_unit = function(l_7_0, l_7_1, l_7_2)
	local l_7_6, l_7_7, l_7_8, l_7_9, l_7_10, l_7_11 = nil
	for i_0,i_1 in ipairs(l_7_1) do
		if not l_7_2[i_1.script_name] then
			return i_1.script_name, i_1.distance
		end
	end
end

AiNavigationOrder.id = function(l_8_0)
	return l_8_0._id
end

AiNavigationOrder.unit_waypoint_path = function(l_9_0, l_9_1)
	return l_9_0._unit_waypoint_paths[l_9_1]
end

AiNavigationOrder.movement_options = function(l_10_0)
	return l_10_0._movement_options
end

AiNavigationOrder.area_cluster = function(l_11_0)
	return l_11_0._area_cluster
end

AiNavigationOrder.arrive_orders = function(l_12_0, l_12_1)
	local l_12_2 = l_12_0._unit_type_lookup[l_12_1]
	assert(l_12_2, "Unit " .. l_12_1 .. " not found in AI order")
	return l_12_0._arrive_orders[l_12_2]
end


