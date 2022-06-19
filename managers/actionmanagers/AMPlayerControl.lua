if not AMPlayerControl then
	AMPlayerControl = class(CoreActionElement)
end
AMPlayerControl.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMPlayerControl.activate_now = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0.units) do
		if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) then
			if l_2_0._mode == "player_control" and managers.unit_scripting:get_unit_by_name(i_1.script_name):control():saved_controller_wrapper() then
				managers.unit_scripting:get_unit_by_name(i_1.script_name):control():set_user_controlled(managers.unit_scripting:get_unit_by_name(i_1.script_name):control():saved_controller_wrapper())
			end
		elseif l_2_0._mode == "ai_control" and not managers.unit_scripting:get_unit_by_name(i_1.script_name):control():is_ai_controlled() then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):control():set_ai_controlled_keep_controller_wrapper()
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


