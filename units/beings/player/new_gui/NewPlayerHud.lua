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
if not NewPlayerHud then
	NewPlayerHud = class()
end
NewPlayerHud.init = function(l_1_0, l_1_1)
	l_1_0._player_unit = l_1_1
	l_1_0._player_data = l_1_0._player_unit:player_data()
	if l_1_0._player_unit:base() then
		l_1_0._inventory = l_1_0._player_unit:base():inventory()
	end
	l_1_0._preload_textures()
	l_1_0.user_viewport = nil
	managers.post_update_manager:register(l_1_1, l_1_0)
	l_1_0._dt = 0
	l_1_0._ammo_queue_list = {}
end

NewPlayerHud.post_update = function(l_2_0)
	if l_2_0._hud_is_hidden then
		return 
	end
	if alive(l_2_0._player_unit) and l_2_0._weakspots_panel and alive(l_2_0._weakspots_panel:panel()) then
		l_2_0._weakspots_panel:update(l_2_0._dt)
	end
	if alive(l_2_0._player_unit) and l_2_0._teammate_name_panel and alive(l_2_0._teammate_name_panel:panel()) then
		l_2_0._teammate_name_panel:update(l_2_0._dt)
	end
end

NewPlayerHud._preload_textures = function(l_3_0)
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

NewPlayerHud.destroy = function(l_4_0)
	if alive(l_4_0._panel) then
		l_4_0._panel:clear()
	end
	if l_4_0._debug_text then
		l_4_0._debug_text:destroy()
	end
	if l_4_0._context_panel ~= nil then
		managers.action_event:unregister_listener(l_4_0)
	end
end

NewPlayerHud.has_panel = function(l_5_0)
	return l_5_0._panel
end

NewPlayerHud.release_gui_panel = function(l_6_0)
	if l_6_0._panel then
		l_6_0._panel:clear()
	end
	l_6_0._panel = nil
end

NewPlayerHud.set_gui_panel = function(l_7_0, l_7_1, l_7_2)
	l_7_0._user_viewport = l_7_2
	l_7_0._last_frame_battle_area_timer = -1
	local l_7_3, l_7_4 = l_7_1:panel, l_7_1
	local l_7_5 = {}
	l_7_5.name = "root_panel"
	l_7_5.valign = "grow"
	l_7_5.halign = "grow"
	l_7_3 = l_7_3(l_7_4, l_7_5)
	l_7_0._panel = l_7_3
	l_7_3 = l_7_0._panel
	l_7_3, l_7_4 = l_7_3:set_size, l_7_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_3(l_7_4, l_7_5)
	l_7_3 = managers
	l_7_3 = l_7_3.menu
	l_7_3, l_7_4 = l_7_3:ingame_gui, l_7_3
	l_7_3 = l_7_3(l_7_4)
	l_7_3, l_7_4 = l_7_3:safe_rect, l_7_3
	l_7_3 = l_7_3(l_7_4)
	l_7_4 = l_7_0._panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:panel
	local l_7_6 = {}
	l_7_6.name = "safe_panel"
	l_7_6.valign = "grow"
	l_7_6.halign = "grow"
	l_7_4 = l_7_4(l_7_5, l_7_6)
	l_7_0._safe_panel = l_7_4
	l_7_4 = l_7_0._safe_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:set_shape
	l_7_6 = l_7_3.x
	l_7_4(l_7_5, l_7_6, l_7_3.y, l_7_3.w, l_7_3.h)
	l_7_4 = WeaponSelectionPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit, l_7_0._inventory_icons)
	l_7_0._weapon_selection_panel = l_7_4
	l_7_4 = HealthPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._safe_panel, l_7_0._player_unit)
	l_7_0._health_panel = l_7_4
	l_7_4 = HurtDirectionIndicatorPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._hurt_direction_indicator_panel = l_7_4
	l_7_4 = NextCoverIndicatorPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._next_cover_indicator_panel = l_7_4
	l_7_4 = ReticulePanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._reticule_panel = l_7_4
	l_7_4 = StickDirectionPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._stick_direction_panel = l_7_4
	l_7_4 = ContextPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._safe_panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._context_panel = l_7_4
	l_7_4 = AmmoPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._safe_panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._ammo_panel = l_7_4
	l_7_4 = WeakspotsPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit, l_7_0._user_viewport)
	l_7_0._weakspots_panel = l_7_4
	l_7_4 = DustPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._dust_panel = l_7_4
	l_7_4 = FlashPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._gun_flash_panel = l_7_4
	l_7_4 = Menu2DCameraNoise
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._noice = l_7_4
	l_7_4 = l_7_0._noice
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:start
	l_7_6 = true
	l_7_4(l_7_5, l_7_6, "ingame")
	l_7_4 = BattleAreaPanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._safe_panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit)
	l_7_0._battle_area_panel = l_7_4
	l_7_4 = TeammateNamePanel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._panel
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_0._player_unit, l_7_0._user_viewport)
	l_7_0._teammate_name_panel = l_7_4
	l_7_4 = DebugText
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	l_7_6 = l_7_0._safe_panel
	local l_7_7 = l_7_6
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_7 = .end
	local l_7_8 = nil
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_7, l_7_8)
	l_7_0._debug_text = l_7_4
	l_7_4 = OverHeatHud
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:new
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_7 = l_7_0._player_unit
	l_7_8 = true
	l_7_4 = l_7_4(l_7_5, l_7_6, l_7_7, l_7_8, true)
	l_7_0._overheat_hud = l_7_4
	l_7_4 = managers
	l_7_4 = l_7_4.action_event
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_4:register_listener
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_7 = l_7_0._player_unit
	l_7_8 = l_7_0._player_unit
	l_7_4(l_7_5, l_7_6, l_7_7, l_7_8)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_0:_hide_player_hud
	l_7_4(l_7_5)
	l_7_4 = HudUtility
	l_7_4 = l_7_4.is_split_screen
	l_7_4 = l_7_4()
	l_7_0._is_split_screen = l_7_4
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_7_4 = l_7_0:_set_localizer_mapping
	l_7_4(l_7_5)
