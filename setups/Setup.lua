require("CoreModuleOverrides")
require("core/setups/CoreNanoSetup")
core_nano_setup.init()
require("managers/SyncScreenManager")
SyncScreenManager.preload()
require("core/setups/CoreSetup")
require("managers/LocalizationManager")
require("game/GameTransition")
require("game/Game")
base_require("TweakData", nil, "RELEASE")
tweak_data = not TweakData.RELOAD and tweak_data or TweakData:new()
base_require("world/Stage", nil, "RELEASE")
base_require("Base", nil, "RELEASE")
base_require("managers/ControllerWrapper", nil, "RELEASE")
base_require("managers/ControllerWrapperGamepad", nil, "RELEASE")
base_require("managers/SequenceManager", nil, "RELEASE")
base_require("managers/VolumeManager", nil, "RELEASE")
base_require("units/UnitDamage", nil, "RELEASE")
base_require("units/BodyDamage", nil, "RELEASE")
base_require("units/AfroBodyDamage", nil, "RELEASE")
base_require("units/attachment/Attachment", nil, "RELEASE")
base_require("units/beings/TargetingInfo", nil, "RELEASE")
base_require("units/beings/VisibilityQuery", nil, "RELEASE")
base_require("units/UnitCamera", nil, "RELEASE")
base_require("units/UnitCameraControllerInterpreter", nil, "RELEASE")
base_require("units/data/PlayerData", nil, "RELEASE")
base_require("units/data/WeaponData", nil, "RELEASE")
base_require("units/data/AiEditorData", nil, "RELEASE")
base_require("units/data/DamageData", nil, "RELEASE")
base_require("units/data/EnemyData", nil, "RELEASE")
base_require("units/affectors/Explosion", nil, "RELEASE")
base_require("units/interact/Interactable", nil, "RELEASE")
base_require("units/interact/Pickup", nil, "RELEASE")
base_require("units/interact/StationaryWeaponEntry", nil, "RELEASE")
base_require("units/interact/InteractQuery", nil, "RELEASE")
base_require("units/interact/PlayerControlInteractQuery", nil, "RELEASE")
base_require("units/UnitMaterials", nil, "RELEASE")
base_require("units/UnitRumble", nil, "RELEASE")
require("shared/camera/CameraManager")
require("shared/camera/CameraRoot")
require("shared/camera/CameraData")
require("shared/camera/TransformCamera")
require("shared/camera/PositionOnlyCamera")
require("shared/camera/CollisionCamera")
require("shared/camera/WorldCameraMover")
require("shared/camera/BlendCamera")
require("shared/camera/UnitLinkCamera")
require("shared/camera/DynamicDistanceDofCamera")
require("shared/camera/StaticDistanceDofCamera")
require("shared/camera/TargetCameraNode")
require("shared/camera/KeepActivationPositionCamera")
require("shared/camera/KeepActivationRotationCamera")
require("shared/camera/FovCamera")
require("units/beings/player/new_gui/NewPlayerHud")
require("menu/ingame/IngameGui")
require("cameras/SpringCamera")
require("cameras/DofCamera")
require("cameras/DirectAimCamera")
require("cameras/SwitchCamera")
require("cameras/RotatingCamera")
require("cameras/MovingCamera")
require("units/UnitDrama")
require("units/UnitDynamicDialog")
require("player_slot/PlayerSlotManager")
require("local_user/LocalUserManager")
if SystemInfo:platform() == "X360" then
	base_require("managers/ControllerWrapperXbox360", nil, "RELEASE")
	require("local_user/detector/xbox360/Xbox360UserDetector")
elseif SystemInfo:platform() == "WIN32" then
	require("user/pc/PcUserIdHandler")
	base_require("managers/ControllerWrapperPC", nil, "RELEASE")
	require("local_user/detector/pc/PcControllerUserDetector")
elseif SystemInfo:platform() == "PS3" then
	require("local_user/detector/ps3/Ps3UserDetector")
