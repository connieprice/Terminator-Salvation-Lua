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
if TweakData.RELOAD or not tweak_data then
	tweak_data = TweakData:new()
end
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
local l_0_0 = SystemInfo:platform()
if l_0_0 == "X360" then
	base_require("managers/ControllerWrapperXbox360", nil, "RELEASE")
	require("local_user/detector/xbox360/Xbox360UserDetector")
elseif l_0_0 == "WIN32" then
	require("user/pc/PcUserIdHandler")
	base_require("managers/ControllerWrapperPC", nil, "RELEASE")
	require("local_user/detector/pc/PcControllerUserDetector")
elseif l_0_0 == "PS3" then
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
if not script_data then
	script_data = {}
end
if not unit_test then
	unit_test = {}
end
if not preload then
	preload = {}
end
if not pre_render_callback_map then
	pre_render_callback_map = {}
end
last_pre_render_callback_id = last_pre_render_callback_id or 0
Global.player_gravity = Vector3(0, 0, -1150)
if not Global.category_debug_render then
	Global.category_debug_render = {}
end
setup_debug_variables = function()
		script_debug.c = true
		script_debug.render_overlay = true
		script_debug.debug_loop = 0
		script_debug.draw_enabled = false
		script_debug.mindprobe_unit = nil
		script_debug.draw_gunfx = true
		script_debug.brightscale = 1
		script_debug.aircam = "aircam"
		script_debug.aircamparam = nil
		script_debug.ghost = false
		script_debug.render_world = true
  end
setup_script_data = function()
	script_data.hub_elements = {}
	script_data.bionic_units = {}
	script_data.profiles = {}
	script_data.active_profile = nil
	script_data.dynamic_aigraphs = {}
	script_data.last_thrown_grenade = 0
	script_data.usable_ext = {}
end

getspy = function()
	return managers.luaspy
end

if not debug_setup then
	debug_setup = class()
end
debug_setup.init = function(l_4_0)
	l_4_0._debug_settings = DebugSettings:new("data/settings/debug_settings.xml")
	l_4_0._debug_info = DebugInfo:new()
end

debug_setup.update = function(l_5_0, l_5_1, l_5_2)
	if script_debug._freeflight then
		script_debug._freeflight:update(l_5_1, l_5_2)
	end
	l_5_0._debug_settings:update(l_5_2)
	l_5_0._debug_info:update(l_5_2)
end

debug_setup.paused_update = function(l_6_0, l_6_1, l_6_2)
	l_6_0:update(l_6_1, l_6_2)
end

if not setup then
	setup = {}
end
setup.set_fixed_timestep = function()
	local l_7_0 = not Application:editor()
	Application:set_forced_timestep(1 / setup.fps)
	Application:cap_framerate(setup.fps)
end

setup.pre_init = function()
end

setup.post_init = function()
end

