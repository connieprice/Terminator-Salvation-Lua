require("units/data/PlayerHudData")
require("units/beings/player/gui/WeaponHud")
require("units/beings/player/gui/ContextActionHud")
require("units/beings/player/sounds/PlayerHudSound")
require("units/beings/player/gui/InventoryHud")
require("units/beings/player/gui/HudElementStack")
require("units/beings/player/gui/TextPanelCreator")
require("units/beings/player/gui/MissionObjectiveHud")
require("units/beings/player/gui/DeltaMissionObjectiveHud")
require("units/beings/player/gui/PanelFader")
require("units/beings/player/gui/QuickMoveHud")
require("units/beings/player/gui/DebugText")
require("units/beings/player/gui/ProjectileWeaponReticuleHud")
require("units/beings/player/gui/OverHeatHud")
PlayerHud = PlayerHud or class()
PlayerHud.HIT_INDICATOR_MODES = {
	"normal",
	"enemy",
	"friend"
}
PlayerHud.HIT_INDICATOR_PIECES = {
	"upper_left",
	"upper_right",
	"lower_left",
	"lower_right"
}
PlayerHud.RETICULE_MODES = PlayerHud.HIT_INDICATOR_MODES
PlayerHud.RETICULE_PIECES = {
	"top",
	"bottom",
	"left",
	"right"
}
PlayerHud.DISABLE_HIT_INDICATOR = SystemInfo:platform() == "PS3"
function PlayerHud.init(A0_0, A1_1)
	local L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11
	A0_0._player_data = L2_2
	A0_0._damage_data = L2_2
	A0_0._unit = A1_1
	A0_0._player_current_control = false
	A0_0._calculate_damage_alpha = L2_2
	L5_5 = A1_1
	L2_2(L3_3, L4_4, L5_5)
	if not L2_2 then
		for L5_5, L6_6 in L2_2(L3_3) do
			for L10_10, L11_11 in L7_7(L8_8) do
				Overlay:gui():preload_texture("gui_hit_indicator_" .. L11_11 .. "_" .. L6_6)
			end
		end
	end
	for L5_5, L6_6 in L2_2(L3_3) do
		L10_10 = L6_6
		L7_7(L8_8, L9_9)
		for L10_10, L11_11 in L7_7(L8_8) do
			Overlay:gui():preload_texture("gui_reticule_" .. L11_11 .. "_" .. L6_6)
		end
		L10_10 = L6_6
		L7_7(L8_8, L9_9)
		L10_10 = L6_6
		L7_7(L8_8, L9_9)
		L10_10 = L6_6
		L7_7(L8_8, L9_9)
	end
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
	L2_2(L3_3, L4_4)
end
function PlayerHud.destroy(A0_12)
	if A0_12._panel then
		A0_12._panel:clear()
	end
	if A0_12._debug_text then
		A0_12._debug_text:destroy()
	end
	managers.action_event:unregister_listener(A0_12)
end
function PlayerHud.has_panel(A0_13)
	local L1_14
	L1_14 = A0_13._panel
	return L1_14
end
function PlayerHud.release_gui_panel(A0_15)
	if A0_15._panel then
		A0_15._panel:clear()
	end
	A0_15._panel = nil
end
function PlayerHud.set_debug_text(A0_16, A1_17)
	if A0_16._debug_text then
		A0_16._debug_text:show_next_line(A1_17)
	end
