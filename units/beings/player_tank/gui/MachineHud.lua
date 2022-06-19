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
MachineHud = MachineHud or class()
function MachineHud.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._player_data = A0_0._unit:player_data()
	A0_0:_preload_textures()
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
	A0_0._startup_sound = nil
	A0_0._shutdown_sound = nil
end
function MachineHud._preload_textures(A0_2)
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
function MachineHud.destroy(A0_3)
	if alive(A0_3._panel) then
		A0_3._panel:clear()
	end
	managers.action_event:unregister_listener(A0_3)
end
function MachineHud.has_panel(A0_4)
	local L1_5
	L1_5 = A0_4._panel
	return L1_5
end
function MachineHud.release_gui_panel(A0_6)
	if A0_6._panel then
		A0_6._panel:clear()
	end
	A0_6._panel = nil
end
function MachineHud.set_gui_panel(A0_7, A1_8, A2_9)
	if A0_7._user_viewport then
		A0_7._new_resolution = true
	end
	A0_7._parent_panel_height = A1_8:height()
	A0_7._user_viewport = A2_9
	A0_7._panel = A1_8:panel({
		name = "root_panel",
		valign = "grow",
		halign = "grow"
	})
	A0_7._panel:set_size(A1_8:size())
	A0_7._panel_height = A0_7._panel:height()
	A0_7._safe_panel = A0_7._panel:panel({
		name = "safe_panel",
		valign = "grow",
		halign = "grow"
	})
	A0_7._safe_panel:set_shape(managers.menu:ingame_gui():safe_rect().x, managers.menu:ingame_gui():safe_rect().y, managers.menu:ingame_gui():safe_rect().w, managers.menu:ingame_gui():safe_rect().h)
	A0_7._startups_initiated = false
	A0_7._ready_to_startup = false
	A0_7._startup_done = false
	A0_7._starting_in_coop = HudUtility.is_split_screen()
	A0_7._code_panel = CodePanel:new(A0_7._safe_panel)
	A0_7._turret_panel = TurretPanel:new(A0_7._safe_panel)
	A0_7._radar_panel = RadarPanel:new(A0_7._safe_panel, A0_7._unit)
	A0_7._status_panel = StatusPanel:new(A0_7._safe_panel, A0_7._unit)
	A0_7._powerup_panel = PowerUpPanel:new(A0_7._safe_panel, A0_7._unit)
	A0_7._overheat_panel = OverHeatPanel:new(A0_7._safe_panel, A0_7._unit, true)
	A0_7._tutorial_panel = MachineTutorialPanel:new(A0_7._safe_panel, A0_7._starting_in_coop, A0_7._unit)
	A0_7._reticule_panel = MachineReticulePanel:new(A0_7._panel)
	A0_7._target_panel = TargetPanel:new(A0_7._safe_panel, A0_7._unit)
	A0_7._outline_handler = OutlineHandler:new(A0_7._unit)
	A0_7._health_panel = HealthPanel:new(A0_7._panel, A0_7._safe_panel, A0_7._unit, tweak_data.machine.hud.MAIN_ALPHA, true, tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK, tweak_data.machine.hud.HEALTH_ICON)
	if not A0_7._starting_in_coop then
		A0_7:update_resolution_and_splitscreen()
		A0_7._ready_to_startup = true
	end
	A0_7._start_checkpoint = managers.save:profile().current_checkpoint_id
	A0_7._quick_startup = A0_7._start_checkpoint > 1
	A0_7._show_tutorial = not A0_7._quick_startup
	managers.tank_display:startup()
	managers.localizer_mapping:update_mapping()
