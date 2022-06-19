require("core/setups/CoreNanoSetup")
function cap_framerate_hijack(A0_0, A1_1)
	Global.application_framerate_cap = tonumber(A1_1) or 0
	A0_0:hijacked_cap_framerate(Global.application_framerate_cap)
end
Global.application_framerate_cap = Global.application_framerate_cap or 0
hijack_func(Application, "cap_framerate", callback(nil, _G, "cap_framerate_hijack"))
function coroutine_resume_hijack(...)
	local L1_3
	L1_3 = {
		coroutine.hijacked_resume(...)
	}
	if not L1_3[1] then
		Application:stack_dump_error(L1_3[2])
	end
	return unpack(L1_3)
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
Global.category_print = Global.category_print or {}
Global.category_print_initialized = Global.category_print_initialized or {}
if base_is_required("DEBUG") then
	NetEWS:new()
	NetEWSServer:new()
end
function core_setup.pre_init()
	local L0_4, L1_5
end
function core_setup.init()
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
		elseif SystemInfo:platform() == "X360" or SystemInfo:platform() == "PS3" and SystemInfo:widescreen() then
			core_setup.wide = true
			core_setup.aspect_ratio = 1.7777778
		else
			core_setup.wide = false
			core_setup.aspect_ratio = 1.3333334
		end
	else
		core_setup.aspect_ratio = RenderSettings.resolution.x / RenderSettings.resolution.y
		core_setup.wide = core_setup.aspect_ratio > 1.34
		core_nano_setup.setup_postprocessor_environment()
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
		managers.toolhub = managers.toolhub or ToolHub:new()
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
			managers.toolhub:add("Material Editor", get_core_or_local("MaterialEditor"))
			managers.toolhub:add("Volume Editor", get_core_or_local("VolumeEditor"))
			managers.toolhub:add("Unit Test Browser", get_core_or_local("UnitTestBrowser"))
			managers.toolhub:add("Luaspy", LuaSpy)
		end
	end
end
function core_setup.post_init()
	managers.sequence:preload()
	managers.cutscene:post_init()
end
function core_setup_resolution()
	core_setup_apply_aspect_settings()
	if core_setup_get_mode().x ~= RenderSettings.resolution.x or core_setup_get_mode().y ~= RenderSettings.resolution.y or core_setup_get_mode().z ~= RenderSettings.resolution.z or core_setup_get_mode() ~= RenderSettings.fullscreen then
		RenderSettings.resolution = core_setup_get_mode()
		RenderSettings.fullscreen = core_setup_get_mode()
		core_setup.flag_rs_apply = true
	end
end
function core_setup_apply_aspect_settings()
	local L0_6
	L0_6 = core_setup
	L0_6.aspect_ratio = core_setup_get_aspect()
	L0_6 = core_setup
	L0_6.wide = core_setup.aspect_ratio > 1.34
	L0_6 = core_setup
	L0_6.flag_rs_apply = true
end
function core_setup_get_mode()
	local L0_7, L1_8, L2_9, L3_10, L4_11, L5_12
	L0_7 = Application
	L0_7 = L0_7.render_settings_filename
	L0_7 = L0_7(L1_8)
	if L1_8 then
		for L4_11 in L1_8(L2_9) do
			L5_12 = L4_11.name
			L5_12 = L5_12(L4_11)
			if L5_12 == "d3d_device" then
				L5_12 = nil
				if Application:render_settings_dirty() then
					L5_12 = core_setup_auto_detect_resolution()
				else
					L5_12 = math.string_to_vector(L4_11:parameter("resolution"))
				end
				L5_12 = Vector3(L5_12.x, L5_12.y, tonumber(L4_11:parameter("refresh_rate")))
				return L5_12, L4_11:parameter("windowed") == "false"
			end
		end
	end
	return L1_8, L2_9
end
function core_setup_auto_detect_resolution()
	local L0_13, L1_14, L2_15, L3_16
	L0_13 = SystemInfo
	L1_14 = L0_13
	L0_13 = L0_13.desktop_resolution
	L0_13 = L0_13(L1_14)
	L1_14 = L0_13.x
	L2_15 = L0_13.y
	L1_14 = L1_14 * L2_15
	L2_15 = math
	L2_15 = L2_15.huge
	L3_16 = RenderSettings
	L3_16 = L3_16.resolution
	for 