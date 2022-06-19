if not AMMoodControl then
	AMMoodControl = class(CoreActionElement)
end
AMMoodControl.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMMoodControl.activate_now = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0.units) do
		if l_2_0._mode == "default_battle_mode" then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):drama():set_default_battle_mood(true)
		else
			managers.unit_scripting:get_unit_by_name(i_1.script_name):drama():set_default_battle_mood(false)
			managers.unit_scripting:get_unit_by_name(i_1.script_name):drama():set_mood(l_2_0._mode)
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