setup.fps = 30
setup.init = function()
	World:set_raycast_bounds(Vector3(-50000, -80000, -20000), Vector3(90000, 50000, 30000))
	World:load("/data/levels/zone.xml")
	core_setup.init()
	managers.sync_screen = SyncScreenManager:new()
	if not Global.has_shown_startup_sync_screen then
		managers.sync_screen:setup_startup_sync_screen()
		managers.sync_screen:start_sync_screen()
		Global.has_shown_startup_sync_screen = true
	end
	Application:load_global_material_manager()
	LocalizationManager.add_default_macros()
	local l_10_0 = SystemInfo:platform()
	if l_10_0 == "PS3" then
		local l_10_1 = managers.localization:text("trophies_loading_msg")
		local l_10_2 = managers.localization:text("trophies_err_installation")
		local l_10_3 = managers.localization:text("trophies_err_insufficient_disk_space")
		local l_10_8, l_10_9 = Trophies:set_translation_text, Trophies
		l_10_8(l_10_9, l_10_1, l_10_2, l_10_3)
	end
	if l_10_0 == "X360" then
		XboxLive:set_notify_position("top_center")
	end
	managers.unit_scripting = UnitScriptingManager:new()
	local l_10_7 = managers.subtitle:_presenter():set_font
	l_10_7(managers.subtitle:_presenter(), "faith_font_22", 22)
	l_10_7 = managers
	l_10_7.update_scheduler = UpdateScheduler:new()
	l_10_7 = pairs
	l_10_7 = l_10_7(tweak_data.update)
	for i_0,i_1 in l_10_7 do
		managers.update_scheduler:add_group(l_10_6, i_1.per_frame)
	end
	setup.setup_category_print()
	setup_script_data()
	setup_debug_variables()
	TimerManager:make_timer("player", TimerManager:game())
	setup._main_timer = TimerManager:main()
	managers.world_info = WorldInfoManager:new()
	managers.action_event = ActionEventManager:new()
	managers.action_event:define_actions({"unit_afro_hit", "unit_footstep", "unit_detected_threat", "unit_hurt", "unit_scan_enter", "unit_scan_leave", "unit_scan_beam_enter", "unit_scan_beam_leave", "unit_fully_damaged", "human_character_entered_idle", "unit_player_damage", "player_need_ammo", "unit_ammo_fill", "unit_killed_machine", "unit_stun_enter", "stun_enter", "unit_stun_exit", "unit_stun_body_damaged", "unit_player_received_ammo_from_player", "unit_explode", "unit_explosion", "unit_player_dead", "unit_player_reloading", "unit_self_destroying", "unit_self_destroyed", "unit_damaged", "unit_dead", "unit_revive_help", "unit_revive_thanks", "say_start", "say_stop", "engine_thrust_start", "engine_thrust_stop", "unit_spawn_projectile", "unit_weapon_fire_start", "unit_weapon_fire_change", "unit_weapon_fire_stop", "unit_weapon_shake_start", "unit_weapon_shake_stop", "unit_hud_mission_objective_new", "unit_hud_mission_objective_completed", "combat_banter", "spawn_projectile", "feedback_bullet_hit", "bullet_hit"})
	managers.unit_control_id = UnitControlIdManager:new()
	setup.setup_camera_manager()
	managers.rumble = RumbleManager:new()
	managers.rumble_aem = RumbleActionEventManager:new()
	managers.cover = CoverManager:new()
	managers.cover_util = CoverUtil:new()
	managers.projectile_manager = ProjectileManager:new()
	managers.decal_manager = DecalManager:new()
	managers.replay = ReplayManager:new()
	managers.scene_trigger = SceneTriggerManager:new()
	managers.menu_trigger = MenuTriggerManager:new()
	managers.dynamic_music = DynamicMusicManager:new()
	managers.dynamic_dialog = DynamicDialogManager:new()
	managers.controller:set_default_settings_path("settings/default_controls.xml")
	managers.controller:load_settings()
	managers.ai = AiManager:new()
	managers.ai_graph = AIGraphManager:new()
	AiSetup.init()
	managers.aihivebrain:parse_data()
	managers.sensory_events = SensoryEventManager:new()
	SensoryEventManagerSetup.setup(managers.sensory_events)
	managers.player = PlayerManager:new()
	managers.tutorial = TutorialManager:new()
	managers.tank_display = TankDisplayManager:new()
	managers.localizer_mapping = LocalizerMappingManager:new()
	managers.post_update_manager = PostUpdateManager:new()
	managers.damage_defense_material = DamageDefenseMaterialManager:new()
	managers.ownership = OwnershipManager:new()
	managers.director = DirectorManager:new()
	managers.drama_scene = DramaSceneManager:new("level_02")
	managers.shadow:preload("default")
	managers.shadow:set("default")
	managers.unit_frequency = UnitFrequencyManager:new()
	managers.synced_sound = SyncedSoundManager:new()
	DirectorManagerSetup.setup()
	if Application:ews_enabled() == true then
		cat_print("jimmy", "setup.init(): ToolHub online.")
		managers.toolhub:buildmenu()
		if Application:net_ews_enabled() then
			managers.toolhub:show()
		end
	else
		cat_print("jimmy", "setup.init(): ToolHub offline, no EWS active.")
	end
	if Application:editor() then
		if not rawget(_G, "WorldEditor") then
			managers.editor = rawget(_G, "CoreEditor"):new()
			managers.editor:toggle()
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if not rawget(_G, "ProfilerManager") or Global.transition_data then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Confused about usage of registers!

		GameTransition.default_data(nil.game_transition)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		Game.default_data(nil.game)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		LocalUserManager.default_data(nil.local_user)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		PlayerSlotManager.default_data(nil.player_slot)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		MenuInputManager.default_data(nil.menu_input)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if SystemInfo:platform() == "X360" then
			Xbox360UserDetector.default_data(nil.user_detector)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif SystemInfo:platform() == "WIN32" then
			PcControllerUserDetector.default_data(nil.user_detector)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		elseif SystemInfo:platform() == "PS3" then
			Ps3UserDetector.default_data(nil.user_detector)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		SaveManager.default_data(nil.save)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		LocalSessionUserManager.default_data(nil.local_session_user)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		Menu.default_data(nil.menu)
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if SystemInfo:platform() == "X360" then
			do return end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if SystemInfo:platform() == "WIN32" then
			do return end
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if SystemInfo:platform() == "PS3" then
			managers.menu2d:post_init()
			 -- DECOMPILER ERROR: Confused about usage of registers!

			local l_10_15, l_10_16 = managers, Menu:new
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_10_15 then
				local l_10_10 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				l_10_16(l_10_10)
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				l_10_16(l_10_10, l_10_15.difficulty_level)
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				local l_10_11 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				for i_0,i_1 in l_10_10 do
					if l_10_14:is_playing_the_game() then
						managers.save:load_controller_settings(l_10_14)
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_10_15()
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			l_10_15()
			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			 -- DECOMPILER ERROR: Overwrote pending register.

			if l_10_15 or l_10_15 then
				l_10_15()
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

				 -- WARNING: undefined locals caused missing assignments!
				 -- WARNING: missing end command somewhere! Added here
			end
			 -- WARNING: missing end command somewhere! Added here
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 401 569 663 
end

