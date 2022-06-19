require("units/data/PlayerHudData")
require("units/beings/player/new_gui/WeaponSelectionPanel")
require("units/beings/player/new_gui/HurtDirectionIndicatorPanel")
require("units/beings/player/new_gui/NextCoverIndicatorPanel")
require("units/beings/player/new_gui/ContextPanel")
require("units/beings/player/new_gui/ReticulePanel")
require("units/beings/player/new_gui/AmmoPanel")
require("units/beings/player/new_gui/DustPanel")
require("units/beings/player/new_gui/StickDirectionPanel")
require("units/beings/player/new_gui/BattleAreaPanel")
require("units/beings/player/new_gui/HealthPanel")
require("units/beings/player/new_gui/HudUtility")
require("units/beings/player/gui/DebugText")
require("units/beings/player/gui/OverHeatHud")
require("menu/2D/Menu2DCameraNoise")
require("units/beings/player/new_gui/TeammateNamePanel")
require("units/beings/player/new_gui/FlashPanel")
require("units/beings/player/new_gui/WeakspotsPanel")
NewPlayerHud = NewPlayerHud or class()
function NewPlayerHud.init(A0_0, A1_1)
	A0_0._player_unit = A1_1
	A0_0._player_data = A0_0._player_unit:player_data()
	if A0_0._player_unit:base() then
		A0_0._inventory = A0_0._player_unit:base():inventory()
	end
	A0_0._preload_textures()
	A0_0.user_viewport = nil
	managers.post_update_manager:register(A1_1, A0_0)
	A0_0._dt = 0
	A0_0._ammo_queue_list = {}
end
function NewPlayerHud.post_update(A0_2)
	if A0_2._hud_is_hidden then
		return
	end
	if alive(A0_2._player_unit) and A0_2._weakspots_panel and alive(A0_2._weakspots_panel:panel()) then
		A0_2._weakspots_panel:update(A0_2._dt)
	end
	if alive(A0_2._player_unit) and A0_2._teammate_name_panel and alive(A0_2._teammate_name_panel:panel()) then
		A0_2._teammate_name_panel:update(A0_2._dt)
	end
end
function NewPlayerHud._preload_textures(A0_3)
	Overlay:gui():preload_texture("gui_damage_indicator")
	Overlay:gui():preload_texture("gui_weaponselection_gradient")
	Overlay:gui():preload_texture("gui_coverdirection_icon")
	Overlay:gui():preload_texture("gui_weakspot_marker")
	Overlay:gui():preload_texture("gui_wpn_icon_small_bg")
	Overlay:gui():preload_texture("gui_wpn_icon_small_sg")
	Overlay:gui():preload_texture("gui_wpn_icon_small_ar")
	Overlay:gui():preload_texture("gui_wpn_icon_small_g")
	Overlay:gui():preload_texture("gui_wpn_icon_small_gl")
	Overlay:gui():preload_texture("gui_wpn_icon_small_rl")
	Overlay:gui():preload_texture("gui_wpn_icon_small_pb")
	Overlay:gui():preload_texture("gui_wpn_icon_shotgun")
	Overlay:gui():preload_texture("gui_wpn_icon_rocketlauncher")
	Overlay:gui():preload_texture("gui_wpn_icon_pipebomb")
	Overlay:gui():preload_texture("gui_wpn_icon_grenadelauncher")
	Overlay:gui():preload_texture("gui_wpn_icon_grenade")
	Overlay:gui():preload_texture("gui_wpn_icon_assaultrifle")
	Overlay:gui():preload_texture("gui_wpn_icon_machinegun")
	Overlay:gui():preload_texture("gui_wpn_icon_shotgun_s")
	Overlay:gui():preload_texture("gui_wpn_icon_rocketlauncher_s")
	Overlay:gui():preload_texture("gui_wpn_icon_grenadelauncher_s")
	Overlay:gui():preload_texture("gui_wpn_icon_assaultrifle_s")
	Overlay:gui():preload_texture("gui_wpn_icon_machinegun_s")
	Overlay:gui():preload_texture("gui_machine_bar_small")
	Overlay:gui():preload_texture("gui_screeneffect_blood_01")
	Overlay:gui():preload_texture("gui_screeneffect_dust_01")
	Overlay:gui():preload_texture("gui_sceeneffect_dust_gradient")
	Overlay:gui():preload_texture("gui_crosshair_grenadelauncher")
	Overlay:gui():preload_texture("gui_healthindicator_df")
	Overlay:gui():preload_texture("gui_hud_selection_dot")
	Overlay:gui():preload_texture("gui_reticule_top_normal")
	Overlay:gui():preload_texture("gui_reticule_top_enemy")
	Overlay:gui():preload_texture("gui_saving_icon")
	Overlay:gui():preload_texture("gui_saving_hilight")
	Overlay:gui():preload_texture("gui_health_icon")
	Overlay:gui():preload_texture("gui_healthmeter_bg")
	Overlay:gui():preload_texture("gui_healthmeter_bar_glow")
	Overlay:gui():preload_texture("gui_inv_empty")
	Overlay:gui():preload_texture("gui_healthmeter_edge")
	Overlay:gui():preload_texture("gui_healthmeter_bar")
	Overlay:gui():preload_texture("gui_screeneffect_dust_02")
	Overlay:gui():preload_texture("security_camera_edgebleed")
	Overlay:gui():preload_texture("security_camera_noise_1")
	Overlay:gui():preload_texture("security_camera_noise_2")
	Overlay:gui():preload_texture("security_camera_noise_3")
	Overlay:gui():preload_texture("security_camera_noise_4")
