if not AMUnitStatus then
	AMUnitStatus = class(CoreActionElement)
end
AMUnitStatus.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMUnitStatus.activate_now = function(l_2_0)
	managers.unit_scripting:get_unit_by_name_callback(l_2_0.target_unit.script_name, callback(l_2_0, l_2_0, "unit_spawned"))
	l_2_0:deactivate_now()
end

AMUnitStatus.unit_spawned = function(l_3_0, l_3_1)
	l_3_1:base():activate_status_callbacks(l_3_0._name)
end


