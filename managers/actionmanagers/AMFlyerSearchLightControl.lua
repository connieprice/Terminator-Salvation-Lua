if not AMFlyerSearchLightControl then
	AMFlyerSearchLightControl = class(CoreActionElement)
end
AMFlyerSearchLightControl.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMFlyerSearchLightControl.activate_now = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0.units) do
		if managers.unit_scripting:get_unit_by_name(i_1.script_name) then
			managers.unit_scripting:get_unit_by_name(i_1.script_name):base():set_search_light_enabled(l_2_0.searchlight_enabled)
		end
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