end
function NewPlayerHud.destroy(A0_4)
	if alive(A0_4._panel) then
		A0_4._panel:clear()
	end
	if A0_4._debug_text then
		A0_4._debug_text:destroy()
	end
	if A0_4._context_panel ~= nil then
		managers.action_event:unregister_listener(A0_4)
	end
end
function NewPlayerHud.has_panel(A0_5)
	local L1_6
	L1_6 = A0_5._panel
	return L1_6
end
function NewPlayerHud.release_gui_panel(A0_7)
	if A0_7._panel then
		A0_7._panel:clear()
	end
	A0_7._panel = nil
end
function NewPlayerHud.set_gui_panel(A0_8, A1_9, A2_10)
	A0_8._user_viewport = A2_10
	A0_8._last_frame_battle_area_timer = -1
	A0_8._panel = A1_9:panel({
		name = "root_panel",
		valign = "grow",
		halign = "grow"
	})
	A0_8._panel:set_size(A1_9:size())
	A0_8._safe_panel = A0_8._panel:panel({
		name = "safe_panel",
		valign = "grow",
		halign = "grow"
	})
	A0_8._safe_panel:set_shape(managers.menu:ingame_gui():safe_rect().x, managers.menu:ingame_gui():safe_rect().y, managers.menu:ingame_gui():safe_rect().w, managers.menu:ingame_gui():safe_rect().h)
	A0_8._weapon_selection_panel = WeaponSelectionPanel:new(A0_8._panel, A0_8._player_unit, A0_8._inventory_icons)
	A0_8._health_panel = HealthPanel:new(A0_8._panel, A0_8._safe_panel, A0_8._player_unit)
	A0_8._hurt_direction_indicator_panel = HurtDirectionIndicatorPanel:new(A0_8._panel, A0_8._player_unit)
	A0_8._next_cover_indicator_panel = NextCoverIndicatorPanel:new(A0_8._panel, A0_8._player_unit)
	A0_8._reticule_panel = ReticulePanel:new(A0_8._panel, A0_8._player_unit)
	A0_8._stick_direction_panel = StickDirectionPanel:new(A0_8._panel, A0_8._player_unit)
	A0_8._context_panel = ContextPanel:new(A0_8._safe_panel, A0_8._player_unit)
	A0_8._ammo_panel = AmmoPanel:new(A0_8._safe_panel, A0_8._player_unit)
	A0_8._weakspots_panel = WeakspotsPanel:new(A0_8._panel, A0_8._player_unit, A0_8._user_viewport)
	A0_8._dust_panel = DustPanel:new(A0_8._panel, A0_8._player_unit)
	A0_8._gun_flash_panel = FlashPanel:new(A0_8._panel, A0_8._player_unit)
	A0_8._noice = Menu2DCameraNoise:new(A0_8._panel, A0_8._player_unit)
	A0_8._noice:start(true, "ingame")
	A0_8._battle_area_panel = BattleAreaPanel:new(A0_8._safe_panel, A0_8._player_unit)
	A0_8._teammate_name_panel = TeammateNamePanel:new(A0_8._panel, A0_8._player_unit, A0_8._user_viewport)
	A0_8._debug_text = DebugText:new(A0_8._safe_panel:panel({
		y = A0_8._safe_panel:height() * 0.65
	}))
	A0_8._overheat_hud = OverHeatHud:new(A0_8._safe_panel, A0_8._player_unit, true, true)
	managers.action_event:register_listener(A0_8, A0_8._player_unit, A0_8._player_unit)
	A0_8:_hide_player_hud()
	A0_8._is_split_screen = HudUtility.is_split_screen()
	A0_8:_set_localizer_mapping()
end
function NewPlayerHud.update(A0_11, A1_12, A2_13, A3_14)
	A0_11._dt = A3_14
	A0_11._t = A2_13
	if A0_11:has_panel() then
		if managers.game:is_paused() or managers.worldcamera:current_world_camera() then
			if not A0_11._hud_is_hidden then
				Application:debug("hiding hud for ", A0_11._player_unit)
				A0_11:_hide_player_hud()
			end
			return
		end
		A0_11:_show_player_hud()
		if not A0_11._player_data.on_destroyed_rail_vehicle then
			A0_11:_update_weapon_selection_panel(A3_14)
			A0_11:_update_hurt_direction_indicator_panel(A3_14)
			A0_11:_update_next_cover_indicator_panel(A3_14)
			A0_11:_update_reticule_panel(A3_14)
			A0_11:_update_context_panel(A2_13, A3_14)
			A0_11:_update_ammo_panel(A2_13, A3_14)
			A0_11:_update_dust_panel(A3_14)
			A0_11:_update_stick_direction_panel(A3_14)
			A0_11._debug_text:update(A3_14)
			A0_11:_update_subtitles_font_size(A3_14)
			A0_11:_update_gun_flash_panel(A3_14)
			A0_11:_update_noice(A3_14)
			A0_11:_update_battle_area_panel(A3_14)
		else
			A0_11:_hide_player_hud()
		end
		A0_11:_update_health_panel(A2_13, A3_14)
	end
end
function NewPlayerHud._update_battle_area_panel(A0_15, A1_16)
	if A0_15._battle_area_panel:next_update(A1_16) then
		if A0_15._player_data.has_left_battle_area_timer ~= -1 or A0_15._player_data.has_left_battle_area_time_out then
			if not A0_15._battle_area_panel:visible() then
				A0_15._battle_area_panel:show()
			end
			A0_15._battle_area_panel:update(A1_16)
		elseif A0_15._battle_area_panel:visible() then
			A0_15._battle_area_panel:hide()
			A0_15._battle_area_panel:update(A1_16)
		else
			A0_15._battle_area_panel:use_low_frequency_update()
		end
	end
