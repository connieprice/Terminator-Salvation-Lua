require("units/beings/player/new_gui/HudPanel")
HealthPanel = HealthPanel or class(HudPanel)
function HealthPanel.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._safe_panel = A2_2
	A0_0._player_unit = A3_3
	A0_0._player_data = A3_3:player_data()
	A0_0._parent_panel_width, A0_0._parent_panel_height = A1_1:size()
	A0_0._width = tweak_data.player.new_hud.health_panel.WIDTH
	A0_0._height = tweak_data.player.new_hud.health_panel.HEIGHT
	A0_0._x = 0
	A0_0._y = 0
	A0_0._health_icon_width = 29
	A0_0._health_bar_texture_x = A0_0._health_icon_width
	A0_0._health_bar_start_alpha = 1 - tweak_data.player.new_hud.health_panel.INITIAL_ALPHA
	A0_0._screen_edge_tint_start_at = tweak_data.player.new_hud.health_panel.INITIAL_SCREEN_EDGE_TINT_AT
	A0_0._heartbeat_sound_start_at = tweak_data.player.new_hud.health_panel.HEARTBEAT_SOUND_START_AT
	A0_0._alpha_modifier = A4_4 or 1
	if A5_5 ~= nil then
		A0_0._simple_mode = A5_5
	else
		A0_0._simple_mode = false
	end
	A0_0:set_up_screen_edge_tint()
	A0_0._panel = A0_0._safe_panel:panel({
		name = "health_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "top",
		halign = "left"
	})
	A0_0._panel:set_lefttop(A0_0._x, A0_0._y)
	A0_0._health_icon_texture = A0_0._panel:bitmap({
		name = "health_icon",
		texture = A7_7 or "gui_health_icon"
	})
	A0_0._background_texture = A0_0._panel:bitmap({
		name = "healthmeter_bg",
		texture = "gui_healthmeter_bg"
	})
	A0_0._background_texture:set_x(A0_0._health_icon_width)
	A0_0._background_texture_color = A0_0._background_texture:color()
	A0_0._health_bar_texture = A0_0._panel:bitmap({
		name = "healthmeter_bar",
		texture = "gui_healthmeter_bar_glow"
	})
	A0_0._health_bar_texture:set_x(A0_0._health_bar_texture_x)
	A0_0._health_bar_texture_color = A0_0._health_bar_texture:color()
	A0_0._health_bar_texture_width = A0_0._health_bar_texture:width()
	A0_0._health_bar_tail_texture = A0_0._panel:bitmap({
		name = "healthmeter_bar_tail",
		texture = "gui_healthmeter_bar"
	})
	A0_0._health_bar_tail_texture:set_x(A0_0._health_bar_texture_x)
	A0_0._health_bar_tail_texture_color = A0_0._health_bar_tail_texture:color()
	A0_0._health_bar_bg_texture = A0_0._panel:bitmap({
		name = "healthmeter_bar_bg",
		texture = "gui_healthmeter_bar"
	})
	A0_0._health_bar_bg_texture:set_x(A0_0._health_bar_texture_x)
	A0_0._health_bar_bg_texture_color = A0_0._health_bar_bg_texture:color()
	A0_0._health_bar_bg_texture_width = A0_0._health_bar_bg_texture:width()
	if A6_6 then
		A0_0._health_icon_texture:set_color(A6_6)
		A0_0._background_texture:set_color(A6_6)
		A0_0._health_bar_texture:set_color(A6_6)
		A0_0._health_bar_tail_texture:set_color(A6_6)
		A0_0._health_bar_bg_texture:set_color(A6_6)
	end
	A0_0._heartbeat_sound = Sound:make_bank("ui_menu_sound", "hud_heartbeat_loop")
	A0_0._health_refill_sound = Sound:make_bank("ui_menu_sound", "hud_health_refill")
	A0_0._health_full_sound = Sound:make_bank("ui_menu_sound", "hud_health_full")
	A0_0._health_percent = 1
	A0_0._scale_target = 1
	A0_0._scale_value = 1
	A0_0._scale_tail_target = 1
	A0_0._scale_tail_value = 1
	A0_0._red_alpha_target = 0
	A0_0._stay_visible_time = 0
	A0_0._target_color = tweak_data.player.new_hud.health_panel.RED_HEALTH_RGB
	A0_0._alpha_interpolator = InterpolatorLinear:new(0.4, tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
	A0_0._red_alpha_interpolator = InterpolatorLinear:new(A0_0._red_alpha_target, tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
	A0_0._scale_interpolator = Interpolator:new(A0_0._scale_target, tweak_data.player.new_hud.health_panel.SCALE_SPEED)
	A0_0._scale_tail_interpolator = Interpolator:new(A0_0._scale_target, tweak_data.player.new_hud.health_panel.SCALE_TAIL_SPEED)
	A0_0._screen_edge_tint_interpolator = InterpolatorLinear:new(0, tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
	A0_0:set_alpha(0)
	A0_0:set_screen_edge_tint_alpha(0)
	A0_0._t = 0
	A0_0._time = 0
	A0_0._next_blink_time = 0
	A0_0._blink_speed = tweak_data.player.new_hud.health_panel.BLINK_SPEED
	A0_0._blink_alpha_modifier = 1
end
function HealthPanel.set_up_screen_edge_tint(A0_8)
	local L1_9, L2_10
	L1_9 = A0_8._screen_edge_tint_texture
	if not L1_9 then
		L1_9 = {}
		A0_8._screen_edge_tint_texture = L1_9
		L1_9 = A0_8._screen_edge_tint_texture
		L2_10 = A0_8._parent_panel
		L2_10 = L2_10.bitmap
		L2_10 = L2_10(L2_10, {
			texture = "gui_healthmeter_edge",
			wrap_mode = "wrap",
			blend_mode = "add",
			texture_rect = {
				0,
				0,
				254,
				255
			}
		})
		L1_9[1] = L2_10
		L1_9 = A0_8._screen_edge_tint_texture
		L2_10 = A0_8._parent_panel
		L2_10 = L2_10.bitmap
		L2_10 = L2_10(L2_10, {
			texture = "gui_healthmeter_edge",
			wrap_mode = "wrap",
			blend_mode = "add",
			texture_rect = {
				-1,
				0,
				-254,
				255
			}
		})
		L1_9[2] = L2_10
		L1_9 = A0_8._screen_edge_tint_texture
		L2_10 = A0_8._parent_panel
		L2_10 = L2_10.bitmap
		L2_10 = L2_10(L2_10, {
			texture = "gui_healthmeter_edge",
			wrap_mode = "wrap",
			blend_mode = "add",
			texture_rect = {
				0,
				0,
				254,
				255
			}
		})
		L1_9[3] = L2_10
		L1_9 = A0_8._screen_edge_tint_texture
		L2_10 = A0_8._parent_panel
		L2_10 = L2_10.bitmap
		L2_10 = L2_10(L2_10, {
			texture = "gui_healthmeter_edge",
			wrap_mode = "wrap",
			blend_mode = "add",
			texture_rect = {
				-1,
				0,
				-254,
				255
			}
		})
		L1_9[4] = L2_10
		L1_9 = A0_8._screen_edge_tint_texture
		L1_9 = L1_9[3]
		L2_10 = L1_9
		L1_9 = L1_9.set_rotation
		L1_9(L2_10, 180)
		L1_9 = A0_8._screen_edge_tint_texture
		L1_9 = L1_9[4]
		L2_10 = L1_9
		L1_9 = L1_9.set_rotation
		L1_9(L2_10, 180)
	end
	L1_9 = A0_8._parent_panel
	L2_10 = L1_9
	L1_9 = L1_9.w
	L1_9 = L1_9(L2_10)
	L1_9 = L1_9 * 0.5
	L2_10 = A0_8._parent_panel
	L2_10 = L2_10.h
	L2_10 = L2_10(L2_10)
	L2_10 = L2_10 * 0.5
	A0_8._screen_edge_tint_texture[1]:set_size(L1_9, L2_10)
	A0_8._screen_edge_tint_texture[2]:set_size(L1_9, L2_10)
	A0_8._screen_edge_tint_texture[3]:set_size(L1_9, L2_10)
	A0_8._screen_edge_tint_texture[4]:set_size(L1_9, L2_10)
	A0_8._screen_edge_tint_texture[3]:set_position(A0_8._screen_edge_tint_texture[1]:right(), A0_8._screen_edge_tint_texture[1]:bottom())
	A0_8._screen_edge_tint_texture[4]:set_center(A0_8._screen_edge_tint_texture[1]:center_x(), A0_8._screen_edge_tint_texture[3]:center_y())
	A0_8._screen_edge_tint_texture[2]:set_center(A0_8._screen_edge_tint_texture[3]:center_x(), A0_8._screen_edge_tint_texture[1]:center_y())
end
function HealthPanel.panel(A0_11)
	local L1_12
	L1_12 = A0_11._panel
	return L1_12
end
function HealthPanel.show(A0_13)
	A0_13._stay_visible_time = tweak_data.player.new_hud.health_panel.TIME_BEFORE_FADE_OUT
	if not A0_13._tail_wait_time then
		A0_13._tail_wait_time = tweak_data.player.new_hud.health_panel.TIME_BEFORE_TAIL_START
	end
	A0_13._hidden = false
	if A0_13._alpha_before_instant_hide then
		A0_13._alpha_interpolator:set_target(A0_13._alpha_before_instant_hide)
		A0_13._alpha_interpolator:set_value(A0_13._alpha_before_instant_hide)
		A0_13._alpha_before_instant_hide = nil
	end
end
function HealthPanel.hide(A0_14)
	if A0_14._stay_visible_time < 0 then
		A0_14._alpha_interpolator:set_target(0)
		A0_14._alpha_interpolator:set_speed(tweak_data.player.new_hud.health_panel.FADE_OUT_SPEED)
	end
end
function HealthPanel.instant_hide(A0_15)
	if A0_15._hidden then
		return
	end
	A0_15._alpha_before_instant_hide = A0_15._alpha
	A0_15._alpha_interpolator:set_target(0)
	A0_15._alpha_interpolator:set_value(0)
	A0_15:set_alpha(0)
	A0_15:set_screen_edge_tint_alpha(0)
	A0_15:pause_heartbeat_sound()
	A0_15._hidden = true
end
function HealthPanel.visible(A0_16)
	return A0_16._alpha > 0
end
function HealthPanel.hidden(A0_17)
	local L1_18
	L1_18 = A0_17._hidden
	return L1_18
end
function HealthPanel._update_health_percent(A0_19, A1_20)
	local L2_21, L3_22
	L2_21 = A1_20.health
	L3_22 = A1_20.damage
	L2_21 = L2_21 - L3_22
	L3_22 = A1_20.health
	L2_21 = L2_21 / L3_22
	if L2_21 < 0 then
		L2_21 = 0
	end
	A0_19._health_percent = L2_21
end
function HealthPanel._update_scale(A0_23, A1_24)
	local L2_25
	L2_25 = A0_23._scale_target
	if L2_25 ~= A0_23._health_percent then
		L2_25 = A0_23._health_percent
		A0_23._scale_target = L2_25
		L2_25 = A0_23._scale_interpolator
		L2_25 = L2_25.set_target
		L2_25(L2_25, A0_23._scale_target)
	end
	L2_25 = A0_23._scale_interpolator
	L2_25 = L2_25.update
	L2_25(L2_25, A1_24)
	L2_25 = nil
	if A0_23._scale_interpolator:has_reached_target() then
		L2_25 = A0_23._scale_interpolator:target()
	else
		L2_25 = A0_23._scale_interpolator:value()
	end
	if L2_25 ~= A0_23._scale_value then
		A0_23._health_bar_texture:set_width(A0_23._health_bar_texture_width * L2_25)
		A0_23._health_bar_texture:set_x(A0_23._health_bar_texture_x + (1 - L2_25) * 3)
		if L2_25 > A0_23._scale_value and not A0_23._health_refill_sound:is_playing() then
			A0_23._health_refill_sound:play()
		end
		A0_23._scale_value = L2_25
	end
end
function HealthPanel._update_scale_tail(A0_26, A1_27)
	local L2_28
	L2_28 = A0_26._tail_wait_time
	if L2_28 then
		L2_28 = A0_26._tail_wait_time
		if L2_28 < 0 then
			L2_28 = A0_26._scale_tail_target
			if L2_28 ~= A0_26._health_percent then
				L2_28 = A0_26._health_percent
				A0_26._scale_tail_target = L2_28
				L2_28 = A0_26._scale_tail_interpolator
				L2_28 = L2_28.set_target
				L2_28(L2_28, A0_26._scale_tail_target)
			end
		end
	end
	L2_28 = A0_26._scale_tail_target
	if L2_28 == A0_26._health_percent then
		A0_26._tail_wait_time = nil
	end
	L2_28 = A0_26._scale_tail_interpolator
	L2_28 = L2_28.update
	L2_28(L2_28, A1_27)
	L2_28 = nil
	if A0_26._scale_tail_interpolator:has_reached_target() then
		L2_28 = A0_26._scale_tail_interpolator:target()
	else
		L2_28 = A0_26._scale_tail_interpolator:value()
	end
	if L2_28 ~= A0_26._scale_tail_value then
		A0_26._health_bar_tail_texture:set_width(A0_26._health_bar_texture_width * L2_28)
		A0_26._health_bar_tail_texture:set_x(A0_26._health_bar_texture_x + (1 - L2_28) * 3)
		if L2_28 > A0_26._scale_tail_value and not A0_26._health_refill_sound:is_playing() then
			A0_26._health_refill_sound:play()
		end
		if L2_28 == 1 then
			A0_26._health_refill_sound:stop()
			A0_26._health_full_sound:play()
			A0_26._stay_visible_time = tweak_data.player.new_hud.health_panel.TIME_BEFORE_FADE_OUT
		end
		A0_26._scale_tail_value = L2_28
	end
end
function HealthPanel._update_red_alpha(A0_29, A1_30)
	local L2_31
	L2_31 = A0_29._red_alpha_target
	if L2_31 ~= 1 - A0_29._health_percent then
		L2_31 = A0_29._health_percent
		L2_31 = 1 - L2_31
		A0_29._red_alpha_target = L2_31
		L2_31 = A0_29._red_alpha_interpolator
		L2_31 = L2_31.set_target
		L2_31(L2_31, A0_29._red_alpha_target)
	end
	L2_31 = A0_29._red_alpha_interpolator
	L2_31 = L2_31.update
	L2_31(L2_31, A1_30)
	L2_31 = nil
	if A0_29._red_alpha_interpolator:has_reached_target() then
		L2_31 = A0_29._red_alpha_interpolator:target()
	else
		L2_31 = A0_29._red_alpha_interpolator:value()
	end
	if L2_31 ~= A0_29._red_alpha_value then
		A0_29._red_alpha_value = L2_31
		A0_29:_set_red_alpha(L2_31)
	end
end
function HealthPanel._set_red_alpha(A0_32, A1_33)
	local L2_34, L3_35, L4_36
	L2_34 = A0_32._target_color
	L2_34 = L2_34.red
	L2_34 = 1 - L2_34
	L2_34 = L2_34 * A1_33
	L2_34 = 1 - L2_34
	L3_35 = A0_32._target_color
	L3_35 = L3_35.green
	L3_35 = 1 - L3_35
	L3_35 = L3_35 * A1_33
	L3_35 = 1 - L3_35
	L4_36 = A0_32._target_color
	L4_36 = L4_36.blue
	L4_36 = 1 - L4_36
	L4_36 = L4_36 * A1_33
	L4_36 = 1 - L4_36
	A0_32._current_color = Color(L2_34, L3_35, L4_36)
	A0_32._health_bar_texture:set_color((A0_32._health_bar_texture_color * A0_32._current_color):with_alpha(A0_32._alpha))
	A0_32._health_bar_bg_texture:set_color((A0_32._health_bar_bg_texture_color * A0_32._current_color):with_alpha(A0_32._alpha * tweak_data.player.new_hud.health_panel.HEALTH_BAR_BACKGROUND_ALPHA))
	A0_32._health_bar_tail_texture:set_color((A0_32._health_bar_tail_texture_color * A0_32._current_color):with_alpha(A0_32._alpha * tweak_data.player.new_hud.health_panel.HEALTH_BAR_TAIL_ALPHA))
end
function HealthPanel._update_alpha(A0_37, A1_38)
	local L2_39
	L2_39 = A0_37._stay_visible_time
	if L2_39 < 0 then
		L2_39 = A0_37._alpha_interpolator
		L2_39 = L2_39.set_target
		L2_39(L2_39, 0)
		L2_39 = A0_37._alpha_interpolator
		L2_39 = L2_39.set_speed
		L2_39(L2_39, tweak_data.player.new_hud.health_panel.FADE_OUT_SPEED)
	else
		L2_39 = A0_37._health_alpha
		if L2_39 ~= A0_37._health_percent then
			L2_39 = A0_37._health_percent
			A0_37._health_alpha = L2_39
			L2_39 = 1
			if not A0_37._simple_mode then
				L2_39 = 1 - A0_37._health_bar_start_alpha * A0_37._health_percent
			end
			A0_37._alpha_interpolator:set_target(L2_39)
			A0_37._alpha_interpolator:set_speed(tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
		end
	end
	L2_39 = A0_37._health_alpha
	if L2_39 then
		L2_39 = A0_37._health_alpha
		if L2_39 <= tweak_data.player.new_hud.health_panel.BLINK_AT then
			A0_37._blink = true
		end
	else
		A0_37._blink = false
	end
	L2_39 = A0_37._alpha_interpolator
	L2_39 = L2_39.update
	L2_39(L2_39, A1_38)
	L2_39 = nil
	if A0_37._alpha_interpolator:has_reached_target() then
		L2_39 = A0_37._alpha_interpolator:target()
	else
		L2_39 = A0_37._alpha_interpolator:value()
	end
	A0_37:set_alpha(L2_39)
end
function HealthPanel._update_screen_edge_tint(A0_40, A1_41)
	local L2_42
	L2_42 = A0_40._hidden
	if L2_42 then
		return
	end
	L2_42 = A0_40._screen_edge_percent
	if L2_42 ~= A0_40._health_percent then
		L2_42 = A0_40._health_percent
		A0_40._screen_edge_percent = L2_42
		L2_42 = 0
		if A0_40._screen_edge_percent <= A0_40._screen_edge_tint_start_at then
			L2_42 = (A0_40._screen_edge_tint_start_at - A0_40._screen_edge_percent) / A0_40._screen_edge_tint_start_at
		end
		A0_40._screen_edge_tint_interpolator:set_target(L2_42)
		A0_40._screen_edge_tint_interpolator:set_speed(tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
	end
	L2_42 = A0_40._screen_edge_tint_interpolator
	L2_42 = L2_42.update
	L2_42(L2_42, A1_41)
	L2_42 = nil
	if A0_40._screen_edge_tint_interpolator:has_reached_target() then
		L2_42 = A0_40._screen_edge_tint_interpolator:target()
	else
		L2_42 = A0_40._screen_edge_tint_interpolator:value()
	end
	if L2_42 ~= A0_40._screen_edge_alpha_value then
		A0_40:set_screen_edge_tint_alpha(L2_42)
	end
end
function HealthPanel.set_alpha(A0_43, A1_44)
	if A0_43._hidden then
		HudPanel.set_alpha(A0_43, 0)
		return
	end
	HudPanel.set_alpha(A0_43, A1_44 * A0_43._alpha_modifier)
	A0_43._health_icon_texture:set_color(A0_43._health_icon_texture:color():with_alpha(A0_43._alpha))
	A0_43._health_bar_bg_texture:set_color(A0_43._health_bar_bg_texture:color():with_alpha(A0_43._alpha * tweak_data.player.new_hud.health_panel.HEALTH_BAR_BACKGROUND_ALPHA))
	A0_43._background_texture:set_color(A0_43._background_texture:color():with_alpha(A0_43._alpha))
	if A0_43._simple_mode then
		A0_43._health_bar_tail_texture:set_color(A0_43._health_bar_tail_texture:color():with_alpha(0))
	else
		A0_43._health_bar_tail_texture:set_color(A0_43._health_bar_tail_texture:color():with_alpha(A0_43._alpha * tweak_data.player.new_hud.health_panel.HEALTH_BAR_TAIL_ALPHA))
	end
	if A0_43._blink and A0_43._blink_alpha_modifier ~= nil then
		A0_43._health_bar_texture:set_color(A0_43._health_bar_texture:color():with_alpha(A0_43._alpha * A0_43._blink_alpha_modifier))
	else
		A0_43._health_bar_texture:set_color(A0_43._health_bar_texture:color():with_alpha(A0_43._alpha))
	end
end
function HealthPanel.set_screen_edge_tint_alpha(A0_45, A1_46)
	if not A0_45._screen_edge_tint_texture then
		return
	end
	for 