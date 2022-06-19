require("ai/directors/AiNavigationOrder.lua")
AiOrderDirector = AiOrderDirector or class()
function AiOrderDirector.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._unit_navigation_order = L1_1
	A0_0._next_assignable_move_order_id = 0
	L1_1 = {}
	A0_0._units = L1_1
end
function AiOrderDirector.add_ai_unit(A0_2, A1_3)
	A0_2._units[A1_3] = A1_3
end
function AiOrderDirector.remove_ai_unit(A0_4, A1_5)
	local L3_6
	L3_6 = A0_4._units
	L3_6[A1_5] = nil
	L3_6 = A0_4._remove_unit
	L3_6(A0_4, managers.unit_scripting:unit_script_name(A1_5))
end
function AiOrderDirector.give_order(A0_7, A1_8, A2_9, A3_10, A4_11, A5_12)
	local L6_13, L7_14, L8_15, L9_16, L10_17, L11_18, L12_19, L13_20
	if L6_13 then
		for L9_16, L10_17 in L6_13(L7_14) do
			L11_18 = managers
			L11_18 = L11_18.unit_scripting
			L12_19 = L11_18
			L11_18 = L11_18.get_unit_by_name
			L13_20 = L10_17.script_name
			L11_18 = L11_18(L12_19, L13_20)
			L12_19 = alive
			L13_20 = L11_18
			L12_19 = L12_19(L13_20)
			if not L12_19 then
				L12_19 = cat_print
				L13_20 = "warning"
				L12_19(L13_20, "No unit " .. L10_17.script_name .. " found for AI order")
			else
				L13_20 = L11_18
				L12_19 = L11_18.ai_data
				L12_19 = L12_19(L13_20)
				L13_20 = L12_19._behavior
				L13_20.navigation_target = nil
				L13_20 = L12_19._behavior
				L13_20.navigation_target_options = {}
				L13_20 = L12_19._behavior
				L13_20.navigation_target_reached = true
				L13_20 = A0_7._apply_arrive_order
				L13_20(A0_7, L10_17, L12_19, A5_12, A4_11)
			end
		end
	else
		L10_17 = A3_10
		L12_19 = A0_7
		L11_18 = A0_7._next_move_order_id
		L11_18 = L11_18(L12_19)
		L12_19 = A5_12
		L13_20 = A4_11
		for L10_17, L11_18 in L7_14(L8_15) do
			L12_19 = managers
			L12_19 = L12_19.unit_scripting
			L13_20 = L12_19
			L12_19 = L12_19.get_unit_by_name
			L12_19 = L12_19(L13_20, L11_18.script_name)
			L13_20 = alive
			L13_20 = L13_20(L12_19)
			if not L13_20 then
				L13_20 = Application
				L13_20 = L13_20.error
				L13_20(L13_20, "Unit " .. L11_18.script_name .. " not found!")
				return
			end
			L13_20 = L12_19.ai_data
			L13_20 = L13_20(L12_19)
			A0_7:_apply_navigation_order(L11_18, L13_20, L6_13)
			A0_7:_apply_arrive_order(L11_18, L13_20, A5_12, A4_11)
		end
	end
end
function AiOrderDirector._apply_arrive_order(A0_21, A1_22, A2_23, A3_24, A4_25)
	local L5_26, L6_27
	L5_26 = A2_23._behavior
	L5_26.area_cluster = A3_24
	L5_26 = A2_23._behavior
	L6_27 = A1_22.type_name
	L6_27 = A4_25[L6_27]
	L5_26.arrive_orders = L6_27
end
function AiOrderDirector._convert_waypoints(A0_28, A1_29, A2_30)
	local L3_31, L4_32, L5_33, L6_34, L7_35, L8_36, L9_37, L10_38
	L3_31 = {}
	for L7_35, L8_36 in L4_32(L5_33) do
		L9_37 = nil
		L10_38 = L8_36.options
		if L10_38 then
			L10_38 = L8_36.options
			L9_37 = L10_38[A2_30]
		else
			L9_37 = nil
		end
		L10_38 = {}
		L10_38.position = L8_36.position
		L10_38.rotation = L8_36.rotation
		L10_38.options = L9_37
		L10_38.id = L8_36.id
		table.insert(L3_31, L10_38)
	end
	return L3_31
end
function AiOrderDirector._apply_navigation_order(A0_39, A1_40, A2_41, A3_42)
	local L4_43, L5_44
	L4_43 = cat_print
	L5_44 = "ai"
	L4_43(L5_44, "New navigation target for " .. A1_40.script_name)
	L5_44 = A0_39
	L4_43 = A0_39._remove_unit
	L4_43(L5_44, A1_40.script_name)
	L4_43 = A0_39._unit_navigation_order
	L5_44 = A1_40.script_name
	L4_43[L5_44] = A3_42
	L5_44 = A3_42
	L4_43 = A3_42.unit_waypoint_path
	L4_43 = L4_43(L5_44, A1_40.script_name)
	L5_44 = nil
	if L4_43 then
		L5_44 = A0_39:_convert_waypoints(L4_43.waypoints, A1_40.type_name)
	end
	A2_41._behavior.navigation_target = L5_44
	A2_41._behavior.navigation_target_options = A3_42:movement_options()[A1_40.type_name] or {}
	A2_41._behavior.navigation_target_reached = false
	A2_41._behavior.arrive_orders = nil
	A2_41._behavior.cluster = nil
	if A2_41._cover then
		if not A2_41._behavior.navigation_target then
			A2_41._cover.navigation_target = nil
			A2_41._cover.navigation_target_rotation = nil
		else
			A2_41._cover.navigation_target = A2_41._behavior.navigation_target[#A2_41._behavior.navigation_target]
			A2_41._cover.navigation_target_rotation = A2_41._cover.navigation_target.rotation
			if not A2_41._cover.navigation_target_rotation then
				if #A2_41._behavior.navigation_target < 2 then
					A2_41._cover.navigation_target_rotation = Rotation(0, 0, 0)
				else
					A2_41._cover.navigation_target_rotation = Rotation:look_at(A2_41._behavior.navigation_target[#A2_41._behavior.navigation_target - 1].position, A2_41._behavior.navigation_target[#A2_41._behavior.navigation_target].position, math.UP)
				end
			end
			A2_41._cover.go_to = nil
			A2_41._cover.cover_info = nil
			A2_41.output.target_cover_info = nil
		end
	end
end
function AiOrderDirector._next_move_order_id(A0_45)
	local L1_46, L2_47
	L1_46 = A0_45._next_assignable_move_order_id
	L2_47 = A0_45._next_assignable_move_order_id
	L2_47 = L2_47 + 1
	A0_45._next_assignable_move_order_id = L2_47
	return L1_46
end
function AiOrderDirector._remove_unit(A0_48, A1_49)
	local L2_50
	L2_50 = A0_48._unit_navigation_order
	L2_50 = L2_50[A1_49]
	if L2_50 then
		L2_50 = A0_48._unit_navigation_order
		L2_50[A1_49] = nil
	end
end
function AiOrderDirector.unit_navigation_order(A0_51, A1_52)
	return A0_51._unit_navigation_order[A1_52]
end
function AiOrderDirector.update(A0_53, A1_54, A2_55)
	local L3_56, L4_57, L5_58, L6_59, L7_60, L8_61, L9_62
	for L9_62, 