end

NewPlayerHud.update = function(l_8_0, l_8_1, l_8_2, l_8_3)
	l_8_0._dt = l_8_3
	l_8_0._t = l_8_2
	if l_8_0:has_panel() then
		if (managers.game:is_paused() or managers.worldcamera:current_world_camera()) and not l_8_0._hud_is_hidden then
			Application:debug("hiding hud for ", l_8_0._player_unit)
			l_8_0:_hide_player_hud()
		end
		return 
		l_8_0:_show_player_hud()
		if not l_8_0._player_data.on_destroyed_rail_vehicle then
			l_8_0:_update_weapon_selection_panel(l_8_3)
			l_8_0:_update_hurt_direction_indicator_panel(l_8_3)
			l_8_0:_update_next_cover_indicator_panel(l_8_3)
			l_8_0:_update_reticule_panel(l_8_3)
			l_8_0:_update_context_panel(l_8_2, l_8_3)
			l_8_0:_update_ammo_panel(l_8_2, l_8_3)
			l_8_0:_update_dust_panel(l_8_3)
			l_8_0:_update_stick_direction_panel(l_8_3)
			l_8_0._debug_text:update(l_8_3)
			l_8_0:_update_subtitles_font_size(l_8_3)
			l_8_0:_update_gun_flash_panel(l_8_3)
			l_8_0:_update_noice(l_8_3)
			l_8_0:_update_battle_area_panel(l_8_3)
		else
			l_8_0:_hide_player_hud()
		end
		l_8_0:_update_health_panel(l_8_2, l_8_3)
	end
end

NewPlayerHud._update_battle_area_panel = function(l_9_0, l_9_1)
	if l_9_0._battle_area_panel:next_update(l_9_1) then
		local l_9_2 = l_9_0._player_data.has_left_battle_area_timer
		local l_9_3 = l_9_0._player_data.has_left_battle_area_time_out
		if l_9_2 ~= -1 or l_9_3 then
			if not l_9_0._battle_area_panel:visible() then
				l_9_0._battle_area_panel:show()
			end
			l_9_0._battle_area_panel:update(l_9_1)
		end
	else
		if l_9_0._battle_area_panel:visible() then
			l_9_0._battle_area_panel:hide()
			l_9_0._battle_area_panel:update(l_9_1)
		end
	else
		l_9_0._battle_area_panel:use_low_frequency_update()
	end
