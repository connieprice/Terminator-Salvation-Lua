if not ScriptUnitData then
	ScriptUnitData = class(CoreScriptUnitData)
end
ScriptUnitData.init = function(l_1_0, l_1_1)
	CoreScriptUnitData.init(l_1_0)
	l_1_0._unit = l_1_1
end

ScriptUnitData.setup = function(l_2_0, l_2_1)
	if l_2_1 then
		l_2_0._unit:set_extension_update_enabled("unit_data", true)
	else
		l_2_0._unit:set_extension_update_enabled("unit_data", false)
	end
	l_2_0._updator = l_2_1
end


