require("units/data/MachineHudData")
require("units/beings/player_tank/gui/CodePanel")
require("units/beings/player_tank/gui/StatusPanel")
require("units/beings/player_tank/gui/TurretPanel")
require("units/beings/player_tank/gui/RadarPanel")
require("units/beings/player_tank/gui/ActionPanel")
require("units/beings/player_tank/gui/PowerUpPanel")
require("units/beings/player_tank/gui/OverHeatPanel")
require("units/beings/player_tank/gui/CompassPanel")
require("units/beings/player_tank/gui/MachineReticulePanel")
require("units/beings/player_tank/gui/TargetPanel")
require("units/beings/player_tank/gui/BackgroundPanel")
require("units/beings/player_tank/gui/MachineTutorialPanel")
require("units/beings/player_tank/gui/OutlineHandler")
require("units/beings/player/new_gui/HudUtility")
require("units/beings/player/new_gui/HealthPanel")
if not MachineHud then
	MachineHud = class()
end
MachineHud.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._player_data = l_1_0._unit:player_data()
	l_1_0:_preload_textures()
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
	l_1_0._startup_sound = nil
	l_1_0._shutdown_sound = nil
end

MachineHud._preload_textures = function(l_2_0)
	Overlay:gui():preload_font("diesel")
	Overlay:gui():preload_font("faith_font_44")
	Overlay:gui():preload_texture("gui_machine_radar_background")
	Overlay:gui():preload_texture("gui_machine_radar")
	Overlay:gui():preload_texture("gui_machine_radar_dot")
	Overlay:gui():preload_texture("gui_machine_inner_shadow_df")
	Overlay:gui():preload_texture("gui_machine_tv_dot")
	Overlay:gui():preload_texture("gui_machine_tv_line")
	Overlay:gui():preload_texture("gui_machine_bottom")
	Overlay:gui():preload_texture("gui_machine_tank_gun")
	Overlay:gui():preload_texture("gui_machine_tank_aim")
	Overlay:gui():preload_texture("gui_machine_bar_cell")
	Overlay:gui():preload_texture("gui_machinie_aim_circle")
	Overlay:gui():preload_texture("gui_machine_aim_big_arrow")
	Overlay:gui():preload_texture("gui_machine_aim_small_arrow")
	Overlay:gui():preload_texture("gui_machine_target_spider")
	Overlay:gui():preload_texture("gui_machine_target_flier")
	Overlay:gui():preload_texture("gui_machine_target_turret")
	Overlay:gui():preload_texture("gui_machine_target_hunter_killer")
	Overlay:gui():preload_texture("gui_machine_target_walker")
	Overlay:gui():preload_texture("gui_health_icon")
	Overlay:gui():preload_texture("gui_healthmeter_bg")
	Overlay:gui():preload_texture("gui_healthmeter_bar")
	Overlay:gui():preload_texture("gui_healthmeter_bar_glow")
	Overlay:gui():preload_texture("gui_healthmeter_edge")
	Overlay:gui():preload_texture("gui_machine_bar_small")
end

MachineHud.destroy = function(l_3_0)
	if alive(l_3_0._panel) then
		l_3_0._panel:clear()
	end
	managers.action_event:unregister_listener(l_3_0)
end

MachineHud.has_panel = function(l_4_0)
	return l_4_0._panel
end

MachineHud.release_gui_panel = function(l_5_0)
	if l_5_0._panel then
		l_5_0._panel:clear()
	end
	l_5_0._panel = nil
end