end
function NewPlayerHud._update_weapon_selection_panel(A0_17, A1_18)
	if A0_17._weapon_selection_panel:next_update(A1_18) then
		if A0_17._player_data.hud_inventory_show and not A0_17._player_data._in_stationary_weapon then
			if not A0_17._weapon_selection_panel:visible() then
				A0_17._weapon_selection_panel:show()
			end
			A0_17._weapon_selection_panel:update(A1_18, true)
		elseif A0_17._weapon_selection_panel:visible() then
			A0_17._weapon_selection_panel:hide()
			A0_17._weapon_selection_panel:update(A1_18, false)
		else
			A0_17._weapon_selection_panel:use_low_frequency_update()
		end
	end
end
function NewPlayerHud._update_hurt_direction_indicator_panel(A0_19, A1_20)
	local L2_21, L3_22
	L2_21 = A0_19._hurt_direction_indicator_panel
	L3_22 = L2_21
	L2_21 = L2_21.next_update
	L2_21 = L2_21(L3_22, A1_20)
	if L2_21 then
		L2_21, L3_22 = nil, nil
		if A0_19._player_data.on_rail_vehicle and tweak_data.player.new_hud.hurt_direction_indicator_panel.USE_HURT_DIRECTION_ON_RAIL_VEHICLE then
			L2_21 = A0_19._player_data.on_rail_vehicle:damage()._time_since_damage
			L3_22 = A0_19._player_data.on_rail_vehicle:damage()._last_hit_direction
		else
			L2_21 = A0_19._player_data.time_since_damage
			L3_22 = A0_19._player_data.last_hit_direction
		end
		if L2_21 and L2_21 < tweak_data.player.hud.DAMAGE_INDICATOR_STAY_TIME then
			A0_19._hurt_direction_indicator_panel:update(A1_20, L2_21, L3_22)
		elseif A0_19._hurt_direction_indicator_panel:visible() then
			A0_19._hurt_direction_indicator_panel:update(A1_20)
		else
			A0_19._hurt_direction_indicator_panel:use_low_frequency_update()
		end
	end
end
function NewPlayerHud._update_next_cover_indicator_panel(A0_23, A1_24)
	if A0_23._next_cover_indicator_panel:next_update(A1_24) then
		if A0_23._player_data.quick_move_info_index > 0 and not A0_23._player_data.is_precision_aiming then
			A0_23._next_cover_indicator_panel:show()
			A0_23._next_cover_indicator_panel:update(A1_24)
		elseif A0_23._next_cover_indicator_panel:visible() then
			A0_23._next_cover_indicator_panel:hide()
			A0_23._next_cover_indicator_panel:update(A1_24)
		else
			A0_23._next_cover_indicator_panel:use_low_frequency_update()
		end
	end
end
function NewPlayerHud._update_reticule_panel(A0_25, A1_26)
	if A0_25._player_data.is_precision_aiming and not A0_25._reticule_panel:visible() then
		A0_25._reticule_panel:use_high_frequency_update()
	end
	if A0_25._reticule_panel:next_update(A1_26) then
		if A0_25._player_data.is_precision_aiming or A0_25._player_data._in_stationary_weapon or A0_25:_on_rail_vehicle() then
			A0_25:_update_reticule_type()
			A0_25._reticule_panel:show()
			A0_25._reticule_panel:update(A1_26, A0_25._player_data.aim_target_unit)
		elseif A0_25._reticule_panel:visible() then
			A0_25._reticule_panel:hide()
			A0_25._reticule_panel:update(A1_26, A0_25._player_data.aim_target_unit)
		else
			A0_25._reticule_panel:use_low_frequency_update()
		end
	end
end
function NewPlayerHud._update_weakspots_panel(A0_27, A1_28)
	if A0_27._player_data.weakspot_unit_list and #A0_27._player_data.weakspot_unit_list > 0 then
		A0_27._weakspots_panel:show()
		A0_27._weakspots_panel:update(A1_28)
	elseif A0_27._weakspots_panel:visible() then
		A0_27._weakspots_panel:hide()
	end
end
function NewPlayerHud._update_reticule_type(A0_29)
	local L1_30
	if A0_29._player_unit:base():weapon() and A0_29._player_unit:base():weapon():hud() then
		L1_30 = A0_29._player_unit:base():weapon():hud()
	end
	if L1_30 then
		if L1_30:reticule_type() == "circular_trajectory_reticule" then
			A0_29._reticule_panel:use_circular_trajectory_reticule()
		elseif L1_30:reticule_type() == "trajectory_reticule" then
			A0_29._reticule_panel:use_trajectory_reticule()
		else
			A0_29._reticule_panel:use_circle_reticule()
		end
	else
		A0_29._reticule_panel:use_circle_reticule()
	end
