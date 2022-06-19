require("units/beings/player/new_gui/HudPanel")
TutorialPanel = TutorialPanel or class(HudPanel)
function TutorialPanel.init(A0_0, A1_1, A2_2)
	HudPanel.init(A0_0, false)
	A0_0._parent_panel = A1_1
	A0_0._safe_panel = A2_2
	A0_0._width = A0_0._safe_panel:width()
	A0_0._height = tweak_data.player.new_hud.tutorial_panel.HEIGHT
	A0_0._start_x = A0_0._parent_panel:width() + A0_0._width + 100
	A0_0._y = A0_0._safe_panel:top()
	A0_0._text_alpha = 0
	A0_0._texture_alpha = 0
	Localizer:load("data/strings/tutorial_strings.xml")
	A0_0._panel = A0_0._parent_panel:panel({
		name = "tutorial_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "top",
		halign = "right",
		layer = tweak_data.player.new_hud.tutorial_panel.LAYER
	})
	A0_0._panel:set_righttop(A0_0._start_x, A0_0._y)
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.tutorial_panel.FADE_IN_SPEED)
	A0_0._alpha_interpolator:set_target(1)
	A0_0:_set_alpha(0)
end
function TutorialPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._panel
	return L1_4
end
function TutorialPanel.show(A0_5, A1_6)
	local L2_7, L3_8, L4_9, L5_10, L6_11, L7_12, L8_13
	L2_7 = A0_5._current_tutorial
	if L2_7 == A1_6 then
		return
	end
	L3_8 = A0_5
	L2_7 = A0_5._set_alpha
	L4_9 = 0
	L2_7(L3_8, L4_9)
	L3_8 = A0_5
	L2_7 = A0_5.use_high_frequency_update
	L2_7(L3_8)
	A0_5._fade_out = true
	L2_7 = A1_6.background
	L3_8 = managers
	L3_8 = L3_8.localizer_mapping
	L4_9 = L3_8
	L3_8 = L3_8.get_localizer_mapping_by_slot
	L5_10 = 1
	L3_8 = L3_8(L4_9, L5_10)
	L4_9 = managers
	L4_9 = L4_9.localization
	L5_10 = L4_9
	L4_9 = L4_9.text
	L6_11 = A1_6.text
	L7_12 = L3_8
	L4_9 = L4_9(L5_10, L6_11, L7_12)
	L5_10 = A0_5._panel
	L6_11 = L5_10
	L5_10 = L5_10.text
	L7_12 = {}
	L7_12.text = L4_9
	L8_13 = tweak_data
	L8_13 = L8_13.player
	L8_13 = L8_13.new_hud
	L8_13 = L8_13.tutorial_panel
	L8_13 = L8_13.TEXT_FONT
	L7_12.font = L8_13
	L8_13 = tweak_data
	L8_13 = L8_13.player
	L8_13 = L8_13.new_hud
	L8_13 = L8_13.tutorial_panel
	L8_13 = L8_13.TEXT_FONT_SIZE
	L7_12.font_size = L8_13
	L7_12.valign = "bottom"
	L8_13 = tweak_data
	L8_13 = L8_13.player
	L8_13 = L8_13.new_hud
	L8_13 = L8_13.tutorial_panel
	L8_13 = L8_13.TEXT_FONT_COLOR
	L7_12.color = L8_13
	L5_10 = L5_10(L6_11, L7_12)
	A0_5._tutorial_text = L5_10
	L5_10 = A0_5._tutorial_text
	L6_11 = L5_10
	L5_10 = L5_10.set_wrap
	L7_12 = true
	L5_10(L6_11, L7_12)
	L5_10 = A0_5._tutorial_text
	L6_11 = L5_10
	L5_10 = L5_10.set_width
	L7_12 = A0_5._safe_panel
	L8_13 = L7_12
	L7_12 = L7_12.width
	L7_12 = L7_12(L8_13)
	L8_13 = tweak_data
	L8_13 = L8_13.player
	L8_13 = L8_13.new_hud
	L8_13 = L8_13.tutorial_panel
	L8_13 = L8_13.TEXT_RECT_WIDTH
	L7_12 = L7_12 * L8_13
	L5_10(L6_11, L7_12)
	L5_10 = A0_5._tutorial_text
	L6_11 = L5_10
	L5_10 = L5_10.set_righttop
	L7_12 = A0_5._panel
	L8_13 = L7_12
	L7_12 = L7_12.width
	L7_12 = L7_12(L8_13)
	L8_13 = 0
	L5_10(L6_11, L7_12, L8_13)
	L5_10 = A0_5._tutorial_text
	L6_11 = L5_10
	L5_10 = L5_10.set_vertical
	L7_12 = "top"
	L5_10(L6_11, L7_12)
	L5_10 = A0_5._tutorial_text
	L6_11 = L5_10
	L5_10 = L5_10.set_align
	L7_12 = "right"
	L5_10(L6_11, L7_12)
	L5_10 = A0_5._tutorial_text
	L6_11 = L5_10
	L5_10 = L5_10.text_rect
	L8_13 = L5_10(L6_11)
	if A1_6.texture and A1_6.texture ~= "" then
		A0_5._tutorial_texture = A0_5._panel:bitmap({
			name = "tutorial_texture",
			texture = A1_6.texture
		})
		A0_5._tutorial_texture:set_righttop(A0_5._panel:width(), L8_13)
	else
		A0_5:_set_texture_alpha(0)
		A0_5._tutorial_texture = nil
	end
	A0_5._current_tutorial = A1_6
	A0_5._panel:set_righttop(A0_5._start_x, A0_5._y)
	A0_5._slide_interpolator = Interpolator:new(A0_5._start_x, tweak_data.player.new_hud.tutorial_panel.SLIDE_IN_SPEED)
	A0_5._slide_interpolator:set_target(A0_5._safe_panel:right())
	A0_5._first_slide_done = false
	A0_5._alpha_interpolator:set_value(0)
	A0_5:_set_text_alpha(0)
	A0_5:_set_texture_alpha(1)