end
require("session/SessionManager")
require("units/beings/machines/MachinesSetup")
require("units/beings/player/PlayerSetup")
require("units/beings/WeaponLogic/InstantFiringWeaponLogic")
require("units/beings/WeaponLogic/DelayedFiringWeaponLogic")
require("units/beings/WeaponLogic/DelayedFiringWeaponLogicSetup")
base_require("cover/UnitCover", nil, "RELEASE")
base_require("managers/WorldManager", nil, "RELEASE")
base_require("managers/BenchmarkManager", nil, "RELEASE")
base_require("managers/EnvironmentAreaManager", nil, "RELEASE")
base_require("managers/SoundEnvironmentManager", nil, "RELEASE")
base_require("managers/SplittableViewportManager", nil, "RELEASE")
base_require("managers/SlotManager", nil, "RELEASE")
base_require("managers/PortalManager", nil, "RELEASE")
base_require("managers/RumbleManager", nil, "RELEASE")
base_require("managers/RumbleActionEventManager", nil, "RELEASE")
base_require("managers/ProjectileManager", nil, "RELEASE")
base_require("managers/DecalManager", nil, "RELEASE")
base_require("managers/AIGraphManager", nil, "RELEASE")
base_require("managers/NetworkManager", nil, "RELEASE")
base_require("managers/PlayerManager", nil, "RELEASE")
base_require("managers/TutorialManager", nil, "RELEASE")
base_require("managers/TankDisplayManager", nil, "RELEASE")
base_require("managers/LocalizerMappingManager", nil, "RELEASE")
base_require("managers/UnitScriptingManager", nil, "RELEASE")
base_require("managers/PostUpdateManager", nil, "RELEASE")
base_require("shared/updatescheduler/UpdateScheduler", nil, "RELEASE")
base_require("units/data/ScriptUnitData", nil, "RELEASE")
base_require("debug/DebugInfo", nil, "RELEASE")
base_require("utils/dev/editor/WorldDefinition", nil, "RELEASE")
base_require("utils/dev/tools/WorldEditor", nil, "DEBUG")
base_require("utils/dev/tools/EnvEditor", nil, "DEBUG")
base_require("utils/dev/ActorEditor", nil, "DEBUG")
base_require("utils/dev/UnitTest", nil, "DEBUG")
base_require("player_slot/PlayerSlotManager", nil, "RELEASE")
base_require("managers/WorldCameraManager", nil, "RELEASE")
base_require("managers/CutsceneManager", nil, "RELEASE")
base_require("managers/ProfilerManager", nil, "DEBUG")
require("managers/LocalizerManager")
require("managers/DramaSceneManager")
require("setups/Milestone0402Setup")
require("ai/AiSetup")
require("ai/AiManager")
require("network/control/UnitControlIdManager")
require("setups/SensoryEventManagerSetup")
require("managers/SensoryEventManager")
require("network/replay/ReplayManager")
require("units/beings/CharacterControllerInterpreter/CharacterControllerInterpreterManager")
require("debug/DebugSettings")
require("managers/DamageDefenseMaterialManager")
require("managers/OwnershipManager")
require("managers/DynamicDialogManager")
require("shared/aimer/InstantBulletAimer")
require("shared/aimer/BallisticProjectileAimer")
require("managers/SceneTriggerManager")
require("managers/MenuTriggerManager")
require("menu/ingame/IngameGui")
require("menu/2D/Menu2DManager")
require("managers/MenuInputManager")
require("managers/OptionSettingsManager")
require("managers/SyncedSoundManager")
require("managers/UnitFrequencyManager")
base_require("units/weapons/BaseWeapon", nil, "RELEASE")
base_require("units/weapons/BikerWeaponEffects", nil, "RELEASE")
base_require("units/weapons/PlayerBaseWeapon", nil, "RELEASE")
base_require("units/weapons/M4Carbine", nil, "RELEASE")
base_require("units/weapons/R870Shotgun", nil, "RELEASE")
base_require("units/weapons/M249Machinegun", nil, "RELEASE")
base_require("units/weapons/M79Grenadelauncher", nil, "RELEASE")
base_require("units/weapons/GenericWeapon", nil, "RELEASE")
base_require("units/weapons/MagneticChargeWeapon", nil, "RELEASE")
base_require("units/weapons/T100Weapon", nil, "RELEASE")
base_require("units/weapons/GrenadeThrower", nil, "RELEASE")
base_require("units/weapons/WeaponLight", nil, "RELEASE")
base_require("units/weapons/MiniGun", nil, "RELEASE")
base_require("units/weapons/FireLogic", nil, "RELEASE")
base_require("units/weapons/FireLogicPowerUp", nil, "RELEASE")
base_require("units/weapons/FlyerWeapon", nil, "RELEASE")
base_require("units/weapons/FlyerWeaponEffects", nil, "RELEASE")
base_require("units/weapons/GenericProjectileWeapon", nil, "RELEASE")
base_require("units/weapons/HunterKillerWeaponEffects", nil, "RELEASE")
base_require("units/weapons/RPG7GrenadeLauncher", nil, "RELEASE")
base_require("units/weapons/TankWeaponSecondary", nil, "RELEASE")
base_require("units/weapons/TankWeaponEffects", nil, "RELEASE")
base_require("units/weapons/HarvesterWeapon", nil, "RELEASE")
base_require("units/weapons/Turret", nil, "RELEASE")
base_require("units/interact/AmmoBox", nil, "RELEASE")
base_require("projectile/InstantBulletSpawner", nil, "RELEASE")
base_require("projectile/InstantShellSpawner", nil, "RELEASE")
base_require("projectile/PointUnitProjectile", nil, "RELEASE")
base_require("projectile/SelfPropelledUnitProjectile", nil, "RELEASE")
base_require("projectile/UnitProjectileSpawner", nil, "RELEASE")
base_require("projectile/UnitProjectile", nil, "RELEASE")
base_require("projectile/magnetic_charge/MagneticCharge", nil, "RELEASE")
base_require("projectile/magnetic_charge/MagneticChargeDamage", nil, "RELEASE")
base_require("projectile/magnetic_charge/MagneticChargeAttachment", nil, "RELEASE")
base_require("projectile/magnetic_charge/MagneticChargeEffects", nil, "RELEASE")
require("viewport/UserViewportManager")
require("viewport/EnvironmentScriptViewport")
require("world/WorldInfoManager")
require("storage/SaveManager")
require("shared/action_event/ActionEventManager")
require("shared/scheduler/Scheduler")
require("debug/DebugAiOrder")
require("setups/RailSetup")
base_require("menu/Menu", nil, "RELEASE")
script_data = script_data or {}
unit_test = unit_test or {}
preload = preload or {}
pre_render_callback_map = pre_render_callback_map or {}
last_pre_render_callback_id = last_pre_render_callback_id or 0
Global.player_gravity = Vector3(0, 0, -1150)
Global.category_debug_render = Global.category_debug_render or {}
function setup_debug_variables()
	local L0_0, L1_1
	L0_0 = script_debug
	L0_0.c = true
	L0_0 = script_debug
	L0_0.render_overlay = true
	L0_0 = script_debug
	L0_0.debug_loop = 0
	L0_0 = script_debug
	L0_0.draw_enabled = false
	L0_0 = script_debug
	L0_0.mindprobe_unit = nil
	L0_0 = script_debug
	L0_0.draw_gunfx = true
	L0_0 = script_debug
	L0_0.brightscale = 1
	L0_0 = script_debug
	L0_0.aircam = "aircam"
	L0_0 = script_debug
	L0_0.aircamparam = nil
	L0_0 = script_debug
	L0_0.ghost = false
	L0_0 = script_debug
	L0_0.render_world = true
