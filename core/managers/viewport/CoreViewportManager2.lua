core:module("CoreViewportManager2")
core:require_module("CoreClass")
core:require_module("CoreApp")
core:require_module("CoreCode")
core:require_module("CoreScriptViewportVMInterface")
core:require_module("CoreEnvironmentManagerVPMInterface")
ViewportManager = ViewportManager or CoreClass.class()
function ViewportManager.init(A0_0)
	CoreApp.min_exe_version("1.0.78.10226", "CoreViewportManager2")
	A0_0._envm_interface = CoreEnvironmentManagerVPMInterface.EnvironmentManagerVPMInterface:new(managers.environment)
	A0_0._resolution_changed_func_map = {}
	A0_0._active_viewports = {}
	A0_0._viewports = {}
	A0_0._viewport_states_stack = {}
	A0_0._cached_environment_name = nil
	script_debug.render_sky = true
end
function ViewportManager.update(A0_1, A1_2, A2_3)
	local L3_4
	L3_4 = Profiler
	L3_4 = L3_4.start
	L3_4 = L3_4(L3_4, "CoreViewportManager")
	for 