if not EnvironmentScriptViewport then
	EnvironmentScriptViewport = class(CoreScriptViewport.ScriptViewport)
end
EnvironmentScriptViewport.environment_change_name = function(l_1_0)
	if l_1_0._environment_change then
		return l_1_0._environment_change.environment_name
	end
end

EnvironmentScriptViewport.environment_change_alternative = function(l_2_0)
	if l_2_0._environment_change then
		return l_2_0._environment_change.alternative_environment
	end
end

EnvironmentScriptViewport.set_environment = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_1
	local l_3_4 = RenderSettings.split_screen
	if l_3_4 then
		local l_3_5 = l_3_1 .. "_coop"
	if managers.environment:exists(l_3_5) or Database:lookup("environment", l_3_5):valid() then
		end
		l_3_3 = l_3_5
	end
	l_3_0._vpm_interface:set_environment_name_cache(l_3_1)
	l_3_0._environment_change = l_3_0._vpm_interface:create_environment_change(l_3_0._environment_change, l_3_3, l_3_2)
	if l_3_0._environment_change then
		l_3_0._environment_change.alternative_environment = l_3_4
		l_3_0._environment_change.environment_name = l_3_1
	end
	l_3_0:feed_now()
end


