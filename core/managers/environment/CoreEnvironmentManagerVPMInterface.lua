core:module("CoreEnvironmentManagerVPMInterface")
core:require_module("CoreClass")
if not EnvironmentManagerVPMInterface then
	EnvironmentManagerVPMInterface = CoreClass.class()
end
EnvironmentManagerVPMInterface.init = function(l_1_0, l_1_1)
	l_1_0._host = l_1_1
end

EnvironmentManagerVPMInterface.feed = function(l_2_0, l_2_1, l_2_2, l_2_3)
	l_2_0._host:feed(l_2_1, l_2_2, l_2_3)
end

EnvironmentManagerVPMInterface.create_environment_change = function(l_3_0, l_3_1, l_3_2, l_3_3)
	local l_3_4, l_3_5 = l_3_0._host:create_environment_change, l_3_0._host
	local l_3_6 = l_3_1
	local l_3_7 = l_3_2
	local l_3_8 = l_3_3
	return l_3_4(l_3_5, l_3_6, l_3_7, l_3_8)
end