end
function NewPlayerHud._update_context_panel(A0_31, A1_32, A2_33)
	local L3_34, L4_35, L5_36, L6_37, L7_38
	L3_34 = A0_31._player_data
	L3_34 = L3_34.interact_will_only_pick_up_ammo
	if L3_34 then
		L3_34 = A0_31._context_panel
		L4_35 = L3_34
		L3_34 = L3_34.use_high_frequency_update
		L3_34(L4_35)
	end
	L3_34 = A0_31._context_panel
	L4_35 = L3_34
	L3_34 = L3_34.next_update
	L5_36 = A2_33
	L3_34 = L3_34(L4_35, L5_36)
	if L3_34 then
		L3_34 = A0_31._is_split_screen
		if L3_34 then
			L3_34 = A0_31._weapon_selection_panel
			L4_35 = L3_34
			L3_34 = L3_34.visible
			L3_34 = L3_34(L4_35)
			if not L3_34 then
				L3_34 = A0_31._last_frame_battle_area_timer
			elseif L3_34 > 0 then
				L3_34 = A0_31._context_panel
				L4_35 = L3_34
				L3_34 = L3_34.is_visible
				L5_36 = "cover"
				L3_34 = L3_34(L4_35, L5_36)
				if L3_34 then
					L3_34 = A0_31._context_panel
					L4_35 = L3_34
					L3_34 = L3_34.instant_hide
					L5_36 = "cover"
					L3_34(L4_35, L5_36)
				end
				L3_34 = A0_31._context_panel
				L4_35 = L3_34
				L3_34 = L3_34.is_visible
				L5_36 = "action"
				L3_34 = L3_34(L4_35, L5_36)
				if L3_34 then
					L3_34 = A0_31._context_panel
					L4_35 = L3_34
					L3_34 = L3_34.instant_hide
					L5_36 = "action"
					L3_34(L4_35, L5_36)
				end
				L3_34 = A0_31._context_panel
				L4_35 = L3_34
				L3_34 = L3_34.is_visible
				L5_36 = "message"
				L3_34 = L3_34(L4_35, L5_36)
				if L3_34 then
					L3_34 = A0_31._context_panel
					L4_35 = L3_34
					L3_34 = L3_34.instant_hide
					L5_36 = "message"
					L3_34(L4_35, L5_36)
				end
				return
			end
		end
		L3_34 = false
		L4_35 = A0_31._player_data
		L4_35 = L4_35.current_interactable
		L5_36 = A0_31._player_data
		L5_36 = L5_36.can_enter_cover
		if L5_36 then
			L5_36 = A0_31._context_panel
			L6_37 = L5_36
			L5_36 = L5_36.display
			L7_38 = "cover"
			L5_36(L6_37, L7_38, "context_cover_new")
			L3_34 = true
		else
			L5_36 = A0_31._context_panel
			L6_37 = L5_36
			L5_36 = L5_36.is_visible
			L7_38 = "cover"
			L5_36 = L5_36(L6_37, L7_38)
			if L5_36 then
				L5_36 = A0_31._context_panel
				L6_37 = L5_36
				L5_36 = L5_36.hide
				L7_38 = "cover"
				L5_36(L6_37, L7_38)
				L3_34 = true
			end
		end
		L5_36 = alive
		L6_37 = L4_35
		L5_36 = L5_36(L6_37)
		if L5_36 then
			L5_36 = A0_31._player_data
			L5_36 = L5_36.interact_will_only_pick_up_ammo
			if not L5_36 then
				L5_36 = A0_31._player_data
				L5_36 = L5_36.in_cover
				if not L5_36 then
					L5_36 = A0_31._player_data
					L5_36 = L5_36.quick_moving
					if not L5_36 then
						L5_36 = nil
						L7_38 = L4_35
						L6_37 = L4_35.hud
						L6_37 = L6_37(L7_38)
						if L6_37 then
							L7_38 = L6_37.small_texture_name
							L7_38 = L7_38(L6_37)
							L5_36 = L7_38
						else
							L7_38 = L4_35.name
							L7_38 = L7_38(L4_35)
							L5_36 = L7_38
						end
						L7_38 = A0_31._player_data
						L7_38 = L7_38.interact_will_only_pick_up_ammo
						if not L7_38 then
							L7_38 = A0_31._player_data
							L7_38 = L7_38.interact_use
							if L7_38 then
								L7_38 = A0_31._stationary_weapon_texture
								if L7_38 then
									L7_38 = A0_31._stationary_weapon_texture
								elseif L7_38 ~= L5_36 then
									L7_38 = Localizer
									L7_38 = L7_38.lookup
									L7_38 = L7_38(L7_38, L5_36)
									A0_31._stationary_weapon_string = L7_38
									A0_31._stationary_weapon_texture = L5_36
								end
								L7_38 = A0_31._context_panel
								L7_38 = L7_38.display
								L7_38(L7_38, "action", "context_use_new", A0_31._stationary_weapon_string)
								L7_38 = A0_31._context_panel
								L7_38 = L7_38.set_minimum_display_time
								L7_38(L7_38, "action", 0, A1_32)
							else
								L7_38 = A0_31._context_panel
								L7_38 = L7_38.display
								L7_38(L7_38, "action", "context_pick_up_new", L5_36)
								L7_38 = A0_31._context_panel
								L7_38 = L7_38.set_minimum_display_time
								L7_38(L7_38, "action", 0, A1_32)
							end
						end
						L3_34 = true
					end
				end
			end
		else
			L5_36 = A0_31._player_data
			L5_36 = L5_36.look_at_position
			if L5_36 then
				L5_36 = A0_31._context_panel
				L6_37 = L5_36
				L5_36 = L5_36.display
				L7_38 = "action"
				L5_36(L6_37, L7_38, "context_look_at_new")
				L5_36 = A0_31._context_panel
				L6_37 = L5_36
				L5_36 = L5_36.set_minimum_display_time
				L7_38 = "action"
				L5_36(L6_37, L7_38, 0, A1_32)
				L3_34 = true
			else
				L5_36 = A0_31._player_data
				L5_36 = L5_36.can_revive
				if L5_36 then
					L5_36 = A0_31._player_data
					L5_36 = L5_36.is_down
					if not L5_36 then
						L5_36 = alive
						L6_37 = A0_31._player_unit
						L5_36 = L5_36(L6_37)
						if L5_36 then
							L5_36 = A0_31._player_data
							L5_36 = L5_36.in_cover
							if not L5_36 then
								L5_36 = A0_31._player_data
								L5_36 = L5_36.quick_moving
								if not L5_36 then
									L5_36 = A0_31._context_panel
									L6_37 = L5_36
									L5_36 = L5_36.display
									L7_38 = "action"
									L5_36(L6_37, L7_38, "context_revive_new")
									L5_36 = A0_31._context_panel
									L6_37 = L5_36
									L5_36 = L5_36.set_minimum_display_time
									L7_38 = "action"
									L5_36(L6_37, L7_38, 0, A1_32)
									L3_34 = true
								end
							end
						end
					end
				else
					L5_36 = A0_31._player_data
					L5_36 = L5_36._in_stationary_weapon
					if L5_36 then
						L5_36 = A0_31._stationary_weapon_texture
						if L5_36 then
							L5_36 = A0_31._context_panel
							L6_37 = L5_36
							L5_36 = L5_36.display
							L7_38 = "action"
							L5_36(L6_37, L7_38, "context_leave_new", A0_31._stationary_weapon_string)
							L5_36 = A0_31._context_panel
							L6_37 = L5_36
							L5_36 = L5_36.set_minimum_display_time
							L7_38 = "action"
							L5_36(L6_37, L7_38, 5, A1_32)
							A0_31._stationary_weapon_texture = nil
							L3_34 = true
						end
					else
						L5_36 = A0_31._context_panel
						L6_37 = L5_36
						L5_36 = L5_36.is_visible
						L7_38 = "action"
						L5_36 = L5_36(L6_37, L7_38)
						if not L5_36 then
							L5_36 = A0_31._context_panel
							L6_37 = L5_36
							L5_36 = L5_36.timed_out
							L7_38 = "action"
							L5_36 = L5_36(L6_37, L7_38)
						elseif L5_36 then
							L5_36 = A0_31._context_panel
							L6_37 = L5_36
							L5_36 = L5_36.hide
							L7_38 = "action"
							L5_36(L6_37, L7_38)
							L3_34 = true
						end
					end
				end
			end
		end
		L5_36 = A0_31._ammo_queue_list
		L5_36 = L5_36[1]
		if L5_36 then
			L5_36 = A0_31._context_panel
			L6_37 = L5_36
			L5_36 = L5_36.is_visible
			L7_38 = "message"
			L5_36 = L5_36(L6_37, L7_38)
			if L5_36 then
				L5_36 = A0_31._context_panel
				L5_36 = L5_36._context_items
				L5_36 = L5_36.message
				L6_37 = L5_36
				L5_36 = L5_36.wants_to_fade_out
				L5_36 = L5_36(L6_37)
				if L5_36 then
					L5_36 = A0_31._context_panel
					L5_36 = L5_36._context_items
					L5_36 = L5_36.message
					L5_36 = L5_36._alpha
				end
			elseif L5_36 < 0.1 then
				L5_36 = TableAlgorithms
				L5_36 = L5_36.count
				L6_37 = A0_31._ammo_queue_list
				L5_36 = L5_36(L6_37)
				if L5_36 > 1 then
					L6_37 = A0_31
					L5_36 = A0_31.merge_duplicates_in_queue_list
					L5_36(L6_37)
				end
				L5_36 = A0_31._ammo_queue_list
				L5_36 = L5_36[1]
				L5_36 = L5_36.ammo_icon_texture
				L6_37 = A0_31._ammo_queue_list
				L6_37 = L6_37[1]
				L6_37 = L6_37.weapon_icon_texture
				L7_38 = A0_31._ammo_queue_list
				L7_38 = L7_38[1]
				L7_38 = L7_38.bullets
				if L5_36 then
					A0_31._context_panel:display("message", "context_fill_ammo_new", L5_36, L7_38, L6_37)
					A0_31._context_panel:set_minimum_display_time("message", 2, A0_31._t)
				else
					A0_31._context_panel:display("message", "context_fill_ammo_no_weapon_new", L6_37, L7_38)
					A0_31._context_panel:set_minimum_display_time("message", 2, A0_31._t)
				end
				table.remove(A0_31._ammo_queue_list, 1)
				L3_34 = true
			end
		end
		L5_36 = A0_31._context_panel
		L6_37 = L5_36
		L5_36 = L5_36.is_visible
		L7_38 = "message"
		L5_36 = L5_36(L6_37, L7_38)
		if not L5_36 then
			L5_36 = A0_31._context_panel
			L6_37 = L5_36
			L5_36 = L5_36.timed_out
			L7_38 = "message"
			L5_36 = L5_36(L6_37, L7_38)
		elseif L5_36 then
			L5_36 = A0_31._context_panel
			L6_37 = L5_36
			L5_36 = L5_36.hide
			L7_38 = "message"
			L5_36(L6_37, L7_38)
			L3_34 = true
		end
		if not L3_34 then
			L5_36 = A0_31._context_panel
			L6_37 = L5_36
			L5_36 = L5_36.active_context
			L5_36 = L5_36(L6_37)
		else
			if L5_36 then
				L5_36 = A0_31._context_panel
				L6_37 = L5_36
				L5_36 = L5_36.update
				L7_38 = A1_32
				L5_36(L6_37, L7_38, A2_33)
		end
		else
			L5_36 = A0_31._context_panel
			L6_37 = L5_36
			L5_36 = L5_36.use_low_frequency_update
			L5_36(L6_37)
		end
	end
