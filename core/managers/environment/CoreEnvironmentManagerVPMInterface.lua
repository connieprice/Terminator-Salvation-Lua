core:module("CoreEnvironmentManagerVPMInterface")
core:require_module("CoreClass")
EnvironmentManagerVPMInterface = EnvironmentManagerVPMInterface or CoreClass.class()
function EnvironmentManagerVPMInterface.init(A0_0, A1_1)
	A0_0._host = A1_1
end
function EnvironmentManagerVPMInterface.feed(A0_2, A1_3, A2_4, A3_5)
	A0_2._host:feed(A1_3, A2_4, A3_5)
end
function EnvironmentManagerVPMInterface.create_environment_change(A0_6, A1_7, A2_8, A3_9)
	return A0_6._host:create_environment_change(A1_7, A2_8, A3_9)
end
