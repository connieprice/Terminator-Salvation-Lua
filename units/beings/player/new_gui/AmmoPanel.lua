require("units/beings/player/new_gui/Hud3DigitText")
require("units/beings/player/new_gui/HudPanel")
if not AmmoPanel then
	AmmoPanel = class(HudPanel)
end
AmmoPanel.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	l_1_0._width = tweak_data.player.new_hud.ammo_panel.WIDTH
	l_1_0._height = tweak_data.player.new_hud.ammo_panel.HEIGHT
	l_1_0._x = 0
	l_1_0._y = l_1_0._parent_panel:height()
	local l_1_4, l_1_5 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_6 = {}
	l_1_6.name = "ammo_panel"
	l_1_6.width = l_1_0._width
	l_1_6.height = l_1_0._height
	l_1_6.valign = "bottom"
	l_1_6.halign = "left"
	l_1_4 = l_1_4(l_1_5, l_1_6)
	l_1_0._panel = l_1_4
	l_1_4 = l_1_0._panel
	l_1_4, l_1_5 = l_1_4:set_leftbottom, l_1_4
	l_1_6 = l_1_0._x
	l_1_4(l_1_5, l_1_6, l_1_0._y)
	l_1_0._primary_weapon = nil
	l_1_0._secondary_weapon = nil
	l_1_0._ammo_icons, l_1_4 = l_1_4, {}
	l_1_4 = l_1_0._ammo_icons
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:bitmap, l_1_5
	local l_1_7 = {}
	l_1_7.name = "primary"
	l_1_7.texture = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_PRIMARY_WEAPON
	l_1_5 = l_1_5(l_1_6, l_1_7)
	l_1_4.primary_weapon = l_1_5
	l_1_4 = l_1_0._ammo_icons
	l_1_4 = l_1_4.primary_weapon
	l_1_4, l_1_5 = l_1_4:set_leftbottom, l_1_4
	l_1_6 = tweak_data
	l_1_6 = l_1_6.player
	l_1_6 = l_1_6.new_hud
	l_1_6 = l_1_6.ammo_panel
	l_1_6 = l_1_6.ICON_OFFSET_X
	l_1_7 = l_1_0._height
	l_1_7 = l_1_7 - tweak_data.player.new_hud.ammo_panel.ICON_OFFSET_Y
	l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_4 = l_1_0._ammo_icons
	l_1_4 = l_1_4.primary_weapon
	l_1_4, l_1_5 = l_1_4:color, l_1_4
	l_1_4 = l_1_4(l_1_5)
	l_1_0._ammo_icon_color = l_1_4
	l_1_4 = l_1_0._ammo_icons
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:bitmap, l_1_5
	l_1_5, l_1_7 = l_1_5(l_1_6, l_1_7), {name = "secondary", texture = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_SECONDARY_WEAPON}
	l_1_4.secondary_weapon = l_1_5
	l_1_4 = l_1_0._ammo_icons
	l_1_4 = l_1_4.secondary_weapon
	l_1_4, l_1_5 = l_1_4:set_lefttop, l_1_4
	l_1_6 = tweak_data
	l_1_6 = l_1_6.player
	l_1_6 = l_1_6.new_hud
	l_1_6 = l_1_6.ammo_panel
	l_1_6 = l_1_6.ICON_OFFSET_X
	l_1_7 = tweak_data
	l_1_7 = l_1_7.player
	l_1_7 = l_1_7.new_hud
	l_1_7 = l_1_7.ammo_panel
	l_1_7 = l_1_7.ICON_OFFSET_Y
	l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_0._ammo_gui_texts, l_1_4 = l_1_4, {}
	l_1_4 = l_1_0._ammo_gui_texts
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:text, l_1_5
	l_1_5, l_1_7 = l_1_5(l_1_6, l_1_7), {font = tweak_data.player.new_hud.ammo_panel.TEXT_FONT, font_size = tweak_data.player.new_hud.ammo_panel.TEXT_FONT_SIZE, text = "", valign = "bottom", color = tweak_data.player.new_hud.ammo_panel.BULLETS_TEXT_FONT_COLOR}
	l_1_4.primary_bullets_in_clip = l_1_5
	l_1_4 = l_1_0._ammo_gui_texts
	l_1_4 = l_1_4.primary_bullets_in_clip
	l_1_4, l_1_5 = l_1_4:set_leftbottom, l_1_4
	l_1_6 = tweak_data
	l_1_6 = l_1_6.player
	l_1_6 = l_1_6.new_hud
	l_1_6 = l_1_6.ammo_panel
	l_1_6 = l_1_6.TEXT_OFFSET_X
	l_1_7 = l_1_0._height
	l_1_7 = l_1_7 - tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_Y
	l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_4 = l_1_0._ammo_gui_texts
	l_1_4 = l_1_4.primary_bullets_in_clip
	l_1_4, l_1_5 = l_1_4:set_vertical, l_1_4
	l_1_6 = "bottom"
	l_1_4(l_1_5, l_1_6)
	l_1_4 = l_1_0._ammo_gui_texts
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:text, l_1_5
	l_1_5, l_1_7 = l_1_5(l_1_6, l_1_7), {font = tweak_data.player.new_hud.ammo_panel.TEXT_FONT, font_size = tweak_data.player.new_hud.ammo_panel.TEXT_FONT_SIZE, text = "", valign = "bottom", color = tweak_data.player.new_hud.ammo_panel.CLIPS_TEXT_FONT_COLOR}
	l_1_4.primary_clips = l_1_5
	l_1_4 = l_1_0._ammo_gui_texts
	l_1_4 = l_1_4.primary_clips
	l_1_4, l_1_5 = l_1_4:set_leftbottom, l_1_4
	l_1_6 = tweak_data
	l_1_6 = l_1_6.player
	l_1_6 = l_1_6.new_hud
	l_1_6 = l_1_6.ammo_panel
	l_1_6 = l_1_6.TEXT_OFFSET_X
	l_1_6 = 80 + l_1_6
	l_1_7 = l_1_0._height
	l_1_7 = l_1_7 - tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_Y
	l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_4 = l_1_0._ammo_gui_texts
	l_1_4 = l_1_4.primary_clips
	l_1_4, l_1_5 = l_1_4:set_vertical, l_1_4
	l_1_6 = "bottom"
	l_1_4(l_1_5, l_1_6)
	l_1_0._ammo_texts, l_1_4 = l_1_4, {}
	l_1_4 = l_1_0._ammo_texts
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:text, l_1_5
	l_1_5, l_1_7 = l_1_5(l_1_6, l_1_7), {font = tweak_data.player.new_hud.ammo_panel.TEXT_FONT, font_size = tweak_data.player.new_hud.ammo_panel.TEXT_FONT_SIZE, text = tweak_data.player.new_hud.ammo_panel.SPLITTER_CHARACTER, valign = "bottom", color = tweak_data.player.new_hud.ammo_panel.SPLITTER_TEXT_FONT_COLOR}
	l_1_4.primary_splitter = l_1_5
	l_1_4 = l_1_0._ammo_texts
	l_1_4 = l_1_4.primary_splitter
	l_1_4, l_1_5 = l_1_4:set_leftbottom, l_1_4
	l_1_6 = tweak_data
	l_1_6 = l_1_6.player
	l_1_6 = l_1_6.new_hud
	l_1_6 = l_1_6.ammo_panel
	l_1_6 = l_1_6.TEXT_OFFSET_X
	l_1_6 = 65 + l_1_6
	l_1_7 = l_1_0._height
	l_1_7 = l_1_7 + 1
	l_1_7 = l_1_7 - tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_Y
	l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_4 = l_1_0._ammo_texts
	l_1_4 = l_1_4.primary_splitter
	l_1_4, l_1_5 = l_1_4:set_vertical, l_1_4
	l_1_6 = "bottom"
	l_1_4(l_1_5, l_1_6)
	l_1_4 = l_1_0._ammo_texts
	l_1_5 = l_1_0._panel
	l_1_5, l_1_6 = l_1_5:text, l_1_5
	l_1_5, l_1_7 = l_1_5(l_1_6, l_1_7), {font = tweak_data.player.new_hud.ammo_panel.TEXT_FONT, font_size = tweak_data.player.new_hud.ammo_panel.TEXT_FONT_SIZE, text = "3", valign = "bottom", color = tweak_data.player.new_hud.ammo_panel.GRENADES_TEXT_FONT_COLOR}
	l_1_4.secondary = l_1_5
	l_1_4 = l_1_0._ammo_texts
	l_1_4 = l_1_4.secondary
	l_1_4, l_1_5 = l_1_4:set_lefttop, l_1_4
	l_1_6 = tweak_data
	l_1_6 = l_1_6.player
	l_1_6 = l_1_6.new_hud
	l_1_6 = l_1_6.ammo_panel
	l_1_6 = l_1_6.TEXT_OFFSET_X
	l_1_7 = tweak_data
	l_1_7 = l_1_7.player
	l_1_7 = l_1_7.new_hud
	l_1_7 = l_1_7.ammo_panel
	l_1_7 = l_1_7.TEXT_OFFSET_Y
	l_1_7 = 0 + l_1_7
	l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_0._ammo_digit_texts, l_1_4 = l_1_4, {}
	l_1_4 = l_1_0._ammo_digit_texts
	l_1_5 = Hud3DigitText
	l_1_5, l_1_6 = l_1_5:new, l_1_5
	l_1_7 = l_1_0._ammo_gui_texts
	l_1_7 = l_1_7.primary_bullets_in_clip
	l_1_5 = l_1_5(l_1_6, l_1_7)
	l_1_4.primary_bullets_in_clip = l_1_5
	l_1_4 = l_1_0._ammo_digit_texts
	l_1_5 = Hud3DigitText
	l_1_5, l_1_6 = l_1_5:new, l_1_5
	l_1_7 = l_1_0._ammo_gui_texts
	l_1_7 = l_1_7.primary_clips
	l_1_5 = l_1_5(l_1_6, l_1_7)
	l_1_4.primary_clips = l_1_5
	l_1_4, l_1_5 = l_1_0:set_alpha, l_1_0
	l_1_6 = 0
	l_1_4(l_1_5, l_1_6)
	l_1_0._stay_visible_time = 0
	l_1_0._t = 0
	l_1_4 = Interpolator
	l_1_4, l_1_5 = l_1_4:new, l_1_4
	l_1_6 = 0
	l_1_7 = tweak_data
	l_1_7 = l_1_7.player
	l_1_7 = l_1_7.new_hud
	l_1_7 = l_1_7.ammo_panel
	l_1_7 = l_1_7.FADE_IN_SPEED
	l_1_4 = l_1_4(l_1_5, l_1_6, l_1_7)
	l_1_0._alpha_interpolator = l_1_4
	l_1_4 = l_1_0._alpha_interpolator
	l_1_4, l_1_5 = l_1_4:set_target, l_1_4
	l_1_6 = 0
	l_1_4(l_1_5, l_1_6)