end
function setup_script_data()
	local L0_2, L1_3
	L0_2 = script_data
	L1_3 = {}
	L0_2.hub_elements = L1_3
	L0_2 = script_data
	L1_3 = {}
	L0_2.bionic_units = L1_3
	L0_2 = script_data
	L1_3 = {}
	L0_2.profiles = L1_3
	L0_2 = script_data
	L0_2.active_profile = nil
	L0_2 = script_data
	L1_3 = {}
	L0_2.dynamic_aigraphs = L1_3
	L0_2 = script_data
	L0_2.last_thrown_grenade = 0
	L0_2 = script_data
	L1_3 = {}
	L0_2.usable_ext = L1_3
end
function getspy()
	local L1_4
	L1_4 = managers
	L1_4 = L1_4.luaspy
	return L1_4
end
debug_setup = debug_setup or class()
function debug_setup.init(A0_5)
	A0_5._debug_settings = DebugSettings:new("data/settings/debug_settings.xml")
	A0_5._debug_info = DebugInfo:new()
end
function debug_setup.update(A0_6, A1_7, A2_8)
	if script_debug._freeflight then
		script_debug._freeflight:update(A1_7, A2_8)
	end
	A0_6._debug_settings:update(A2_8)
	A0_6._debug_info:update(A2_8)
end
function debug_setup.paused_update(A0_9, A1_10, A2_11)
	A0_9:update(A1_10, A2_11)
end
setup = setup or {}
function setup.set_fixed_timestep()
	Application:set_forced_timestep(1 / setup.fps)
	Application:cap_framerate(setup.fps)
end
function setup.pre_init()
	local L0_12, L1_13
end
function setup.post_init()
	local L0_14, L1_15
