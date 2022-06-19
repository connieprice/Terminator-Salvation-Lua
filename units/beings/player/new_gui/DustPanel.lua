require("units/beings/player/new_gui/HudPanel")
require("units/beings/player/new_gui/HudUtility")
if not DustPanel then
	DustPanel = class(HudPanel)
end
DustPanel.init = function(l_1_0, l_1_1, l_1_2)
	HudPanel.init(l_1_0, false)
	l_1_0:set_low_frequency_update(1)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._width = l_1_0._parent_panel:width()
	l_1_0._height = l_1_0._parent_panel:height()
	l_1_0._center_x = l_1_0._width / 2
	l_1_0._center_y = l_1_0._height / 2
	l_1_0._x = 0
	l_1_0._y = 0
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "dust_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.valign = "center"
	l_1_5.halign = "center"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:set_center, l_1_3
	l_1_5 = l_1_0._center_x
	l_1_3(l_1_4, l_1_5, l_1_0._center_y)
	l_1_0._dust_icon, l_1_3 = l_1_3, {}
	l_1_3 = l_1_0._dust_icon
	l_1_4 = l_1_0._panel
	l_1_4, l_1_5 = l_1_4:bitmap, l_1_4
	local l_1_6 = {}
	l_1_6.name = "dust_icon"
	l_1_6.texture = "gui_screeneffect_dust_01"
	l_1_6.valign = "center"
	l_1_6.halign = "center"
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_3.first_dust = l_1_4
	l_1_3 = l_1_0._dust_icon
	l_1_3 = l_1_3.first_dust
	l_1_3, l_1_4 = l_1_3:set_size, l_1_3
	l_1_5 = tweak_data
	l_1_5 = l_1_5.player
	l_1_5 = l_1_5.new_hud
	l_1_5 = l_1_5.dust_panel
	l_1_5 = l_1_5.FIRST_DUST_TEXTURE_SIZE
	l_1_6 = tweak_data
	l_1_6 = l_1_6.player
	l_1_6 = l_1_6.new_hud
	l_1_6 = l_1_6.dust_panel
	l_1_6 = l_1_6.FIRST_DUST_TEXTURE_SIZE
	l_1_3(l_1_4, l_1_5, l_1_6)
	l_1_3 = l_1_0._dust_icon
	l_1_3 = l_1_3.first_dust
	l_1_3, l_1_4 = l_1_3:set_center, l_1_3
	l_1_5 = l_1_0._center_x
	l_1_6 = l_1_0._center_y
	l_1_3(l_1_4, l_1_5, l_1_6)
	l_1_3 = l_1_0._dust_icon
	l_1_4 = l_1_0._panel
	l_1_4, l_1_5 = l_1_4:bitmap, l_1_4
	l_1_4, l_1_6 = l_1_4(l_1_5, l_1_6), {name = "dust_icon", texture = "gui_screeneffect_dust_02", valign = "center", halign = "center"}
	l_1_3.second_dust = l_1_4
	l_1_3 = l_1_0._dust_icon
	l_1_3 = l_1_3.second_dust
	l_1_3, l_1_4 = l_1_3:set_size, l_1_3
	l_1_5 = tweak_data
	l_1_5 = l_1_5.player
	l_1_5 = l_1_5.new_hud
	l_1_5 = l_1_5.dust_panel
	l_1_5 = l_1_5.SECOND_DUST_TEXTURE_SIZE
	l_1_6 = tweak_data
	l_1_6 = l_1_6.player
	l_1_6 = l_1_6.new_hud
	l_1_6 = l_1_6.dust_panel
	l_1_6 = l_1_6.SECOND_DUST_TEXTURE_SIZE
	l_1_3(l_1_4, l_1_5, l_1_6)
	l_1_3 = l_1_0._dust_icon
	l_1_3 = l_1_3.second_dust
	l_1_3, l_1_4 = l_1_3:set_center, l_1_3
	l_1_5 = l_1_0._center_x
	l_1_6 = l_1_0._center_y
	l_1_3(l_1_4, l_1_5, l_1_6)
	l_1_0._alpha_table, l_1_3 = l_1_3, {}
	l_1_3 = l_1_0._alpha_table
	l_1_3.first_dust = 0
	l_1_3 = l_1_0._alpha_table
	l_1_3.second_dust = 0
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	l_1_5 = 0
	l_1_6 = "first_dust"
	l_1_3(l_1_4, l_1_5, l_1_6)
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	l_1_5 = 0
	l_1_6 = "second_dust"
	l_1_3(l_1_4, l_1_5, l_1_6)
	l_1_0._stay_visible_time = 0
	l_1_0._alpha_interpolator, l_1_3 = l_1_3, {}
	l_1_3 = l_1_0._alpha_interpolator
	l_1_4 = Interpolator
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_6 = 0
	l_1_4 = l_1_4(l_1_5, l_1_6, tweak_data.player.new_hud.dust_panel.FADE_IN_SPEED)
	l_1_3.first_dust = l_1_4
	l_1_3 = l_1_0._alpha_interpolator
	l_1_3 = l_1_3.first_dust
	l_1_3, l_1_4 = l_1_3:set_target, l_1_3
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._alpha_interpolator
	l_1_4 = Interpolator
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_6 = 0
	l_1_4 = l_1_4(l_1_5, l_1_6, tweak_data.player.new_hud.dust_panel.FADE_IN_SPEED)
	l_1_3.second_dust = l_1_4
	l_1_3 = l_1_0._alpha_interpolator
	l_1_3 = l_1_3.second_dust
	l_1_3, l_1_4 = l_1_3:set_target, l_1_3
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_3 = HudUtility
	l_1_3 = l_1_3.is_split_screen
	l_1_3 = l_1_3()
	l_1_0._is_split_screen = l_1_3