end

NewPlayerHud._update_weapon_selection_panel = function(l_10_0, l_10_1)
	if l_10_0._weapon_selection_panel:next_update(l_10_1) then
		if l_10_0._player_data.hud_inventory_show and not l_10_0._player_data._in_stationary_weapon then
			if not l_10_0._weapon_selection_panel:visible() then
				l_10_0._weapon_selection_panel:show()
			end
			l_10_0._weapon_selection_panel:update(l_10_1, true)
		end
	else
		if l_10_0._weapon_selection_panel:visible() then
			l_10_0._weapon_selection_panel:hide()
			l_10_0._weapon_selection_panel:update(l_10_1, false)
		end
	else
		l_10_0._weapon_selection_panel:use_low_frequency_update()
	end
end

NewPlayerHud._update_hurt_direction_indicator_panel = function(l_11_0, l_11_1)
	if l_11_0._hurt_direction_indicator_panel:next_update(l_11_1) then
		local l_11_2, l_11_3 = nil, nil
		if l_11_0._player_data.on_rail_vehicle and tweak_data.player.new_hud.hurt_direction_indicator_panel.USE_HURT_DIRECTION_ON_RAIL_VEHICLE then
			local l_11_4 = l_11_0._player_data.on_rail_vehicle:damage()
			l_11_2 = l_11_4._time_since_damage
			l_11_3 = l_11_4._last_hit_direction
		else
			l_11_2 = l_11_0._player_data.time_since_damage
			l_11_3 = l_11_0._player_data.last_hit_direction
		end
		if l_11_2 and l_11_2 < tweak_data.player.hud.DAMAGE_INDICATOR_STAY_TIME then
			l_11_0._hurt_direction_indicator_panel:update(l_11_1, l_11_2, l_11_3)
		end
	else
		if l_11_0._hurt_direction_indicator_panel:visible() then
			l_11_0._hurt_direction_indicator_panel:update(l_11_1)
		end
	else
		l_11_0._hurt_direction_indicator_panel:use_low_frequency_update()
	end
end

NewPlayerHud._update_next_cover_indicator_panel = function(l_12_0, l_12_1)
	if l_12_0._next_cover_indicator_panel:next_update(l_12_1) then
		local l_12_2 = l_12_0._player_data.quick_move_info_index
		if l_12_2 > 0 and not l_12_0._player_data.is_precision_aiming then
			l_12_0._next_cover_indicator_panel:show()
			l_12_0._next_cover_indicator_panel:update(l_12_1)
		end
	else
		if l_12_0._next_cover_indicator_panel:visible() then
			l_12_0._next_cover_indicator_panel:hide()
			l_12_0._next_cover_indicator_panel:update(l_12_1)
		end
	else
		l_12_0._next_cover_indicator_panel:use_low_frequency_update()
	end
end

NewPlayerHud._update_reticule_panel = function(l_13_0, l_13_1)
	if l_13_0._player_data.is_precision_aiming and not l_13_0._reticule_panel:visible() then
		l_13_0._reticule_panel:use_high_frequency_update()
	end
	if l_13_0._reticule_panel:next_update(l_13_1) then
		if l_13_0._player_data.is_precision_aiming or l_13_0._player_data._in_stationary_weapon or l_13_0:_on_rail_vehicle() then
			l_13_0:_update_reticule_type()
			l_13_0._reticule_panel:show()
			l_13_0._reticule_panel:update(l_13_1, l_13_0._player_data.aim_target_unit)
		end
	else
		if l_13_0._reticule_panel:visible() then
			l_13_0._reticule_panel:hide()
			l_13_0._reticule_panel:update(l_13_1, l_13_0._player_data.aim_target_unit)
		end
	else
		l_13_0._reticule_panel:use_low_frequency_update()
	end
end

