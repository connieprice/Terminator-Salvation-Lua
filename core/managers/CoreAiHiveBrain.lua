CoreAiMachine = CoreAiMachine or class()
CoreAiMachine.PROFILE = false
CoreAiMachine._ai_logic_functions = {}
function CoreAiMachine.register_logicfunctions(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8
	if L2_2 == "table" then
		for L5_5, L6_6 in L2_2(L3_3) do
			L7_7 = type
			L8_8 = L6_6
			L7_7 = L7_7(L8_8)
			if L7_7 == "function" then
				L7_7 = string
				L7_7 = L7_7.find
				L8_8 = L5_5
				L7_7 = L7_7(L8_8, "logic_")
				if L7_7 ~= nil then
					L8_8 = string
					L8_8 = L8_8.sub
					L8_8 = L8_8(L5_5, 7)
					if A0_0._ai_logic_functions[L8_8] == nil then
						A0_0._ai_logic_functions[L8_8] = callback(A1_1, A1_1, L5_5)
					else
						Application:error("CoreAiMachine:register_logicfunctions: There is already a logic with the name '" .. L8_8 .. "'")
					end
				end
			end
		end
	end
end
function CoreAiMachine.init(A0_9)
	A0_9._brains_data = {}
	A0_9._threads_data = {}
	A0_9._brain_groups = {}
	A0_9._ai_call_functions = {}
	A0_9._enable = true
	A0_9._debug = false
	cat_print("ai", "------------------------ CoreAiMachine:Init Done")
end
function CoreAiMachine.parse_data(A0_10)
	local L1_11, L2_12, L3_13, L4_14, L5_15
	L1_11 = cat_print
	L1_11(L2_12, L3_13)
	L1_11 = File
	L1_11 = L1_11.parse_xml
	L1_11 = L1_11(L2_12, L3_13)
	if L1_11 == nil then
		L2_12(L3_13)
	end
	for L5_15 in L2_12(L3_13) do
		A0_10:parse_ai_graph(L5_15)
	end
	for L5_15, 