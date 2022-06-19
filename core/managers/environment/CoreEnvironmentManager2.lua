core:module("CoreEnvironmentManager2")
core:require_module("CoreClass")
core:require_module("CoreCode")
core:require_module("CoreSky")
core:require_module("CoreUnderlayEffect")
core:require_module("CorePostEffect")
core:require_module("CoreLightEnvironment")
core:require_module("CoreDebug")
EnvironmentManager = EnvironmentManager or CoreClass.class()
function EnvironmentManager.init(A0_0, A1_1)
	A0_0:deprecated_init(A1_1)
	A0_0._environment_blends = {}
end
function EnvironmentManager.update(A0_2, A1_3, A2_4)
	local L3_5, L4_6, L5_7, L6_8, L7_9
	L3_5 = Profiler
	L3_5 = L3_5.start
	L3_5 = L3_5(L4_6, L5_7)
	for L7_9, 