MachineHud.set_gui_panel = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._user_viewport then
		l_6_0._new_resolution = true
	end
	l_6_0._parent_panel_height = l_6_1:height()
	l_6_0._user_viewport = l_6_2
	local l_6_3, l_6_4 = l_6_1:panel, l_6_1
	local l_6_5 = {}
	l_6_5.name = "root_panel"
	l_6_5.valign = "grow"
	l_6_5.halign = "grow"
	l_6_3 = l_6_3(l_6_4, l_6_5)
	l_6_0._panel = l_6_3
	l_6_3 = l_6_0._panel
	l_6_3, l_6_4 = l_6_3:set_size, l_6_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_3(l_6_4, l_6_5)
	l_6_3 = l_6_0._panel
	l_6_3, l_6_4 = l_6_3:height, l_6_3
	l_6_3 = l_6_3(l_6_4)
	l_6_0._panel_height = l_6_3
	l_6_3 = managers
	l_6_3 = l_6_3.menu
	l_6_3, l_6_4 = l_6_3:ingame_gui, l_6_3
	l_6_3 = l_6_3(l_6_4)
	l_6_3, l_6_4 = l_6_3:safe_rect, l_6_3
	l_6_3 = l_6_3(l_6_4)
	l_6_4 = l_6_0._panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:panel
	local l_6_6 = {}
	l_6_6.name = "safe_panel"
	l_6_6.valign = "grow"
	l_6_6.halign = "grow"
	l_6_4 = l_6_4(l_6_5, l_6_6)
	l_6_0._safe_panel = l_6_4
	l_6_4 = l_6_0._safe_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:set_shape
	l_6_6 = l_6_3.x
	l_6_4(l_6_5, l_6_6, l_6_3.y, l_6_3.w, l_6_3.h)
	l_6_0._startups_initiated = false
	l_6_0._ready_to_startup = false
	l_6_0._startup_done = false
	l_6_4 = HudUtility
	l_6_4 = l_6_4.is_split_screen
	l_6_4 = l_6_4()
	l_6_0._starting_in_coop = l_6_4
	l_6_4 = CodePanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._safe_panel
	l_6_4 = l_6_4(l_6_5, l_6_6)
	l_6_0._code_panel = l_6_4
	l_6_4 = TurretPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._safe_panel
	l_6_4 = l_6_4(l_6_5, l_6_6)
	l_6_0._turret_panel = l_6_4
	l_6_4 = RadarPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._safe_panel
	l_6_4 = l_6_4(l_6_5, l_6_6, l_6_0._unit)
	l_6_0._radar_panel = l_6_4
	l_6_4 = StatusPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._safe_panel
	l_6_4 = l_6_4(l_6_5, l_6_6, l_6_0._unit)
	l_6_0._status_panel = l_6_4
	l_6_4 = PowerUpPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._safe_panel
	l_6_4 = l_6_4(l_6_5, l_6_6, l_6_0._unit)
	l_6_0._powerup_panel = l_6_4
	l_6_4 = OverHeatPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._safe_panel
	l_6_4 = l_6_4(l_6_5, l_6_6, l_6_0._unit, true)
	l_6_0._overheat_panel = l_6_4
	l_6_4 = MachineTutorialPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._safe_panel
	l_6_4 = l_6_4(l_6_5, l_6_6, l_6_0._starting_in_coop, l_6_0._unit)
	l_6_0._tutorial_panel = l_6_4
	l_6_4 = MachineReticulePanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._panel
	l_6_4 = l_6_4(l_6_5, l_6_6)
	l_6_0._reticule_panel = l_6_4
	l_6_4 = TargetPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._safe_panel
	l_6_4 = l_6_4(l_6_5, l_6_6, l_6_0._unit)
	l_6_0._target_panel = l_6_4
	l_6_4 = OutlineHandler
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._unit
	l_6_4 = l_6_4(l_6_5, l_6_6)
	l_6_0._outline_handler = l_6_4
	l_6_4 = HealthPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:new
	l_6_6 = l_6_0._panel
	l_6_4 = l_6_4(l_6_5, l_6_6, l_6_0._safe_panel, l_6_0._unit, tweak_data.machine.hud.MAIN_ALPHA, true, tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK, tweak_data.machine.hud.HEALTH_ICON)
	l_6_0._health_panel = l_6_4
	l_6_4 = l_6_0._starting_in_coop
	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_6_4 then
		l_6_4 = l_6_0:update_resolution_and_splitscreen
		l_6_4(l_6_5)
		l_6_0._ready_to_startup = true
	end
	l_6_4 = managers
	l_6_4 = l_6_4.save
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:profile
	l_6_4 = l_6_4(l_6_5)
	l_6_4 = l_6_4.current_checkpoint_id
	l_6_0._start_checkpoint = l_6_4
	l_6_4 = l_6_0._start_checkpoint
	l_6_4 = l_6_4 > 1
	l_6_0._quick_startup = l_6_4
	l_6_4 = l_6_0._quick_startup
	l_6_4 = not l_6_4
	l_6_0._show_tutorial = l_6_4
	l_6_4 = managers
	l_6_4 = l_6_4.tank_display
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:startup
	l_6_4(l_6_5)
	l_6_4 = managers
	l_6_4 = l_6_4.localizer_mapping
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_4 = l_6_4:update_mapping
	l_6_4(l_6_5)
