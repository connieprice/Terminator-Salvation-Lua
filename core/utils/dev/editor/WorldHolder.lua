CoreWorldDefinition = CoreWorldDefinition or class()
CoreHubElementUnit = CoreHubElementUnit or class()
WorldHolder = WorldHolder or class()
function WorldHolder.get_world_file(A0_0)
	local L1_1
	L1_1 = A0_0._world_file
	return L1_1
end
function WorldHolder.init(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9, L8_10, L9_11
	L2_4 = {}
	A0_2._worlds = L2_4
	A0_2._world_file = A1_3
	L2_4 = A0_2._world_file
	if L2_4 then
		L2_4 = string
		L2_4 = L2_4.reverse
		L3_5 = A1_3
		L2_4 = L2_4(L3_5)
		L3_5 = string
		L3_5 = L3_5.find
		L4_6 = L2_4
		L5_7 = "\\"
		L3_5 = L3_5(L4_6, L5_7)
		L4_6 = string
		L4_6 = L4_6.reverse
		L5_7 = string
		L5_7 = L5_7.sub
		L9_11 = L5_7(L6_8, L7_9)
		L4_6 = L4_6(L5_7, L6_8, L7_9, L8_10, L9_11, L5_7(L6_8, L7_9))
		A0_2._world_dir = L4_6
		L4_6 = rawget
		L5_7 = _G
		L4_6 = L4_6(L5_7, L6_8)
		if not L4_6 then
			L4_6 = rawget
			L5_7 = _G
			L4_6 = L4_6(L5_7, L6_8)
		end
		L5_7 = string
		L5_7 = L5_7.find
		L9_11 = true
		L5_7 = L5_7(L6_8, L7_9, L8_10, L9_11)
		if L5_7 then
			L5_7 = File
			L5_7 = L5_7.exists
			L5_7 = L5_7(L6_8, L7_9)
			if L5_7 then
				L5_7 = A0_2._world_file
				A0_2._level_file = L5_7
				L5_7 = Level
				L5_7 = L5_7.load
				L5_7 = L5_7(L6_8, L7_9)
				L9_11 = "world"
				L9_11 = L4_6
				L6_8[L7_9] = L8_10
				return
			end
			L5_7 = string
			L5_7 = L5_7.gsub
			L5_7 = L5_7(L6_8, L7_9, L8_10)
			A0_2._world_file = L5_7
			L5_7 = Application
			L5_7 = L5_7.error
			L5_7(L6_8, L7_9)
		end
		L5_7 = cat_debug
		L5_7(L6_8, L7_9)
		L5_7 = File
		L5_7 = L5_7.config_exists
		L5_7 = L5_7(L6_8, L7_9)
		if L5_7 then
			L5_7 = File
			L5_7 = L5_7.parse_xml
			L5_7 = L5_7(L6_8, L7_9)
			for L9_11 in L6_8(L7_9) do
				if L9_11:name() == "world" then
					A0_2._worlds[L9_11:parameter("name")] = L4_6:new(L9_11, nil, A0_2._world_dir)
				end
			end
		else
			L5_7 = Application
			L5_7 = L5_7.error
			L5_7(L6_8, L7_9, L8_10)
		end
	end
end
function WorldHolder.is_ok(A0_12)
	return table.size(A0_12._worlds) > 0 and A0_12._worlds.world
end
function WorldHolder.create_world(A0_13, A1_14, A2_15, A3_16)
	local L4_17
	L4_17 = A0_13._worlds
	L4_17 = L4_17[A1_14]
	if L4_17 then
		if not Application:editor() and (A2_15 == "statics" or A2_15 == "all") and not Global.running_slave then
			World:culling_octree():build_tree()
			World:occlusion_manager():merge_occluders(5)
		end
		if not Application:editor() and A2_15 == "all" then
			L4_17:clear_definitions()
		end
		return (L4_17:create(A2_15, A3_16))
	else
		Application:error("WorldHolder:create_world :: Could not create world", A1_14, "for layer", A2_15)
	end
end
function WorldHolder.get_player_data(A0_18, A1_19, A2_20, A3_21)
	local L4_22
	L4_22 = A0_18._worlds
	L4_22 = L4_22[A1_19]
	if L4_22 then
		return L4_22:get_player_data(A3_21)
	else
		Application:error("WorldHolder:create_world :: Could not create world", A1_19, "for layer", A2_20)
	end
end
function WorldHolder.get_max_id(A0_23, A1_24)
	local L2_25
	L2_25 = A0_23._worlds
	L2_25 = L2_25[A1_24]
	if L2_25 then
		return L2_25:get_max_id()
	else
		Application:error("WorldHolder:create_world :: Could not create world", A1_24)
	end
end
function WorldHolder.get_level_name(A0_26, A1_27)
	local L2_28
	L2_28 = A0_26._worlds
	L2_28 = L2_28[A1_27]
	if L2_28 then
		return L2_28:get_level_name()
	else
		Application:error("WorldHolder:create_world :: Could not create world", A1_27)
	end
end
function CoreWorldDefinition.init(A0_29, A1_30, A2_31, A3_32)
	managers.worlddefinition = A0_29
	A0_29._world_dir = A3_32
	A0_29._max_id = 0
	A0_29._level_name = "none"
	A0_29._definitions = {}
	A0_29._old_groups = {}
	A0_29._old_groups.groups = {}
	A0_29._old_groups.group_names = {}
	A0_29._portal_slot_mask = World:make_slot_mask(1)
	A0_29._massunit_replace_names = {}
	A0_29._replace_names = {}
	A0_29._replace_units_path = "\\data\\lib\\utils\\dev\\editor\\xml\\replace_units.xml"
	A0_29:parse_replace_unit()
	if A1_30 then
		if A1_30:has_parameter("max_id") then
			A0_29._max_id = tonumber(A1_30:parameter("max_id"))
		end
		if A1_30:has_parameter("level_name") then
			A0_29._level_name = A1_30:parameter("level_name")
		end
		A0_29:parse_definitions(A1_30)
	elseif A2_31 then
		A0_29._level_file = A2_31
		A0_29._max_id = A0_29._level_file:data("world").max_id
		A0_29._level_name = A0_29._level_file:data("world").level_name
	end
	A0_29._definitions.editor_groups = A0_29._definitions.editor_groups or {
		groups = A0_29._old_groups.groups,
		group_names = A0_29._old_groups.group_names
	}
	A0_29._all_units = {}
	A0_29._stage_depended_units = {}
	A0_29._trigger_units = {}
	A0_29._use_unit_callbacks = {}
end
function CoreWorldDefinition.parse_definitions(A0_33, A1_34)
	local L2_35, L3_36, L4_37, L5_38, L6_39, L7_40, L8_41
	L3_36 = A1_34
	L2_35 = A1_34.num_children
	L2_35 = L2_35(L3_36)
	L3_36 = 0
	for L7_40 in L4_37(L5_38) do
		L8_41 = L7_40.name
		L8_41 = L8_41(L7_40)
		A0_33._definitions[L8_41] = A0_33._definitions[L8_41] or {}
		if managers.editor then
			L3_36 = L3_36 + 50 / L2_35
			managers.editor:update_load_progress(L3_36, "Parse layer: " .. L8_41)
		end
		if A0_33["parse_" .. L8_41] then
			A0_33["parse_" .. L8_41](A0_33, L7_40, A0_33._definitions[L8_41])
		else
			Application:error("CoreWorldDefinition:No parse function for type/layer", L8_41)
		end
	end
end
function CoreWorldDefinition.world_dir(A0_42)
	local L1_43
	L1_43 = A0_42._world_dir
	return L1_43
end
function CoreWorldDefinition.get_max_id(A0_44)
	local L1_45
	L1_45 = A0_44._max_id
	return L1_45
end
function CoreWorldDefinition.get_level_name(A0_46)
	local L1_47
	L1_47 = A0_46._level_name
	return L1_47
end
function CoreWorldDefinition.parse_continents(A0_48, A1_49, A2_50)
	local L3_51, L4_52, L5_53, L6_54, L7_55, L8_56, L9_57, L10_58, L11_59, L12_60, L13_61, L14_62, L15_63, L16_64
	L4_52 = A1_49
	L3_51 = A1_49.parameter
	L5_53 = "file"
	L3_51 = L3_51(L4_52, L5_53)
	L5_53 = A0_48
	L4_52 = A0_48.world_dir
	L4_52 = L4_52(L5_53)
	L5_53 = "\\"
	L4_52 = L4_52 .. L5_53 .. L6_54
	L5_53 = File
	L5_53 = L5_53.config_exists
	L5_53 = L5_53(L6_54, L7_55)
	if not L5_53 then
		L5_53 = Application
		L5_53 = L5_53.error
		L9_57 = ")."
		L5_53(L6_54, L7_55)
		return
	end
	L5_53 = File
	L5_53 = L5_53.parse_xml
	L9_57 = L3_51
	L5_53 = L5_53(L6_54, L7_55)
	for L9_57 in L6_54(L7_55) do
		L11_59 = L9_57
		L10_58 = L9_57.parameter
		L12_60 = "name"
		L10_58 = L10_58(L11_59, L12_60)
		L11_59 = tonumber
		L12_60 = L9_57.parameter
		L16_64 = L12_60(L13_61, L14_62)
		L11_59 = L11_59(L12_60, L13_61, L14_62, L15_63, L16_64, L12_60(L13_61, L14_62))
		L12_60 = File
		L12_60 = L12_60.exists
		L16_64 = ".xml"
		L12_60 = L12_60(L13_61, L14_62)
		if L12_60 then
			L12_60 = File
			L12_60 = L12_60.parse_xml
			L16_64 = ".xml"
			L12_60 = L12_60(L13_61, L14_62)
			for L16_64 in L13_61(L14_62) do
				({}).max_id = tonumber(L16_64:parameter("max_id"))
				;({}).base_id = L11_59
				A2_50[L10_58], ({}).level_name = {}, L16_64:parameter("level_name")
				A0_48:parse_definitions(L16_64)
			end
		else
			L12_60 = Application
			L12_60 = L12_60.error
			L16_64 = ".xml doesnt exist."
			L12_60(L13_61, L14_62)
		end
	end
end
function CoreWorldDefinition.parse_values(A0_65, A1_66, A2_67)
	local L3_68, L4_69, L5_70, L6_71
	for L6_71 in L3_68(L4_69) do
		A2_67[parse_value_node(L6_71)] = parse_value_node(L6_71)
	end
end
function CoreWorldDefinition.parse_markers(A0_72, A1_73, A2_74)
	local L3_75, L4_76, L5_77, L6_78
	for L6_78 in L3_75(L4_76) do
		table.insert(A2_74, LoadedMarker:new(L6_78))
	end
end
function CoreWorldDefinition.parse_groups(A0_79, A1_80, A2_81)
	local L3_82, L4_83, L5_84, L6_85, L7_86, L8_87
	for L6_85 in L3_82(L4_83) do
		L8_87 = L6_85
		L7_86 = L6_85.parameter
		L7_86 = L7_86(L8_87, "name")
		L8_87 = tonumber
		L8_87 = L8_87(L6_85:parameter("reference_unit_id"))
		if L8_87 ~= 0 then
			A0_79:add_editor_group(L7_86, L8_87)
		else
			cat_error("Removed empty group", L7_86, "when converting from old GroupHandler to new.")
		end
	end
end
function CoreWorldDefinition.parse_editor_groups(A0_88, A1_89, A2_90)
	local L3_91, L4_92, L5_93, L6_94, L7_95, L8_96, L9_97, L10_98, L11_99, L12_100
	L3_91 = A0_88._old_groups
	L3_91 = L3_91.groups
	L4_92 = A0_88._old_groups
	L4_92 = L4_92.group_names
	for L8_96 in L5_93(L6_94) do
		L10_98 = L8_96
		L9_97 = L8_96.parameter
		L11_99 = "name"
		L9_97 = L9_97(L10_98, L11_99)
		L10_98 = L3_91[L9_97]
		if not L10_98 then
			L10_98 = tonumber
			L12_100 = L8_96
			L11_99 = L8_96.parameter
			L12_100 = L11_99(L12_100, "reference_id")
			L10_98 = L10_98(L11_99, L12_100, L11_99(L12_100, "reference_id"))
			L11_99 = nil
			L12_100 = L8_96.has_parameter
			L12_100 = L12_100(L8_96, "continent")
			if L12_100 then
				L12_100 = L8_96.parameter
				L12_100 = L12_100(L8_96, "continent")
				if L12_100 ~= "nil" then
					L12_100 = L8_96.parameter
					L12_100 = L12_100(L8_96, "continent")
					L11_99 = L12_100
				end
			end
			L12_100 = {}
			for 