end
setup.fps = 30
function setup.init()
	local L0_16, L1_17, L2_18, L3_19, L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26, L11_27
	L0_16 = World
	L0_16 = L0_16.set_raycast_bounds
	L4_20 = -80000
	L5_21 = -20000
	L4_20 = 90000
	L5_21 = 50000
	L6_22 = 30000
	L11_27 = L3_19(L4_20, L5_21, L6_22)
	L0_16(L1_17, L2_18, L3_19, L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26, L11_27, L3_19(L4_20, L5_21, L6_22))
	L0_16 = World
	L0_16 = L0_16.load
	L0_16(L1_17, L2_18)
	L0_16 = core_setup
	L0_16 = L0_16.init
	L0_16()
	L0_16 = managers
	L0_16.sync_screen = L1_17
	L0_16 = Global
	L0_16 = L0_16.has_shown_startup_sync_screen
	if not L0_16 then
		L0_16 = managers
		L0_16 = L0_16.sync_screen
		L0_16 = L0_16.setup_startup_sync_screen
		L0_16(L1_17)
		L0_16 = managers
		L0_16 = L0_16.sync_screen
		L0_16 = L0_16.start_sync_screen
		L0_16(L1_17)
		L0_16 = Global
		L0_16.has_shown_startup_sync_screen = true
	end
	L0_16 = Application
	L0_16 = L0_16.load_global_material_manager
	L0_16(L1_17)
	L0_16 = LocalizationManager
	L0_16 = L0_16.add_default_macros
	L0_16()
	L0_16 = SystemInfo
	L0_16 = L0_16.platform
	L0_16 = L0_16(L1_17)
	if L0_16 == "PS3" then
		L4_20 = "trophies_err_installation"
		L4_20 = L3_19
		L5_21 = "trophies_err_insufficient_disk_space"
		L4_20 = Trophies
		L5_21 = L4_20
		L4_20 = L4_20.set_translation_text
		L6_22 = L1_17
		L4_20(L5_21, L6_22, L7_23, L8_24)
	end
	if L0_16 == "X360" then
		L1_17(L2_18, L3_19)
	end
	L1_17.unit_scripting = L2_18
	L4_20 = 22
	L1_17(L2_18, L3_19, L4_20)
	L1_17.update_scheduler = L2_18
	for L4_20, L5_21 in L1_17(L2_18) do
		L6_22 = managers
		L6_22 = L6_22.update_scheduler
		L6_22 = L6_22.add_group
		L6_22(L7_23, L8_24, L9_25)
	end
	L1_17()
	L1_17()
	L1_17()
	L4_20 = TimerManager
	L5_21 = L4_20
	L4_20 = L4_20.game
	L11_27 = L4_20(L5_21)
	L1_17(L2_18, L3_19, L4_20, L5_21, L6_22, L7_23, L8_24, L9_25, L10_26, L11_27, L4_20(L5_21))
	L1_17._main_timer = L2_18
	L1_17.world_info = L2_18
	L1_17.action_event = L2_18
	L4_20 = "unit_detected_threat"
	L5_21 = "unit_hurt"
	L6_22 = "unit_scan_enter"
	L10_26 = "unit_fully_damaged"
	L11_27 = "human_character_entered_idle"
	L4_20 = L1_17
	L2_18(L3_19, L4_20)
	L4_20 = L3_19
	L2_18.unit_control_id = L3_19
	L2_18()
	L4_20 = L3_19
	L2_18.rumble = L3_19
	L4_20 = L3_19
	L2_18.rumble_aem = L3_19
	L4_20 = L3_19
	L2_18.cover = L3_19
	L4_20 = L3_19
	L2_18.cover_util = L3_19
	L4_20 = L3_19
	L2_18.projectile_manager = L3_19
	L4_20 = L3_19
	L2_18.decal_manager = L3_19
	L4_20 = L3_19
	L2_18.replay = L3_19
	L4_20 = L3_19
	L2_18.scene_trigger = L3_19
	L4_20 = L3_19
	L2_18.menu_trigger = L3_19
	L4_20 = L3_19
	L2_18.dynamic_music = L3_19
	L4_20 = L3_19
	L2_18.dynamic_dialog = L3_19
	L4_20 = "settings/default_controls.xml"
	L2_18(L3_19, L4_20)
	L2_18(L3_19)
	L4_20 = L3_19
	L2_18.ai = L3_19
	L4_20 = L3_19
	L2_18.ai_graph = L3_19
	L2_18()
	L2_18(L3_19)
	L4_20 = L3_19
	L2_18.sensory_events = L3_19
	L2_18(L3_19)
	L4_20 = L3_19
	L2_18.player = L3_19
	L4_20 = L3_19
	L2_18.tutorial = L3_19
	L4_20 = L3_19
	L2_18.tank_display = L3_19
	L4_20 = L3_19
	L2_18.localizer_mapping = L3_19
	L4_20 = L3_19
	L2_18.post_update_manager = L3_19
	L4_20 = L3_19
	L2_18.damage_defense_material = L3_19
	L4_20 = L3_19
	L2_18.ownership = L3_19
	L4_20 = L3_19
	L2_18.director = L3_19
	L4_20 = L3_19
	L5_21 = "level_02"
	L2_18.drama_scene = L3_19
	L4_20 = "default"
	L2_18(L3_19, L4_20)
	L4_20 = "default"
	L2_18(L3_19, L4_20)
	L4_20 = L3_19
	L2_18.unit_frequency = L3_19
	L4_20 = L3_19
	L2_18.synced_sound = L3_19
	L2_18()
	if L2_18 == true then
		L4_20 = "setup.init(): ToolHub online."
		L2_18(L3_19, L4_20)
		L2_18(L3_19)
		if L2_18 then
			L2_18(L3_19)
		end
	else
		L4_20 = "setup.init(): ToolHub offline, no EWS active."
		L2_18(L3_19, L4_20)
	end
	if L2_18 then
		L4_20 = _G
		L5_21 = "WorldEditor"
		if not L3_19 then
			L4_20 = _G
			L5_21 = "CoreEditor"
		end
		L4_20 = L3_19
		L2_18.editor = L3_19
		L2_18(L3_19)
	end
	L4_20 = _G
	L5_21 = "ProfilerManager"
	if L3_19 then
		L4_20 = ProfilerManager
		L5_21 = L4_20
		L4_20 = L4_20.new
		L4_20 = L4_20(L5_21)
		L3_19.profiler = L4_20
	end
	L4_20 = Global
	L4_20 = L4_20.transition_data
	if L4_20 then
		L4_20 = Global
	else
		L4_20 = {}
		L4_20 = {}
		L3_19.game_transition = L4_20
		L4_20 = GameTransition
		L4_20 = L4_20.default_data
		L5_21 = L3_19.game_transition
		L4_20(L5_21)
		L4_20 = {}
		L3_19.game = L4_20
		L4_20 = Game
		L4_20 = L4_20.default_data
		L5_21 = L3_19.game
		L4_20(L5_21)
		L4_20 = {}
		L3_19.local_user = L4_20
		L4_20 = LocalUserManager
		L4_20 = L4_20.default_data
		L5_21 = L3_19.local_user
		L4_20(L5_21)
		L4_20 = {}
		L3_19.player_slot = L4_20
		L4_20 = PlayerSlotManager
		L4_20 = L4_20.default_data
		L5_21 = L3_19.player_slot
		L4_20(L5_21)
		L4_20 = {}
		L3_19.menu_input = L4_20
		L4_20 = MenuInputManager
		L4_20 = L4_20.default_data
		L5_21 = L3_19.menu_input
		L4_20(L5_21)
		L4_20 = {}
		L3_19.user_detector = L4_20
		L4_20 = SystemInfo
		L5_21 = L4_20
		L4_20 = L4_20.platform
		L4_20 = L4_20(L5_21)
		if L4_20 == "X360" then
			L5_21 = Xbox360UserDetector
			L5_21 = L5_21.default_data
			L6_22 = L3_19.user_detector
			L5_21(L6_22)
		elseif L4_20 == "WIN32" then
			L5_21 = PcControllerUserDetector
			L5_21 = L5_21.default_data
			L6_22 = L3_19.user_detector
			L5_21(L6_22)
		elseif L4_20 == "PS3" then
			L5_21 = Ps3UserDetector
			L5_21 = L5_21.default_data
			L6_22 = L3_19.user_detector
			L5_21(L6_22)
		end
		L5_21 = {}
		L3_19.save = L5_21
		L5_21 = SaveManager
		L5_21 = L5_21.default_data
		L6_22 = L3_19.save
		L5_21(L6_22)
		L5_21 = {}
		L3_19.local_session_user = L5_21
		L5_21 = LocalSessionUserManager
		L5_21 = L5_21.default_data
		L6_22 = L3_19.local_session_user
		L5_21(L6_22)
		L5_21 = {}
		L3_19.menu = L5_21
		L5_21 = Menu
		L5_21 = L5_21.default_data
		L6_22 = L3_19.menu
		L5_21(L6_22)
	end
	L4_20 = managers
	L5_21 = GameTransition
	L6_22 = L5_21
	L5_21 = L5_21.new
	L5_21 = L5_21(L6_22, L7_23)
	L4_20.game_transition = L5_21
	L4_20 = managers
	L5_21 = LocalUserManager
	L6_22 = L5_21
	L5_21 = L5_21.new
	L5_21 = L5_21(L6_22, L7_23)
	L4_20.local_user = L5_21
	L4_20 = managers
	L5_21 = Game
	L6_22 = L5_21
	L5_21 = L5_21.new
	L5_21 = L5_21(L6_22, L7_23)
	L4_20.game = L5_21
	L4_20 = managers
	L5_21 = PlayerSlotManager
	L6_22 = L5_21
	L5_21 = L5_21.new
	L5_21 = L5_21(L6_22, L7_23)
	L4_20.player_slot = L5_21
	L4_20 = managers
	L5_21 = MenuInputManager
	L6_22 = L5_21
	L5_21 = L5_21.new
	L5_21 = L5_21(L6_22, L7_23)
	L4_20.menu_input = L5_21
	L4_20 = managers
	L5_21 = Scheduler
	L6_22 = L5_21
	L5_21 = L5_21.new
	L5_21 = L5_21(L6_22)
	L4_20.scheduler = L5_21
	L4_20 = SystemInfo
	L5_21 = L4_20
	L4_20 = L4_20.platform
	L4_20 = L4_20(L5_21)
	if L4_20 == "X360" then
		L5_21 = setup
		L6_22 = Xbox360UserDetector
		L6_22 = L6_22.new
		L6_22 = L6_22(L7_23, L8_24)
		L5_21.user_detector = L6_22
	elseif L4_20 == "WIN32" then
		L5_21 = setup
		L6_22 = PcControllerUserDetector
		L6_22 = L6_22.new
		L6_22 = L6_22(L7_23, L8_24)
		L5_21.user_detector = L6_22
	elseif L4_20 == "PS3" then
		L5_21 = setup
		L6_22 = Ps3UserDetector
		L6_22 = L6_22.new
		L6_22 = L6_22(L7_23, L8_24)
		L5_21.user_detector = L6_22
	end
	L5_21 = managers
	L6_22 = SaveManager
	L6_22 = L6_22.new
	L6_22 = L6_22(L7_23, L8_24)
	L5_21.save = L6_22
	L5_21 = managers
	L6_22 = LocalSessionUserManager
	L6_22 = L6_22.new
	L6_22 = L6_22(L7_23, L8_24)
	L5_21.local_session_user = L6_22
	L5_21 = managers
	L6_22 = Menu2DManager
	L6_22 = L6_22.new
	L6_22 = L6_22(L7_23)
	L5_21.menu2d = L6_22
	L5_21 = managers
	L5_21 = L5_21.menu2d
	L6_22 = L5_21
	L5_21 = L5_21.post_init
	L5_21(L6_22)
	L5_21 = managers
	L6_22 = Menu
	L6_22 = L6_22.new
	L10_26 = L9_25
	L11_27 = L9_25(L10_26)
	L6_22 = L6_22(L7_23, L8_24, L9_25, L10_26, L11_27, L9_25(L10_26))
	L5_21.menu = L6_22
	L5_21 = managers
	L6_22 = OptionSettingsManager
	L6_22 = L6_22.new
	L6_22 = L6_22(L7_23)
	L5_21.settings = L6_22
	L5_21 = Global
	L5_21.transition_data = nil
	L5_21 = managers
	L5_21 = L5_21.save
	L6_22 = L5_21
	L5_21 = L5_21.has_primary_user
	L5_21 = L5_21(L6_22)
	if L5_21 then
		L5_21 = managers
		L5_21 = L5_21.save
		L6_22 = L5_21
		L5_21 = L5_21.profile
		L5_21 = L5_21(L6_22)
		L6_22 = assert
		L6_22(L7_23)
		L6_22 = tweak_data
		L6_22 = L6_22.set_difficulty
		L6_22(L7_23, L8_24)
		L6_22 = managers
		L6_22 = L6_22.local_user
		L6_22 = L6_22.users
		L6_22 = L6_22(L7_23)
		for L10_26, L11_27 in L7_23(L8_24) do
			if L11_27:is_playing_the_game() then
				managers.save:load_controller_settings(L11_27)
			end
		end
	end
	L5_21 = IngameGui
	L5_21 = L5_21._preload_textures
	L5_21()
	L5_21 = UserViewportManager
	L5_21 = L5_21.preload
	L5_21()
	L5_21 = Global
	L5_21 = L5_21.level_info
	if not L5_21 then
		L5_21 = Application
		L6_22 = L5_21
		L5_21 = L5_21.debug_build
		L5_21 = L5_21(L6_22)
	elseif L5_21 then
		L5_21 = setup
		L6_22 = debug_setup
		L6_22 = L6_22.new
		L6_22 = L6_22(L7_23)
		L5_21._debug = L6_22
	end
	L5_21 = setup
	L5_21 = L5_21.wait_for_sync_screen_to_fade
	L5_21()