NewPlayerHud._update_weakspots_panel = function(l_14_0, l_14_1)
	if l_14_0._player_data.weakspot_unit_list and #l_14_0._player_data.weakspot_unit_list > 0 then
		l_14_0._weakspots_panel:show()
		l_14_0._weakspots_panel:update(l_14_1)
	else
		if l_14_0._weakspots_panel:visible() then
			l_14_0._weakspots_panel:hide()
		end
	end
end

NewPlayerHud._update_reticule_type = function(l_15_0)
	local l_15_1 = nil
	if l_15_0._player_unit:base():weapon() and l_15_0._player_unit:base():weapon():hud() then
		l_15_1 = l_15_0._player_unit:base():weapon():hud()
	end
	if l_15_1 then
		if l_15_1:reticule_type() == "circular_trajectory_reticule" then
			l_15_0._reticule_panel:use_circular_trajectory_reticule()
		elseif l_15_1:reticule_type() == "trajectory_reticule" then
			l_15_0._reticule_panel:use_trajectory_reticule()
		else
			l_15_0._reticule_panel:use_circle_reticule()
		end
	else
		l_15_0._reticule_panel:use_circle_reticule()
	end
end

NewPlayerHud._update_context_panel = function(l_16_0, l_16_1, l_16_2)
	if l_16_0._player_data.interact_will_only_pick_up_ammo then
		l_16_0._context_panel:use_high_frequency_update()
	end
	if l_16_0._context_panel:next_update(l_16_2) then
		if l_16_0._is_split_screen and (l_16_0._weapon_selection_panel:visible() or l_16_0._last_frame_battle_area_timer > 0) then
			if l_16_0._context_panel:is_visible("cover") then
				l_16_0._context_panel:instant_hide("cover")
			end
			if l_16_0._context_panel:is_visible("action") then
				l_16_0._context_panel:instant_hide("action")
			end
			if l_16_0._context_panel:is_visible("message") then
				l_16_0._context_panel:instant_hide("message")
			end
			return 
		end
		local l_16_3 = false
		local l_16_4 = l_16_0._player_data.current_interactable
		if l_16_0._player_data.can_enter_cover then
			l_16_0._context_panel:display("cover", "context_cover_new")
			l_16_3 = true
		else
			if l_16_0._context_panel:is_visible("cover") then
				l_16_0._context_panel:hide("cover")
				l_16_3 = true
			end
		end
		if alive(l_16_4) and not l_16_0._player_data.interact_will_only_pick_up_ammo and not l_16_0._player_data.in_cover and not l_16_0._player_data.quick_moving then
			local l_16_5 = nil
			local l_16_6 = l_16_4:hud()
			if l_16_6 then
				l_16_5 = l_16_6:small_texture_name()
			else
				l_16_5 = l_16_4:name()
			end
			if not l_16_0._player_data.interact_will_only_pick_up_ammo then
				if l_16_0._player_data.interact_use then
					if not l_16_0._stationary_weapon_texture or l_16_0._stationary_weapon_texture ~= l_16_5 then
						l_16_0._stationary_weapon_string = Localizer:lookup(l_16_5)
						l_16_0._stationary_weapon_texture = l_16_5
					end
					l_16_0._context_panel:display("action", "context_use_new", l_16_0._stationary_weapon_string)
					l_16_0._context_panel:set_minimum_display_time("action", 0, l_16_1)
				end
			else
				l_16_0._context_panel:display("action", "context_pick_up_new", l_16_5)
				l_16_0._context_panel:set_minimum_display_time("action", 0, l_16_1)
			end
			l_16_3 = true
		else
			if l_16_0._player_data.look_at_position then
				l_16_0._context_panel:display("action", "context_look_at_new")
				l_16_0._context_panel:set_minimum_display_time("action", 0, l_16_1)
				l_16_3 = true
			end
		else
			if l_16_0._player_data.can_revive and not l_16_0._player_data.is_down and alive(l_16_0._player_unit) and not l_16_0._player_data.in_cover and not l_16_0._player_data.quick_moving then
				l_16_0._context_panel:display("action", "context_revive_new")
				l_16_0._context_panel:set_minimum_display_time("action", 0, l_16_1)
				l_16_3 = true
			end
		else
			if l_16_0._player_data._in_stationary_weapon and l_16_0._stationary_weapon_texture then
				l_16_0._context_panel:display("action", "context_leave_new", l_16_0._stationary_weapon_string)
				l_16_0._context_panel:set_minimum_display_time("action", 5, l_16_1)
				l_16_0._stationary_weapon_texture = nil
				l_16_3 = true
			end
		else
			if l_16_0._context_panel:is_visible("action") or l_16_0._context_panel:timed_out("action") then
				l_16_0._context_panel:hide("action")
				l_16_3 = true
			end
		end
		if l_16_0._ammo_queue_list[1] and (not l_16_0._context_panel:is_visible("message") or not l_16_0._context_panel._context_items.message:wants_to_fade_out() or l_16_0._context_panel._context_items.message._alpha < 0.1) then
			if TableAlgorithms.count(l_16_0._ammo_queue_list) > 1 then
				l_16_0:merge_duplicates_in_queue_list()
			end
			local l_16_7 = l_16_0._ammo_queue_list[1].ammo_icon_texture
			local l_16_8 = l_16_0._ammo_queue_list[1].weapon_icon_texture
			local l_16_9 = l_16_0._ammo_queue_list[1].bullets
			if l_16_7 then
				l_16_0._context_panel:display("message", "context_fill_ammo_new", l_16_7, l_16_9, l_16_8)
				l_16_0._context_panel:set_minimum_display_time("message", 2, l_16_0._t)
			else
				l_16_0._context_panel:display("message", "context_fill_ammo_no_weapon_new", l_16_8, l_16_9)
				l_16_0._context_panel:set_minimum_display_time("message", 2, l_16_0._t)
			end
			table.remove(l_16_0._ammo_queue_list, 1)
			l_16_3 = true
		end
		if l_16_0._context_panel:is_visible("message") or l_16_0._context_panel:timed_out("message") then
			l_16_0._context_panel:hide("message")
			l_16_3 = true
		end
		if l_16_3 or l_16_0._context_panel:active_context() then
			l_16_0._context_panel:update(l_16_1, l_16_2)
		end
	else
		l_16_0._context_panel:use_low_frequency_update()
	end