end
function PlayerHud.set_gui_panel(A0_18, A1_19)
	local L2_20, L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L11_29, L12_30, L13_31, L14_32
	L3_21 = A1_19
	L2_20 = A1_19.panel
	L4_22.name = "root_panel"
	L4_22.valign = "grow"
	L4_22.halign = "grow"
	L2_20 = L2_20(L3_21, L4_22)
	A0_18._panel = L2_20
	L2_20 = A0_18._panel
	L3_21 = L2_20
	L2_20 = L2_20.set_size
	L14_32 = L4_22(L5_23)
	L2_20(L3_21, L4_22, L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L11_29, L12_30, L13_31, L14_32, L4_22(L5_23))
	L2_20 = A0_18._panel
	L3_21 = L2_20
	L2_20 = L2_20.panel
	L4_22.name = "safe_panel"
	L4_22.valign = "grow"
	L4_22.halign = "grow"
	L2_20 = L2_20(L3_21, L4_22)
	A0_18._safe_panel = L2_20
	L2_20 = managers
	L2_20 = L2_20.menu
	L3_21 = L2_20
	L2_20 = L2_20.ingame_gui
	L2_20 = L2_20(L3_21)
	L3_21 = L2_20
	L2_20 = L2_20.safe_rect
	L2_20 = L2_20(L3_21)
	L3_21 = A0_18._safe_panel
	L3_21 = L3_21.set_shape
	L7_25 = L2_20.w
	L8_26 = L2_20.h
	L3_21(L4_22, L5_23, L6_24, L7_25, L8_26)
	L3_21 = A0_18._safe_panel
	L3_21 = L3_21.height
	L3_21 = L3_21(L4_22)
	A0_18._hud_element_stack = L4_22
	L7_25 = true
	A0_18._respawn_hud = L4_22
	A0_18._context_action_hud = L4_22
	L7_25 = true
	A0_18._context_cover_hud = L4_22
	A0_18._pick_up_action_hud = L4_22
	L7_25 = true
	A0_18._look_at_hud = L4_22
	L7_25 = L6_24
	L8_26 = {}
	L9_27 = A0_18._safe_panel
	L9_27 = L9_27.height
	L9_27 = L9_27(L10_28)
	L9_27 = L9_27 * 0.65
	L8_26.y = L9_27
	L14_32 = L6_24(L7_25, L8_26)
	A0_18._debug_text = L4_22
	L6_24.valign = "grow"
	L6_24.halign = "grow"
	L7_25 = A0_18._safe_panel
	L8_26 = L7_25
	L7_25 = L7_25.width
	L7_25 = L7_25(L8_26)
	L6_24.width = L7_25
	L7_25 = A0_18._safe_panel
	L8_26 = L7_25
	L7_25 = L7_25.height
	L7_25 = L7_25(L8_26)
	L7_25 = L7_25 * 0.5
	L6_24.height = L7_25
	A0_18._mission_objective_panel = L4_22
	A0_18._mission_objective_panel_fader = L4_22
	A0_18._mission_objective_hud = L4_22
	L6_24.valign = "grow"
	L6_24.halign = "grow"
	L7_25 = A0_18._safe_panel
	L8_26 = L7_25
	L7_25 = L7_25.width
	L7_25 = L7_25(L8_26)
	L6_24.width = L7_25
	L7_25 = A0_18._safe_panel
	L8_26 = L7_25
	L7_25 = L7_25.height
	L7_25 = L7_25(L8_26)
	L7_25 = L7_25 * 0.5
	L6_24.height = L7_25
	A0_18._delta_mission_objective_panel = L4_22
	A0_18._delta_mission_objective_panel_fader = L4_22
	L7_25 = A0_18._delta_mission_objective_panel
	A0_18._delta_mission_objective_hud = L4_22
	A0_18._reticule = L4_22
	A0_18._reticule_dot = L4_22
	A0_18._reticule_zoom = L4_22
	for L7_25, L8_26 in L4_22(L5_23) do
		L9_27 = {}
		for L13_31, L14_32 in L10_28(L11_29) do
			L9_27[L14_32] = {
				bitmap = A0_18._panel:bitmap({
					name = "reticule_" .. L14_32 .. "_" .. L8_26,
					texture = "gui_reticule_" .. L14_32 .. "_" .. L8_26,
					valign = "center",
					halign = "center",
					visible = false
				})
			}
		end
		L10_28[L8_26] = L9_27
		L13_31 = {}
		L14_32 = "reticule_dot_"
		L14_32 = L14_32 .. L8_26
		L13_31.name = L14_32
		L14_32 = "gui_reticule_dot_"
		L14_32 = L14_32 .. L8_26
		L13_31.texture = L14_32
		L13_31.valign = "center"
		L13_31.halign = "center"
		L13_31.visible = false
		L10_28[L8_26] = L11_29
		L9_27 = L10_28
		L13_31 = "reticule_zoom_base_"
		L14_32 = L8_26
		L13_31 = L13_31 .. L14_32
		L12_30.name = L13_31
		L13_31 = "gui_reticule_lines_base_"
		L14_32 = L8_26
		L13_31 = L13_31 .. L14_32
		L12_30.texture = L13_31
		L12_30.valign = "center"
		L12_30.halign = "center"
		L12_30.visible = false
		L9_27._zoom_base = L10_28
		L13_31 = "reticule_zoom_lock_"
		L14_32 = L8_26
		L13_31 = L13_31 .. L14_32
		L12_30.name = L13_31
		L13_31 = "gui_reticule_lines_lock_"
		L14_32 = L8_26
		L13_31 = L13_31 .. L14_32
		L12_30.texture = L13_31
		L12_30.valign = "center"
		L12_30.halign = "center"
		L12_30.visible = false
		L9_27._zoom_lock = L10_28
		L13_31 = "reticule_zoom_line_"
		L14_32 = L8_26
		L13_31 = L13_31 .. L14_32
		L12_30.name = L13_31
		L13_31 = "gui_reticule_lines_"
		L14_32 = L8_26
		L13_31 = L13_31 .. L14_32
		L12_30.texture = L13_31
		L12_30.valign = "center"
		L12_30.halign = "center"
		L12_30.visible = false
		L9_27._zoom_line = L10_28
		L10_28[L8_26] = L9_27
	end
	L7_25 = tweak_data
	L7_25 = L7_25.player
	L7_25 = L7_25.hud
	L7_25 = L7_25.RETICULE_FADE_SPEED
	A0_18._reticule_alpha_interpolator = L4_22
	L7_25 = tweak_data
	L7_25 = L7_25.player
	L7_25 = L7_25.hud
	L7_25 = L7_25.RETICULE_SCALE_SPEED
	A0_18._reticule_scale_interpolator = L4_22
	L7_25 = tweak_data
	L7_25 = L7_25.player
	L7_25 = L7_25.hud
	L7_25 = L7_25.RETICULE_DOT_FADE_SPEED
	A0_18._reticule_dot_interpolator = L4_22
	L7_25 = tweak_data
	L7_25 = L7_25.player
	L7_25 = L7_25.hud
	L7_25 = L7_25.RETICULE_ZOOM_FADE_SPEED
	A0_18._reticule_zoom_interpolator = L4_22
	if not L4_22 then
		A0_18._hit_indicator = L4_22
		for L7_25, L8_26 in L4_22(L5_23) do
			L9_27 = {}
			for L13_31, L14_32 in L10_28(L11_29) do
				L9_27[L14_32] = {
					bitmap = A0_18._panel:bitmap({
						name = "hit_indicator_" .. L14_32 .. "_" .. L8_26,
						texture = "gui_hit_indicator_" .. L14_32 .. "_" .. L8_26,
						valign = "center",
						halign = "center"
					})
				}
			end
			L10_28[L8_26] = L9_27
		end
		L7_25 = tweak_data
		L7_25 = L7_25.player
		L7_25 = L7_25.hud
		L7_25 = L7_25.HIT_INDICATOR_FADE_SPEED
		A0_18._hit_indicator_alpha_interpolator = L4_22
	end
	L7_25 = 1
	L8_26 = false
	L9_27 = 0
	L4_22(L5_23, L6_24, L7_25, L8_26, L9_27)
	L6_24.name = "damage_indicator"
	L6_24.texture = "gui_damage_indicator_right"
	A0_18._damage_indicator = L4_22
	L7_25 = L6_24
	L7_25 = L6_24
	L8_26 = 0
	L14_32 = L6_24(L7_25, L8_26)
	L4_22(L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L11_29, L12_30, L13_31, L14_32, L6_24(L7_25, L8_26))
	L7_25 = tweak_data
	L7_25 = L7_25.player
	L7_25 = L7_25.hud
	L7_25 = L7_25.DAMAGE_INDICATOR_FADE_SPEED
	A0_18._damage_indicator_alpha = L4_22
	L6_24.name = "damage_overlay"
	L6_24.texture = "gui_healthindicator_df"
	L6_24.valign = "grow"
	L6_24.halign = "grow"
	A0_18._damage_overlay = L4_22
	L7_25 = L6_24
	L14_32 = L6_24(L7_25)
	L4_22(L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L11_29, L12_30, L13_31, L14_32, L6_24(L7_25))
	L7_25 = L6_24
	L7_25 = L6_24
	L8_26 = 0
	L14_32 = L6_24(L7_25, L8_26)
	L4_22(L5_23, L6_24, L7_25, L8_26, L9_27, L10_28, L11_29, L12_30, L13_31, L14_32, L6_24(L7_25, L8_26))
	L7_25 = tweak_data
	L7_25 = L7_25.player
	L7_25 = L7_25.hud
	L7_25 = L7_25.DAMAGE_OVERLAY_INTERPOLATE_SPEED
	A0_18._damage_overlay_alpha = L4_22
	L7_25 = A0_18._safe_panel
	A0_18._weapon_hud = L4_22
	L7_25 = A0_18._safe_panel
	L8_26 = A0_18._inventory_icons
	A0_18._inventory_hud = L4_22
	L7_25 = 2
	A0_18._screen_overlay_alpha_interpolator = L4_22
	L7_25 = 2
	A0_18._mission_objective_panel_alpha = L4_22
	L6_24.layer = -1
	L7_25 = Color
	L8_26 = "111"
	L7_25 = L7_25(L8_26)
	L6_24.color = L7_25
	L6_24.blend_mode = "add"
	L6_24.halign = "grow"
	L6_24.valign = "grow"
	A0_18._screen_gun_flash_rect = L4_22
	L4_22(L5_23)
	L7_25 = tweak_data
	L7_25 = L7_25.player
	L7_25 = L7_25.hud
	L7_25 = L7_25.gun_flash
	L7_25 = L7_25.FADE_SPEED
	A0_18._gun_flash_alpha_interpolator = L4_22
	L7_25 = A0_18._safe_panel
	L8_26 = "quick_move_panel"
	A0_18._quick_move_hud = L4_22
	L7_25 = A0_18._safe_panel
	L8_26 = L7_25
	L7_25 = L7_25.width
	L7_25 = L7_25(L8_26)
	L7_25 = L7_25 * 0.5
	L5_23(L6_24, L7_25)
	L7_25 = A0_18._safe_panel
	L8_26 = L7_25
	L7_25 = L7_25.height
	L7_25 = L7_25(L8_26)
	L7_25 = L7_25 * 0.95
	L5_23(L6_24, L7_25)
