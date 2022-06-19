local L0_0
L0_0 = require
L0_0("world/WorldInfo")
function L0_0()
	local L0_1, L1_2, L2_3, L3_4, L4_5, L5_6, L6_7, L7_8
	L0_1 = File
	L1_2 = L0_1
	L0_1 = L0_1.new_parse_xml
	L2_3 = "data/lib/menu/levelnames.xml"
	L0_1 = L0_1(L1_2, L2_3)
	L2_3 = L0_1
	L1_2 = L0_1.children
	L1_2 = L1_2(L2_3)
	L2_3 = {}
	for L6_7 in L1_2, nil, nil do
		L7_8 = tonumber
		L7_8 = L7_8(L6_7:parameter("start_id"))
		table.insert(L2_3, L7_8)
	end
	return L2_3
end
WorldInfoManager = WorldInfoManager or class()
function WorldInfoManager.init(A0_9)
	local L1_10, L2_11
	L1_10 = {}
	A0_9._id_to_level_info = L1_10
	L1_10 = {}
	A0_9._name_to_level_info = L1_10
	L1_10 = {}
	A0_9._index_to_id = L1_10
	L1_10 = File
	L2_11 = L1_10
	L1_10 = L1_10.exists
	L1_10 = L1_10(L2_11, "data/videos/enable_debug_levels.hack")
	A0_9._is_show_case_build = L1_10
	L1_10 = File
	L2_11 = L1_10
	L1_10 = L1_10.new_parse_xml
	L1_10 = L1_10(L2_11, "data/levels/levels.xml")
	L2_11 = _UPVALUE0_
	L2_11 = L2_11()
	A0_9:load_world_infos(L1_10:children(), L2_11)
end
function WorldInfoManager.load_world_infos(A0_12, A1_13, A2_14)
	local L3_15, L4_16, L5_17, L6_18, L7_19, L8_20, L9_21
	for L6_18 in A1_13, nil, nil do
		L7_19 = tonumber
		L9_21 = L6_18
		L8_20 = L6_18.parameter
		L9_21 = L8_20(L9_21, "id")
		L7_19 = L7_19(L8_20, L9_21, L8_20(L9_21, "id"))
		L9_21 = L6_18
		L8_20 = L6_18.parameter
		L8_20 = L8_20(L9_21, "name")
		L9_21 = _UPVALUE0_
		L9_21 = L9_21(L7_19, A2_14)
		assert(L9_21)
		if not A0_12._is_show_case_build or L6_18:parameter("enabled") == "true" then
			A0_12._id_to_level_info[L7_19] = WorldInfo:new(L7_19, L8_20, L9_21)
			A0_12._name_to_level_info[L8_20] = WorldInfo:new(L7_19, L8_20, L9_21)
			if not A0_12._first_world_info then
				A0_12._first_world_info = WorldInfo:new(L7_19, L8_20, L9_21)
			end
		end
		if not A0_12._is_show_case_build then
			A0_12._first_world_info = A0_12:info_from_id(1)
		end
	end
end
function WorldInfoManager.info_from_id(A0_22, A1_23)
	return A0_22._id_to_level_info[A1_23]
end
function WorldInfoManager.info_from_name(A0_24, A1_25)
	return A0_24._name_to_level_info[A1_25]
end
function WorldInfoManager.has_info_for_name(A0_26, A1_27)
	local L2_28
	L2_28 = A0_26._name_to_level_info
	L2_28 = L2_28[A1_27]
	L2_28 = L2_28 ~= nil
	return L2_28
end
function WorldInfoManager.level_infos(A0_29)
	local L1_30
	L1_30 = A0_29._id_to_level_info
	return L1_30
end
function WorldInfoManager.first_world_info(A0_31)
	local L1_32
	L1_32 = A0_31._first_world_info
	return L1_32
end
function WorldInfoManager.next_world_info(A0_33, A1_34)
	local L2_35, L3_36, L4_37, L5_38, L6_39, L7_40
	L2_35 = A1_34.id
	L3_36 = 20
	for L7_40 = L2_35 + 1, L3_36 do
		if A0_33:info_from_id(L7_40) then
			return (A0_33:info_from_id(L7_40))
		end
	end
end
