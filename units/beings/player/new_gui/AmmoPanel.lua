require("units/beings/player/new_gui/Hud3DigitText")
require("units/beings/player/new_gui/HudPanel")
AmmoPanel = AmmoPanel or class(HudPanel)
function AmmoPanel.init(A0_0, A1_1, A2_2, A3_3)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._width = tweak_data.player.new_hud.ammo_panel.WIDTH
	A0_0._height = tweak_data.player.new_hud.ammo_panel.HEIGHT
	A0_0._x = 0
	A0_0._y = A0_0._parent_panel:height()
	A0_0._panel = A0_0._parent_panel:panel({
		name = "ammo_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "bottom",
		halign = "left"
	})
	A0_0._panel:set_leftbottom(A0_0._x, A0_0._y)
	A0_0._primary_weapon = nil
	A0_0._secondary_weapon = nil
	A0_0._ammo_icons = {}
	A0_0._ammo_icons.primary_weapon = A0_0._panel:bitmap({
		name = "primary",
		texture = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_PRIMARY_WEAPON
	})
	A0_0._ammo_icons.primary_weapon:set_leftbottom(tweak_data.player.new_hud.ammo_panel.ICON_OFFSET_X, A0_0._height - tweak_data.player.new_hud.ammo_panel.ICON_OFFSET_Y)
	A0_0._ammo_icon_color = A0_0._ammo_icons.primary_weapon:color()
	A0_0._ammo_icons.secondary_weapon = A0_0._panel:bitmap({
		name = "secondary",
		texture = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_SECONDARY_WEAPON
	})
	A0_0._ammo_icons.secondary_weapon:set_lefttop(tweak_data.player.new_hud.ammo_panel.ICON_OFFSET_X, tweak_data.player.new_hud.ammo_panel.ICON_OFFSET_Y)
	A0_0._ammo_gui_texts = {}
	A0_0._ammo_gui_texts.primary_bullets_in_clip = A0_0._panel:text({
		font = tweak_data.player.new_hud.ammo_panel.TEXT_FONT,
		font_size = tweak_data.player.new_hud.ammo_panel.TEXT_FONT_SIZE,
		text = "",
		valign = "bottom",
		color = tweak_data.player.new_hud.ammo_panel.BULLETS_TEXT_FONT_COLOR
	})
	A0_0._ammo_gui_texts.primary_bullets_in_clip:set_leftbottom(tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_X, A0_0._height - tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_Y)
	A0_0._ammo_gui_texts.primary_bullets_in_clip:set_vertical("bottom")
	A0_0._ammo_gui_texts.primary_clips = A0_0._panel:text({
		font = tweak_data.player.new_hud.ammo_panel.TEXT_FONT,
		font_size = tweak_data.player.new_hud.ammo_panel.TEXT_FONT_SIZE,
		text = "",
		valign = "bottom",
		color = tweak_data.player.new_hud.ammo_panel.CLIPS_TEXT_FONT_COLOR
	})
	A0_0._ammo_gui_texts.primary_clips:set_leftbottom(80 + tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_X, A0_0._height - tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_Y)
	A0_0._ammo_gui_texts.primary_clips:set_vertical("bottom")
	A0_0._ammo_texts = {}
	A0_0._ammo_texts.primary_splitter = A0_0._panel:text({
		font = tweak_data.player.new_hud.ammo_panel.TEXT_FONT,
		font_size = tweak_data.player.new_hud.ammo_panel.TEXT_FONT_SIZE,
		text = tweak_data.player.new_hud.ammo_panel.SPLITTER_CHARACTER,
		valign = "bottom",
		color = tweak_data.player.new_hud.ammo_panel.SPLITTER_TEXT_FONT_COLOR
	})
	A0_0._ammo_texts.primary_splitter:set_leftbottom(65 + tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_X, A0_0._height + 1 - tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_Y)
	A0_0._ammo_texts.primary_splitter:set_vertical("bottom")
	A0_0._ammo_texts.secondary = A0_0._panel:text({
		font = tweak_data.player.new_hud.ammo_panel.TEXT_FONT,
		font_size = tweak_data.player.new_hud.ammo_panel.TEXT_FONT_SIZE,
		text = "3",
		valign = "bottom",
		color = tweak_data.player.new_hud.ammo_panel.GRENADES_TEXT_FONT_COLOR
	})
	A0_0._ammo_texts.secondary:set_lefttop(tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_X, 0 + tweak_data.player.new_hud.ammo_panel.TEXT_OFFSET_Y)
	A0_0._ammo_digit_texts = {}
	A0_0._ammo_digit_texts.primary_bullets_in_clip = Hud3DigitText:new(A0_0._ammo_gui_texts.primary_bullets_in_clip)
	A0_0._ammo_digit_texts.primary_clips = Hud3DigitText:new(A0_0._ammo_gui_texts.primary_clips)
	A0_0:set_alpha(0)
	A0_0._stay_visible_time = 0
	A0_0._t = 0
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.ammo_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator:set_target(0)
end
function AmmoPanel.panel(A0_4)
	local L1_5
	L1_5 = A0_4._panel
	return L1_5
end
function AmmoPanel.show(A0_6)
	A0_6._stay_visible_time = tweak_data.player.new_hud.ammo_panel.TIME_BEFORE_FADE_OUT
	A0_6._alpha_interpolator:set_target(1)
	A0_6._alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.FADE_IN_SPEED)
end
function AmmoPanel.hide(A0_7)
	if A0_7._stay_visible_time < 0 then
		A0_7._alpha_interpolator:set_target(0)
		A0_7._alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.FADE_OUT_SPEED)
	end
end
function AmmoPanel.visible(A0_8)
	return A0_8._alpha > 0
end
function AmmoPanel.update_primary_weapon_icon(A0_9)
	local L1_10
	if A0_9._primary_weapon:base()._projectile_spawner:hud() then
		L1_10 = A0_9._primary_weapon:base()._projectile_spawner:hud():texture_name()
	else
		L1_10 = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_PRIMARY_WEAPON
	end
	A0_9._ammo_icons.primary_weapon:set_image(L1_10)
end
function AmmoPanel.update_secondary_weapon_icon(A0_11)
	local L1_12
	if A0_11._secondary_weapon:hud() then
		L1_12 = A0_11._secondary_weapon:hud():small_texture_name()
	else
		L1_12 = tweak_data.player.new_hud.ammo_panel.DEFAULT_ICON_SECONDARY_WEAPON
	end
	A0_11._ammo_icons.secondary_weapon:set_image(L1_12)
end
function AmmoPanel.get_alpha(A0_13)
	local L1_14
	L1_14 = A0_13._alpha
	return L1_14
end
function AmmoPanel.set_alpha(A0_15, A1_16)
	HudPanel.set_alpha(A0_15, A1_16)
	for 