end
function PlayerHud.update(A0_33, A1_34, A2_35, A3_36)
	if A0_33:has_panel() then
		A0_33:update_hud(A1_34, A3_36)
	end
end
function PlayerHud.update_hud(A0_37, A1_38, A2_39)
	A0_37._player_data.time_since_last_hit = A0_37._player_data.time_since_last_hit + A2_39
	A0_37:update_weapon(A1_38, A2_39)
	A0_37:update_hit_indicator(A2_39)
	A0_37:update_damage_indicator(A2_39)
	A0_37:update_damage_overlay(A2_39)
	A0_37._weapon_hud:update(A2_39)
	A0_37._inventory_hud:update(A2_39)
	A0_37:update_context_action(A2_39)
	A0_37:update_mission_objectives(A2_39)
	A0_37:update_screen_overlay(A2_39)
	A0_37:update_gun_flash_overlay(A2_39)
	A0_37:_update_quick_move()
	A0_37:update_projectile_weapon_reticule(A2_39)
	A0_37:update_overheat_hud(A2_39)
end
function PlayerHud.update_projectile_weapon_reticule(A0_40, A1_41)
	local L2_42, L3_43
	L2_42 = A0_40._unit
	L3_43 = L2_42
	L2_42 = L2_42.base
	L2_42 = L2_42(L3_43)
	L3_43 = L2_42
	L2_42 = L2_42.weapon
	L2_42 = L2_42(L3_43)
	L3_43 = L2_42.name
	L3_43 = L3_43(L2_42)
	if L3_43 == "rail_weapon_mk19_ring" then
		L3_43 = L2_42.base
		L3_43 = L3_43(L2_42)
		L3_43 = L3_43._reticule_scale
		L3_43 = L3_43 or 0
		if not A0_40._projectile_weapon_reticule_hud then
			A0_40._projectile_weapon_reticule_hud = ProjectileWeaponReticuleHud:new(A0_40._panel)
			A0_40._projectile_weapon_reticule_hud:set_reticule_scale(L3_43)
		end
		A0_40._projectile_weapon_reticule_hud:update(A1_41, A0_40._panel)
		A0_40._projectile_weapon_reticule_hud:set_player_control(A0_40._unit:base():player_has_control())
		for 