setup.wait_for_sync_screen_to_fade = function()
	local l_11_0 = 0.01
	do
		while 1 do
			local l_11_1 = false
			while managers.sync_screen:is_showing_sync_screen() do
				managers.sync_screen:update(l_11_0)
				managers.game:update(l_11_0)
				managers.menu2d:update(l_11_0)
				managers.menu:update(l_11_0)
				if not managers.game:is_loading_done() or not l_11_1 then
					setup.post_loading()
					l_11_1 = true
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

setup.post_loading = function()
	core_setup.post_init()
end

setup.exec = function()
	if Application:editor() then
		return 
	end
	managers.sync_screen:start_sync_screen()
	Global.transition_data = {}
	local l_13_0 = Global.transition_data
	l_13_0.game_transition = {}
	managers.game_transition:save(l_13_0.game_transition)
	l_13_0.game = {}
	managers.game:save(l_13_0.game)
	l_13_0.local_user = {}
	managers.local_user:save(l_13_0.local_user)
	l_13_0.player_slot = {}
	managers.player_slot.default_data(l_13_0.player_slot)
	l_13_0.menu_input = {}
	managers.menu_input:save(l_13_0.menu_input)
	l_13_0.user_detector = {}
	setup.user_detector:save(l_13_0.user_detector)
	l_13_0.save = {}
	managers.save:save(l_13_0.save)
	l_13_0.local_session_user = {}
	managers.local_session_user.default_data(l_13_0.local_session_user)
	l_13_0.menu = {}
	managers.menu:save(l_13_0.menu)
	local l_13_1 = nil
	if not managers.game_transition:wants_to_go_to_frontend() and managers.save:has_primary_user() then
		local l_13_2 = managers.save:profile()
		assert(l_13_2)
		if l_13_2.debug_level_name then
			l_13_1 = l_13_2.debug_level_name
		else
			local l_13_3 = l_13_2.current_level_id
			assert(l_13_3)
			local l_13_4 = managers.world_info:info_from_id(l_13_3)
			assert(l_13_4, "Level:" .. tostring(l_13_3) .. " missing")
			l_13_1 = l_13_4.name
		end
		assert(l_13_1, "We need a level name to load a level")
	end
	setup.exec_level_name = l_13_1
