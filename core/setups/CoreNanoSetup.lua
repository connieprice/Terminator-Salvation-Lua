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
if not core_nano_setup then
	core_nano_setup = {}
end
if not managers then
	managers = {}
end
core_nano_setup.init = function()
	if not core_nano_setup.is_initialized then
		core_nano_setup.is_initialized = true
		if not Application:editor() then
			core_nano_setup.setup_postprocessor_environment()
		end
		managers.global_texture = core_or_local("GTextureManager")
		managers.localization = CoreLocalizationManager.LocalizationManager:new()
	end
end

core_nano_setup.setup_postprocessor_environment = function()
	if not Global.shaders_loaded then
		Application:load_render_templates("/data/shaders/filters_rtdb.xml")
		Application:load_render_templates("/data/shaders/deferred_geometry_deprecated_rtdb.xml")
		Application:load_render_templates("/data/shaders/deferred_lighting_rtdb.xml")
		local l_2_0, l_2_1 = nil, nil
		if SystemInfo:platform() == "WIN32" then
			if SystemInfo:renderer() == "DX10" then
				l_2_0 = "win32"
				l_2_1 = "d3d10"
				Application:load_shader_config("/data/shaders/win32_dx10/filters")
				Application:load_shader_config("/data/shaders/win32_dx10/deferred_geometry_deprecated")
				Application:load_shader_config("/data/shaders/win32_dx10/deferred_lighting")
			else
				l_2_0 = "win32"
				l_2_1 = "d3d9"
				Application:load_shader_config("/data/shaders/win32/filters")
				Application:load_shader_config("/data/shaders/win32/deferred_geometry_deprecated")
				Application:load_shader_config("/data/shaders/win32/deferred_lighting")
			end
		else
			if SystemInfo:platform() == "X360" then
				l_2_0 = "x360"
				Application:load_shader_config("/data/shaders/x360/filters")
				Application:load_shader_config("/data/shaders/x360/deferred_geometry_deprecated")
				Application:load_shader_config("/data/shaders/x360/deferred_lighting")
			end
		else
			l_2_0 = "ps3"
			Application:load_shader_config("/data/shaders/ps3/filters")
			Application:load_shader_config("/data/shaders/ps3/deferred_geometry_deprecated")
			Application:load_shader_config("/data/shaders/ps3/deferred_lighting")
		end
		core_nano_setup.load_custom_shaders(Database, l_2_0, l_2_1)
		Global.shaders_loaded = true
	end
end

core_nano_setup.load_custom_shaders = function(l_3_0, l_3_1, l_3_2)
	local l_3_7, l_3_8, l_3_9, l_3_10, l_3_12, l_3_14, l_3_16, l_3_18 = nil
	local l_3_3 = l_3_0:all(false, "render_template")
	for i_0,i_1 in ipairs(l_3_3) do
		local l_3_17, l_3_19 = Application:load_render_templates, Application
		l_3_17(l_3_19, l_3_0:root() .. "/" .. l_3_15:path())
	end
	for i_0,i_1 in ipairs(l_3_0:all(false, "shader_lib")) do
		do
			if i_1:property("platform") == l_3_1 and core_nano_setup.is_renderer(l_3_2, i_1:path()) then
				Application:load_shader_config(l_3_0:root() .. "/" .. i_1:path())
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

core_nano_setup.is_renderer = function(l_4_0, l_4_1)
	if l_4_0 then
		local l_4_2 = string.find(l_4_1, l_4_0)
		l_4_2 = l_4_2
		return l_4_2
	end
end

core_nano_setup.initialized = function()
	return core_nano_setup.is_initialized
end


