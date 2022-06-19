require("units/beings/player/new_gui/HudPanel")
if not HealthPanel then
	HealthPanel = class(HudPanel)
end
HealthPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._safe_panel = l_1_2
	l_1_0._player_unit = l_1_3
	l_1_0._player_data = l_1_3:player_data()
	local l_1_8 = l_1_1:size()
	l_1_0._parent_panel_height = l_1_1
	l_1_0._parent_panel_width = l_1_8
	l_1_8 = tweak_data
	l_1_8 = l_1_8.player
	l_1_8 = l_1_8.new_hud
	l_1_8 = l_1_8.health_panel
	l_1_8 = l_1_8.WIDTH
	l_1_0._width = l_1_8
	l_1_8 = tweak_data
	l_1_8 = l_1_8.player
	l_1_8 = l_1_8.new_hud
	l_1_8 = l_1_8.health_panel
	l_1_8 = l_1_8.HEIGHT
	l_1_0._height = l_1_8
	l_1_0._x = 0
	l_1_0._y = 0
	l_1_0._health_icon_width = 29
	l_1_8 = l_1_0._health_icon_width
	l_1_0._health_bar_texture_x = l_1_8
	l_1_8 = tweak_data
	l_1_8 = l_1_8.player
	l_1_8 = l_1_8.new_hud
	l_1_8 = l_1_8.health_panel
	l_1_8 = l_1_8.INITIAL_ALPHA
	l_1_8 = 1 - l_1_8
	l_1_0._health_bar_start_alpha = l_1_8
	l_1_8 = tweak_data
	l_1_8 = l_1_8.player
	l_1_8 = l_1_8.new_hud
	l_1_8 = l_1_8.health_panel
	l_1_8 = l_1_8.INITIAL_SCREEN_EDGE_TINT_AT
	l_1_0._screen_edge_tint_start_at = l_1_8
	l_1_8 = tweak_data
	l_1_8 = l_1_8.player
	l_1_8 = l_1_8.new_hud
	l_1_8 = l_1_8.health_panel
	l_1_8 = l_1_8.HEARTBEAT_SOUND_START_AT
	l_1_0._heartbeat_sound_start_at = l_1_8
	l_1_8 = l_1_4 or 1
	l_1_0._alpha_modifier = l_1_8
	if l_1_5 ~= nil then
		l_1_0._simple_mode = l_1_5
	else
		l_1_0._simple_mode = false
	end
	l_1_8(l_1_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_9 = l_1_8
	local l_1_10 = {}
	l_1_10.name = "health_panel"
	l_1_10.width = l_1_0._width
	l_1_10.height = l_1_0._height
	l_1_10.valign = "top"
	l_1_10.halign = "left"
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_0._panel = l_1_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_9 = l_1_8
	l_1_10 = l_1_0._x
	l_1_8(l_1_9, l_1_10, l_1_0._y)
	 -- DECOMPILER ERROR: Overwrote pending register.

	if not l_1_7 then
		l_1_9 = l_1_0._panel
	end
	l_1_9, l_1_10 = l_1_9:bitmap, l_1_9
	local l_1_11 = {}
	l_1_11.name = "health_icon"
	l_1_11.texture = l_1_8
	l_1_9 = l_1_9(l_1_10, l_1_11)
	l_1_0._health_icon_texture = l_1_9
	l_1_9 = l_1_0._panel
	l_1_9, l_1_10 = l_1_9:bitmap, l_1_9
	l_1_9, l_1_11 = l_1_9(l_1_10, l_1_11), {name = "healthmeter_bg", texture = "gui_healthmeter_bg"}
	l_1_0._background_texture = l_1_9
	l_1_9 = l_1_0._background_texture
	l_1_9, l_1_10 = l_1_9:set_x, l_1_9
	l_1_11 = l_1_0._health_icon_width
	l_1_9(l_1_10, l_1_11)
	l_1_9 = l_1_0._background_texture
	l_1_9, l_1_10 = l_1_9:color, l_1_9
	l_1_9 = l_1_9(l_1_10)
	l_1_0._background_texture_color = l_1_9
	l_1_9 = l_1_0._panel
	l_1_9, l_1_10 = l_1_9:bitmap, l_1_9
	l_1_9, l_1_11 = l_1_9(l_1_10, l_1_11), {name = "healthmeter_bar", texture = "gui_healthmeter_bar_glow"}
	l_1_0._health_bar_texture = l_1_9
	l_1_9 = l_1_0._health_bar_texture
	l_1_9, l_1_10 = l_1_9:set_x, l_1_9
	l_1_11 = l_1_0._health_bar_texture_x
	l_1_9(l_1_10, l_1_11)
	l_1_9 = l_1_0._health_bar_texture
	l_1_9, l_1_10 = l_1_9:color, l_1_9
	l_1_9 = l_1_9(l_1_10)
	l_1_0._health_bar_texture_color = l_1_9
	l_1_9 = l_1_0._health_bar_texture
	l_1_9, l_1_10 = l_1_9:width, l_1_9
	l_1_9 = l_1_9(l_1_10)
	l_1_0._health_bar_texture_width = l_1_9
	l_1_9 = l_1_0._panel
	l_1_9, l_1_10 = l_1_9:bitmap, l_1_9
	l_1_9, l_1_11 = l_1_9(l_1_10, l_1_11), {name = "healthmeter_bar_tail", texture = "gui_healthmeter_bar"}
	l_1_0._health_bar_tail_texture = l_1_9
	l_1_9 = l_1_0._health_bar_tail_texture
	l_1_9, l_1_10 = l_1_9:set_x, l_1_9
	l_1_11 = l_1_0._health_bar_texture_x
	l_1_9(l_1_10, l_1_11)
	l_1_9 = l_1_0._health_bar_tail_texture
	l_1_9, l_1_10 = l_1_9:color, l_1_9
	l_1_9 = l_1_9(l_1_10)
	l_1_0._health_bar_tail_texture_color = l_1_9
	l_1_9 = l_1_0._panel
	l_1_9, l_1_10 = l_1_9:bitmap, l_1_9
	l_1_9, l_1_11 = l_1_9(l_1_10, l_1_11), {name = "healthmeter_bar_bg", texture = "gui_healthmeter_bar"}
	l_1_0._health_bar_bg_texture = l_1_9
	l_1_9 = l_1_0._health_bar_bg_texture
	l_1_9, l_1_10 = l_1_9:set_x, l_1_9
	l_1_11 = l_1_0._health_bar_texture_x
	l_1_9(l_1_10, l_1_11)
	l_1_9 = l_1_0._health_bar_bg_texture
	l_1_9, l_1_10 = l_1_9:color, l_1_9
	l_1_9 = l_1_9(l_1_10)
	l_1_0._health_bar_bg_texture_color = l_1_9
	l_1_9 = l_1_0._health_bar_bg_texture
	l_1_9, l_1_10 = l_1_9:width, l_1_9
	l_1_9 = l_1_9(l_1_10)
	l_1_0._health_bar_bg_texture_width = l_1_9
	if l_1_6 then
		l_1_9 = l_1_0._health_icon_texture
		l_1_9, l_1_10 = l_1_9:set_color, l_1_9
		l_1_11 = l_1_6
		l_1_9(l_1_10, l_1_11)
		l_1_9 = l_1_0._background_texture
		l_1_9, l_1_10 = l_1_9:set_color, l_1_9
		l_1_11 = l_1_6
		l_1_9(l_1_10, l_1_11)
		l_1_9 = l_1_0._health_bar_texture
		l_1_9, l_1_10 = l_1_9:set_color, l_1_9
		l_1_11 = l_1_6
		l_1_9(l_1_10, l_1_11)
		l_1_9 = l_1_0._health_bar_tail_texture
		l_1_9, l_1_10 = l_1_9:set_color, l_1_9
		l_1_11 = l_1_6
		l_1_9(l_1_10, l_1_11)
		l_1_9 = l_1_0._health_bar_bg_texture
		l_1_9, l_1_10 = l_1_9:set_color, l_1_9
		l_1_11 = l_1_6
		l_1_9(l_1_10, l_1_11)
	end
	l_1_9 = Sound
	l_1_9, l_1_10 = l_1_9:make_bank, l_1_9
	l_1_11 = "ui_menu_sound"
	l_1_9 = l_1_9(l_1_10, l_1_11, "hud_heartbeat_loop")
	l_1_0._heartbeat_sound = l_1_9
	l_1_9 = Sound
	l_1_9, l_1_10 = l_1_9:make_bank, l_1_9
	l_1_11 = "ui_menu_sound"
	l_1_9 = l_1_9(l_1_10, l_1_11, "hud_health_refill")
	l_1_0._health_refill_sound = l_1_9
	l_1_9 = Sound
	l_1_9, l_1_10 = l_1_9:make_bank, l_1_9
	l_1_11 = "ui_menu_sound"
	l_1_9 = l_1_9(l_1_10, l_1_11, "hud_health_full")
	l_1_0._health_full_sound = l_1_9
	l_1_0._health_percent = 1
	l_1_0._scale_target = 1
	l_1_0._scale_value = 1
	l_1_0._scale_tail_target = 1
	l_1_0._scale_tail_value = 1
	l_1_0._red_alpha_target = 0
	l_1_0._stay_visible_time = 0
	l_1_9 = tweak_data
	l_1_9 = l_1_9.player
	l_1_9 = l_1_9.new_hud
	l_1_9 = l_1_9.health_panel
	l_1_9 = l_1_9.RED_HEALTH_RGB
	l_1_0._target_color = l_1_9
	l_1_9 = InterpolatorLinear
	l_1_9, l_1_10 = l_1_9:new, l_1_9
	l_1_11 = 0.4
	l_1_9 = l_1_9(l_1_10, l_1_11, tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
	l_1_0._alpha_interpolator = l_1_9
	l_1_9 = InterpolatorLinear
	l_1_9, l_1_10 = l_1_9:new, l_1_9
	l_1_11 = l_1_0._red_alpha_target
	l_1_9 = l_1_9(l_1_10, l_1_11, tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
	l_1_0._red_alpha_interpolator = l_1_9
	l_1_9 = Interpolator
	l_1_9, l_1_10 = l_1_9:new, l_1_9
	l_1_11 = l_1_0._scale_target
	l_1_9 = l_1_9(l_1_10, l_1_11, tweak_data.player.new_hud.health_panel.SCALE_SPEED)
	l_1_0._scale_interpolator = l_1_9
	l_1_9 = Interpolator
	l_1_9, l_1_10 = l_1_9:new, l_1_9
	l_1_11 = l_1_0._scale_target
	l_1_9 = l_1_9(l_1_10, l_1_11, tweak_data.player.new_hud.health_panel.SCALE_TAIL_SPEED)
	l_1_0._scale_tail_interpolator = l_1_9
	l_1_9 = InterpolatorLinear
	l_1_9, l_1_10 = l_1_9:new, l_1_9
	l_1_11 = 0
	l_1_9 = l_1_9(l_1_10, l_1_11, tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
	l_1_0._screen_edge_tint_interpolator = l_1_9
	l_1_9, l_1_10 = l_1_0:set_alpha, l_1_0
	l_1_11 = 0
	l_1_9(l_1_10, l_1_11)
	l_1_9, l_1_10 = l_1_0:set_screen_edge_tint_alpha, l_1_0
	l_1_11 = 0
	l_1_9(l_1_10, l_1_11)
	l_1_0._t = 0
	l_1_0._time = 0
	l_1_0._next_blink_time = 0
	l_1_9 = tweak_data
	l_1_9 = l_1_9.player
	l_1_9 = l_1_9.new_hud
	l_1_9 = l_1_9.health_panel
	l_1_9 = l_1_9.BLINK_SPEED
	l_1_0._blink_speed = l_1_9
	l_1_0._blink_alpha_modifier = 1
end

HealthPanel.set_up_screen_edge_tint = function(l_2_0)
	if not l_2_0._screen_edge_tint_texture then
		l_2_0._screen_edge_tint_texture = {}
		local l_2_1 = l_2_0._screen_edge_tint_texture
		local l_2_2, l_2_3 = l_2_0._parent_panel:bitmap, l_2_0._parent_panel
		local l_2_4 = {}
		l_2_4.texture = "gui_healthmeter_edge"
		l_2_4.wrap_mode = "wrap"
		l_2_4.blend_mode = "add"
		local l_2_5 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_5 = {0, 0, 254, 255}
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4 = {texture = "gui_healthmeter_edge", wrap_mode = "wrap", blend_mode = "add", texture_rect = l_2_5}
		l_2_1[2] = l_2_2
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_5 = {0, 0, 254, 255}
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4 = {texture = "gui_healthmeter_edge", wrap_mode = "wrap", blend_mode = "add", texture_rect = l_2_5}
		l_2_1[3] = l_2_2
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_5 = {-1, 0, -254, 255}
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_4 = {texture = "gui_healthmeter_edge", wrap_mode = "wrap", blend_mode = "add", texture_rect = l_2_5}
		l_2_1[4] = l_2_2
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_1(l_2_2, l_2_3)
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_1(l_2_2, l_2_3)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_2_6 = l_2_1:w() * 0.5
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_2_7 = l_2_0._parent_panel:h() * 0.5
	l_2_0._screen_edge_tint_texture[1]:set_size(l_2_6, l_2_7)
	l_2_0._screen_edge_tint_texture[2]:set_size(l_2_6, l_2_7)
	l_2_0._screen_edge_tint_texture[3]:set_size(l_2_6, l_2_7)
	l_2_0._screen_edge_tint_texture[4]:set_size(l_2_6, l_2_7)
	l_2_0._screen_edge_tint_texture[3]:set_position(l_2_0._screen_edge_tint_texture[1]:right(), l_2_0._screen_edge_tint_texture[1]:bottom())
	l_2_0._screen_edge_tint_texture[4]:set_center(l_2_0._screen_edge_tint_texture[1]:center_x(), l_2_0._screen_edge_tint_texture[3]:center_y())
	l_2_0._screen_edge_tint_texture[2]:set_center(l_2_0._screen_edge_tint_texture[3]:center_x(), l_2_0._screen_edge_tint_texture[1]:center_y())
end

HealthPanel.panel = function(l_3_0)
	return l_3_0._panel
end

HealthPanel.show = function(l_4_0)
	l_4_0._stay_visible_time = tweak_data.player.new_hud.health_panel.TIME_BEFORE_FADE_OUT
	if not l_4_0._tail_wait_time then
		l_4_0._tail_wait_time = tweak_data.player.new_hud.health_panel.TIME_BEFORE_TAIL_START
	end
	l_4_0._hidden = false
	if l_4_0._alpha_before_instant_hide then
		l_4_0._alpha_interpolator:set_target(l_4_0._alpha_before_instant_hide)
		l_4_0._alpha_interpolator:set_value(l_4_0._alpha_before_instant_hide)
		l_4_0._alpha_before_instant_hide = nil
	end
end

HealthPanel.hide = function(l_5_0)
	if l_5_0._stay_visible_time < 0 then
		l_5_0._alpha_interpolator:set_target(0)
		l_5_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.health_panel.FADE_OUT_SPEED)
	end
end

HealthPanel.instant_hide = function(l_6_0)
	if l_6_0._hidden then
		return 
	end
	l_6_0._alpha_before_instant_hide = l_6_0._alpha
	l_6_0._alpha_interpolator:set_target(0)
	l_6_0._alpha_interpolator:set_value(0)
	l_6_0:set_alpha(0)
	l_6_0:set_screen_edge_tint_alpha(0)
	l_6_0:pause_heartbeat_sound()
	l_6_0._hidden = true
end

HealthPanel.visible = function(l_7_0)
	return l_7_0._alpha > 0
end

HealthPanel.hidden = function(l_8_0)
	return l_8_0._hidden
end

HealthPanel._update_health_percent = function(l_9_0, l_9_1)
	if (l_9_1.health - l_9_1.damage) / l_9_1.health < 0 then
		l_9_0._health_percent = 0
	end
end

HealthPanel._update_scale = function(l_10_0, l_10_1)
	if l_10_0._scale_target ~= l_10_0._health_percent then
		l_10_0._scale_target = l_10_0._health_percent
		l_10_0._scale_interpolator:set_target(l_10_0._scale_target)
	end
	l_10_0._scale_interpolator:update(l_10_1)
	local l_10_2 = nil
	if l_10_0._scale_interpolator:has_reached_target() then
		l_10_2 = l_10_0._scale_interpolator:target()
	else
		l_10_2 = l_10_0._scale_interpolator:value()
	end
	if l_10_2 ~= l_10_0._scale_value then
		l_10_0._health_bar_texture:set_width(l_10_0._health_bar_texture_width * l_10_2)
		l_10_0._health_bar_texture:set_x(l_10_0._health_bar_texture_x + (1 - l_10_2) * 3)
		if l_10_0._scale_value < l_10_2 and not l_10_0._health_refill_sound:is_playing() then
			l_10_0._health_refill_sound:play()
		end
		l_10_0._scale_value = l_10_2
	end
end

HealthPanel._update_scale_tail = function(l_11_0, l_11_1)
	if l_11_0._tail_wait_time and l_11_0._tail_wait_time < 0 and l_11_0._scale_tail_target ~= l_11_0._health_percent then
		l_11_0._scale_tail_target = l_11_0._health_percent
		l_11_0._scale_tail_interpolator:set_target(l_11_0._scale_tail_target)
	end
	if l_11_0._scale_tail_target == l_11_0._health_percent then
		l_11_0._tail_wait_time = nil
	end
	l_11_0._scale_tail_interpolator:update(l_11_1)
	local l_11_2 = nil
	if l_11_0._scale_tail_interpolator:has_reached_target() then
		l_11_2 = l_11_0._scale_tail_interpolator:target()
	else
		l_11_2 = l_11_0._scale_tail_interpolator:value()
	end
	if l_11_2 ~= l_11_0._scale_tail_value then
		l_11_0._health_bar_tail_texture:set_width(l_11_0._health_bar_texture_width * l_11_2)
		l_11_0._health_bar_tail_texture:set_x(l_11_0._health_bar_texture_x + (1 - l_11_2) * 3)
		if l_11_0._scale_tail_value < l_11_2 and not l_11_0._health_refill_sound:is_playing() then
			l_11_0._health_refill_sound:play()
		end
		if l_11_2 == 1 then
			l_11_0._health_refill_sound:stop()
			l_11_0._health_full_sound:play()
			l_11_0._stay_visible_time = tweak_data.player.new_hud.health_panel.TIME_BEFORE_FADE_OUT
		end
		l_11_0._scale_tail_value = l_11_2
	end
end

HealthPanel._update_red_alpha = function(l_12_0, l_12_1)
	if l_12_0._red_alpha_target ~= 1 - l_12_0._health_percent then
		l_12_0._red_alpha_target = 1 - l_12_0._health_percent
		l_12_0._red_alpha_interpolator:set_target(l_12_0._red_alpha_target)
	end
	l_12_0._red_alpha_interpolator:update(l_12_1)
	local l_12_2 = nil
	if l_12_0._red_alpha_interpolator:has_reached_target() then
		l_12_2 = l_12_0._red_alpha_interpolator:target()
	else
		l_12_2 = l_12_0._red_alpha_interpolator:value()
	end
	if l_12_2 ~= l_12_0._red_alpha_value then
		l_12_0._red_alpha_value = l_12_2
		l_12_0:_set_red_alpha(l_12_2)
	end
end

HealthPanel._set_red_alpha = function(l_13_0, l_13_1)
	local l_13_2 = 1 - (1 - l_13_0._target_color.red) * l_13_1
	local l_13_3 = 1 - (1 - l_13_0._target_color.green) * l_13_1
	local l_13_4 = 1 - (1 - l_13_0._target_color.blue) * l_13_1
	l_13_0._current_color = Color(l_13_2, l_13_3, l_13_4)
	l_13_0._health_bar_texture:set_color(l_13_0._health_bar_texture_color * l_13_0._current_color:with_alpha(l_13_0._alpha))
	l_13_0._health_bar_bg_texture:set_color(l_13_0._health_bar_bg_texture_color * l_13_0._current_color:with_alpha(l_13_0._alpha * tweak_data.player.new_hud.health_panel.HEALTH_BAR_BACKGROUND_ALPHA))
	l_13_0._health_bar_tail_texture:set_color(l_13_0._health_bar_tail_texture_color * l_13_0._current_color:with_alpha(l_13_0._alpha * tweak_data.player.new_hud.health_panel.HEALTH_BAR_TAIL_ALPHA))
end

HealthPanel._update_alpha = function(l_14_0, l_14_1)
	if l_14_0._stay_visible_time < 0 then
		l_14_0._alpha_interpolator:set_target(0)
		l_14_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.health_panel.FADE_OUT_SPEED)
	else
		if l_14_0._health_alpha ~= l_14_0._health_percent then
			l_14_0._health_alpha = l_14_0._health_percent
			local l_14_2 = 1
			if not l_14_0._simple_mode then
				l_14_2 = 1 - l_14_0._health_bar_start_alpha * l_14_0._health_percent
			end
			l_14_0._alpha_interpolator:set_target(l_14_2)
			l_14_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
		end
	end
	if l_14_0._health_alpha and l_14_0._health_alpha <= tweak_data.player.new_hud.health_panel.BLINK_AT then
		l_14_0._blink = true
	else
		l_14_0._blink = false
	end
	l_14_0._alpha_interpolator:update(l_14_1)
	local l_14_3 = nil
	if l_14_0._alpha_interpolator:has_reached_target() then
		l_14_3 = l_14_0._alpha_interpolator:target()
	else
		l_14_3 = l_14_0._alpha_interpolator:value()
	end
	l_14_0:set_alpha(l_14_3)
end

HealthPanel._update_screen_edge_tint = function(l_15_0, l_15_1)
	if l_15_0._hidden then
		return 
	end
	if l_15_0._screen_edge_percent ~= l_15_0._health_percent then
		l_15_0._screen_edge_percent = l_15_0._health_percent
		local l_15_2 = 0
		if l_15_0._screen_edge_percent <= l_15_0._screen_edge_tint_start_at then
			l_15_2 = (l_15_0._screen_edge_tint_start_at - l_15_0._screen_edge_percent) / l_15_0._screen_edge_tint_start_at
		end
		l_15_0._screen_edge_tint_interpolator:set_target(l_15_2)
		l_15_0._screen_edge_tint_interpolator:set_speed(tweak_data.player.new_hud.health_panel.FADE_IN_SPEED)
	end
	l_15_0._screen_edge_tint_interpolator:update(l_15_1)
	local l_15_3 = nil
	if l_15_0._screen_edge_tint_interpolator:has_reached_target() then
		l_15_3 = l_15_0._screen_edge_tint_interpolator:target()
	else
		l_15_3 = l_15_0._screen_edge_tint_interpolator:value()
	end
	if l_15_3 ~= l_15_0._screen_edge_alpha_value then
		l_15_0:set_screen_edge_tint_alpha(l_15_3)
	end
end

HealthPanel.set_alpha = function(l_16_0, l_16_1)
	if l_16_0._hidden then
		HudPanel.set_alpha(l_16_0, 0)
		return 
	end
	HudPanel.set_alpha(l_16_0, l_16_1 * l_16_0._alpha_modifier)
	l_16_0._health_icon_texture:set_color(l_16_0._health_icon_texture:color():with_alpha(l_16_0._alpha))
	l_16_0._health_bar_bg_texture:set_color(l_16_0._health_bar_bg_texture:color():with_alpha(l_16_0._alpha * tweak_data.player.new_hud.health_panel.HEALTH_BAR_BACKGROUND_ALPHA))
	l_16_0._background_texture:set_color(l_16_0._background_texture:color():with_alpha(l_16_0._alpha))
	if l_16_0._simple_mode then
		l_16_0._health_bar_tail_texture:set_color(l_16_0._health_bar_tail_texture:color():with_alpha(0))
	else
		l_16_0._health_bar_tail_texture:set_color(l_16_0._health_bar_tail_texture:color():with_alpha(l_16_0._alpha * tweak_data.player.new_hud.health_panel.HEALTH_BAR_TAIL_ALPHA))
	end
	if l_16_0._blink and l_16_0._blink_alpha_modifier ~= nil then
		l_16_0._health_bar_texture:set_color(l_16_0._health_bar_texture:color():with_alpha(l_16_0._alpha * l_16_0._blink_alpha_modifier))
	else
		l_16_0._health_bar_texture:set_color(l_16_0._health_bar_texture:color():with_alpha(l_16_0._alpha))
	end
end

HealthPanel.set_screen_edge_tint_alpha = function(l_17_0, l_17_1)
	local l_17_5, l_17_6, l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_13, l_17_14, l_17_15, l_17_16, l_17_17, l_17_18, l_17_19, l_17_20, l_17_21, l_17_22 = nil
	if not l_17_0._screen_edge_tint_texture then
		return 
	end
	for i_0,i_1 in pairs(l_17_0._screen_edge_tint_texture) do
		i_1:set_color(i_1:color():with_alpha(l_17_1))
		if not l_17_0._screen_edge_alpha_value then
			i_1:hide()
		elseif l_17_0._screen_edge_alpha_value > 0 and l_17_1 == 0 then
			i_1:hide()
		elseif l_17_0._screen_edge_alpha_value == 0 and l_17_1 > 0 then
			i_1:show()
		end
	end
	l_17_0._screen_edge_alpha_value = l_17_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

HealthPanel._update_heartbeat_sound = function(l_18_0, l_18_1)
	if l_18_0._heartbeat_sound_is_paused then
		l_18_0._heartbeat_sound:unpause()
	end
	if l_18_0._heartbeat_sound_percent ~= l_18_0._health_percent then
		l_18_0._heartbeat_sound_percent = l_18_0._health_percent
		local l_18_2 = 0
		if l_18_0._heartbeat_sound_percent <= l_18_0._heartbeat_sound_start_at and l_18_0._heartbeat_sound_percent > 0 then
			l_18_2 = (l_18_0._heartbeat_sound_start_at - l_18_0._heartbeat_sound_percent) / l_18_0._heartbeat_sound_start_at
			if not l_18_0._heartbeat_sound:is_playing() then
				l_18_0._heartbeat_sound:play()
			end
			l_18_0._heartbeat_sound:set_control("t", l_18_2)
		end
	else
		if l_18_0._heartbeat_sound:is_playing() then
			l_18_0._heartbeat_sound:stop()
		end
	end
end

HealthPanel.pause_heartbeat_sound = function(l_19_0)
	if l_19_0._heartbeat_sound:is_playing() then
		l_19_0._heartbeat_sound:pause()
		l_19_0._heartbeat_sound_is_paused = true
	end
end

HealthPanel.update = function(l_20_0, l_20_1, l_20_2)
	local l_20_3 = nil
	l_20_0._stay_visible_time = l_20_0._stay_visible_time - (l_20_1 - l_20_0._t)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_20_0._tail_wait_time then
		l_20_0._tail_wait_time = l_20_0._tail_wait_time - (l_20_1 - l_20_0._t)
	end
	if l_20_0._player_data.on_rail_vehicle and l_20_0._player_data.rail_player_escort_unit and alive(l_20_0._player_data.rail_player_escort_unit) then
		l_20_3 = l_20_0._player_data.rail_player_escort_unit:damage_data()
	end
	do return end
	l_20_3 = l_20_0._player_data.on_rail_vehicle:damage_data()
	do return end
	if l_20_0._player_data.on_destroyed_rail_vehicle then
		local l_20_4 = nil
		l_20_3 = {health = 1, damage = 1}
	else
		l_20_3 = l_20_0._player_unit:damage_data()
	end
	l_20_0:_update_health_percent(l_20_3)
	l_20_0:_update_scale(l_20_2)
	l_20_0:_update_alpha(l_20_2)
	l_20_0:_update_blink(l_20_2)
	if not l_20_0._simple_mode then
		l_20_0:_update_scale_tail(l_20_2)
		l_20_0:_update_red_alpha(l_20_2)
		l_20_0:_update_heartbeat_sound(l_20_2)
		l_20_0:_update_screen_edge_tint(l_20_2)
	end
	if not l_20_0:visible() then
		l_20_0._tail_wait_time = nil
	end
	local l_20_5, l_20_6 = , l_20_0._parent_panel:size()
	if l_20_6 ~= l_20_0._parent_panel_width or l_20_0._parent_panel ~= l_20_0._parent_panel_height then
		l_20_0:set_up_screen_edge_tint()
	end
	local l_20_7 = nil
	 -- DECOMPILER ERROR: Overwrote pending register.

	if ((false or not not l_20_0._scale_interpolator:has_reached_target()) and l_20_0._simple_mode) or l_20_0._blink or not l_20_0._scale_tail_interpolator:has_reached_target() or not l_20_0._screen_edge_tint_interpolator:has_reached_target() then
		l_20_0:use_high_frequency_update()
	else
		l_20_0:use_low_frequency_update()
	end
end

HealthPanel._update_blink = function(l_21_0, l_21_1)
	l_21_0._time = l_21_0._time + l_21_1
	if l_21_0._next_blink_time < l_21_0._time then
		if l_21_0._blink_alpha_modifier == tweak_data.player.new_hud.health_panel.HEALTH_BAR_BLINK_ALPHA then
			l_21_0._blink_alpha_modifier = 1
		else
			l_21_0._blink_alpha_modifier = tweak_data.player.new_hud.health_panel.HEALTH_BAR_BLINK_ALPHA
		end
		l_21_0._next_blink_time = l_21_0._time + l_21_0._blink_speed
	end
end


