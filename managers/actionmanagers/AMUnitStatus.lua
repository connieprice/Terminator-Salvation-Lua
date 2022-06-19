AMUnitStatus = AMUnitStatus or class(CoreActionElement)
function AMUnitStatus.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMUnitStatus.activate_now(A0_3)
	managers.unit_scripting:get_unit_by_name_callback(A0_3.target_unit.script_name, callback(A0_3, A0_3, "unit_spawned"))
	A0_3:deactivate_now()
end
function AMUnitStatus.unit_spawned(A0_4, A1_5)
	A1_5:base():activate_status_callbacks(A0_4._name)
end