end

AmmoPanel.panel = function(l_2_0)
	return l_2_0._panel
end

AmmoPanel.show = function(l_3_0)
	l_3_0._stay_visible_time = tweak_data.player.new_hud.ammo_panel.TIME_BEFORE_FADE_OUT
	l_3_0._alpha_interpolator:set_target(1)
	l_3_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.FADE_IN_SPEED)
end

AmmoPanel.hide = function(l_4_0)
	if l_4_0._stay_visible_time < 0 then
		l_4_0._alpha_interpolator:set_target(0)
		l_4_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.FADE_OUT_SPEED)
	end
end

AmmoPanel.visible = function(l_5_0)
	return l_5_0._alpha > 0
end

AmmoPanel.update_primary_weapon_icon = function(l_6_0)
	local l_6_1 = nil
	if l_6_0._primary_weapon:base()._projectile_spawner:hud() then
		l_6_1 = l_6_0._primary_weapon:base()._projectile_spawner:hud():texture_name()
	else
		l_6_1 = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_PRIMARY_WEAPON
	end
	l_6_0._ammo_icons.primary_weapon:set_image(l_6_1)
end

AmmoPanel.update_secondary_weapon_icon = function(l_7_0)
	local l_7_1 = nil
	if l_7_0._secondary_weapon:hud() then
		l_7_1 = l_7_0._secondary_weapon:hud():small_texture_name()
	else
		l_7_1 = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_SECONDARY_WEAPON
	end
	l_7_0._ammo_icons.secondary_weapon:set_image(l_7_1)
