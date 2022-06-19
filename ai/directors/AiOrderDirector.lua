require("ai/directors/AiNavigationOrder.lua")
if not AiOrderDirector then
	AiOrderDirector = class()
end
AiOrderDirector.init = function(l_1_0)
	l_1_0._unit_navigation_order = {}
	l_1_0._next_assignable_move_order_id = 0
	l_1_0._units = {}
end

AiOrderDirector.add_ai_unit = function(l_2_0, l_2_1)
	l_2_0._units[l_2_1] = l_2_1
end

AiOrderDirector.remove_ai_unit = function(l_3_0, l_3_1)
	l_3_0._units[l_3_1] = nil
	l_3_0:_remove_unit(managers.unit_scripting:unit_script_name(l_3_1))
end

AiOrderDirector.give_order = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4, l_4_5)
	local l_4_9, l_4_10, l_4_11, l_4_12 = nil
	if TableAlgorithms.is_empty(l_4_2) then
		for i_0,i_1 in pairs(l_4_1) do
			if not alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
				cat_print("warning", "No unit " .. i_1.script_name .. " found for AI order")
			else
				managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._behavior.navigation_target = nil
				managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._behavior.navigation_target_options = {}
				managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._behavior.navigation_target_reached = true
				l_4_0:_apply_arrive_order(l_4_14, managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data(), l_4_5, l_4_4)
			end
		end
	else
		local l_4_19 = AiNavigationOrder:new
		local l_4_20 = AiNavigationOrder
		l_4_19 = l_4_19(l_4_20, l_4_1, l_4_2, l_4_3, l_4_0:_next_move_order_id(), l_4_5, l_4_4)
		local l_4_15 = nil
		l_4_20 = pairs
		l_4_15 = l_4_1
		l_4_20 = l_4_20(l_4_15)
		for i_0,i_1 in l_4_20 do
			local l_4_21 = managers.unit_scripting:get_unit_by_name(l_4_18.script_name)
			if not alive(l_4_21) then
				Application:error("Unit " .. l_4_18.script_name .. " not found!")
				return 
			end
			local l_4_22 = l_4_21:ai_data()
			l_4_0:_apply_navigation_order(l_4_18, l_4_22, l_4_19)
			l_4_0:_apply_arrive_order(l_4_18, l_4_22, l_4_5, l_4_4)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

AiOrderDirector._apply_arrive_order = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4)
	l_5_2._behavior.area_cluster = l_5_3
	l_5_2._behavior.arrive_orders = l_5_4[l_5_1.type_name]
end

AiOrderDirector._convert_waypoints = function(l_6_0, l_6_1, l_6_2)
	local l_6_7, l_6_8, l_6_9, l_6_10, l_6_11, l_6_12 = nil
	local l_6_3 = {}
	for i_0,i_1 in ipairs(l_6_1) do
		 -- DECOMPILER ERROR: Overwrote pending register.

		if i_1.options then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		table.insert(l_6_3, {position = l_6_14.position, rotation = l_6_14.rotation, options = nil, id = l_6_14.id})
	end
	return l_6_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiOrderDirector._apply_navigation_order = function(l_7_0, l_7_1, l_7_2, l_7_3)
	cat_print("ai", "New navigation target for " .. l_7_1.script_name)
	l_7_0:_remove_unit(l_7_1.script_name)
	l_7_0._unit_navigation_order[l_7_1.script_name] = l_7_3
	local l_7_4 = (l_7_3:unit_waypoint_path(l_7_1.script_name))
	local l_7_5 = nil
	if l_7_4 then
		l_7_5 = l_7_0:_convert_waypoints(l_7_4.waypoints, l_7_1.type_name)
	end
	l_7_2._behavior.navigation_target = l_7_5
	if not l_7_3:movement_options()[l_7_1.type_name] then
		l_7_2._behavior.navigation_target_options = {}
	end
	l_7_2._behavior.navigation_target_reached = false
	l_7_2._behavior.arrive_orders = nil
	l_7_2._behavior.cluster = nil
	if l_7_2._cover then
		local l_7_6 = l_7_2._behavior.navigation_target
		if not l_7_6 then
			l_7_2._cover.navigation_target = nil
			l_7_2._cover.navigation_target_rotation = nil
		end
	else
		local l_7_7 = #l_7_6
		l_7_2._cover.navigation_target = l_7_6[l_7_7]
		l_7_2._cover.navigation_target_rotation = l_7_2._cover.navigation_target.rotation
		if not l_7_2._cover.navigation_target_rotation then
			if l_7_7 < 2 then
				l_7_2._cover.navigation_target_rotation = Rotation(0, 0, 0)
			end
		else
			l_7_2._cover.navigation_target_rotation = Rotation:look_at(l_7_6[l_7_7 - 1].position, l_7_6[l_7_7].position, math.UP)
		end
		l_7_2._cover.go_to = nil
		l_7_2._cover.cover_info = nil
		l_7_2.output.target_cover_info = nil
	end
end

AiOrderDirector._next_move_order_id = function(l_8_0)
	local l_8_1 = l_8_0._next_assignable_move_order_id
	l_8_0._next_assignable_move_order_id = l_8_0._next_assignable_move_order_id + 1
	return l_8_1
end

AiOrderDirector._remove_unit = function(l_9_0, l_9_1)
	if l_9_0._unit_navigation_order[l_9_1] then
		l_9_0._unit_navigation_order[l_9_1] = nil
	end
end

AiOrderDirector.unit_navigation_order = function(l_10_0, l_10_1)
	return l_10_0._unit_navigation_order[l_10_1]
end

AiOrderDirector.update = function(l_11_0, l_11_1, l_11_2)
	local l_11_3, l_11_4, l_11_5, l_11_6, l_11_7, l_11_8, l_11_9, l_11_10, l_11_11, l_11_12, l_11_13, l_11_14, l_11_15, l_11_16 = nil, nil, nil
	for i_0,i_1 in pairs(l_11_0._unit_navigation_order) do
		l_11_3 = managers.unit_scripting:get_unit_by_name(i_0)
		if alive(l_11_3) then
			l_11_4 = l_11_3:ai_data()
			l_11_5 = l_11_4._behavior._last_completed_navigation_target == l_11_4._behavior.navigation_target
			if l_11_5 then
				l_11_4._behavior.navigation_target = nil
				if l_11_4._cover then
					l_11_4._cover.navigation_target = nil
				end
				l_11_0:_remove_unit(i_0)
			end
		else
			l_11_0:_remove_unit(i_0)
		end
	end
end