end
function NewPlayerHud.merge_duplicates_in_queue_list(A0_39)
	local L1_40, L2_41, L3_42, L4_43, L5_44
	L1_40 = TableAlgorithms
	L1_40 = L1_40.count
	L1_40 = L1_40(L2_41)
	for L5_44 = 2, L1_40 do
		if A0_39._ammo_queue_list[1].weapon_icon_texture == A0_39._ammo_queue_list[L5_44].weapon_icon_texture and A0_39._ammo_queue_list[1].ammo_icon_texture == A0_39._ammo_queue_list[L5_44].ammo_icon_texture then
			A0_39._ammo_queue_list[1].bullets = A0_39._ammo_queue_list[1].bullets + A0_39._ammo_queue_list[L5_44].bullets
			A0_39._ammo_queue_list[L5_44].bullets = 0
		end
	end
	for L5_44 = L1_40, 1, -1 do
		if A0_39._ammo_queue_list[L5_44].bullets == 0 then
			table.remove(A0_39._ammo_queue_list, L5_44)
		end
	end
end
function NewPlayerHud.unit_ammo_fill(A0_45, A1_46, A2_47, A3_48)
	local L4_49, L5_50, L6_51, L7_52
	if A2_47 > 0 then
		L4_49 = A3_48._unit
		L5_50, L6_51, L7_52 = nil, nil, nil
		if L4_49:hud() then
			L5_50 = L4_49:hud():small_texture_name()
		else
			L5_50 = interactable:name()
		end
		if L4_49:base()._projectile_spawner then
			L7_52 = L4_49:base()._projectile_spawner:hud()
		end
		if L7_52 then
			L6_51 = L7_52:texture_name()
		end
		if L5_50 then
			table.insert(A0_45._ammo_queue_list, {
				weapon_icon_texture = L5_50,
				ammo_icon_texture = L6_51,
				bullets = A2_47
			})
		end
	end
