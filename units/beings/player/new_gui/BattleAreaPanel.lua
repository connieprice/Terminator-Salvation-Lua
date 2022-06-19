require("units/beings/player/new_gui/HudPanel")
BattleAreaPanel = BattleAreaPanel or class(HudPanel)
function BattleAreaPanel.init(A0_0, A1_1, A2_2)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	Localizer:load("data/strings/context_actions.xml")
	A0_0._width = A1_1:width()
	A0_0._height = tweak_data.player.new_hud.battle_area_panel.HEIGHT
	A0_0._x = A0_0._parent_panel:width() / 2
	A0_0._y = A0_0._parent_panel:height() / 2
	A0_0._panel = A0_0._parent_panel:panel({
		name = "battle_area_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "center",
		halign = "center"
	})
	A0_0._panel:set_center_x(A0_0._x)
	A0_0._panel:set_center_y(A0_0._y)
	A0_0._text = A0_0._panel:text({
		layer = tweak_data.player.new_hud.battle_area_panel.TEXT_LAYER,
		font = tweak_data.player.new_hud.battle_area_panel.TEXT_FONT,
		font_size = tweak_data.player.new_hud.battle_area_panel.TEXT_FONT_SIZE,
		text = "3",
		color = tweak_data.player.new_hud.battle_area_panel.TEXT_FONT_COLOR
	})
	A0_0._text:set_wrap(true)
	A0_0._text_x = A0_0._width / 2
	A0_0._text_y = A0_0._height / 2
	A0_0._text:set_center_x(A0_0._text_x)
	A0_0._text:set_center_y(A0_0._text_y)
	A0_0:set_alpha(0)
	A0_0._stay_visible_time = 0
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.battle_area_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator:set_target(0)
	A0_0._time = 0
	A0_0._next_blink_time = 0
	A0_0._blink_speed = tweak_data.player.new_hud.battle_area_panel.BLINK_SPEED
	A0_0._blink_alpha_modifier = 1
	A0_0._warning_time = 0
end
function BattleAreaPanel.update(A0_3, A1_4)
	A0_3._stay_visible_time = A0_3._stay_visible_time - A1_4
	A0_3:_update_text(A1_4)
	A0_3:_update_alpha(A1_4)
	A0_3:_update_blink(A1_4)
end
function BattleAreaPanel._update_text(A0_5, A1_6)
	if A0_5._player_data.has_left_battle_area_time_out then
		A0_5._blink = false
		A0_5._text:set_text(Localizer:lookup("battle_area_message_failure"))
		A0_5._text:set_align("center")
	elseif A0_5._player_data.has_left_battle_area_timer ~= -1 then
		A0_5._warning_time = A0_5._warning_time + A1_6
		if A0_5._warning_time > tweak_data.player.new_hud.battle_area_panel.BLINK_START_TIME then
			A0_5._blink = true
		else
			A0_5._blink = false
		end
		A0_5._text:set_text(Localizer:lookup("battle_area_message_warning"))
		A0_5._text:set_align("center")
	else
		A0_5._warning_time = 0
	end
end
function BattleAreaPanel._update_alpha(A0_7, A1_8)
	local L2_9
	L2_9 = A0_7._alpha_interpolator
	L2_9 = L2_9.update
	L2_9(L2_9, A1_8)
	L2_9 = A0_7._alpha_interpolator
	L2_9 = L2_9.value
	L2_9 = L2_9(L2_9)
	A0_7:set_alpha(L2_9)
end
function BattleAreaPanel.panel(A0_10)
	local L1_11
	L1_11 = A0_10._panel
	return L1_11
end
function BattleAreaPanel.show(A0_12)
	A0_12._stay_visible_time = tweak_data.player.new_hud.battle_area_panel.MIN_TIME_BEFORE_FADE_OUT
	A0_12._visible_time = 0
	A0_12._alpha_interpolator:set_target(1)
	A0_12._alpha_interpolator:set_speed(tweak_data.player.new_hud.battle_area_panel.FADE_IN_SPEED)
	A0_12:use_high_frequency_update()
end
function BattleAreaPanel.hide(A0_13)
	if A0_13._stay_visible_time < 0 then
		A0_13._alpha_interpolator:set_target(0)
		A0_13._alpha_interpolator:set_speed(tweak_data.player.new_hud.battle_area_panel.FADE_OUT_SPEED)
		A0_13._blink = false
	end
end
function BattleAreaPanel.visible(A0_14)
	return A0_14._alpha > 0 or A0_14._blink
end
function BattleAreaPanel.instant_hide(A0_15)
	A0_15:set_alpha(0)
	A0_15._blink = false
end
function BattleAreaPanel.get_alpha(A0_16)
	local L1_17
	L1_17 = A0_16._alpha
	return L1_17
end
function BattleAreaPanel.set_alpha(A0_18, A1_19)
	HudPanel.set_alpha(A0_18, A1_19)
	A0_18._text:set_color(A0_18._text:color():with_alpha(A1_19))
end
function BattleAreaPanel._update_blink(A0_20, A1_21)
	A0_20._time = A0_20._time + A1_21
	if A0_20._time > A0_20._next_blink_time and A0_20._blink then
		if A0_20._alpha_interpolator:target() == 0 then
			A0_20._alpha_interpolator:set_target(1)
			A0_20._alpha_interpolator:set_speed(tweak_data.player.new_hud.battle_area_panel.BLINK_FADE_SPEED)
		else
			A0_20._alpha_interpolator:set_target(0)
			A0_20._alpha_interpolator:set_speed(tweak_data.player.new_hud.battle_area_panel.BLINK_FADE_SPEED)
		end
		A0_20._next_blink_time = A0_20._time + A0_20._blink_speed
	end
end
