if not AMControlRailFlyer then
	AMControlRailFlyer = class(CoreActionElement)
end
AMControlRailFlyer.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMControlRailFlyer.activate_now = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	Application:debug("AMControlRailFlyer:activate_now()")
	for i_0,i_1 in pairs(l_2_0.units) do
		if alive(managers.unit_scripting:get_unit_by_name(i_1.script_name)) and managers.unit_scripting:get_unit_by_name(i_1.script_name) ~= nil then
			if l_2_0.path then
				managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.path = managers.unit_scripting:get_unit_by_name(l_2_0.path.script_name)
			end
			if l_2_0.targets then
				managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._combat.new_targets = l_2_0.targets
			end
			if l_2_0.target_range ~= nil and l_2_0.target_range ~= "" then
				if l_2_0.offset_displacement then
					managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data().input.target_range = managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data().input.target_range + l_2_0.target_range * 100
				end
			else
				managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data().input.target_range = l_2_0.target_range * 100
			end
			managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.target_from_behind = l_2_0.target_from_behind
			if l_2_0.offset_displacement then
				managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.displacement = managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.displacement:with_x(managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.displacement.x + l_2_0.displacement_x * 100):with_z(managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.displacement.z + l_2_0.displacement_y * 100)
			end
		elseif l_2_0.displacement_x ~= nil then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.displacement = managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.displacement:with_x(l_2_0.displacement_x * 100)
		end
		if l_2_0.displacement_y ~= nil then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.displacement = managers.unit_scripting:get_unit_by_name(i_1.script_name):ai_data()._move.displacement:with_z(l_2_0.displacement_y * 100)
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