end
function NewPlayerHud._update_ammo_panel(A0_53, A1_54, A2_55)
	local L3_56, L4_57, L5_58, L6_59, L7_60, L8_61, L9_62, L10_63, L11_64
	L3_56 = A0_53._ammo_panel
	L4_57 = L3_56
	L3_56 = L3_56.next_update
	L5_58 = A2_55
	L3_56 = L3_56(L4_57, L5_58)
	if L3_56 then
		L3_56 = A0_53._player_unit
		L4_57 = L3_56
		L3_56 = L3_56.base
		L3_56 = L3_56(L4_57)
		L4_57 = L3_56
		L3_56 = L3_56.weapon
		L3_56 = L3_56(L4_57)
		L5_58 = A0_53
		L4_57 = A0_53._on_rail_vehicle
		L4_57 = L4_57(L5_58)
		if L4_57 then
			L4_57 = A0_53._ammo_panel
			L5_58 = L4_57
			L4_57 = L4_57.visible
			L4_57 = L4_57(L5_58)
			if L4_57 then
				L4_57 = A0_53._ammo_panel
				L5_58 = L4_57
				L4_57 = L4_57.hide
				L4_57(L5_58)
				L4_57 = A0_53._ammo_panel
				L5_58 = L4_57
				L4_57 = L4_57.update
				L6_59 = A2_55
				L4_57(L5_58, L6_59)
			end
			L5_58 = L3_56
			L4_57 = L3_56.logic
			L4_57 = L4_57(L5_58)
			L5_58 = L4_57
			L4_57 = L4_57.has_overheat
			L4_57 = L4_57(L5_58)
			if L4_57 then
				L5_58 = L3_56
				L4_57 = L3_56.logic
				L4_57 = L4_57(L5_58)
				L5_58 = L4_57
				L4_57 = L4_57.show_overheat_hud
				L4_57 = L4_57(L5_58)
				if L4_57 then
					L4_57 = A0_53._ammo_panel
					L5_58 = L4_57
					L4_57 = L4_57.use_high_frequency_update
					L4_57(L5_58)
					L4_57 = A0_53._overheat_hud
					L5_58 = L4_57
					L4_57 = L4_57.show
					L6_59 = L3_56
					L4_57(L5_58, L6_59)
					L4_57 = A0_53._overheat_hud
					L5_58 = L4_57
					L4_57 = L4_57.update
					L6_59 = A2_55
					L4_57(L5_58, L6_59)
				end
			else
				L4_57 = A0_53._overheat_hud
				L5_58 = L4_57
				L4_57 = L4_57.visible
				L4_57 = L4_57(L5_58)
				if L4_57 then
					L4_57 = A0_53._overheat_hud
					L5_58 = L4_57
					L4_57 = L4_57.hide
					L4_57(L5_58)
					L4_57 = A0_53._overheat_hud
					L5_58 = L4_57
					L4_57 = L4_57.update
					L6_59 = A2_55
					L4_57(L5_58, L6_59)
				else
					L4_57 = A0_53._ammo_panel
					L5_58 = L4_57
					L4_57 = L4_57.use_low_frequency_update
					L4_57(L5_58)
				end
			end
			return
		end
		L4_57 = A0_53._player_unit
		L5_58 = L4_57
		L4_57 = L4_57.base
		L4_57 = L4_57(L5_58)
		L5_58 = L4_57
		L4_57 = L4_57.weapon_data
		L4_57 = L4_57(L5_58)
		if not L4_57 then
			return
		end
		L6_59 = L4_57
		L5_58 = L4_57.ammo_pool
		L5_58 = L5_58(L6_59)
		L7_60 = L4_57
		L6_59 = L4_57.bullets_in_clip
		L6_59 = L6_59(L7_60)
		L7_60 = A0_53._player_data
		L7_60 = L7_60.hud_inventory_secondary_active_slot
		L8_61, L9_62, L10_63 = nil, nil, nil
		if L7_60 then
			L11_64 = A0_53._inventory
			L11_64 = L11_64.item_by_index
			L11_64 = L11_64(L11_64, L7_60)
			L8_61 = L11_64
			L11_64 = alive
			L11_64 = L11_64(L8_61)
			if L11_64 then
				L11_64 = L8_61.weapon_data
				L11_64 = L11_64(L8_61)
				L9_62 = L11_64
				L11_64 = L9_62.ammo_pool
				L11_64 = L11_64(L9_62)
				L10_63 = L11_64
			end
		end
		L11_64 = A0_53._player_data
		L11_64 = L11_64.firing
		if A0_53._previous_bullets_in_clip and L6_59 ~= A0_53._previous_bullets_in_clip then
			L11_64 = true
		elseif A0_53._player_data.throwing_grenade then
			L11_64 = true
		end
		if A0_53._primary_ammo and L5_58 ~= A0_53._primary_ammo then
		else
		end
		if A0_53._player_data.switching_weapon then
		else
		end
		A0_53._previous_bullets_in_clip = L6_59
		A0_53._primary_ammo = L5_58
		A0_53._secondary_ammo = L10_63
		A0_53._previous_secondary_weapon_slot = L7_60
		A0_53._ammo_panel_showing = false
		if A0_53._player_data.is_precision_aiming or L11_64 or true or true or A0_53._player_data.reloading or A0_53._player_data.hud_inventory_show then
			A0_53._ammo_panel:show()
			A0_53._ammo_panel:update(A1_54, A2_55, L3_56, L8_61, L11_64)
			A0_53._ammo_panel_showing = true
		elseif A0_53._ammo_panel:visible() then
			A0_53._ammo_panel:hide()
			A0_53._ammo_panel:update(A1_54, A2_55)
		else
			A0_53._ammo_panel:use_low_frequency_update()
		end
	end
