require("core/CorePatches")
require("core/CoreModule")
require("core/CoreModules")
core:copy_module_to_global("CoreClass")
core:copy_module_to_global("CoreCode")
core:copy_module_to_global("CoreDebug")
core:copy_module_to_global("CoreEvent")
core:copy_module_to_global("CoreEws")
core:copy_module_to_global("CoreInput")
core:copy_module_to_global("CoreMath")
core:copy_module_to_global("CoreOldModule")
core:copy_module_to_global("CoreString")
core:copy_module_to_global("CoreTable")
core:copy_module_to_global("CoreUnit")
core:copy_module_to_global("CoreXml")
core:copy_module_to_global("CoreApp")
base_require("core/managers/CoreGTextureManager", nil, "RELEASE")
core:require_module("CoreLocalizationManager")
core_nano_setup = core_nano_setup or {}
managers = managers or {}
function core_nano_setup.init()
	if not core_nano_setup.is_initialized then
		core_nano_setup.is_initialized = true
		if not Application:editor() then
			core_nano_setup.setup_postprocessor_environment()
		end
		managers.global_texture = core_or_local("GTextureManager")
		managers.localization = CoreLocalizationManager.LocalizationManager:new()
	end
end
function core_nano_setup.setup_postprocessor_environment()
	local L0_0, L1_1
	L0_0 = Global
	L0_0 = L0_0.shaders_loaded
	if not L0_0 then
		L0_0 = Application
		L1_1 = L0_0
		L0_0 = L0_0.load_render_templates
		L0_0(L1_1, "/data/shaders/filters_rtdb.xml")
		L0_0 = Application
		L1_1 = L0_0
		L0_0 = L0_0.load_render_templates
		L0_0(L1_1, "/data/shaders/deferred_geometry_deprecated_rtdb.xml")
		L0_0 = Application
		L1_1 = L0_0
		L0_0 = L0_0.load_render_templates
		L0_0(L1_1, "/data/shaders/deferred_lighting_rtdb.xml")
		L0_0, L1_1 = nil, nil
		if SystemInfo:platform() == "WIN32" then
			if SystemInfo:renderer() == "DX10" then
				L0_0 = "win32"
				L1_1 = "d3d10"
				Application:load_shader_config("/data/shaders/win32_dx10/filters")
				Application:load_shader_config("/data/shaders/win32_dx10/deferred_geometry_deprecated")
				Application:load_shader_config("/data/shaders/win32_dx10/deferred_lighting")
			else
				L0_0 = "win32"
				L1_1 = "d3d9"
				Application:load_shader_config("/data/shaders/win32/filters")
				Application:load_shader_config("/data/shaders/win32/deferred_geometry_deprecated")
				Application:load_shader_config("/data/shaders/win32/deferred_lighting")
			end
		elseif SystemInfo:platform() == "X360" then
			L0_0 = "x360"
			Application:load_shader_config("/data/shaders/x360/filters")
			Application:load_shader_config("/data/shaders/x360/deferred_geometry_deprecated")
			Application:load_shader_config("/data/shaders/x360/deferred_lighting")
		else
			L0_0 = "ps3"
			Application:load_shader_config("/data/shaders/ps3/filters")
			Application:load_shader_config("/data/shaders/ps3/deferred_geometry_deprecated")
			Application:load_shader_config("/data/shaders/ps3/deferred_lighting")
		end
		core_nano_setup.load_custom_shaders(Database, L0_0, L1_1)
		Global.shaders_loaded = true
	end
end
function core_nano_setup.load_custom_shaders(A0_2, A1_3, A2_4)
	local L3_5, L4_6
	L3_5 = A0_2.all
	L3_5 = L3_5(L4_6, false, "render_template")
	for 