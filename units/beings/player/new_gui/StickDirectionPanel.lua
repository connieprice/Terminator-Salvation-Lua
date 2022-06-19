require("units/beings/player/new_gui/HudPanel")
if not StickDirectionPanel then
	StickDirectionPanel = class(HudPanel)
end
StickDirectionPanel.init = function(l_1_0, l_1_1, l_1_2)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._width = l_1_0._parent_panel:width()
	l_1_0._height = l_1_0._parent_panel:height()
	l_1_0._center_x = l_1_0._parent_panel:width() / 2
	l_1_0._center_y = l_1_0._parent_panel:height() / 2
	l_1_0._radius = 0
	l_1_0._current_angle = 0
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "stick_direction_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.valign = "center"
	l_1_5.halign = "center"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:bitmap, l_1_3
	l_1_3, l_1_5 = l_1_3(l_1_4, l_1_5), {name = "gui_hud_selection_dot", texture = "gui_hud_selection_dot"}
	l_1_0._stick_dot_texture = l_1_3
	l_1_3 = Interpolator
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 0
	l_1_3 = l_1_3(l_1_4, l_1_5, tweak_data.player.new_hud.stick_direction_panel.FADE_IN_SPEED)
	l_1_0._alpha_interpolator = l_1_3
	l_1_3 = l_1_0._alpha_interpolator
	l_1_3, l_1_4 = l_1_3:set_target, l_1_3
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_3 = Interpolator
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 0
	l_1_3 = l_1_3(l_1_4, l_1_5, tweak_data.player.new_hud.stick_direction_panel.ANGULAR_SPEED)
	l_1_0._angle_interpolator = l_1_3
	l_1_3 = l_1_0._angle_interpolator
	l_1_3, l_1_4 = l_1_3:set_target, l_1_3
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_3 = Interpolator
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 0
	l_1_3 = l_1_3(l_1_4, l_1_5, tweak_data.player.new_hud.stick_direction_panel.RADIUS_SPEED)
	l_1_0._radius_interpolator = l_1_3
	l_1_3 = l_1_0._radius_interpolator
	l_1_3, l_1_4 = l_1_3:set_target, l_1_3
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
end

StickDirectionPanel.panel = function(l_2_0)
	return l_2_0._panel
end

StickDirectionPanel.set_angle = function(l_3_0, l_3_1)
	local l_3_2 = nil
	if tweak_data.player.new_hud.stick_direction_panel.USE_RADIUS_MOVEMENT then
		l_3_2 = l_3_0._radius
	else
		l_3_2 = tweak_data.player.new_hud.stick_direction_panel.RADIUS
	end
	local l_3_3 = l_3_0._center_x + l_3_2 * math.cos(l_3_1 - 90)
	l_3_0._stick_dot_texture:set_rotation(l_3_1)
	l_3_0._stick_dot_texture:set_center(l_3_3, l_3_0._center_y + l_3_2 * math.sin(l_3_1 - 90))
end

StickDirectionPanel.update_angle = function(l_4_0)
	l_4_0:set_angle(l_4_0._current_angle)
end

StickDirectionPanel.set_radius = function(l_5_0, l_5_1)
	l_5_0._radius = l_5_1
end

StickDirectionPanel.show = function(l_6_0)
	l_6_0._wants_to_hide = false
	l_6_0._alpha_interpolator:set_target(1)
	l_6_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.stick_direction_panel.FADE_IN_SPEED)
	if l_6_0._alpha_interpolator:value() == 0 then
		l_6_0._radius = 0
	end
end

StickDirectionPanel.hide = function(l_7_0)
	l_7_0._wants_to_hide = true
	l_7_0._alpha_interpolator:set_target(0)
	l_7_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.stick_direction_panel.FADE_OUT_SPEED)
end

StickDirectionPanel.visible = function(l_8_0)
	return l_8_0._alpha > 0
end

StickDirectionPanel.get_alpha = function(l_9_0)
	return l_9_0._alpha
end

StickDirectionPanel.set_alpha = function(l_10_0, l_10_1)
	HudPanel.set_alpha(l_10_0, l_10_1)
	l_10_0._stick_dot_texture:set_color(l_10_0._stick_dot_texture:color():with_alpha(l_10_0._alpha))
end

StickDirectionPanel.update = function(l_11_0, l_11_1, l_11_2, l_11_3)
	local l_11_4 = l_11_3
	local l_11_5 = l_11_2
	if l_11_5 and l_11_5 >= 0 then
		if not l_11_0._init_angle then
			l_11_0._init_angle = l_11_5
			l_11_0._angle_interpolator:set_value(l_11_5)
		end
		if l_11_0._angle_interpolator:value() > 360 then
			local l_11_6, l_11_7 = l_11_0._angle_interpolator:value() - 360
			l_11_7 = l_11_0._angle_interpolator
			l_11_7(l_11_7, l_11_6)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_11_6 < 0 then
			local l_11_8, l_11_9, l_11_10 = l_11_6 + 360, l_11_7
			l_11_9 = l_11_0._angle_interpolator
			l_11_9, l_11_10 = l_11_9:set_value, l_11_9
			l_11_9(l_11_10, l_11_8)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		local l_11_11 = nil
		if l_11_8 - l_11_5 > 240 then
			l_11_5 = l_11_5 + 360
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_11_8 - l_11_5 < -240 then
			l_11_5 = l_11_5 - 360
		end
		l_11_0._angle_interpolator:set_target(l_11_5)
	end
	l_11_0._angle_interpolator:update(l_11_1)
	l_11_5 = l_11_0._angle_interpolator:value()
	l_11_0:set_angle(l_11_5)
	if l_11_4 == 0 then
		l_11_0._init_angle = nil
	end
	if l_11_4 and not l_11_0._wants_to_hide then
		l_11_0._radius_interpolator:set_target(l_11_4 * tweak_data.player.new_hud.stick_direction_panel.RADIUS)
	end
	l_11_0._radius_interpolator:update(l_11_1)
	local l_11_12 = l_11_0._radius_interpolator:value()
	l_11_0:set_radius(l_11_12)
	if not tweak_data.player.new_hud.stick_direction_panel.USE_RADIUS_MOVEMENT then
		if l_11_12 > 0.98 then
			l_11_0._alpha_interpolator:set_target(1)
			l_11_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.stick_direction_panel.FADE_IN_SPEED)
		end
	else
		l_11_0._alpha_interpolator:set_target(0)
		l_11_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.stick_direction_panel.FADE_OUT_SPEED)
	end
	l_11_0._alpha_interpolator:update(l_11_1)
	local l_11_13 = l_11_0._alpha_interpolator:value()
	if l_11_0._alpha_interpolator:target() == 0 and l_11_0._alpha_interpolator:has_reached_target() then
		l_11_0._radius_interpolator:set_target(0)
		l_11_0._radius_interpolator:set_value(0)
		l_11_0._init_angle = nil
	end
	l_11_0:set_alpha(l_11_13)
end