end

MachineHud.update = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if not l_7_0:has_panel() then
		return 
	end
	if not l_7_0._unit:rail()._vehicle then
		return 
	end
	do return end
	if not l_7_0._tank then
		l_7_0._is_main_tank = l_7_0._unit:rail()._vehicle:base().is_main_tank
		if l_7_0._is_main_tank == nil then
			return 
		end
		if l_7_0._is_main_tank then
			l_7_0._tank = l_7_0._unit:rail()._vehicle
		else
			l_7_0._tank = l_7_0._unit:rail()._vehicle:base().main_tank
		end
		l_7_0._turret = l_7_0._tank:base():get_turret_object()
	end
	if l_7_0._starting_in_coop and not l_7_0._ready_to_startup and math.abs(l_7_0._panel:height() - l_7_0._parent_panel_height / 2) < 2 then
		l_7_0:update_resolution_and_splitscreen()
		l_7_0._ready_to_startup = true
	end
	if managers.game:is_paused() then
		l_7_0:_hide_machine_hud()
		return 
	elseif l_7_0._hidden then
		l_7_0:_show_machine_hud()
		managers.localizer_mapping:update_mapping()
	end
	l_7_0:_update_directions()
	l_7_0:_update_target()
	l_7_0:_update_panels(l_7_2, l_7_3)
	if l_7_0._ready_to_startup and not l_7_0._startups_initiated and managers.tank_display:startup_done() then
		l_7_0:startup_panels()
		l_7_0._tutorial_panel:show_tutorial(9, l_7_0._powerup_panel, l_7_0._overheat_panel)
		l_7_0._target_panel:hide()
		l_7_0._startups_initiated = true
	end
	if l_7_0:_tank_is_destroyed() and not l_7_0._shutdowned then
		managers.tank_display:shutdown()
		l_7_0:shutdown_panels()
		l_7_0._target_panel:hide()
		l_7_0._shutdowned = true
	end
end

MachineHud._update_panels = function(l_8_0, l_8_1, l_8_2)
	l_8_0._reticule_panel:update(l_8_1, l_8_2, l_8_0._current_target)
	if l_8_0._shutdowned or not l_8_0._startup_done then
		if not l_8_0._target_panel.hidden then
			l_8_0._target_panel:hide()
		end
		if not l_8_0._health_panel:hidden() then
			l_8_0._health_panel:instant_hide()
		end
	else
		l_8_0._target_panel:update(l_8_1, l_8_2, l_8_0._current_target)
	if l_8_0._is_main_tank then
		end
		l_8_0:_update_health_panel(l_8_1, l_8_2)
	end
	l_8_0._outline_handler:update(l_8_1, l_8_2)
	l_8_0._powerup_panel:update(l_8_1, l_8_2)
	l_8_0._overheat_panel:update(l_8_1, l_8_2)
	if not l_8_0._code_panel._disabled then
		l_8_0._code_panel:update(l_8_1, l_8_2)
	end
	if not l_8_0._turret_panel._disabled then
		l_8_0._turret_panel:update(l_8_1, l_8_2, l_8_0._tank_direction, l_8_0._turret_direction)
	end
	if not l_8_0._radar_panel._disabled then
		l_8_0._radar_panel:update(l_8_1, l_8_2)
	end
	if not l_8_0._status_panel._disabled then
		l_8_0._status_panel:update(l_8_1, l_8_2)
	end
	if l_8_0._show_tutorial and not l_8_0._tutorial_finished then
		l_8_0._tutorial_finished = l_8_0._tutorial_panel:tutorial_finished()
	if not l_8_0._tutorial_finished then
		end
		l_8_0._tutorial_panel:update(l_8_1, l_8_2)
	end
	if l_8_0._startups_initiated and not l_8_0._startup_done then
		l_8_0:update_startup()
	end
end