end
function setup.wait_for_sync_screen_to_fade()
	local L0_28
	L0_28 = 0.01
	while managers.sync_screen:is_showing_sync_screen() do
		managers.sync_screen:update(L0_28)
		managers.game:update(L0_28)
		managers.menu2d:update(L0_28)
		managers.menu:update(L0_28)
		if managers.game:is_loading_done() and not false then
			setup.post_loading()
		end
	end
end
function setup.post_loading()
	core_setup.post_init()
end
function setup.exec()
	local L0_29, L1_30, L2_31, L3_32, L4_33
	L0_29 = Application
	L1_30 = L0_29
	L0_29 = L0_29.editor
	L0_29 = L0_29(L1_30)
	if L0_29 then
		return
	end
	L0_29 = managers
	L0_29 = L0_29.sync_screen
	L1_30 = L0_29
	L0_29 = L0_29.start_sync_screen
	L0_29(L1_30)
	L0_29 = Global
	L1_30 = {}
	L0_29.transition_data = L1_30
	L0_29 = Global
	L0_29 = L0_29.transition_data
	L1_30 = {}
	L0_29.game_transition = L1_30
	L1_30 = managers
	L1_30 = L1_30.game_transition
	L2_31 = L1_30
	L1_30 = L1_30.save
	L3_32 = L0_29.game_transition
	L1_30(L2_31, L3_32)
	L1_30 = {}
	L0_29.game = L1_30
	L1_30 = managers
	L1_30 = L1_30.game
	L2_31 = L1_30
	L1_30 = L1_30.save
	L3_32 = L0_29.game
	L1_30(L2_31, L3_32)
	L1_30 = {}
	L0_29.local_user = L1_30
	L1_30 = managers
	L1_30 = L1_30.local_user
	L2_31 = L1_30
	L1_30 = L1_30.save
	L3_32 = L0_29.local_user
	L1_30(L2_31, L3_32)
	L1_30 = {}
	L0_29.player_slot = L1_30
	L1_30 = managers
	L1_30 = L1_30.player_slot
	L1_30 = L1_30.default_data
	L2_31 = L0_29.player_slot
	L1_30(L2_31)
	L1_30 = {}
	L0_29.menu_input = L1_30
	L1_30 = managers
	L1_30 = L1_30.menu_input
	L2_31 = L1_30
	L1_30 = L1_30.save
	L3_32 = L0_29.menu_input
	L1_30(L2_31, L3_32)
	L1_30 = {}
	L0_29.user_detector = L1_30
	L1_30 = setup
	L1_30 = L1_30.user_detector
	L2_31 = L1_30
	L1_30 = L1_30.save
	L3_32 = L0_29.user_detector
	L1_30(L2_31, L3_32)
	L1_30 = {}
	L0_29.save = L1_30
	L1_30 = managers
	L1_30 = L1_30.save
	L2_31 = L1_30
	L1_30 = L1_30.save
	L3_32 = L0_29.save
	L1_30(L2_31, L3_32)
	L1_30 = {}
	L0_29.local_session_user = L1_30
	L1_30 = managers
	L1_30 = L1_30.local_session_user
	L1_30 = L1_30.default_data
	L2_31 = L0_29.local_session_user
	L1_30(L2_31)
	L1_30 = {}
	L0_29.menu = L1_30
	L1_30 = managers
	L1_30 = L1_30.menu
	L2_31 = L1_30
	L1_30 = L1_30.save
	L3_32 = L0_29.menu
	L1_30(L2_31, L3_32)
	L1_30 = nil
	L2_31 = managers
	L2_31 = L2_31.game_transition
	L3_32 = L2_31
	L2_31 = L2_31.wants_to_go_to_frontend
	L2_31 = L2_31(L3_32)
	if not L2_31 then
		L2_31 = managers
		L2_31 = L2_31.save
		L3_32 = L2_31
		L2_31 = L2_31.has_primary_user
		L2_31 = L2_31(L3_32)
		if L2_31 then
			L2_31 = managers
			L2_31 = L2_31.save
			L3_32 = L2_31
			L2_31 = L2_31.profile
			L2_31 = L2_31(L3_32)
			L3_32 = assert
			L4_33 = L2_31
			L3_32(L4_33)
			L3_32 = L2_31.debug_level_name
			if L3_32 then
				L1_30 = L2_31.debug_level_name
			else
				L3_32 = L2_31.current_level_id
				L4_33 = assert
				L4_33(L3_32)
				L4_33 = managers
				L4_33 = L4_33.world_info
				L4_33 = L4_33.info_from_id
				L4_33 = L4_33(L4_33, L3_32)
				assert(L4_33, "Level:" .. tostring(L3_32) .. " missing")
				L1_30 = L4_33.name
			end
			L3_32 = assert
			L4_33 = L1_30
			L3_32(L4_33, "We need a level name to load a level")
		end
	end
	L2_31 = setup
	L2_31.exec_level_name = L1_30