end
function TutorialPanel.hide(A0_14)
	A0_14._fade_out = true
	A0_14:use_high_frequency_update()
	A0_14._alpha_interpolator:set_target(0)
	A0_14._alpha_interpolator:set_speed(tweak_data.player.new_hud.tutorial_panel.FADE_OUT_SPEED)
	A0_14._slide_interpolator = nil
end
function TutorialPanel.visible(A0_15)
	local L1_16
	L1_16 = A0_15._text_alpha
	L1_16 = L1_16 > 0 or L1_16 > 0
	return L1_16
end
function TutorialPanel._set_alpha(A0_17, A1_18)
	A0_17._alpha = A1_18
	A0_17:_set_text_alpha(A1_18)
	A0_17:_set_texture_alpha(A1_18)
end
function TutorialPanel._set_text_alpha(A0_19, A1_20)
	if A0_19._tutorial_text then
		A0_19._text_alpha = A1_20
		A0_19._tutorial_text:set_color(A0_19._tutorial_text:color():with_alpha(A1_20))
		if A1_20 == 1 then
			A0_19:use_low_frequency_update()
		end
	end
end
function TutorialPanel._set_texture_alpha(A0_21, A1_22)
	HudPanel.set_alpha(A0_21, A1_22)
	if A0_21._tutorial_texture then
		A0_21._texture_alpha = A1_22
		A0_21._tutorial_texture:set_color(A0_21._tutorial_texture:color():with_alpha(A1_22))
	end
end
function TutorialPanel.update(A0_23, A1_24)
	local L2_25
	L2_25 = A0_23._alpha_interpolator
	L2_25 = L2_25.update
	L2_25(L2_25, A1_24)
	L2_25 = A0_23._alpha_interpolator
	L2_25 = L2_25.value
	L2_25 = L2_25(L2_25)
	A0_23:_set_text_alpha(L2_25)
	if A0_23._slide_interpolator then
		A0_23:_update_slide(A1_24)
	else
		A0_23:_set_texture_alpha(L2_25)
	end
end
function TutorialPanel._update_slide(A0_26, A1_27)
	A0_26._slide_interpolator:update(A1_27)
	A0_26._x = A0_26._slide_interpolator:value()
	if A0_26._x - A0_26._slide_interpolator:target() < tweak_data.player.new_hud.tutorial_panel.SHOW_TEXT_AT_PIXELS_LEFT_ON_SLIDE then
		A0_26._alpha_interpolator:set_target(1)
		A0_26._alpha_interpolator:set_speed(tweak_data.player.new_hud.tutorial_panel.FADE_IN_SPEED)
	end
	if A0_26._slide_interpolator:has_reached_target() then
		A0_26._x = A0_26._slide_interpolator:target()
		A0_26._panel:set_righttop(A0_26._x, A0_26._y)
		A0_26._first_slide_done = true
	end
	if not A0_26._first_slide_done then
		A0_26._panel:set_righttop(A0_26._x, A0_26._y)
	end
end
function TutorialPanel.use_splitscreen_position(A0_28)
	if A0_28._y == A0_28._parent_panel:height() / 2 - A0_28._height / 2 + A0_28._safe_panel:top() / 2 then
		return
	end
	A0_28._y = A0_28._parent_panel:height() / 2 - A0_28._height / 2 + A0_28._safe_panel:top() / 2
	A0_28._panel:set_righttop(A0_28._x, A0_28._y)
end
function TutorialPanel.use_single_player_position(A0_29)
	if A0_29._y == A0_29._safe_panel:top() then
		return
	end
	A0_29._y = A0_29._safe_panel:top()
	A0_29._panel:set_righttop(A0_29._x, A0_29._y)
end
