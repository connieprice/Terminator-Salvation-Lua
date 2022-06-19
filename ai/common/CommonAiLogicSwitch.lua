local L0_0
L0_0 = CommonAiLogicSwitch
L0_0 = L0_0 or {}
CommonAiLogicSwitch = L0_0
L0_0 = CommonAiLogicSwitch
function L0_0.evaluate_switch(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9
	for L5_6, L6_7 in L2_3(L3_4) do
		L7_8 = loadstring
		L8_9 = L6_7.expression
		L7_8 = L7_8(L8_9)
		L8_9 = {}
		L8_9.ai_data = A1_2
		setfenv(L7_8, L8_9)
		if L7_8() then
			return L6_7.value
		end
	end
	return L2_3
end