end
function setup.do_exec()
	if managers.session then
		managers.session:destroy()
		managers.session = nil
	end
	if managers.menu2d then
		managers.menu2d:destroy()
		managers.menu2d = nil
	end
	if managers.menu then
		managers.menu:destroy()
		managers.menu = nil
	end
	cat_print("debug", "")
	cat_print("debug", "")
	cat_print("debug", "")
	cat_print("debug", "******************************************************* EXEC() *************************************************************")
	Application:exec("lib/setups/Setup", setup.exec_level_name)
end
function setup.update(A0_34, A1_35)
	local L2_36
	L2_36 = setup
	L2_36 = L2_36._main_timer
	L2_36 = L2_36.delta_time
	L2_36 = L2_36(L2_36)
	if not managers.viewport.__update then
		managers.viewport.__update = managers.viewport.update
		function managers.viewport.update()
			local L0_37, L1_38
		end
	end
	core_setup.update(A0_34, A1_35)
	setup._common_update(A0_34, A1_35, L2_36)
	managers.update_scheduler:update(A1_35)
	managers.cover:update()
	managers.unit_scripting:update(A0_34, A1_35)
	managers.player_slot:update()
	if managers.world then
		managers.world:update(A0_34, A1_35)
	end
	managers.action_event:update(A0_34, A1_35)
	managers.director:update(A0_34, A1_35)
	managers.ai:update(A0_34, A1_35)
	managers.ai_graph:update(A0_34, A1_35)
	managers.camera:update(A0_34, A1_35)
	managers.sensory_events:update(A0_34, A1_35)
	managers.replay:update()
	managers.dynamic_music:update(A1_35)
	managers.drama_scene:update(A1_35)
	setup.user_detector:update()
	update_tickets()
	managers.dynamic_dialog:update(A1_35)
	managers.scheduler:update(A1_35)
	managers.sync_screen:update(A1_35)
