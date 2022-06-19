if not CoreConfigManager then
	CoreConfigManager = class()
end
CoreConfigManager.init = function(l_1_0, l_1_1)
	l_1_0._configs = {}
	l_1_0:read_config(l_1_1)
end

CoreConfigManager.read_config = function(l_2_0, l_2_1)
	local l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12 = nil
	local l_2_2 = File:parse_xml(l_2_1)
	if l_2_2 and l_2_2:name() == "config_manager" then
		for i_0 in l_2_2:children() do
			if i_0:name() == "preload" and i_0:parameter("file") ~= "" then
				cat_print("config_manager", "[CoreConfigManager] Preload: " .. i_0:parameter("file"))
				l_2_0:add_config(l_2_13:parameter("file"), File:new_parse_xml(i_0:parameter("file")))
			end
		end
	end
end

CoreConfigManager.parse_xml = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0:get_config(l_3_1)
	if not l_3_2 then
		cat_print("config_manager", "[CoreConfigManager] Could not find '" .. l_3_1 .. "' Loading it now!")
		l_3_2 = File:new_parse_xml(l_3_1)
		if l_3_2 then
			l_3_0:add_config(l_3_1, l_3_2)
		end
	else
		cat_print("config_manager", "[CoreConfigManager] Can not find '" .. l_3_1 .. "'!")
	end
	return l_3_2
end

CoreConfigManager.add_config = function(l_4_0, l_4_1, l_4_2)
	l_4_0._configs[l_4_1] = l_4_2
end

CoreConfigManager.get_config = function(l_5_0, l_5_1)
	return l_5_0._configs[l_5_1]
end