MachineHud.update_startup = function(l_9_0)
	if not l_9_0._startup_done then
		l_9_0._startup_done = l_9_0._code_panel.startup_done
	end
	if not l_9_0._startup_done then
		l_9_0._startup_done = l_9_0._turret_panel.startup_done
	end
	if not l_9_0._startup_done then
		l_9_0._startup_done = l_9_0._radar_panel.startup_done
	end
	if not l_9_0._startup_done then
		l_9_0._startup_done = l_9_0._status_panel.startup_done
	end
	if not l_9_0._startup_done then
		l_9_0._startup_done = l_9_0._overheat_panel.startup_done
	end
	if not l_9_0._startup_done then
		l_9_0._startup_done = l_9_0._powerup_panel.startup_done
	end
	if not l_9_0._startup_done then
		l_9_0._startup_done = l_9_0._reticule_panel.startup_done
	end
end

MachineHud.startup_panels = function(l_10_0)
	if l_10_0._quick_startup then
		l_10_0._code_panel:startup(0.2)
		l_10_0._turret_panel:startup(0.5)
		l_10_0._radar_panel:startup(0.3)
		l_10_0._status_panel:startup(0.4)
		l_10_0._overheat_panel:startup(0.4)
		l_10_0._powerup_panel:startup(0.2)
		l_10_0._reticule_panel:startup(0.4)
	else
		l_10_0._code_panel:startup(2)
		l_10_0._turret_panel:startup(5)
		l_10_0._radar_panel:startup(3)
		l_10_0._status_panel:startup(4)
		l_10_0._overheat_panel:startup(4)
		l_10_0._powerup_panel:startup(2)
		l_10_0._reticule_panel:startup(4)
	end
	l_10_0._startup_sound = l_10_0._tank:play("tank_start_up")
end

MachineHud.shutdown_panels = function(l_11_0)
	l_11_0._code_panel:shutdown(0.25, true)
	l_11_0._turret_panel:shutdown(0.5, true)
	l_11_0._radar_panel:shutdown(0.5, true)
	l_11_0._status_panel:shutdown(0.25, true)
	l_11_0._overheat_panel:shutdown(0.5, true)
	l_11_0._powerup_panel:shutdown(0.5, true)
	l_11_0._reticule_panel:shutdown(0.5, true)
	l_11_0._outline_handler:shutdown(0.5, true)
	l_11_0._shutdown_sound = l_11_0._tank:play("tank_shut_down")
end

MachineHud.update_resolution_and_splitscreen = function(l_12_0)
	l_12_0._split_screen = HudUtility.is_split_screen()
	if l_12_0._split_screen then
		local l_12_1, l_12_2, l_12_3, l_12_4, l_12_5, l_12_6, l_12_7, l_12_8, l_12_9, l_12_10, l_12_11, l_12_12, l_12_13, l_12_14, l_12_15, l_12_16, l_12_17, l_12_18, l_12_19, l_12_20, l_12_21, l_12_22, l_12_23, l_12_24, l_12_25, l_12_26, l_12_27, l_12_28, l_12_29, l_12_30, l_12_31, l_12_32, l_12_33, l_12_34, l_12_35, l_12_36, l_12_37 = l_12_0._panel:height() * 2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_12_1 <= 720 then
		l_12_0._target_panel:use_size(0.75)
		if l_12_0._split_screen then
			l_12_0._reticule_panel:use_size(0.75)
			l_12_0._radar_panel:disable()
			l_12_0._code_panel:disable()
			l_12_0._status_panel:disable()
			l_12_0._turret_panel:disable()
			l_12_0._target_panel:use_position(0.6, 0)
			l_12_0._overheat_panel:enable(0.75, 0)
			l_12_0._powerup_panel:enable(0.75)
		else
			l_12_0._reticule_panel:use_size(1)
			l_12_0._radar_panel:enable(0.75)
			l_12_0._code_panel:enable(0.5)
			l_12_0._status_panel:enable(0.5)
			l_12_0._turret_panel:enable(0.75, 0.5)
			l_12_0._overheat_panel:enable(0.75, 0.5)
			l_12_0._powerup_panel:enable(0.75)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_12_1 <= 1024 then
				l_12_0._target_panel:use_position(0.6, 1)
			end
		else
			l_12_0._target_panel:use_position(0.8, 1.75)
		end
	else
		l_12_0._target_panel:use_size(1)
		l_12_0._reticule_panel:use_size(1)
		if l_12_0._split_screen then
			l_12_0._radar_panel:disable()
			l_12_0._code_panel:disable()
			l_12_0._status_panel:disable()
			l_12_0._turret_panel:disable()
			l_12_0._overheat_panel:enable(1, 0)
			l_12_0._powerup_panel:enable(1)
			 -- DECOMPILER ERROR: Confused about usage of registers!

			if l_12_1 <= 1024 then
				l_12_0._target_panel:use_position(1, 0)
			end
		else
			l_12_0._target_panel:use_position(1, 0.3)
		end
	else
		l_12_0._radar_panel:enable(1)
		l_12_0._code_panel:enable(0.78)
		l_12_0._status_panel:enable(0.8)
		l_12_0._turret_panel:enable(1, 0.75)
		l_12_0._overheat_panel:enable(1, 0.8)
		l_12_0._powerup_panel:enable(1)
		l_12_0._target_panel:use_position(1, 2)
	end
