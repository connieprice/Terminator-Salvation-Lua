ScriptUnitData = ScriptUnitData or class(CoreScriptUnitData)
function ScriptUnitData.init(A0_0, A1_1)
	CoreScriptUnitData.init(A0_0)
	A0_0._unit = A1_1
end
function ScriptUnitData.setup(A0_2, A1_3)
	if A1_3 then
		A0_2._unit:set_extension_update_enabled("unit_data", true)
	else
		A0_2._unit:set_extension_update_enabled("unit_data", false)
	end
	A0_2._updator = A1_3
end