end
function MachineHud.update(A0_10, A1_11, A2_12, A3_13)
	if not A0_10:has_panel() then
		return
	end
	if not A0_10._unit:rail()._vehicle then
		return
	elseif not A0_10._tank then
		A0_10._is_main_tank = A0_10._unit:rail()._vehicle:base().is_main_tank
		if A0_10._is_main_tank == nil then
			return
		end
		if A0_10._is_main_tank then
			A0_10._tank = A0_10._unit:rail()._vehicle
		else
			A0_10._tank = A0_10._unit:rail()._vehicle:base().main_tank
		end
		A0_10._turret = A0_10._tank:base():get_turret_object()
	end
	if A0_10._starting_in_coop and not A0_10._ready_to_startup and math.abs(A0_10._panel:height() - A0_10._parent_panel_height / 2) < 2 then
		A0_10:update_resolution_and_splitscreen()
		A0_10._ready_to_startup = true
	end
	if managers.game:is_paused() then
		A0_10:_hide_machine_hud()
		return
	elseif A0_10._hidden then
		A0_10:_show_machine_hud()
		managers.localizer_mapping:update_mapping()
	end
	A0_10:_update_directions()
	A0_10:_update_target()
	A0_10:_update_panels(A2_12, A3_13)
	if A0_10._ready_to_startup and not A0_10._startups_initiated and managers.tank_display:startup_done() then
		A0_10:startup_panels()
		A0_10._tutorial_panel:show_tutorial(9, A0_10._powerup_panel, A0_10._overheat_panel)
		A0_10._target_panel:hide()
		A0_10._startups_initiated = true
	end
	if A0_10:_tank_is_destroyed() and not A0_10._shutdowned then
		managers.tank_display:shutdown()
		A0_10:shutdown_panels()
		A0_10._target_panel:hide()
		A0_10._shutdowned = true
	end
end
function MachineHud._update_panels(A0_14, A1_15, A2_16)
	A0_14._reticule_panel:update(A1_15, A2_16, A0_14._current_target)
	if A0_14._shutdowned or not A0_14._startup_done then
		if not A0_14._target_panel.hidden then
			A0_14._target_panel:hide()
		end
		if not A0_14._health_panel:hidden() then
			A0_14._health_panel:instant_hide()
		end
	else
		A0_14._target_panel:update(A1_15, A2_16, A0_14._current_target)
		if A0_14._is_main_tank then
			A0_14:_update_health_panel(A1_15, A2_16)
		end
	end
	A0_14._outline_handler:update(A1_15, A2_16)
	A0_14._powerup_panel:update(A1_15, A2_16)
	A0_14._overheat_panel:update(A1_15, A2_16)
	if not A0_14._code_panel._disabled then
		A0_14._code_panel:update(A1_15, A2_16)
	end
	if not A0_14._turret_panel._disabled then
		A0_14._turret_panel:update(A1_15, A2_16, A0_14._tank_direction, A0_14._turret_direction)
	end
	if not A0_14._radar_panel._disabled then
		A0_14._radar_panel:update(A1_15, A2_16)
	end
	if not A0_14._status_panel._disabled then
		A0_14._status_panel:update(A1_15, A2_16)
	end
	if A0_14._show_tutorial and not A0_14._tutorial_finished then
		A0_14._tutorial_finished = A0_14._tutorial_panel:tutorial_finished()
		if not A0_14._tutorial_finished then
			A0_14._tutorial_panel:update(A1_15, A2_16)
		end
	end
	if A0_14._startups_initiated and not A0_14._startup_done then
		A0_14:update_startup()
	end
