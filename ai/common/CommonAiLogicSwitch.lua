if not CommonAiLogicSwitch then
	CommonAiLogicSwitch = {}
end
CommonAiLogicSwitch.evaluate_switch = function(l_1_0, l_1_1)
	local l_1_5, l_1_6, l_1_7, l_1_8 = nil
	for i_0,i_1 in ipairs(l_1_0) do
		setfenv(loadstring(i_1.expression), {ai_data = l_1_1})
		if loadstring(i_1.expression)() then
			return l_1_10.value
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


