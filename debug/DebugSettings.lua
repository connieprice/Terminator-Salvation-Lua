require("debug/DebugUserJoin")
DebugSettings = DebugSettings or class()
function DebugSettings.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10
	L2_2 = {}
	L3_3 = A0_0._parse_default_controller
	L2_2.default_controller = L3_3
	L3_3 = assert
	L4_4 = File
	L4_4 = L4_4.config_exists
	L10_10 = L4_4(L5_5, L6_6)
	L3_3(L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L4_4(L5_5, L6_6))
	L3_3 = File
	L4_4 = L3_3
	L3_3 = L3_3.parse_xml
	L3_3 = L3_3(L4_4, L5_5)
	L4_4 = L3_3.name
	L4_4 = L4_4(L5_5)
	for L8_8 in L5_5(L6_6) do
		L10_10 = L8_8
		L9_9 = L8_8.name
		L9_9 = L9_9(L10_10)
		L10_10 = L2_2[L9_9]
		if not L10_10 then
			Application:error("Unknown setting: " .. L9_9)
		end
		L10_10(A0_0, L8_8)
	end
	if not L5_5 then
		L5_5(L6_6, L7_7)
	end
	if not L5_5 then
	elseif L5_5 then
		A0_0._user_join = L5_5
	end
end
function DebugSettings.default_controller_type(A0_11)
	local L1_12
	L1_12 = A0_11._default_controller_type
	return L1_12
end
function DebugSettings._parse_default_controller(A0_13, A1_14)
	local L2_15
	L2_15 = "type"
	assert(A1_14:has_parameter(L2_15))
	A0_13._default_controller_type = A1_14:parameter(L2_15)
end
function DebugSettings.update(A0_16, A1_17)
	if A0_16._user_join then
		A0_16._user_join:update(A1_17)
	end
end
