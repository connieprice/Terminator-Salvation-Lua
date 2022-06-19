CoreAiArea = CoreAiArea or class()
function CoreAiArea.init(A0_0, A1_1, A2_2, A3_3, A4_4)
	A0_0._unit = A1_1
	A0_0._spawn_point_index = 1
	A0_0._obj = A0_0._unit:get_object(A3_3)
	A0_0._nav = Search:nav(A2_2 .. A3_3)
	A0_0._nav:set_reference_object(A0_0._obj)
	A0_0._spawn_points = {}
	A0_0:find_spawnpoints(A4_4)
end
function CoreAiArea.spawn(A0_5, A1_6, A2_7)
	local L3_8
	if A2_7 ~= "" then
		L3_8 = A0_5._unit:get_object(A2_7)
	else
		if A0_5._spawn_point_index > #A0_5._spawn_points then
			return
		end
		L3_8 = A0_5._spawn_points[A0_5._spawn_point_index]
		A0_5._spawn_point_index = A0_5._spawn_point_index + 1
	end
	if World:raycast("ray", L3_8:position() + L3_8:rotation():z() * 100, L3_8:position() - L3_8:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")) then
		if World:spawn_unit(A1_6, World:raycast("ray", L3_8:position() + L3_8:rotation():z() * 100, L3_8:position() - L3_8:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")).position):base() ~= nil and World:spawn_unit(A1_6, World:raycast("ray", L3_8:position() + L3_8:rotation():z() * 100, L3_8:position() - L3_8:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")).position):base().link ~= nil then
			World:spawn_unit(A1_6, World:raycast("ray", L3_8:position() + L3_8:rotation():z() * 100, L3_8:position() - L3_8:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")).position):base():link(A0_5._unit, A0_5._obj, A0_5._nav)
		end
		return (World:spawn_unit(A1_6, World:raycast("ray", L3_8:position() + L3_8:rotation():z() * 100, L3_8:position() - L3_8:rotation():z() * 500, "slot_mask", managers.slot:get_mask("statics")).position))
	end
end
function CoreAiArea.find_spawnpoints(A0_9, A1_10)
	local L2_11, L3_12, L4_13, L5_14, L6_15
	for L5_14 in L2_11(L3_12) do
		L6_15 = L5_14.name
		L6_15 = L6_15(L5_14)
		if L6_15 == "ai_spawn_point" then
			L6_15 = L5_14.parameter
			L6_15 = L6_15(L5_14, "name")
			if L6_15 ~= "" then
				L6_15 = A0_9._unit
				L6_15 = L6_15.get_object
				L6_15 = L6_15(L6_15, L5_14:parameter("name"))
				if L6_15 ~= nil then
					cat_print("spawn_system", "[" .. A0_9._unit:name() .. "] AI spawn point found: " .. L5_14:parameter("name"))
					table.insert(A0_9._spawn_points, L6_15)
				end
			end
		end
	end
end
CoreSpawnSystem = CoreSpawnSystem or class()
function CoreSpawnSystem.init(A0_16, A1_17)
	A0_16._unit = A1_17
	A0_16._post_init = false
	A0_16._ai_surface_name = "surface_generic_spawner_"
	A0_16._ai_spawn_areas = {}
	A0_16:read_spawn_xml()
end
function CoreSpawnSystem.get_linked_unit_list(A0_18)
	local L1_19, L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L11_29
	L1_19 = {}
	if L2_20 then
		for L5_23, L6_24 in L2_20(L3_21) do
			for L10_28, L11_29 in L7_25(L8_26) do
				table.insert(L1_19, L11_29)
			end
		end
	end
	return L1_19
end
function CoreSpawnSystem.destroy(A0_30)
	local L1_31, L2_32, L3_33, L4_34, L5_35, L6_36, L7_37, L8_38, L9_39, L10_40
	if L1_31 then
		for L4_34, L5_35 in L1_31(L2_32) do
			for L9_39, L10_40 in L6_36(L7_37) do
				if alive(L10_40) then
					cat_print("spawn_system", "[CoreSpawnSystem] Destroy unit: " .. L10_40:name())
					L10_40:set_slot(0)
				end
			end
		end
	end
end
function CoreSpawnSystem.update(A0_41, A1_42, A2_43, A3_44)
	local L4_45, L5_46, L6_47, L7_48, L8_49
	if L4_45 then
		for L7_48, L8_49 in L4_45(L5_46) do
			A0_41:set_var_and_cb(L8_49, L7_48)
		end
		A0_41._delayed_var_and_cb_init = nil
	end
	L7_48 = false
	L4_45(L5_46, L6_47, L7_48)
	A0_41._post_init = true
end
function CoreSpawnSystem.get_child_unit(A0_50, A1_51, A2_52)
	local L3_53, L4_54
	L3_53 = A0_50._linked_unit_map
	if L3_53 then
		L3_53 = A0_50._linked_unit_map
		L3_53 = L3_53[A1_51]
		if L3_53 then
			L4_54 = L3_53[A2_52]
			return L4_54
		end
	end
	L3_53 = nil
	return L3_53
end
function CoreSpawnSystem.init_ai_area(A0_55, A1_56, A2_57)
	if not A0_55._ai_spawn_areas[A0_55._unit:get_object(A1_56):name()] then
		A0_55._ai_spawn_areas[A0_55._unit:get_object(A1_56):name()] = CoreAiArea:new(A0_55._unit, A0_55._ai_surface_name, A0_55._unit:get_object(A1_56):name(), A2_57)
	end
end
function CoreSpawnSystem.find_spawn_node(A0_58, A1_59)
	for 