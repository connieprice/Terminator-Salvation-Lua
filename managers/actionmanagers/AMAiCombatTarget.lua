if not AMAiCombatTarget then
	AMAiCombatTarget = class(CoreActionElement)
end
AMAiCombatTarget.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMAiCombatTarget.activate_now = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0.units) do
		assert(l_2_0.min_target_weight)
		assert(l_2_0.max_target_weight)
		managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._min_target_weight = l_2_0.min_target_weight
		managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._max_target_weight = l_2_0.max_target_weight
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