end
function setup.end_update(A0_39, A1_40)
	managers.projectile_manager:update(A0_39, A1_40)
	managers.decal_manager:update(A0_39, A1_40)
	core_setup.end_update(A0_39, A1_40)
end
function setup.paused_end_update(A0_41, A1_42)
	core_setup.paused_end_update(A0_41, A1_42)
end
function setup._update_managers_not_related_to_game(A0_43, A1_44)
	if managers.editor then
		managers.editor:update(A0_43, A1_44)
	end
	if setup._debug then
		setup._debug:update(A0_43, A1_44)
	end
	if managers.profiler then
		managers.profiler:update(A1_44)
	end
end
function setup._common_update(A0_45, A1_46, A2_47)
	setup._always_update(A0_45, A1_46, A2_47)
	if managers.session then
		managers.session:update(A0_45, A1_46)
	end
	managers.settings:update(A0_45, A1_46)
	setup._exec_update()
end
function setup._always_update(A0_48, A1_49, A2_50)
	setup._update_managers_not_related_to_game(A0_48, A1_49)
	managers.game:update(A1_49)
	managers.menu:update(A2_50)
	managers.menu2d:update(A2_50)
	managers.local_user:update(A1_49)
end
function setup._exec_update()
	if managers.game_transition:wants_to_exec() then
		setup.exec()
	end