end

setup.do_exec = function()
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

setup.update = function(l_15_0, l_15_1)
	local l_15_2 = setup._main_timer:delta_time()
	if not managers.viewport.__update then
		managers.viewport.__update = managers.viewport.update
		managers.viewport.update = function()
    end
	end
	core_setup.update(l_15_0, l_15_1)
	setup._common_update(l_15_0, l_15_1, l_15_2)
	managers.update_scheduler:update(l_15_1)
	managers.cover:update()
	managers.unit_scripting:update(l_15_0, l_15_1)
	managers.player_slot:update()
	if managers.world then
		managers.world:update(l_15_0, l_15_1)
	end
	managers.action_event:update(l_15_0, l_15_1)
	managers.director:update(l_15_0, l_15_1)
	managers.ai:update(l_15_0, l_15_1)
	managers.ai_graph:update(l_15_0, l_15_1)
	managers.camera:update(l_15_0, l_15_1)
	managers.sensory_events:update(l_15_0, l_15_1)
	managers.replay:update()
	managers.dynamic_music:update(l_15_1)
	managers.drama_scene:update(l_15_1)
	setup.user_detector:update()
	update_tickets()
	managers.dynamic_dialog:update(l_15_1)
	managers.scheduler:update(l_15_1)
	managers.sync_screen:update(l_15_1)
end

setup.end_update = function(l_16_0, l_16_1)
	managers.projectile_manager:update(l_16_0, l_16_1)
	managers.decal_manager:update(l_16_0, l_16_1)
	core_setup.end_update(l_16_0, l_16_1)
end

setup.paused_end_update = function(l_17_0, l_17_1)
	core_setup.paused_end_update(l_17_0, l_17_1)
end

setup._update_managers_not_related_to_game = function(l_18_0, l_18_1)
	if managers.editor then
		managers.editor:update(l_18_0, l_18_1)
	end
	if setup._debug then
		setup._debug:update(l_18_0, l_18_1)
	end
	if managers.profiler then
		managers.profiler:update(l_18_1)
	end
end

setup._common_update = function(l_19_0, l_19_1, l_19_2)
	setup._always_update(l_19_0, l_19_1, l_19_2)
	if managers.session then
		managers.session:update(l_19_0, l_19_1)
	end
	managers.settings:update(l_19_0, l_19_1)
	setup._exec_update()
end

setup._always_update = function(l_20_0, l_20_1, l_20_2)
	setup._update_managers_not_related_to_game(l_20_0, l_20_1)
	managers.game:update(l_20_1)
	managers.menu:update(l_20_2)
	managers.menu2d:update(l_20_2)
	managers.local_user:update(l_20_1)
end

setup._exec_update = function()
	if managers.game_transition:wants_to_exec() then
		setup.exec()
	end
end

setup.paused_update = function(l_22_0, l_22_1)
	local l_22_2 = setup._main_timer:delta_time()
	if not managers.viewport.__update then
		managers.viewport.__update = managers.viewport.update
		managers.viewport.update = function()
    end
	end
	if managers.game:is_frozen() then
		core_setup.paused_update(l_22_0, l_22_1)
		setup._always_update(l_22_0, l_22_1, l_22_2)
		setup._exec_update()
	else
		core_setup.paused_update(l_22_0, l_22_1)
		setup._common_update(l_22_0, l_22_1, l_22_2)
	end
end