end
function MachineHud.update_startup(A0_17)
	local L1_18
	L1_18 = A0_17._startup_done
	if not L1_18 then
		L1_18 = A0_17._code_panel
		L1_18 = L1_18.startup_done
	end
	A0_17._startup_done = L1_18
	L1_18 = A0_17._startup_done
	if not L1_18 then
		L1_18 = A0_17._turret_panel
		L1_18 = L1_18.startup_done
	end
	A0_17._startup_done = L1_18
	L1_18 = A0_17._startup_done
	if not L1_18 then
		L1_18 = A0_17._radar_panel
		L1_18 = L1_18.startup_done
	end
	A0_17._startup_done = L1_18
	L1_18 = A0_17._startup_done
	if not L1_18 then
		L1_18 = A0_17._status_panel
		L1_18 = L1_18.startup_done
	end
	A0_17._startup_done = L1_18
	L1_18 = A0_17._startup_done
	if not L1_18 then
		L1_18 = A0_17._overheat_panel
		L1_18 = L1_18.startup_done
	end
	A0_17._startup_done = L1_18
	L1_18 = A0_17._startup_done
	if not L1_18 then
		L1_18 = A0_17._powerup_panel
		L1_18 = L1_18.startup_done
	end
	A0_17._startup_done = L1_18
	L1_18 = A0_17._startup_done
	if not L1_18 then
		L1_18 = A0_17._reticule_panel
		L1_18 = L1_18.startup_done
	end
	A0_17._startup_done = L1_18
end
function MachineHud.startup_panels(A0_19)
	if A0_19._quick_startup then
		A0_19._code_panel:startup(0.2)
		A0_19._turret_panel:startup(0.5)
		A0_19._radar_panel:startup(0.3)
		A0_19._status_panel:startup(0.4)
		A0_19._overheat_panel:startup(0.4)
		A0_19._powerup_panel:startup(0.2)
		A0_19._reticule_panel:startup(0.4)
	else
		A0_19._code_panel:startup(2)
		A0_19._turret_panel:startup(5)
		A0_19._radar_panel:startup(3)
		A0_19._status_panel:startup(4)
		A0_19._overheat_panel:startup(4)
		A0_19._powerup_panel:startup(2)
		A0_19._reticule_panel:startup(4)
	end
	A0_19._startup_sound = A0_19._tank:play("tank_start_up")
end
function MachineHud.shutdown_panels(A0_20)
	A0_20._code_panel:shutdown(0.25, true)
	A0_20._turret_panel:shutdown(0.5, true)
	A0_20._radar_panel:shutdown(0.5, true)
	A0_20._status_panel:shutdown(0.25, true)
	A0_20._overheat_panel:shutdown(0.5, true)
	A0_20._powerup_panel:shutdown(0.5, true)
	A0_20._reticule_panel:shutdown(0.5, true)
	A0_20._outline_handler:shutdown(0.5, true)
	A0_20._shutdown_sound = A0_20._tank:play("tank_shut_down")
end
function MachineHud.update_resolution_and_splitscreen(A0_21)
	A0_21._split_screen = HudUtility.is_split_screen()
	if A0_21._split_screen then
	end
	if A0_21._panel:height() * 2 <= 720 then
		A0_21._target_panel:use_size(0.75)
		if A0_21._split_screen then
			A0_21._reticule_panel:use_size(0.75)
			A0_21._radar_panel:disable()
			A0_21._code_panel:disable()
			A0_21._status_panel:disable()
			A0_21._turret_panel:disable()
			A0_21._target_panel:use_position(0.6, 0)
			A0_21._overheat_panel:enable(0.75, 0)
			A0_21._powerup_panel:enable(0.75)
		else
			A0_21._reticule_panel:use_size(1)
			A0_21._radar_panel:enable(0.75)
			A0_21._code_panel:enable(0.5)
			A0_21._status_panel:enable(0.5)
			A0_21._turret_panel:enable(0.75, 0.5)
			A0_21._overheat_panel:enable(0.75, 0.5)
			A0_21._powerup_panel:enable(0.75)
			if A0_21._panel:height() * 2 <= 1024 then
				A0_21._target_panel:use_position(0.6, 1)
			else
				A0_21._target_panel:use_position(0.8, 1.75)
			end
		end
	else
		A0_21._target_panel:use_size(1)
		A0_21._reticule_panel:use_size(1)
		if A0_21._split_screen then
			A0_21._radar_panel:disable()
			A0_21._code_panel:disable()
			A0_21._status_panel:disable()
			A0_21._turret_panel:disable()
			A0_21._overheat_panel:enable(1, 0)
			A0_21._powerup_panel:enable(1)
			if A0_21._panel:height() * 2 <= 1024 then
				A0_21._target_panel:use_position(1, 0)
			else
				A0_21._target_panel:use_position(1, 0.3)
			end
		else
			A0_21._radar_panel:enable(1)
			A0_21._code_panel:enable(0.78)
			A0_21._status_panel:enable(0.8)
			A0_21._turret_panel:enable(1, 0.75)
			A0_21._overheat_panel:enable(1, 0.8)
			A0_21._powerup_panel:enable(1)
			A0_21._target_panel:use_position(1, 2)
		end
	end