end

DustPanel.panel = function(l_2_0)
	return l_2_0._panel
end

DustPanel.show = function(l_3_0, l_3_1)
	l_3_0._explosion_direction = l_3_1
	l_3_0._second_dust_start = tweak_data.player.new_hud.dust_panel.DELAY_BETWEEN_DUSTS
	l_3_0:_show("first_dust")
end

DustPanel._show = function(l_4_0, l_4_1)
	l_4_0._stay_visible_time = tweak_data.player.new_hud.dust_panel.TIME_BEFORE_FADE_OUT
	l_4_0._alpha_interpolator[l_4_1]:set_target(1)
	l_4_0._alpha_interpolator[l_4_1]:set_speed(tweak_data.player.new_hud.dust_panel.FADE_IN_SPEED)
	local l_4_2 = l_4_0:_get_explosion_direction_angle()
	l_4_0:_set_random_position_and_rotation(l_4_2, l_4_1)
end

DustPanel._get_random_rotation = function(l_5_0)
	local l_5_1 = math.random
	local l_5_2 = 360
	return l_5_1(l_5_2)
end

DustPanel._get_random_radius = function(l_6_0)
	local l_6_1 = nil
	if l_6_0._is_split_screen then
		l_6_1 = math.random(tweak_data.player.new_hud.dust_panel.COOP_RADIUS_VARIATION * 2) - tweak_data.player.new_hud.dust_panel.COOP_RADIUS_VARIATION
	else
		l_6_1 = math.random(tweak_data.player.new_hud.dust_panel.RADIUS_VARIATION * 2) - tweak_data.player.new_hud.dust_panel.RADIUS_VARIATION
	end
	return tweak_data.player.new_hud.dust_panel.RADIUS + (l_6_1)
end

DustPanel._get_random_angle = function(l_7_0, l_7_1)
	l_7_1 = l_7_1 + (math.random(tweak_data.player.new_hud.dust_panel.ANGLE_VARIATION * 2) - tweak_data.player.new_hud.dust_panel.ANGLE_VARIATION)
	return l_7_1
end

DustPanel._set_random_position_and_rotation = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = l_8_0:_get_random_radius()
	local l_8_4 = l_8_0:_get_random_rotation()
	local l_8_5 = l_8_0:_get_random_angle(l_8_1)
	local l_8_6 = l_8_0._center_x + l_8_3 * math.cos(l_8_5 - 90)
	local l_8_7 = l_8_0._center_y + l_8_3 * math.sin(l_8_5 - 90)
	if alive(l_8_0._dust_icon[l_8_2]) then
		if l_8_0._is_split_screen then
			l_8_0:_randomize_texture(l_8_2)
		else
			l_8_0._dust_icon[l_8_2]:set_rotation(l_8_4)
		end
		l_8_0._dust_icon[l_8_2]:set_center(l_8_6, l_8_7)
	end
