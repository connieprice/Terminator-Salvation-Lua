require("units/beings/player/new_gui/HudPanel")
if not BattleAreaPanel then
	BattleAreaPanel = class(HudPanel)
end
BattleAreaPanel.init = function(l_1_0, l_1_1, l_1_2)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._player_unit = l_1_2
	l_1_0._player_data = l_1_2:player_data()
	Localizer:load("data/strings/context_actions.xml")
	l_1_0._width = l_1_1:width()
	l_1_0._height = tweak_data.player.new_hud.battle_area_panel.HEIGHT
	l_1_0._x = l_1_0._parent_panel:width() / 2
	l_1_0._y = l_1_0._parent_panel:height() / 2
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "battle_area_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.valign = "center"
	l_1_5.halign = "center"
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:set_center_x, l_1_3
	l_1_5 = l_1_0._x
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:set_center_y, l_1_3
	l_1_5 = l_1_0._y
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:text, l_1_3
	l_1_3, l_1_5 = l_1_3(l_1_4, l_1_5), {layer = tweak_data.player.new_hud.battle_area_panel.TEXT_LAYER, font = tweak_data.player.new_hud.battle_area_panel.TEXT_FONT, font_size = tweak_data.player.new_hud.battle_area_panel.TEXT_FONT_SIZE, text = "3", color = tweak_data.player.new_hud.battle_area_panel.TEXT_FONT_COLOR}
	l_1_0._text = l_1_3
	l_1_3 = l_1_0._text
	l_1_3, l_1_4 = l_1_3:set_wrap, l_1_3
	l_1_5 = true
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._width
	l_1_3 = l_1_3 / 2
	l_1_0._text_x = l_1_3
	l_1_3 = l_1_0._height
	l_1_3 = l_1_3 / 2
	l_1_0._text_y = l_1_3
	l_1_3 = l_1_0._text
	l_1_3, l_1_4 = l_1_3:set_center_x, l_1_3
	l_1_5 = l_1_0._text_x
	l_1_3(l_1_4, l_1_5)
	l_1_3 = l_1_0._text
	l_1_3, l_1_4 = l_1_3:set_center_y, l_1_3
	l_1_5 = l_1_0._text_y
	l_1_3(l_1_4, l_1_5)
	l_1_3, l_1_4 = l_1_0:set_alpha, l_1_0
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_0._stay_visible_time = 0
	l_1_3 = Interpolator
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 0
	l_1_3 = l_1_3(l_1_4, l_1_5, tweak_data.player.new_hud.battle_area_panel.FADE_IN_SPEED)
	l_1_0._alpha_interpolator = l_1_3
	l_1_3 = l_1_0._alpha_interpolator
	l_1_3, l_1_4 = l_1_3:set_target, l_1_3
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
	l_1_0._time = 0
	l_1_0._next_blink_time = 0
	l_1_3 = tweak_data
	l_1_3 = l_1_3.player
	l_1_3 = l_1_3.new_hud
	l_1_3 = l_1_3.battle_area_panel
	l_1_3 = l_1_3.BLINK_SPEED
	l_1_0._blink_speed = l_1_3
	l_1_0._blink_alpha_modifier = 1
	l_1_0._warning_time = 0
end

BattleAreaPanel.update = function(l_2_0, l_2_1)
	l_2_0._stay_visible_time = l_2_0._stay_visible_time - l_2_1
	l_2_0:_update_text(l_2_1)
	l_2_0:_update_alpha(l_2_1)
	l_2_0:_update_blink(l_2_1)
end

BattleAreaPanel._update_text = function(l_3_0, l_3_1)
	if l_3_0._player_data.has_left_battle_area_time_out then
		l_3_0._blink = false
		l_3_0._text:set_text(Localizer:lookup("battle_area_message_failure"))
		l_3_0._text:set_align("center")
	else
		if l_3_0._player_data.has_left_battle_area_timer ~= -1 then
			l_3_0._warning_time = l_3_0._warning_time + l_3_1
			if tweak_data.player.new_hud.battle_area_panel.BLINK_START_TIME < l_3_0._warning_time then
				l_3_0._blink = true
			else
				l_3_0._blink = false
			end
			l_3_0._text:set_text(Localizer:lookup("battle_area_message_warning"))
			l_3_0._text:set_align("center")
		end
	else
		l_3_0._warning_time = 0
	end
end

BattleAreaPanel._update_alpha = function(l_4_0, l_4_1)
	l_4_0._alpha_interpolator:update(l_4_1)
	local l_4_2 = l_4_0._alpha_interpolator:value()
	l_4_0:set_alpha(l_4_2)
end

BattleAreaPanel.panel = function(l_5_0)
	return l_5_0._panel
end

BattleAreaPanel.show = function(l_6_0)
	l_6_0._stay_visible_time = tweak_data.player.new_hud.battle_area_panel.MIN_TIME_BEFORE_FADE_OUT
	l_6_0._visible_time = 0
	l_6_0._alpha_interpolator:set_target(1)
	l_6_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.battle_area_panel.FADE_IN_SPEED)
	l_6_0:use_high_frequency_update()
end

BattleAreaPanel.hide = function(l_7_0)
	if l_7_0._stay_visible_time < 0 then
		l_7_0._alpha_interpolator:set_target(0)
		l_7_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.battle_area_panel.FADE_OUT_SPEED)
		l_7_0._blink = false
	end
end

BattleAreaPanel.visible = function(l_8_0)
	if l_8_0._alpha <= 0 then
		local l_8_1 = l_8_0._blink
		l_8_1 = l_8_1
		return l_8_1
	end
end

BattleAreaPanel.instant_hide = function(l_9_0)
	l_9_0:set_alpha(0)
	l_9_0._blink = false
end

BattleAreaPanel.get_alpha = function(l_10_0)
	return l_10_0._alpha
end

BattleAreaPanel.set_alpha = function(l_11_0, l_11_1)
	HudPanel.set_alpha(l_11_0, l_11_1)
	l_11_0._text:set_color(l_11_0._text:color():with_alpha(l_11_1))
end

BattleAreaPanel._update_blink = function(l_12_0, l_12_1)
	l_12_0._time = l_12_0._time + l_12_1
	if l_12_0._next_blink_time < l_12_0._time and l_12_0._blink then
		if l_12_0._alpha_interpolator:target() == 0 then
			l_12_0._alpha_interpolator:set_target(1)
			l_12_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.battle_area_panel.BLINK_FADE_SPEED)
		else
			l_12_0._alpha_interpolator:set_target(0)
			l_12_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.battle_area_panel.BLINK_FADE_SPEED)
		end
		l_12_0._next_blink_time = l_12_0._time + l_12_0._blink_speed
	end
end