end

NewPlayerHud.merge_duplicates_in_queue_list = function(l_17_0)
	local l_17_1 = TableAlgorithms.count(l_17_0._ammo_queue_list)
	for l_17_5 = 2, l_17_1 do
		if l_17_0._ammo_queue_list[1].weapon_icon_texture == l_17_0._ammo_queue_list[l_17_5].weapon_icon_texture and l_17_0._ammo_queue_list[1].ammo_icon_texture == l_17_0._ammo_queue_list[l_17_5].ammo_icon_texture then
			l_17_0._ammo_queue_list[1].bullets = l_17_0._ammo_queue_list[1].bullets + l_17_0._ammo_queue_list[l_17_5].bullets
			l_17_0._ammo_queue_list[l_17_5].bullets = 0
		end
	end
	for l_17_9 = l_17_1, 1, -1 do
		if l_17_0._ammo_queue_list[l_17_9].bullets == 0 then
			table.remove(l_17_0._ammo_queue_list, l_17_9)
		end
	end
end

NewPlayerHud.unit_ammo_fill = function(l_18_0, l_18_1, l_18_2, l_18_3)
	if l_18_2 > 0 then
		local l_18_4 = l_18_3._unit
		local l_18_5, l_18_6, l_18_7 = nil, nil, nil
		local l_18_8 = l_18_4:hud()
		if l_18_8 then
			l_18_5 = l_18_8:small_texture_name()
		else
			l_18_5 = interactable:name()
		end
		if l_18_4:base()._projectile_spawner then
			l_18_7 = l_18_4:base()._projectile_spawner:hud()
		end
		if l_18_7 then
			l_18_6 = l_18_7:texture_name()
		end
	if l_18_5 then
		end
		local l_18_9 = table.insert
		local l_18_10 = l_18_0._ammo_queue_list
		local l_18_11 = {}
		l_18_11.weapon_icon_texture = l_18_5
		l_18_11.ammo_icon_texture = l_18_6
		l_18_11.bullets = l_18_2
		l_18_9(l_18_10, l_18_11)
	end