end

DustPanel._randomize_texture = function(l_9_0, l_9_1)
	local l_9_2 = math.random(4)
	local l_9_3 = "gui_screeneffect_dust_01"
	if l_9_1 == "second_dust" then
		l_9_3 = "gui_screeneffect_dust_02"
	end
	if l_9_2 == 1 then
		l_9_0._dust_icon[l_9_1]:set_image(l_9_3, 0, 0, 256, 256)
	elseif l_9_2 == 2 then
		l_9_0._dust_icon[l_9_1]:set_image(l_9_3, 256, 0, -256, 256)
	elseif l_9_2 == 3 then
		l_9_0._dust_icon[l_9_1]:set_image(l_9_3, 0, 256, 256, -256)
	else
		l_9_0._dust_icon[l_9_1]:set_image(l_9_3, 256, 256, -256, -256)
	end
end

DustPanel._get_explosion_direction_angle = function(l_10_0)
	local l_10_1 = l_10_0._explosion_direction
	local l_10_2 = l_10_0._player_unit:camera_data().camera_rotation:y()
	return Rotation(l_10_2, Vector3(0, 0, 1)):roll() - Rotation(l_10_1, Vector3(0, 0, 1)):roll() + 180
end

DustPanel.hide = function(l_11_0)
	if l_11_0._stay_visible_time < 0 then
		l_11_0._alpha_interpolator.first_dust:set_target(0)
		l_11_0._alpha_interpolator.first_dust:set_speed(tweak_data.player.new_hud.dust_panel.FADE_OUT_SPEED)
		l_11_0._alpha_interpolator.second_dust:set_target(0)
		l_11_0._alpha_interpolator.second_dust:set_speed(tweak_data.player.new_hud.dust_panel.FADE_OUT_SPEED)
	end
end

DustPanel.visible = function(l_12_0)
	return l_12_0._alpha_table.first_dust > 0 or l_12_0._alpha_table.second_dust > 0 or l_12_0._stay_visible_time > 0
end

DustPanel.done = function(l_13_0)
	return l_13_0._alpha_table.first_dust > 0.3 or l_13_0._alpha_table.second_dust > 0.3 or l_13_0._stay_visible_time > 0
end

DustPanel.get_alpha = function(l_14_0)
	return l_14_0._alpha
end

DustPanel.set_alpha = function(l_15_0, l_15_1, l_15_2)
	l_15_0._alpha_table[l_15_2] = l_15_1
	l_15_0._dust_icon[l_15_2]:set_color(l_15_0._dust_icon[l_15_2]:color():with_alpha(l_15_0._alpha_table[l_15_2]))
	local l_15_3 = math.max(l_15_0._alpha_table.first_dust, l_15_0._alpha_table.second_dust)
	HudPanel.set_alpha(l_15_0, l_15_3)
end

DustPanel.set_temp_alpha = function(l_16_0, l_16_1, l_16_2)
	l_16_0._dust_icon[l_16_2]:set_color(l_16_0._dust_icon[l_16_2]:color():with_alpha(l_16_1))
	HudPanel.set_alpha(l_16_0, 0)
end

DustPanel.update = function(l_17_0, l_17_1, l_17_2)
	local l_17_6, l_17_7, l_17_8, l_17_9, l_17_10, l_17_11, l_17_12, l_17_13, l_17_14, l_17_15 = nil
	if l_17_0._second_dust_start then
		l_17_0._second_dust_start = l_17_0._second_dust_start - l_17_1
	if l_17_0._second_dust_start <= 0 then
		end
		l_17_0:_show("second_dust")
		l_17_0._second_dust_start = nil
	end
	l_17_0._stay_visible_time = l_17_0._stay_visible_time - l_17_1
	if l_17_0._stay_visible_time <= 0 then
		l_17_0:hide()
	end
	for i_0,i_1 in pairs(l_17_0._alpha_interpolator) do
		i_1:update(l_17_1)
		 -- DECOMPILER ERROR: Overwrote pending register.

		if i_1:has_reached_target() then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_17_2 then
			l_17_0:set_temp_alpha(0, l_17_16)
		else
			l_17_0:set_alpha(nil, l_17_16)
		end
	end
end


