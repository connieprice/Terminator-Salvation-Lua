require("shared/Angle")
require("units/beings/player/new_gui/HudPanel")
if not HurtDirectionIndicatorPanel then
	HurtDirectionIndicatorPanel = class(HudPanel)
end
HurtDirectionIndicatorPanel.init = function(l_1_0, l_1_1, l_1_2)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._width = l_1_0._parent_panel:width()
	l_1_0._height = l_1_0._parent_panel:height()
	l_1_0._centre_x = l_1_0._width / 2
	l_1_0._centre_y = l_1_0._height / 2
	l_1_0._radius = tweak_data.player.new_hud.hurt_direction_indicator_panel.RADIUS
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "hurt_direction_indicator_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.valign = "center"
	l_1_5.halign = "center"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:bitmap, l_1_3
	l_1_3, l_1_5 = l_1_3(l_1_4, l_1_5), {name = "gui_damage_indicator", texture = "gui_damage_indicator"}
	l_1_0._hurt_direction_indicator_texture = l_1_3
	l_1_3 = l_1_0._hurt_direction_indicator_texture
	l_1_3, l_1_4 = l_1_3:set_center, l_1_3
	l_1_5 = l_1_0._centre_x
	l_1_3(l_1_4, l_1_5, l_1_0._centre_y)
	l_1_0._alpha = 0
	l_1_3 = Interpolator
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 0
	l_1_3 = l_1_3(l_1_4, l_1_5, tweak_data.player.new_hud.hurt_direction_indicator_panel.FADE_OUT_SPEED)
	l_1_0._alpha_interpolator = l_1_3
	l_1_3 = l_1_0._alpha_interpolator
	l_1_3, l_1_4 = l_1_3:set_target, l_1_3
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._hurt_direction_indicator_texture
	l_1_3, l_1_4 = l_1_3:set_color, l_1_3
	l_1_5 = l_1_0._hurt_direction_indicator_texture
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_4, l_1_5)
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_3(l_1_4, l_1_5)
end

HurtDirectionIndicatorPanel.panel = function(l_2_0)
	return l_2_0._panel
end

HurtDirectionIndicatorPanel.visible = function(l_3_0)
	return l_3_0._alpha > 0
end

HurtDirectionIndicatorPanel.set_angle = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._centre_x + l_4_0._radius * math.cos(l_4_1 - 90)
	local l_4_3 = l_4_0._centre_y + l_4_0._radius * math.sin(l_4_1 - 90)
	local l_4_4 = 0
	if l_4_0._current_angle then
		l_4_4 = angle_diff(l_4_0._current_angle, l_4_1)
	end
	if l_4_4 > 5 or not l_4_0._current_angle then
		l_4_0._current_angle = l_4_1
		l_4_0._hurt_direction_indicator_texture:set_rotation(l_4_1)
		l_4_0._hurt_direction_indicator_texture:set_center(l_4_2, l_4_3)
	end
end

HurtDirectionIndicatorPanel.update_hurt_direction = function(l_5_0, l_5_1)
	if l_5_1 then
		local l_5_2 = l_5_0._player_unit:camera_data().camera_rotation:y()
		local l_5_3 = Rotation(l_5_1, Vector3(0, 0, 1)):roll()
		local l_5_4 = Rotation(l_5_2, Vector3(0, 0, 1)):roll()
		local l_5_5 = l_5_4 - l_5_3 + 180
		l_5_0:set_angle(l_5_5)
	end
end

HurtDirectionIndicatorPanel.update_alpha = function(l_6_0, l_6_1, l_6_2)
	if l_6_2 and l_6_2 < tweak_data.player.hud.DAMAGE_INDICATOR_STAY_TIME then
		l_6_0._alpha_interpolator:set_value(1)
		l_6_0._alpha_interpolator:set_target(0)
		l_6_0:use_low_frequency_update()
	else
		l_6_0._alpha_interpolator:update(l_6_1)
		l_6_0:use_high_frequency_update()
	end
	local l_6_3 = l_6_0._alpha_interpolator:value()
	l_6_0:set_alpha(l_6_3)
end

HurtDirectionIndicatorPanel.instant_hide = function(l_7_0)
	l_7_0._alpha_interpolator:set_value(0)
	l_7_0._alpha_interpolator:set_target(0)
	l_7_0._hurt_direction_indicator_texture:set_color(l_7_0._hurt_direction_indicator_texture:color():with_alpha(0))
end

HurtDirectionIndicatorPanel.update = function(l_8_0, l_8_1, l_8_2, l_8_3)
	l_8_0:update_hurt_direction(l_8_3)
	l_8_0:update_alpha(l_8_1, l_8_2)
	if l_8_3 then
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 10 
end

HurtDirectionIndicatorPanel.set_alpha = function(l_9_0, l_9_1)
	HudPanel.set_alpha(l_9_0, l_9_1)
	l_9_0._hurt_direction_indicator_texture:set_color(l_9_0._hurt_direction_indicator_texture:color():with_alpha(l_9_0._alpha))
end


