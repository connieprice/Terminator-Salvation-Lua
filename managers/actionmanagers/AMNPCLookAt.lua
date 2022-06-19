require("shared/TableAlgorithms")
if not AMNPCLookAt then
	AMNPCLookAt = class(CoreActionElement)
end
AMNPCLookAt.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMNPCLookAt.activate_now = function(l_2_0)
	local l_2_1, l_2_2, l_2_5, l_2_7 = nil, nil
	if TableAlgorithms.count(l_2_0.look_at_unit) == 1 then
		local l_2_4, l_2_6 = , managers.unit_scripting:get_unit_by_name
		l_2_6 = l_2_6(managers.unit_scripting, l_2_0.look_at_unit[TableAlgorithms.max_index(l_2_0.look_at_unit)].script_name)
		l_2_2 = l_2_6
		l_2_6 = alive
		l_2_6 = l_2_6(l_2_2)
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_2_6 then
			l_2_1 = l_2_6
		else
			l_2_1 = l_2_0.position
		end
	else
		l_2_1 = l_2_0.position
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in pairs(l_2_6) do
		managers.unit_scripting:get_unit_by_name(i_1.script_name):input():set_eye_target_position(l_2_1)
		managers.unit_scripting:get_unit_by_name(i_1.script_name):player_data().should_aim_head_at_eye_target_position = true
		managers.unit_scripting:get_unit_by_name(i_1.script_name):player_data().look_at_unit = l_2_2
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