end
function MachineHud._update_tint(A0_22)
	local L1_23, L3_24
	L1_23 = tweak_data
	L1_23 = L1_23.machine
	L1_23 = L1_23.hud
	L1_23 = L1_23.TINT_COLOR
	L3_24 = A0_22._red_tint_rectangle
	L3_24 = L3_24.set_color
	L3_24(L3_24, Color(L1_23.a, L1_23.r, L1_23.g, L1_23.b))
end
function MachineHud._update_directions(A0_25)
	A0_25._tank_direction = A0_25._tank:rotation():roll()
	A0_25._turret_direction = -Rotation:rotation_difference(A0_25._tank:rotation(), A0_25._turret:rotation()):roll()
	A0_25._compass_direction = A0_25._tank_direction * 10
	if A0_25._compass_direction < 0 then
		A0_25._compass_direction = 3600 + A0_25._compass_direction
	end
end
function MachineHud._update_target(A0_26)
	if not A0_26._unit:player_data() then
		return
	end
	A0_26._current_target = nil
	if A0_26._unit:player_data().aim_target_unit and alive(A0_26._unit:player_data().aim_target_unit) and A0_26._unit:player_data().aim_target_unit:in_slot(managers.slot:get_mask("enemies")) and A0_26._unit:player_data().aim_target_unit:name() ~= "rail_vehicle_tank" then
		A0_26._current_target = A0_26._unit:player_data().aim_target_unit
	end
end
function MachineHud._tank_is_destroyed(A0_27)
	return A0_27._tank:damage_data().damage >= A0_27._tank:damage_data().health
end
function MachineHud._update_health_panel(A0_28, A1_29, A2_30)
	if A0_28._player_data.on_rail_vehicle then
		if A0_28._unit:base():player_has_control() then
		else
			A0_28._health_panel:instant_hide()
		end
	elseif A0_28._player_data.on_destroyed_rail_vehicle then
	else
	end
	if A0_28._unit:damage_data().damage > 0 then
		A0_28._health_panel:show()
		A0_28._health_panel:update(A1_29, A2_30)
	elseif A0_28._health_panel:visible() or A0_28._health_panel:hidden() then
		A0_28._health_panel:update(A1_29, A2_30)
	end
end
function MachineHud._show_machine_hud(A0_31)
	A0_31._code_panel:show()
	A0_31._turret_panel:show()
	A0_31._radar_panel:show()
	A0_31._status_panel:show()
	A0_31._powerup_panel:show()
	A0_31._overheat_panel:show()
	A0_31._reticule_panel:show()
	A0_31._tutorial_panel:show()
	A0_31._target_panel:show()
	A0_31._health_panel:show()
	A0_31._hidden = false
end
function MachineHud._hide_machine_hud(A0_32)
	A0_32._code_panel:hide()
	A0_32._turret_panel:hide()
	A0_32._radar_panel:hide()
	A0_32._status_panel:hide()
	A0_32._powerup_panel:hide()
	A0_32._overheat_panel:hide()
	A0_32._reticule_panel:hide()
	A0_32._tutorial_panel:hide()
	A0_32._target_panel:hide()
	A0_32._outline_handler:hide()
	A0_32._health_panel:instant_hide()
	A0_32._hidden = true
end
