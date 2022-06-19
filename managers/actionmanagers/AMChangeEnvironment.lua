if not AMChangeEnvironment then
	AMChangeEnvironment = class(CoreActionElement)
end
AMChangeEnvironment.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	managers.environment:preload_environment(l_1_0.environment_name)
	local l_1_3 = l_1_0.environment_name .. "_coop"
	if managers.environment:exists_on_disk(l_1_3) then
		managers.environment:preload_environment(l_1_3)
	end
end

AMChangeEnvironment.activate_now = function(l_2_0)
	if l_2_0.fade_in_time == 0 then
		l_2_0.fade_in_time = 0.001
	end
	local l_2_4, l_2_5 = ipairs, managers.viewport:active_viewports()
	l_2_4 = l_2_4(l_2_5)
	for i_0,i_1 in l_2_4 do
		l_2_3:set_environment(l_2_0.environment_name, l_2_0.fade_in_time)
	end
	l_2_0:deactivate_now()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