end

AmmoPanel.get_alpha = function(l_8_0)
	return l_8_0._alpha
end

AmmoPanel.set_alpha = function(l_9_0, l_9_1)
	local l_9_5, l_9_6, l_9_7, l_9_8, l_9_9, l_9_10, l_9_11, l_9_12, l_9_13, l_9_14, l_9_15, l_9_16, l_9_17, l_9_18, l_9_19, l_9_20 = nil
	HudPanel.set_alpha(l_9_0, l_9_1)
	for i_0,i_1 in pairs(l_9_0._ammo_texts) do
		i_1:set_color(i_1:color():with_alpha(l_9_0._alpha))
	end
	for i_0,i_1 in pairs(l_9_0._ammo_digit_texts) do
		i_1:set_alpha(l_9_1)
	end
	for i_0,i_1 in pairs(l_9_0._ammo_icons) do
		i_1:set_color(i_1:color():with_alpha(l_9_0._alpha))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AmmoPanel.update = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5)
	local l_10_11, l_10_12, l_10_13, l_10_14 = nil
	local l_10_6 = l_10_1 - l_10_0._t
	l_10_0._t = l_10_1
	if l_10_3 then
		l_10_0:_update_weapons(l_10_3, l_10_4)
		l_10_0:_update_ammo()
	end
	l_10_0._stay_visible_time = l_10_0._stay_visible_time - l_10_6
	l_10_0._alpha_interpolator:update(l_10_2)
	local l_10_7 = l_10_0._alpha_interpolator:value()
	l_10_0:set_alpha(l_10_7)
	for i_0,i_1 in pairs(l_10_0._ammo_digit_texts) do
		i_1:update(l_10_2)
	end
	if l_10_0._current_color ~= l_10_0._ammo_digit_texts.primary_bullets_in_clip:get_red_color() then
		l_10_0._ammo_icons.primary_weapon:set_color(l_10_0._ammo_icon_color * l_10_0._current_color:with_alpha(l_10_0._alpha))
	end
	if not l_10_0._alpha_interpolator:has_reached_target() or l_10_5 or true then
		l_10_0:use_high_frequency_update()
	else
		l_10_0:use_low_frequency_update()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