end

NewPlayerHud._update_ammo_panel = function(l_19_0, l_19_1, l_19_2)
	if l_19_0._ammo_panel:next_update(l_19_2) then
		local l_19_3 = l_19_0._player_unit:base():weapon()
		if l_19_0:_on_rail_vehicle() then
			if l_19_0._ammo_panel:visible() then
				l_19_0._ammo_panel:hide()
				l_19_0._ammo_panel:update(l_19_2)
			end
			if l_19_3:logic():has_overheat() and l_19_3:logic():show_overheat_hud() then
				l_19_0._ammo_panel:use_high_frequency_update()
				l_19_0._overheat_hud:show(l_19_3)
				l_19_0._overheat_hud:update(l_19_2)
			else
				if l_19_0._overheat_hud:visible() then
					l_19_0._overheat_hud:hide()
					l_19_0._overheat_hud:update(l_19_2)
				end
			else
				l_19_0._ammo_panel:use_low_frequency_update()
				return 
			end
			local l_19_4 = l_19_0._player_unit:base():weapon_data()
			if not l_19_4 then
				return 
			end
			local l_19_5 = l_19_4:ammo_pool()
			local l_19_6 = l_19_4:bullets_in_clip()
			local l_19_7 = l_19_0._player_data.hud_inventory_secondary_active_slot
			local l_19_8, l_19_9, l_19_10 = nil, nil, nil
			if l_19_7 then
				l_19_8 = l_19_0._inventory:item_by_index(l_19_7)
			if alive(l_19_8) then
				end
				l_19_9 = l_19_8:weapon_data()
				l_19_10 = l_19_9:ammo_pool()
			end
			local l_19_11 = l_19_0._player_data.firing
			local l_19_12 = false
			local l_19_13 = false
			local l_19_14 = l_19_0._player_data.reloading
			if l_19_0._previous_bullets_in_clip and l_19_6 ~= l_19_0._previous_bullets_in_clip then
				l_19_11 = true
			else
				if l_19_0._player_data.throwing_grenade then
					l_19_11 = true
				end
			end
			if l_19_0._primary_ammo and l_19_5 ~= l_19_0._primary_ammo then
				l_19_12 = true
			elseif l_19_0._secondary_ammo and l_19_10 ~= l_19_0._secondary_ammo then
				l_19_12 = true
			end
			if l_19_0._player_data.switching_weapon then
				l_19_13 = true
			elseif l_19_0._previous_secondary_weapon_slot and l_19_7 ~= l_19_0._previous_secondary_weapon_slot then
				l_19_13 = true
			end
			l_19_0._previous_bullets_in_clip = l_19_6
			l_19_0._primary_ammo = l_19_5
			l_19_0._secondary_ammo = l_19_10
			l_19_0._previous_secondary_weapon_slot = l_19_7
			l_19_0._ammo_panel_showing = false
			if l_19_0._player_data.is_precision_aiming or l_19_11 or l_19_12 or l_19_13 or l_19_14 or l_19_0._player_data.hud_inventory_show then
				l_19_0._ammo_panel:show()
				l_19_0._ammo_panel:update(l_19_1, l_19_2, l_19_3, l_19_8, l_19_11)
				l_19_0._ammo_panel_showing = true
			end
		else
			if l_19_0._ammo_panel:visible() then
				l_19_0._ammo_panel:hide()
				l_19_0._ammo_panel:update(l_19_1, l_19_2)
			end
		else
			l_19_0._ammo_panel:use_low_frequency_update()
		end
		 -- WARNING: missing end command somewhere! Added here
	end
end