setup.add_pre_render_callback = function(l_23_0)
	last_pre_render_callback_id = last_pre_render_callback_id + 1
	pre_render_callback_map[last_pre_render_callback_id] = l_23_0
	return last_pre_render_callback_id
end

setup.remove_pre_render_callback = function(l_24_0)
	pre_render_callback_map[l_24_0] = nil
end

setup.render = function()
	local l_25_11, l_25_12, l_25_13, l_25_14, l_25_15 = nil
	if not Global.shows_sync_screen and not Global.inhibit_all_rendering then
		local l_25_0 = managers.worldcamera:current_world_camera()
		if script_debug._freeflight then
			local l_25_1, l_25_2, l_25_3, l_25_4, l_25_5, l_25_6, l_25_7 = script_debug._freeflight:in_focus()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if managers.session and not l_25_1 and not l_25_0 then
			managers.session:render()
		else
			if managers.user_viewport then
				managers.user_viewport:render()
			end
		end
		managers.viewport:__update()
		core_setup.render()
		managers.menu2d:render()
		managers.post_update_manager:update()
		for i_0,i_1 in pairs(pre_render_callback_map) do
			local l_25_8 = nil
			i_1(i_0)
		end
	end
	if managers.game_transition:wants_to_exec() then
		setup.do_exec()
	end
end

setup.save = function(l_26_0)
	managers.sequence:save(l_26_0)
	managers.area:save(l_26_0)
end

setup.load = function(l_27_0)
	managers.sequence:load(l_27_0)
	managers.area:load(l_27_0)
end

setup.destroy = function()
	core_setup.destroy()
end

setup.setup_camera_manager = function()
	managers.camera = CameraManager:new()
	managers.camera:load_cameras("data/cameras/player_camera.xml")
	managers.camera:load_cameras("data/cameras/rail_vehicle_buggy.xml")
	managers.camera:load_cameras("data/cameras/rail_vehicle_pickup.xml")
	managers.camera:load_cameras("data/cameras/rail_vehicle_tank.xml")
	managers.camera:load_cameras("data/cameras/rail_subway_train.xml")
	managers.camera:load_cameras("data/cameras/unit_camera.xml")
end

setup.setup_category_print = function()
	local l_30_4, l_30_5 = nil
	if Global.category_print_initialized.setup then
		return 
	end
	core_setup.setup_category_print()
	Global.category_print.config_manager = false
	Global.category_print.gravity_manager = false
	Global.category_print.musicmanager = false
	Global.category_print.netman = false
	Global.category_print.volume_manager = false
	Global.category_print.ai = false
	Global.category_print.controls = false
	Global.category_print.editor = false
	Global.category_print.pickup_extension = false
	Global.category_print.spawn_system = false
	Global.category_print.tutorial = false
	Global.category_print.camera = false
	Global.category_print.grunt = false
	Global.category_print.wreckermecha = false
	Global.category_print.statemachine = true
	Global.category_print.debug = true
	local l_30_0 = setup.get_people_list()
	for i_0,i_1 in ipairs(l_30_0) do
		Global.category_print[i_1] = false
	end
	catprint_load()
	Global.category_print_initialized.setup = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

setup.get_people_list = function()
	do
		local l_31_0 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		return l_31_0
	end
	 -- WARNING: undefined locals caused missing assignments!
end

init = function()
	setup.init()
end

update = function(l_33_0, l_33_1)
	setup.update(l_33_0, l_33_1)
end

end_update = function(l_34_0, l_34_1)
	setup.end_update(l_34_0, l_34_1)
end

paused_update = function(l_35_0, l_35_1)
	setup.paused_update(l_35_0, l_35_1)
end

render = function()
	setup.render()
end

pre_init = function()
	setup.pre_init()
end

destroy = function()
	setup.destroy()
end

core_setup_apply_aspect_settings = function()
	core_setup.aspect_ratio = core_setup_get_aspect()
	local l_39_0 = core_setup
	l_39_0.wide = core_setup.aspect_ratio > 1.34
end