end
function NewPlayerHud._update_health_panel(A0_65, A1_66, A2_67)
	if A0_65._health_panel:next_update(A2_67) then
		if A0_65._player_data.on_rail_vehicle then
			if A0_65._player_data.rail_player_escort_unit then
				if alive(A0_65._player_data.rail_player_escort_unit) then
				else
				end
			else
			end
		elseif A0_65._player_data.on_destroyed_rail_vehicle then
		else
		end
		if 0 < A0_65._player_unit:damage_data().damage then
			A0_65._health_panel:show()
			A0_65._health_panel:update(A1_66, A2_67)
		elseif A0_65._health_panel:visible() or A0_65._health_panel:hidden() then
			A0_65._health_panel:update(A1_66, A2_67)
		else
			A0_65._health_panel:use_low_frequency_update()
		end
	end
end
function NewPlayerHud._update_damage_overlay_panel(A0_68, A1_69)
	local L2_70
	if A0_68._player_data.on_rail_vehicle then
		L2_70 = A0_68._player_data.on_rail_vehicle:damage_data()
	else
		L2_70 = A0_68._player_unit:damage_data()
	end
	A0_68._damage_overlay_panel:update(A1_69, L2_70)
end
function NewPlayerHud.set_debug_text(A0_71, A1_72)
	if A0_71._debug_text then
		A0_71._debug_text:show_next_line(A1_72)
	end
end
function NewPlayerHud.unit_explode(A0_73, A1_74, A2_75, A3_76)
	if not A0_73._dust_panel then
		return
	end
	if not A0_73._dust_panel:done() then
		A0_73._dust_panel:show(A2_75)
		A0_73._dust_panel:use_high_frequency_update()
	end
end
function NewPlayerHud.unit_player_received_ammo_from_player(A0_77, A1_78, A2_79)
	local L3_80, L4_81, L5_82, L6_83, L7_84, L8_85
	L3_80 = A0_77._player_unit
	L4_81 = L3_80
	L3_80 = L3_80.base
	L3_80 = L3_80(L4_81)
	L4_81 = L3_80
	L3_80 = L3_80.weapon
	L3_80 = L3_80(L4_81)
	L4_81 = A0_77._player_unit
	L5_82 = L4_81
	L4_81 = L4_81.base
	L4_81 = L4_81(L5_82)
	L5_82 = L4_81
	L4_81 = L4_81.weapon_data
	L4_81 = L4_81(L5_82)
	L5_82 = L4_81._clip_size
	L6_83 = tweak_data
	L6_83 = L6_83.player
	L6_83 = L6_83.RECEIVE_AMMO_SIZE_MULTIPLIER
	L5_82 = L5_82 * L6_83
	L6_83 = nil
	L8_85 = L3_80
	L7_84 = L3_80.hud
	L7_84 = L7_84(L8_85)
	if L7_84 then
		L8_85 = L7_84.small_texture_name
		L8_85 = L8_85(L7_84)
		L6_83 = L8_85
	else
		L8_85 = L3_80.name
		L8_85 = L8_85(L3_80)
		L6_83 = L8_85
	end
	L8_85 = nil
	if L3_80:base()._projectile_spawner:hud() then
		L8_85 = L3_80:base()._projectile_spawner:hud():texture_name()
	else
		L8_85 = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_PRIMARY_WEAPON
	end
	table.insert(A0_77._ammo_queue_list, {
		weapon_icon_texture = L6_83,
		ammo_icon_texture = L8_85,
		bullets = L5_82
	})