NewPlayerHud._update_health_panel = function(l_20_0, l_20_1, l_20_2)
	if l_20_0._health_panel:next_update(l_20_2) then
		local l_20_3 = false
		if l_20_0._player_data.rail_player_escort_unit then
			if alive(l_20_0._player_data.rail_player_escort_unit) then
				if l_20_0._player_data.rail_player_escort_unit:damage_data().damage <= 0 then
					l_20_3 = not l_20_0._player_data.on_rail_vehicle
			else
				end
			end
			l_20_3 = true
		else
			l_20_3 = l_20_0._player_data.on_rail_vehicle:damage_data().damage > 0
		end
		do return end
		if l_20_0._player_data.on_destroyed_rail_vehicle then
			l_20_3 = true
		else
			l_20_3 = l_20_0._player_unit:damage_data().damage > 0
		end
		if l_20_3 then
			l_20_0._health_panel:show()
			l_20_0._health_panel:update(l_20_1, l_20_2)
		end
	else
		if l_20_0._health_panel:visible() or l_20_0._health_panel:hidden() then
			l_20_0._health_panel:update(l_20_1, l_20_2)
		end
	else
		l_20_0._health_panel:use_low_frequency_update()
	end
end

NewPlayerHud._update_damage_overlay_panel = function(l_21_0, l_21_1)
	local l_21_2 = nil
	if l_21_0._player_data.on_rail_vehicle then
		l_21_2 = l_21_0._player_data.on_rail_vehicle:damage_data()
	else
		l_21_2 = l_21_0._player_unit:damage_data()
	end
	l_21_0._damage_overlay_panel:update(l_21_1, l_21_2)
end

NewPlayerHud.set_debug_text = function(l_22_0, l_22_1)
	if l_22_0._debug_text then
		l_22_0._debug_text:show_next_line(l_22_1)
	end
end

NewPlayerHud.unit_explode = function(l_23_0, l_23_1, l_23_2, l_23_3)
	if not l_23_0._dust_panel then
		return 
	end
	if not l_23_0._dust_panel:done() then
		l_23_0._dust_panel:show(l_23_2)
		l_23_0._dust_panel:use_high_frequency_update()
	end
end

NewPlayerHud.unit_player_received_ammo_from_player = function(l_24_0, l_24_1, l_24_2)
	local l_24_3 = l_24_0._player_unit:base():weapon()
	local l_24_4 = l_24_0._player_unit:base():weapon_data()
	local l_24_5 = l_24_4._clip_size * tweak_data.player.RECEIVE_AMMO_SIZE_MULTIPLIER
	local l_24_6 = nil
	local l_24_7 = l_24_3:hud()
	if l_24_7 then
		l_24_6 = l_24_7:small_texture_name()
	else
		l_24_6 = l_24_3:name()
	end
	local l_24_8 = nil
	local l_24_9 = l_24_3:base()._projectile_spawner:hud()
	if l_24_9 then
		l_24_8 = l_24_9:texture_name()
	else
		l_24_8 = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_PRIMARY_WEAPON
	end
	local l_24_10 = table.insert
	local l_24_11 = l_24_0._ammo_queue_list
	local l_24_12 = {}
	l_24_12.weapon_icon_texture = l_24_6
	l_24_12.ammo_icon_texture = l_24_8
	l_24_12.bullets = l_24_5
	l_24_10(l_24_11, l_24_12)
end

NewPlayerHud._update_dust_panel = function(l_25_0, l_25_1)
	if l_25_0._dust_panel:next_update(l_25_1) then
		if l_25_0._dust_panel:visible() then
			local l_25_2 = managers.worldcamera:current_world_camera()
			l_25_0._dust_panel:update(l_25_1, l_25_2)
		end
	else
		l_25_0._dust_panel:use_low_frequency_update(l_25_1)
	end
end

NewPlayerHud._update_subtitles_font_size = function(l_26_0, l_26_1)
	if l_26_0._panel:width() <= tweak_data.player.new_hud.TEXTPANEL_RESOLUTION_FOR_SMALL_FONT then
		managers.menu:ingame_gui():use_small_font()
	else
		managers.menu:ingame_gui():use_normal_font()
	end
end

