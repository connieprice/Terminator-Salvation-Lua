CoreConfigManager = CoreConfigManager or class()
function CoreConfigManager.init(A0_0, A1_1)
	A0_0._configs = {}
	A0_0:read_config(A1_1)
end
function CoreConfigManager.read_config(A0_2, A1_3)
	local L2_4, L3_5, L4_6, L5_7, L6_8, L7_9
	L2_4 = File
	L2_4 = L2_4.parse_xml
	L2_4 = L2_4(L3_5, L4_6)
	if L2_4 then
		if L3_5 == "config_manager" then
			for L6_8 in L3_5(L4_6) do
				L7_9 = L6_8.name
				L7_9 = L7_9(L6_8)
				if L7_9 == "preload" then
					L7_9 = L6_8.parameter
					L7_9 = L7_9(L6_8, "file")
					if L7_9 ~= "" then
						L7_9 = cat_print
						L7_9("config_manager", "[CoreConfigManager] Preload: " .. L6_8:parameter("file"))
						L7_9 = File
						L7_9 = L7_9.new_parse_xml
						L7_9 = L7_9(L7_9, L6_8:parameter("file"))
						A0_2:add_config(L6_8:parameter("file"), L7_9)
					end
				end
			end
		end
	end
end
function CoreConfigManager.parse_xml(A0_10, A1_11)
	local L2_12
	L2_12 = A0_10.get_config
	L2_12 = L2_12(A0_10, A1_11)
	if not L2_12 then
		cat_print("config_manager", "[CoreConfigManager] Could not find '" .. A1_11 .. "' Loading it now!")
		L2_12 = File:new_parse_xml(A1_11)
		if L2_12 then
			A0_10:add_config(A1_11, L2_12)
		else
			cat_print("config_manager", "[CoreConfigManager] Can not find '" .. A1_11 .. "'!")
		end
	end
	return L2_12
end
function CoreConfigManager.add_config(A0_13, A1_14, A2_15)
	A0_13._configs[A1_14] = A2_15
end
function CoreConfigManager.get_config(A0_16, A1_17)
	return A0_16._configs[A1_17]
end