end
function NewPlayerHud._update_dust_panel(A0_86, A1_87)
	local L2_88
	L2_88 = A0_86._dust_panel
	L2_88 = L2_88.next_update
	L2_88 = L2_88(L2_88, A1_87)
	if L2_88 then
		L2_88 = A0_86._dust_panel
		L2_88 = L2_88.visible
		L2_88 = L2_88(L2_88)
		if L2_88 then
			L2_88 = managers
			L2_88 = L2_88.worldcamera
			L2_88 = L2_88.current_world_camera
			L2_88 = L2_88(L2_88)
			A0_86._dust_panel:update(A1_87, L2_88)
		else
			L2_88 = A0_86._dust_panel
			L2_88 = L2_88.use_low_frequency_update
			L2_88(L2_88, A1_87)
		end
	end
end
function NewPlayerHud._update_subtitles_font_size(A0_89, A1_90)
	if A0_89._panel:width() <= tweak_data.player.new_hud.TEXTPANEL_RESOLUTION_FOR_SMALL_FONT then
		managers.menu:ingame_gui():use_small_font()
	else
		managers.menu:ingame_gui():use_normal_font()
	end
end
function NewPlayerHud._update_stick_direction_panel(A0_91, A1_92)
	if A0_91._stick_direction_panel:next_update(A1_92) then
		if A0_91._player_data.hud_move_stick_angle and not A0_91._player_data._in_stationary_weapon then
			A0_91._stick_direction_panel:show()
			A0_91._stick_direction_panel:use_high_frequency_update(A1_92)
			A0_91._stick_direction_panel:update(A1_92, A0_91._player_data.hud_move_stick_angle, A0_91._player_data.hud_move_stick_radius)
		elseif A0_91._player_data.hud_move_stick_cover_angle and A0_91._player_data.quick_move_info_index > 0 and not A0_91._player_data.is_precision_aiming then
			A0_91._stick_direction_panel:show()
			A0_91._stick_direction_panel:use_high_frequency_update(A1_92)
			A0_91._stick_direction_panel:update(A1_92, A0_91._player_data.hud_move_stick_cover_angle, A0_91._player_data.hud_move_stick_cover_radius)
		elseif A0_91._stick_direction_panel:visible() then
			A0_91._stick_direction_panel:hide()
			A0_91._stick_direction_panel:update(A1_92)
		else
			A0_91._stick_direction_panel:use_low_frequency_update(A1_92)
		end
	end
end
function NewPlayerHud._update_noice(A0_93, A1_94)
	if A0_93._last_frame_battle_area_timer ~= A0_93._player_data.has_left_battle_area_timer then
		A0_93._noice:update_ingame(A1_94)
		A0_93._last_frame_battle_area_timer = A0_93._player_data.has_left_battle_area_timer
	end
end
function NewPlayerHud._update_gun_flash_panel(A0_95, A1_96)
	local L2_97, L3_98
	L2_97 = A0_95._player_unit
	L3_98 = L2_97
	L2_97 = L2_97.base
	L2_97 = L2_97(L3_98)
	L3_98 = L2_97
	L2_97 = L2_97.weapon
	L2_97 = L2_97(L3_98)
	L3_98 = alive
	L3_98 = L3_98(L2_97)
	if L3_98 then
		L3_98 = L2_97.weapon_data
		L3_98 = L3_98(L2_97)
		if L3_98._show_gun_flash_overlay then
			A0_95._gun_flash_panel:update(A1_96, L3_98)
		end
	end
end
function NewPlayerHud._on_rail_vehicle(A0_99)
	local L1_100
	L1_100 = A0_99._player_data
	L1_100 = L1_100.on_rail_vehicle
	if not L1_100 then
		L1_100 = A0_99._player_data
		L1_100 = L1_100.on_destroyed_rail_vehicle
	elseif L1_100 then
		L1_100 = true
		return L1_100
	end
	L1_100 = false
	return L1_100
end
function NewPlayerHud._hide_player_hud(A0_101)
	A0_101._weapon_selection_panel:panel():hide()
	A0_101._hurt_direction_indicator_panel:panel():hide()
	A0_101._next_cover_indicator_panel:panel():hide()
	A0_101._reticule_panel:panel():hide()
	A0_101._stick_direction_panel:panel():hide()
	A0_101._context_panel:panel():hide()
	A0_101._dust_panel:panel():hide()
	A0_101._overheat_hud:panel():hide()
	A0_101._weakspots_panel:hide()
	A0_101._noice:panel():hide()
	A0_101._battle_area_panel:panel():hide()
	A0_101._gun_flash_panel:hide()
	A0_101._ammo_panel:instant_hide()
	A0_101._health_panel:instant_hide()
	A0_101._teammate_name_panel:instant_hide()
	A0_101._hud_is_hidden = true
end
function NewPlayerHud._show_player_hud(A0_102)
	if A0_102._hud_is_hidden then
		A0_102._noice:panel():show()
		A0_102._reticule_panel:instant_show()
		A0_102._is_split_screen = HudUtility.is_split_screen()
		A0_102:_set_localizer_mapping()
	end
	A0_102._hud_is_hidden = false
end
function NewPlayerHud.set_extension_enabled(A0_103, A1_104)
	A0_103._extension_enabled = A1_104
	if not A1_104 and A0_103:has_panel() then
		A0_103:_hide_player_hud()
	end
end
function NewPlayerHud._set_localizer_mapping(A0_105)
	managers.localizer_mapping:update_mapping()
	A0_105._localizer_mapping = managers.localizer_mapping:get_localizer_mapping_by_unit(A0_105._player_unit)
	A0_105._context_panel:set_localizer_mapping(A0_105._localizer_mapping)
end