NewPlayerHud._update_stick_direction_panel = function(l_27_0, l_27_1)
	if l_27_0._stick_direction_panel:next_update(l_27_1) then
		if l_27_0._player_data.hud_move_stick_angle and not l_27_0._player_data._in_stationary_weapon then
			l_27_0._stick_direction_panel:show()
			l_27_0._stick_direction_panel:use_high_frequency_update(l_27_1)
			l_27_0._stick_direction_panel:update(l_27_1, l_27_0._player_data.hud_move_stick_angle, l_27_0._player_data.hud_move_stick_radius)
		end
	else
		if l_27_0._player_data.hud_move_stick_cover_angle and l_27_0._player_data.quick_move_info_index > 0 and not l_27_0._player_data.is_precision_aiming then
			l_27_0._stick_direction_panel:show()
			l_27_0._stick_direction_panel:use_high_frequency_update(l_27_1)
			l_27_0._stick_direction_panel:update(l_27_1, l_27_0._player_data.hud_move_stick_cover_angle, l_27_0._player_data.hud_move_stick_cover_radius)
		end
	else
		if l_27_0._stick_direction_panel:visible() then
			l_27_0._stick_direction_panel:hide()
			l_27_0._stick_direction_panel:update(l_27_1)
		end
	else
		l_27_0._stick_direction_panel:use_low_frequency_update(l_27_1)
	end
end

NewPlayerHud._update_noice = function(l_28_0, l_28_1)
	if l_28_0._last_frame_battle_area_timer ~= l_28_0._player_data.has_left_battle_area_timer then
		l_28_0._noice:update_ingame(l_28_1)
		l_28_0._last_frame_battle_area_timer = l_28_0._player_data.has_left_battle_area_timer
	end
end

NewPlayerHud._update_gun_flash_panel = function(l_29_0, l_29_1)
	local l_29_2 = l_29_0._player_unit:base():weapon()
	if alive(l_29_2) then
		local l_29_3 = l_29_2:weapon_data()
	if l_29_3._show_gun_flash_overlay then
		end
		l_29_0._gun_flash_panel:update(l_29_1, l_29_3)
	end
end

NewPlayerHud._on_rail_vehicle = function(l_30_0)
	if l_30_0._player_data.on_rail_vehicle or l_30_0._player_data.on_destroyed_rail_vehicle then
		return true
	end
	return false
end

NewPlayerHud._hide_player_hud = function(l_31_0)
	l_31_0._weapon_selection_panel:panel():hide()
	l_31_0._hurt_direction_indicator_panel:panel():hide()
	l_31_0._next_cover_indicator_panel:panel():hide()
	l_31_0._reticule_panel:panel():hide()
	l_31_0._stick_direction_panel:panel():hide()
	l_31_0._context_panel:panel():hide()
	l_31_0._dust_panel:panel():hide()
	l_31_0._overheat_hud:panel():hide()
	l_31_0._weakspots_panel:hide()
	l_31_0._noice:panel():hide()
	l_31_0._battle_area_panel:panel():hide()
	l_31_0._gun_flash_panel:hide()
	l_31_0._ammo_panel:instant_hide()
	l_31_0._health_panel:instant_hide()
	l_31_0._teammate_name_panel:instant_hide()
	l_31_0._hud_is_hidden = true
end

NewPlayerHud._show_player_hud = function(l_32_0)
	if l_32_0._hud_is_hidden then
		l_32_0._noice:panel():show()
		l_32_0._reticule_panel:instant_show()
		l_32_0._is_split_screen = HudUtility.is_split_screen()
		l_32_0:_set_localizer_mapping()
	end
	l_32_0._hud_is_hidden = false
end

NewPlayerHud.set_extension_enabled = function(l_33_0, l_33_1)
	l_33_0._extension_enabled = l_33_1
	if not l_33_1 and l_33_0:has_panel() then
		l_33_0:_hide_player_hud()
	end
end

NewPlayerHud._set_localizer_mapping = function(l_34_0)
	managers.localizer_mapping:update_mapping()
	l_34_0._localizer_mapping = managers.localizer_mapping:get_localizer_mapping_by_unit(l_34_0._player_unit)
	l_34_0._context_panel:set_localizer_mapping(l_34_0._localizer_mapping)
end


