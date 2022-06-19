require("world/WorldInfo")
local l_0_0 = function()
	local l_1_6, l_1_7 = nil
	local l_1_0 = File:new_parse_xml("data/lib/menu/levelnames.xml")
	local l_1_1 = l_1_0:children()
	local l_1_2 = {}
	local l_1_3 = l_1_1
	for i_0 in l_1_3 do
		table.insert(l_1_2, tonumber(i_0:parameter("start_id")))
	end
	return l_1_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

if not WorldInfoManager then
	WorldInfoManager = class()
end
WorldInfoManager.init = function(l_2_0)
	-- upvalues: l_0_0
	l_2_0._id_to_level_info = {}
	l_2_0._name_to_level_info = {}
	l_2_0._index_to_id = {}
	l_2_0._is_show_case_build = File:exists("data/videos/enable_debug_levels.hack")
	local l_2_1 = File:new_parse_xml("data/levels/levels.xml")
	local l_2_2 = l_0_0()
	l_2_0:load_world_infos(l_2_1:children(), l_2_2)
end

local l_0_1 = function(l_3_0, l_3_1)
	local l_3_2 = #l_3_1
	for l_3_6 = l_3_2, 1, -1 do
		if l_3_1[l_3_6] <= l_3_0 then
			return l_3_6
		end
	end
	assert(false)
end

WorldInfoManager.load_world_infos = function(l_4_0, l_4_1, l_4_2)
	-- upvalues: l_0_1
	local l_4_6, l_4_7, l_4_8 = nil
	local l_4_3 = l_4_1
	for i_0 in l_4_3 do
		local l_4_10 = tonumber(i_0:parameter("id"))
		local l_4_11 = l_4_9:parameter("name")
		assert(l_0_1(l_4_10, l_4_2))
		if not l_4_0._is_show_case_build or l_4_9:parameter("enabled") == "true" then
			local l_4_12 = nil
			l_4_0._id_to_level_info[l_4_10] = WorldInfo:new(l_4_10, l_4_11, l_0_1(l_4_10, l_4_2))
			l_4_0._name_to_level_info[l_4_11] = WorldInfo:new(l_4_10, l_4_11, l_0_1(l_4_10, l_4_2))
		if not l_4_0._first_world_info then
			end
			l_4_0._first_world_info = WorldInfo:new(l_4_10, l_4_11, l_0_1(l_4_10, l_4_2))
		end
		if not l_4_0._is_show_case_build then
			l_4_0._first_world_info = l_4_0:info_from_id(1)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WorldInfoManager.info_from_id = function(l_5_0, l_5_1)
	return l_5_0._id_to_level_info[l_5_1]
end

WorldInfoManager.info_from_name = function(l_6_0, l_6_1)
	return l_6_0._name_to_level_info[l_6_1]
end

WorldInfoManager.has_info_for_name = function(l_7_0, l_7_1)
	return l_7_0._name_to_level_info[l_7_1] ~= nil
end

WorldInfoManager.level_infos = function(l_8_0)
	return l_8_0._id_to_level_info
end

WorldInfoManager.first_world_info = function(l_9_0)
	return l_9_0._first_world_info
end

WorldInfoManager.next_world_info = function(l_10_0, l_10_1)
	local l_10_2 = l_10_1.id
	local l_10_3 = 20
	for l_10_7 = l_10_2 + 1, l_10_3 do
		local l_10_8 = l_10_0:info_from_id(l_10_7)
		if l_10_8 then
			return l_10_8
		end
	end
end


