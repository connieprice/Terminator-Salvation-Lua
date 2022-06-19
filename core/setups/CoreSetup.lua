require("core/setups/CoreNanoSetup")
cap_framerate_hijack = function(l_1_0, l_1_1)
	Global.application_framerate_cap = tonumber(l_1_1) or 0
	l_1_0:hijacked_cap_framerate(Global.application_framerate_cap)
end

Global.application_framerate_cap = Global.application_framerate_cap or 0
hijack_func(Application, "cap_framerate", callback(nil, _G, "cap_framerate_hijack"))
coroutine_resume_hijack = function(...)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not ({coroutine.hijacked_resume(...)})[1] then
		local l_2_3 = nil
		Application:stack_dump_error(({coroutine.hijacked_resume(...)})[2])
	end
	local l_2_1 = nil
	local l_2_2 = unpack
	return l_2_2(l_2_1)
end

hijack_func(coroutine, "resume", callback(nil, _G, "coroutine_resume_hijack"))
base_require("core/utils/dev/ews/CoreEWS", nil, "DEBUG")
base_require("core/units/CoreSpawnSystem", nil, "RELEASE")
base_require("core/units/data/CoreScriptUnitData", nil, "RELEASE")
base_require("core/units/data/CoreWireData", nil, "RELEASE")
base_require("core/units/data/CoreCutsceneData", nil, "RELEASE")
base_require("core/managers/controller/CoreControllerManager", nil, "RELEASE")
base_require("core/managers/cutscene/CoreCutsceneManager", nil, "RELEASE")
base_require("core/managers/CoreSlotManager", nil, "RELEASE")
base_require("core/managers/CoreAiHiveBrain", nil, "RELEASE")
base_require("core/managers/CoreDebugManager", nil, "DEBUG")
base_require("core/managers/CoreConfigManager", nil, "RELEASE")
base_require("core/managers/CoreVolumeManager", nil, "RELEASE")
base_require("core/managers/CoreDOFManager", nil, "RELEASE")
base_require("core/managers/CoreRumbleManager", nil, "RELEASE")
core:require_module("CoreShadowManager")
core:require_module("CoreMusicManager")
core:require_module("CoreNewsReportManager")
core:require_module("CoreSubtitleManager")
core:require_module("CoreEnvironmentManager2")
core:require_module("CoreViewportManager2")
base_require("core/managers/CoreSequenceManager", nil, "RELEASE")
base_require("core/managers/CoreGenericStateManager", nil, "RELEASE")
base_require("core/managers/CoreWorldManager", nil, "RELEASE")
base_require("core/managers/CoreExpressionManager", nil, "RELEASE")
base_require("core/managers/CoreBenchmarkManager", nil, "RELEASE")
base_require("core/managers/CoreWorldCameraManager", nil, "RELEASE")
base_require("core/managers/CoreShapeManager", nil, "RELEASE")
base_require("core/managers/CorePortalManager", nil, "RELEASE")
base_require("core/managers/CoreGTextureManager", nil, "RELEASE")
base_require("core/managers/CoreDatabaseManager", nil, "DEBUG")
base_require("core/managers/CoreSoundEnvironmentManager", nil, "RELEASE")
base_require("core/managers/CoreEnvironmentAreaManager", nil, "RELEASE")
base_require("core/managers/CoreListenerManager", nil, "RELEASE")
base_require("core/managers/CoreEnvironmentEffectsManager", nil, "RELEASE")
base_require("core/managers/CoreOverlayEffectManager", nil, "RELEASE")
base_require("core/units/CoreUnitDamage", nil, "RELEASE")
base_require("core/units/CoreEditableGui", nil, "RELEASE")
base_require("core/utils/dev/Utils", nil, "RELEASE")
base_require("core/utils/dev/Tablescan", nil, "RELEASE")
base_require("core/utils/dev/Luaspy", nil, "DEBUG")
base_require("core/utils/dev/ToolHub", nil, "DEBUG")
base_require("core/utils/dev/CoreLuaDump", nil, "DEBUG")
base_require("core/utils/dev/CoreFreeFlight", nil, "RELEASE")
base_require("core/utils/dev/netews/CoreNetEWSWidget", nil, "DEBUG")
base_require("core/utils/dev/netews/CoreNetEWSUtils", nil, "DEBUG")
base_require("core/utils/dev/netews/CoreNetEWS", nil, "DEBUG")
base_require("core/utils/dev/netews/CoreNetEWSServer", nil, "DEBUG")
core:require_module("CoreMusicEditor2")
core:require_module("CoreMusicMonitor")
core:require_module("CoreLuaProfilerViewer")
base_require("core/utils/dev/tools/CoreVolumeEditor", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreUnitReloader", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreUnitTestBrowser", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreEnvEditor", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreDatabaseBrowser", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreBenchmarkEditor", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreLuaProfiler", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreXMLEditor", nil, "DEBUG")
base_require("core/utils/dev/tools/CorePrefHud", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreResourceExporter", nil, "DEBUG")
base_require("core/utils/dev/tools/CoreMacroToolbar", nil, "DEBUG")
base_require("core/utils/dev/tools/CorePuppeteer", nil, "DEBUG")
base_require("core/utils/dev/tools/material_editor/CoreMaterialEditor", nil, "DEBUG")
base_require("core/utils/dev/tools/material_editor2/CoreMaterialEditor2", nil, "DEBUG")
base_require("core/utils/dev/tools/particle_editor/CoreParticleEditor", nil, "DEBUG")
base_require("core/utils/dev/tools/unit_editor/CoreUnitEditor", nil, "DEBUG")
base_require("core/utils/dev/tools/cutscene_editor/CoreCutsceneEditor", nil, "DEBUG")
base_require("core/utils/dev/editor/CoreEditor", nil, "DEBUG")
base_require("core/utils/dev/editor/WorldHolder", nil, "RELEASE")
d = managers.debug
if not Global.category_print then
	Global.category_print = {}
end
if not Global.category_print_initialized then
	Global.category_print_initialized = {}
end
if base_is_required("DEBUG") then
	NetEWS:new()
	NetEWSServer:new()
end
core_setup.pre_init = function()
end

core_setup.init = function()
	assert(core_nano_setup.initialized(), "Must initialize core_nano_setup first.")
	assert(not core_setup.is_initialized, "Must only initialize core_setup once.")
	core_setup.is_initialized = true
	min_exe_version("1.0.0.7000", "Core Systems")
	rawset(_G, "UnitDamage", rawget(_G, "UnitDamage") or CoreUnitDamage)
	rawset(_G, "EditableGui", rawget(_G, "EditableGui") or CoreEditableGui)
	core_setup.setup_category_print()
	core_setup.flag_rs_apply = false
	if not Application:editor() then
		if SystemInfo:platform() == "WIN32" then
			core_setup_resolution()
		else
			if SystemInfo:platform() == "X360" or SystemInfo:platform() == "PS3" and SystemInfo:widescreen() then
				core_setup.wide = true
				core_setup.aspect_ratio = 1.7777778
			end
		else
			core_setup.wide = false
			core_setup.aspect_ratio = 1.3333334
		end
	else
		local l_4_0 = RenderSettings.resolution
		core_setup.aspect_ratio = l_4_0.x / l_4_0.y
		local l_4_1 = core_setup
		l_4_1.wide = core_setup.aspect_ratio > 1.34
		l_4_1 = core_nano_setup
		l_4_1 = l_4_1.setup_postprocessor_environment
		l_4_1()
	end
	managers.controller = core_or_local("ControllerManager")
	managers.slot = core_or_local("SlotManager")
	managers.listener = core_or_local("ListenerManager")
	managers.config = core_or_local("ConfigManager", "data/lib/managers/xml/configmanager.xml")
	managers.environment = core_prepare_full_load(CoreEnvironmentManager2.EnvironmentManager:new(), managers.environment)
	managers.viewport = CoreViewportManager2.ViewportManager:new()
	managers.volume = core_or_local("VolumeManager", "data/lib/managers/xml/volumemanager.xml")
	managers.aihivebrain = core_or_local("AiMachine")
	managers.music = CoreMusicManager.MusicManager:new()
	managers.shadow = CoreShadowManager.ShadowManager:new()
	managers.music2 = managers.music:player()
	managers.sequence = core_or_local("SequenceManager")
	managers.sequence:internal_load()
	managers.world = core_or_local("WorldManager")
	managers.expression = core_or_local("ExpressionManager")
	managers.benchmark = core_or_local("BenchmarkManager")
	managers.worldcamera = core_or_local("WorldCameraManager")
	managers.environment_effects = core_or_local("EnvironmentEffectsManager")
	managers.portal = core_or_local("PortalManager")
	managers.debug = core_or_local("DebugManager")
	managers.global_texture = core_prepare_full_load(core_or_local("GTextureManager"), managers.global_texture)
	managers.sound_environment = core_or_local("SoundEnvironmentManager")
	managers.shape = core_or_local("ShapeManager")
	managers.environment_area = core_or_local("EnvironmentAreaManager")
	managers.cutscene = core_or_local("CutsceneManager")
	managers.rumble = core_or_local("RumbleManager")
	managers.DOF = core_or_local("DOFManager")
	managers.subtitle = CoreSubtitleManager.SubtitleManager:new()
	managers.overlay_effect = core_or_local("OverlayEffectManager")
	if Application:ews_enabled() then
		managers.news = CoreNewsReportManager.NewsReportManager:new()
	end
	if base_is_required("DEBUG") then
		managers.database = core_or_local("DatabaseManager")
		managers.prefhud = core_or_local("PrefHud")
	end
	d = managers.debug
	if Application:ews_enabled() then
		if not managers.toolhub then
			managers.toolhub = ToolHub:new()
		end
		if not Application:editor() then
			managers.toolhub:add("Unit Reloader", get_core_or_local("UnitReloader"))
		end
		managers.toolhub:add("Environment Editor", get_core_or_local("EnvEditor"))
		managers.toolhub:add(CoreMusicEditor2.TOOLHUB_NAME, CoreMusicEditor2.CoreMusicEditor2)
		managers.toolhub:add(CoreMusicMonitor.TOOLHUB_NAME, CoreMusicMonitor.CoreMusicMonitor)
		managers.toolhub:add(CoreLuaProfilerViewer.TOOLHUB_NAME, CoreLuaProfilerViewer.LuaProfilerViewer)
		managers.toolhub:add("Database Browser", get_core_or_local("DatabaseBrowser"))
		managers.toolhub:add(get_core_or_local("MaterialEditor2").TOOLHUB_NAME, get_core_or_local("MaterialEditor2"))
		managers.toolhub:add("Benchmark Editor", get_core_or_local("BenchmarkEditor"))
		managers.toolhub:add("LUA Profiler", get_core_or_local("LuaProfiler"))
		managers.toolhub:add("XML Editor", get_core_or_local("XMLEditor"))
		managers.toolhub:add("Particle Editor", get_core_or_local("ParticleEditor"))
		managers.toolhub:add(get_core_or_local("ResourceExporter").TOOLHUB_NAME, get_core_or_local("ResourceExporter"))
		managers.toolhub:add(get_core_or_local("Puppeteer").EDITOR_TITLE, get_core_or_local("Puppeteer"))
		managers.toolhub:add(get_core_or_local("UnitEditor").TOOLHUB_NAME, get_core_or_local("UnitEditor"))
		managers.toolhub:add(get_core_or_local("CutsceneEditor").EDITOR_TITLE, get_core_or_local("CutsceneEditor"))
	if not Global.NEW_CORE_GENERATION_2 then
		end
		managers.toolhub:add("Material Editor", get_core_or_local("MaterialEditor"))
		managers.toolhub:add("Volume Editor", get_core_or_local("VolumeEditor"))
		managers.toolhub:add("Unit Test Browser", get_core_or_local("UnitTestBrowser"))
		managers.toolhub:add("Luaspy", LuaSpy)
	end
end

core_setup.post_init = function()
	managers.sequence:preload()
	managers.cutscene:post_init()
end

core_setup_resolution = function()
	local l_6_0, l_6_1 = core_setup_get_mode()
	local l_6_2 = RenderSettings.resolution
	core_setup_apply_aspect_settings()
	if l_6_0.x ~= l_6_2.x or l_6_0.y ~= l_6_2.y or l_6_0.z ~= l_6_2.z or l_6_1 ~= RenderSettings.fullscreen then
		RenderSettings.resolution = l_6_0
		RenderSettings.fullscreen = l_6_1
		core_setup.flag_rs_apply = true
	end
end

core_setup_apply_aspect_settings = function()
	core_setup.aspect_ratio = core_setup_get_aspect()
	local l_7_0 = core_setup
	l_7_0.wide = core_setup.aspect_ratio > 1.34
	l_7_0 = core_setup
	l_7_0.flag_rs_apply = true
end

core_setup_get_mode = function()
	local l_8_4, l_8_5 = nil
	local l_8_0 = Application:render_settings_filename()
	if File:config_exists(l_8_0) then
		for i_0 in File:parse_xml(l_8_0):children() do
			 -- DECOMPILER ERROR: Overwrote pending register.

			if i_0:name() == "d3d_device" then
				if Application:render_settings_dirty() then
					do return end
				end
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Confused about usage of registers!

				local l_8_7 = nil
				return Vector3(nil.x, nil.y, tonumber(l_8_6:parameter("refresh_rate"))), l_8_6:parameter("windowed") == "false"
			end
		end
	end
	return RenderSettings.resolution, RenderSettings.fullscreen
end

core_setup_auto_detect_resolution = function()
	local l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14 = nil
	local l_9_0 = SystemInfo:desktop_resolution()
	local l_9_1 = l_9_0.x * l_9_0.y
	local l_9_2 = math.huge
	local l_9_3 = RenderSettings.resolution
	for i_0,i_1 in ipairs(RenderSettings.modes) do
		if ((l_9_0.z > 0 and l_9_0.z) or i_1.z == l_9_3.z) and math.abs(l_9_1 - i_1.x * i_1.y) < l_9_2 then
			l_9_2 = math.abs(l_9_1 - i_1.x * i_1.y)
			l_9_3 = i_1
		end
	end
	File:open(Application:render_settings_filename(), "w"):puts("<renderer_config>\n\t<d3d_device adapter=\"" .. RenderSettings.adapter .. "\" resolution=\"" .. l_9_3.x .. " " .. l_9_3.y .. "\" refresh_rate=\"" .. l_9_3.z .. "\" windowed=\"" .. tostring(not RenderSettings.fullscreen) .. "\" aspect_ratio=\"" .. l_9_3.x / l_9_3.y .. "\"/>\n</renderer_config>")
	File:open(Application:render_settings_filename(), "w"):close()
	return l_9_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

core_setup_get_aspect = function()
	if File:config_exists(Application:render_settings_filename()) then
		local l_10_3 = File:parse_xml
		l_10_3 = l_10_3(File, Application:render_settings_filename())
		 -- DECOMPILER ERROR: Overwrote pending register.

		for i_0 in l_10_3 do
			if l_10_2:name() == "d3d_device" and l_10_2:parameter("aspect_ratio") ~= "" then
				local l_10_4 = tonumber
				local l_10_5, l_10_6, l_10_7 = l_10_2:parameter("aspect_ratio"), .end
				return l_10_4(l_10_5, l_10_6, l_10_7)
			end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_10_3
end

core_setup.update = function(l_11_0, l_11_1)
	if core_setup.flag_rs_apply then
		Application:apply_render_settings()
		core_setup.flag_rs_apply = false
	if managers.viewport then
		end
		managers.viewport:resolution_changed()
	end
	if managers.viewport.update then
		managers.viewport:update(l_11_0, l_11_1)
	end
	if managers.worldcamera.update then
		managers.worldcamera:update(l_11_0, l_11_1)
	end
	if managers.controller.update then
		managers.controller:update(l_11_0, l_11_1)
	end
	if managers.cutscene and managers.cutscene.update then
		managers.cutscene:update()
	end
	if managers.aihivebrain.update then
		managers.aihivebrain:update(l_11_0, l_11_1)
	end
	if managers.environment.update then
		managers.environment:update(l_11_0, l_11_1)
	end
	if managers.volume.update then
		managers.volume:update(l_11_0, l_11_1)
	end
	if managers.config.update then
		managers.config:update(l_11_0, l_11_1)
	end
	if managers.music.update then
		managers.music:update(l_11_0, l_11_1)
	end
	if managers.sequence.update then
		managers.sequence:update(l_11_0, l_11_1)
	end
	if managers.environment_effects.update then
		managers.environment_effects:update(l_11_0, l_11_1)
	end
	if managers.sound_environment then
		managers.sound_environment:update(l_11_0, l_11_1)
	end
	if managers.environment_area then
		managers.environment_area:update(l_11_0, l_11_1)
	end
	if managers.expression.update then
		managers.expression:update(l_11_0, l_11_1)
	end
	if managers.benchmark.update then
		managers.benchmark:update(l_11_0, l_11_1)
	end
	if managers.global_texture.update then
		managers.global_texture:update(l_11_0, l_11_1)
	end
	if managers.prefhud and managers.prefhud.update then
		managers.prefhud:update(l_11_0, l_11_1)
	end
	if managers.toolhub and managers.toolhub.update then
		managers.toolhub:update(l_11_0, l_11_1)
	end
	if managers.subtitle and managers.subtitle.update then
		managers.subtitle:update(TimerManager:game_animation():time(), TimerManager:game_animation():delta_time())
	end
	if managers.rumble.update then
		managers.rumble:update(l_11_0, l_11_1)
	end
	if managers.shadow.update then
		managers.shadow:update(l_11_0, l_11_1)
	end
	if managers.DOF.update then
		managers.DOF:update(l_11_0, l_11_1)
	end
	if managers.overlay_effect.update then
		managers.overlay_effect:update(l_11_0, l_11_1)
	end
	if managers.debug and managers.debug.update then
		managers.debug:update(TimerManager:wall():time(), TimerManager:wall():delta_time())
	end
	if rawget(_G, "NET_EWS_CLIENT") and NET_EWS_CLIENT.update then
		NET_EWS_CLIENT:update(l_11_0, l_11_1)
	end
	if rawget(_G, "NET_EWS_SERVER") and NET_EWS_SERVER.update then
		NET_EWS_SERVER:update(l_11_0, l_11_1)
	end
end

core_setup.paused_update = function(l_12_0, l_12_1)
	if core_setup.flag_rs_apply then
		Application:apply_render_settings()
		core_setup.flag_rs_apply = false
	if managers.viewport then
		end
		managers.viewport:resolution_changed()
	end
	if managers.viewport.paused_update then
		managers.viewport:paused_update(l_12_0, l_12_1)
	end
	if managers.controller.update then
		managers.controller:paused_update(l_12_0, l_12_1)
	end
	if managers.cutscene and managers.cutscene.paused_update then
		managers.cutscene:paused_update(l_12_0, l_12_1)
	end
	if managers.aihivebrain.paused_update then
		managers.aihivebrain:paused_update(l_12_0, l_12_1)
	end
	if managers.environment.update then
		managers.environment:update(l_12_0, l_12_1)
	end
	if managers.volume.paused_update then
		managers.volume:paused_update(l_12_0, l_12_1)
	end
	if managers.config.paused_update then
		managers.config:paused_update(l_12_0, l_12_1)
	end
	if managers.music.paused_update then
		managers.music:paused_update(l_12_0, l_12_1)
	end
	if managers.sequence.paused_update then
		managers.sequence:paused_update(l_12_0, l_12_1)
	end
	if managers.expression.paused_update then
		managers.expression:paused_update(l_12_0, l_12_1)
	end
	if managers.benchmark.paused_update then
		managers.benchmark:paused_update(l_12_0, l_12_1)
	end
	if managers.DOF.paused_update then
		managers.DOF:paused_update(l_12_0, l_12_1)
	end
	if managers.rumble.paused_update then
		managers.rumble:paused_update(l_12_0, l_12_1)
	end
	if managers.toolhub and managers.toolhub.paused_update then
		managers.toolhub:paused_update(l_12_0, l_12_1)
	end
	if managers.shadow.paused_update then
		managers.shadow:paused_update(l_12_0, l_12_1)
	end
	if managers.overlay_effect.paused_update then
		managers.overlay_effect:paused_update(l_12_0, l_12_1)
	end
	if managers.debug and managers.debug.paused_update then
		managers.debug:paused_update(TimerManager:wall():time(), TimerManager:wall():delta_time())
	end
	if managers.global_texture.paused_update then
		managers.global_texture:paused_update(l_12_0, l_12_1)
	end
	if rawget(_G, "NET_EWS_CLIENT") and NET_EWS_CLIENT.paused_update then
		NET_EWS_CLIENT:paused_update(l_12_0, l_12_1)
	end
	if rawget(_G, "NET_EWS_SERVER") and NET_EWS_SERVER.paused_update then
		NET_EWS_SERVER:paused_update(l_12_0, l_12_1)
	end
end

core_setup.end_update = function(l_13_0, l_13_1)
	if managers.environment.end_update then
		managers.environment:end_update()
	end
	if managers.toolhub and managers.toolhub.end_update then
		managers.toolhub:end_update(l_13_0, l_13_1)
	end
end

core_setup.paused_end_update = function(l_14_0, l_14_1)
	if managers.environment.end_update then
		managers.environment:end_update()
	end
end

core_setup.render = function()
	if managers.portal.render then
		managers.portal:render()
	end
	if managers.viewport.render then
		managers.viewport:render()
	end
	if managers.overlay_effect.render then
		managers.overlay_effect:render()
	end
end

core_setup.setup_category_print = function()
	if Global.category_print_initialized.core_setup then
		return 
	end
	Global.category_print.debug = true
	Global.category_print.editor = false
	Global.category_print.sequence = false
	Global.category_print.controller_manager = false
	Global.category_print_initialized.core_setup = true
end

core_setup.destroy = function()
	if managers.toolhub then
		managers.toolhub:destroy()
	end
	if managers.global_texture.destroy then
		managers.global_texture:destroy()
	end
	if managers.cutscene then
		managers.cutscene:destroy()
	end
	if managers.subtitle then
		managers.subtitle:destroy()
	end
	if managers.viewport then
		managers.viewport:destroy()
	end
	if managers.overlay_effect then
		managers.overlay_effect:destroy()
	end
	if managers.worldcamera then
		managers.worldcamera:destroy()
	end
	if managers.editor then
		managers.editor:destroy()
	end
	if managers.volume then
		managers.volume:destroy()
	end
	if managers.music then
		managers.music:destroy()
	end
	if managers.environment then
		managers.environment:destroy()
	end
	if managers.debug then
		managers.debug:destroy()
	end
	if managers.prefhud then
		managers.prefhud:destroy()
	end
end