end

MachineHud._update_tint = function(l_13_0)
	local l_13_1 = tweak_data.machine.hud.TINT_COLOR
	l_13_0._red_tint_rectangle:set_color(Color(l_13_1.a, l_13_1.r, l_13_1.g, l_13_1.b))
end

MachineHud._update_directions = function(l_14_0)
	l_14_0._tank_direction = l_14_0._tank:rotation():roll()
	local l_14_1 = Rotation:rotation_difference(l_14_0._tank:rotation(), l_14_0._turret:rotation())
	l_14_0._turret_direction = -l_14_1:roll()
	l_14_0._compass_direction = l_14_0._tank_direction * 10
	if l_14_0._compass_direction < 0 then
		l_14_0._compass_direction = 3600 + l_14_0._compass_direction
	end
end

MachineHud._update_target = function(l_15_0)
	local l_15_1 = l_15_0._unit:player_data()
	if not l_15_1 then
		return 
	end
	l_15_0._current_target = nil
	if l_15_1.aim_target_unit and alive(l_15_1.aim_target_unit) and l_15_1.aim_target_unit:in_slot(managers.slot:get_mask("enemies")) and l_15_1.aim_target_unit:name() ~= "rail_vehicle_tank" then
		l_15_0._current_target = l_15_1.aim_target_unit
	end
end

MachineHud._tank_is_destroyed = function(l_16_0)
	return l_16_0._tank:damage_data().health <= l_16_0._tank:damage_data().damage
end

MachineHud._update_health_panel = function(l_17_0, l_17_1, l_17_2)
	local l_17_3 = false
	if l_17_0._unit:base():player_has_control() then
		if l_17_0._player_data.on_rail_vehicle:damage_data().damage <= 0 then
			l_17_3 = not l_17_0._player_data.on_rail_vehicle
	else
		end
	end
	l_17_0._health_panel:instant_hide()
	do return end
	if l_17_0._player_data.on_destroyed_rail_vehicle then
		l_17_3 = true
	else
		l_17_3 = l_17_0._unit:damage_data().damage > 0
	end
	if l_17_3 then
		l_17_0._health_panel:show()
		l_17_0._health_panel:update(l_17_1, l_17_2)
	else
		if l_17_0._health_panel:visible() or l_17_0._health_panel:hidden() then
			l_17_0._health_panel:update(l_17_1, l_17_2)
		end
	end
end

MachineHud._show_machine_hud = function(l_18_0)
	l_18_0._code_panel:show()
	l_18_0._turret_panel:show()
	l_18_0._radar_panel:show()
	l_18_0._status_panel:show()
	l_18_0._powerup_panel:show()
	l_18_0._overheat_panel:show()
	l_18_0._reticule_panel:show()
	l_18_0._tutorial_panel:show()
	l_18_0._target_panel:show()
	l_18_0._health_panel:show()
	l_18_0._hidden = false
end

MachineHud._hide_machine_hud = function(l_19_0)
	l_19_0._code_panel:hide()
	l_19_0._turret_panel:hide()
	l_19_0._radar_panel:hide()
	l_19_0._status_panel:hide()
	l_19_0._powerup_panel:hide()
	l_19_0._overheat_panel:hide()
	l_19_0._reticule_panel:hide()
	l_19_0._tutorial_panel:hide()
	l_19_0._target_panel:hide()
	l_19_0._outline_handler:hide()
	l_19_0._health_panel:instant_hide()
	l_19_0._hidden = true
end