end
function setup.paused_update(A0_51, A1_52)
	local L2_53
	L2_53 = setup
	L2_53 = L2_53._main_timer
	L2_53 = L2_53.delta_time
	L2_53 = L2_53(L2_53)
	if not managers.viewport.__update then
		managers.viewport.__update = managers.viewport.update
		function managers.viewport.update()
			local L0_54, L1_55
		end
	end
	if managers.game:is_frozen() then
		core_setup.paused_update(A0_51, A1_52)
		setup._always_update(A0_51, A1_52, L2_53)
		setup._exec_update()
	else
		core_setup.paused_update(A0_51, A1_52)
		setup._common_update(A0_51, A1_52, L2_53)
	end
end
function setup.add_pre_render_callback(A0_56)
	local L1_57
	L1_57 = last_pre_render_callback_id
	L1_57 = L1_57 + 1
	last_pre_render_callback_id = L1_57
	L1_57 = pre_render_callback_map
	L1_57[last_pre_render_callback_id] = A0_56
	L1_57 = last_pre_render_callback_id
	return L1_57
end
function setup.remove_pre_render_callback(A0_58)
	pre_render_callback_map[A0_58] = nil
end
function setup.render()
	local L0_59, L1_60, L2_61, L3_62, L4_63, L5_64, L6_65
	L0_59 = Global
	L0_59 = L0_59.shows_sync_screen
	if not L0_59 then
		L0_59 = Global
		L0_59 = L0_59.inhibit_all_rendering
		if not L0_59 then
			L0_59 = managers
			L0_59 = L0_59.worldcamera
			L1_60 = L0_59
			L0_59 = L0_59.current_world_camera
			L0_59 = L0_59(L1_60)
			L1_60 = script_debug
			L1_60 = L1_60._freeflight
			if L1_60 then
				L1_60 = script_debug
				L1_60 = L1_60._freeflight
				L1_60 = L1_60.in_focus
				L1_60 = L1_60(L2_61)
			end
			if L2_61 and not L1_60 and not L0_59 then
				L2_61(L3_62)
			elseif L2_61 then
				L2_61(L3_62)
			end
			L2_61(L3_62)
			L2_61()
			L2_61(L3_62)
			L2_61(L3_62)
			for L5_64, L6_65 in L2_61(L3_62) do
				L6_65(L5_64)
			end
		end
	end
	L0_59 = managers
	L0_59 = L0_59.game_transition
	L1_60 = L0_59
	L0_59 = L0_59.wants_to_exec
	L0_59 = L0_59(L1_60)
	if L0_59 then
		L0_59 = setup
		L0_59 = L0_59.do_exec
		L0_59()
	end
end
function setup.save(A0_66)
	managers.sequence:save(A0_66)
	managers.area:save(A0_66)
end
function setup.load(A0_67)
	managers.sequence:load(A0_67)
	managers.area:load(A0_67)
end
function setup.destroy()
	core_setup.destroy()
end
function setup.setup_camera_manager()
	managers.camera = CameraManager:new()
	managers.camera:load_cameras("data/cameras/player_camera.xml")
	managers.camera:load_cameras("data/cameras/rail_vehicle_buggy.xml")
	managers.camera:load_cameras("data/cameras/rail_vehicle_pickup.xml")
	managers.camera:load_cameras("data/cameras/rail_vehicle_tank.xml")
	managers.camera:load_cameras("data/cameras/rail_subway_train.xml")
	managers.camera:load_cameras("data/cameras/unit_camera.xml")
end
function setup.setup_category_print()
	local L0_68
	L0_68 = Global
	L0_68 = L0_68.category_print_initialized
	L0_68 = L0_68.setup
	if L0_68 then
		return
	end
	L0_68 = core_setup
	L0_68 = L0_68.setup_category_print
	L0_68()
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.config_manager = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.gravity_manager = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.musicmanager = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.netman = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.volume_manager = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.ai = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.controls = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.editor = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.pickup_extension = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.spawn_system = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.tutorial = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.camera = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.grunt = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.wreckermecha = false
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.statemachine = true
	L0_68 = Global
	L0_68 = L0_68.category_print
	L0_68.debug = true
	L0_68 = setup
	L0_68 = L0_68.get_people_list
	L0_68 = L0_68()
	for 