AmmoPanel._update_weapons = function(l_11_0, l_11_1, l_11_2)
	if alive(l_11_1) and l_11_0._primary_weapon ~= l_11_1 then
		l_11_0._primary_weapon = l_11_1
	if l_11_1 then
		end
		l_11_0._primary_weapon_data = l_11_1:weapon_data()
		l_11_0:update_primary_weapon_icon()
	end
	if alive(l_11_2) and l_11_0._secondary_weapon ~= l_11_2 then
		l_11_0._secondary_weapon = l_11_2
	if l_11_2 then
		end
		l_11_0._secondary_weapon_data = l_11_2:weapon_data()
		l_11_0:update_secondary_weapon_icon()
	end
end

AmmoPanel._update_ammo = function(l_12_0)
	local l_12_1 = math.ceil(l_12_0._primary_weapon:logic():ammo_pool() / l_12_0._primary_weapon_data._clip_size)
	local l_12_2 = l_12_0._primary_weapon_data:bullets_in_clip()
	local l_12_3 = ""
	l_12_0._ammo_digit_texts.primary_bullets_in_clip:set_text(l_12_2)
	l_12_0._ammo_digit_texts.primary_clips:set_text(l_12_1)
	local l_12_4 = tweak_data.player.new_hud.ammo_panel.LOW_AMMO_WARNING[l_12_0._primary_weapon:name()]
	if l_12_4 and l_12_2 <= l_12_4 then
		l_12_0._ammo_digit_texts.primary_bullets_in_clip:show_red()
	else
		l_12_0._ammo_digit_texts.primary_bullets_in_clip:hide_red()
	end
	if l_12_0._secondary_weapon_data then
		l_12_3 = l_12_0._secondary_weapon:logic():ammo_pool() + l_12_0._secondary_weapon_data:bullets_in_clip()
	end
	l_12_0._ammo_texts.secondary:set_text(l_12_3)
end

AmmoPanel._parse = function(l_13_0, l_13_1)
	local l_13_2 = "000" .. l_13_1
	l_13_2 = l_13_2:sub(-3)
	return l_13_2
end

AmmoPanel.instant_hide = function(l_14_0)
	local l_14_4, l_14_5, l_14_6, l_14_7 = nil
	l_14_0:set_alpha(0)
	for i_0,i_1 in pairs(l_14_0._ammo_digit_texts) do
		i_1:instant_hide()
	end
end


