require("units/beings/player/new_gui/HudPanel")
if not TutorialPanel then
	TutorialPanel = class(HudPanel)
end
TutorialPanel.init = function(l_1_0, l_1_1, l_1_2)
	HudPanel.init(l_1_0, false)
	l_1_0._parent_panel = l_1_1
	l_1_0._safe_panel = l_1_2
	l_1_0._width = l_1_0._safe_panel:width()
	l_1_0._height = tweak_data.player.new_hud.tutorial_panel.HEIGHT
	l_1_0._start_x = l_1_0._parent_panel:width() + l_1_0._width + 100
	l_1_0._y = l_1_0._safe_panel:top()
	l_1_0._text_alpha = 0
	l_1_0._texture_alpha = 0
	Localizer:load("data/strings/tutorial_strings.xml")
	local l_1_3, l_1_4 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_5 = {}
	l_1_5.name = "tutorial_panel"
	l_1_5.width = l_1_0._width
	l_1_5.height = l_1_0._height
	l_1_5.valign = "top"
	l_1_5.halign = "right"
	l_1_5.layer = tweak_data.player.new_hud.tutorial_panel.LAYER
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._panel = l_1_3
	l_1_3 = l_1_0._panel
	l_1_3, l_1_4 = l_1_3:set_righttop, l_1_3
	l_1_5 = l_1_0._start_x
	l_1_3(l_1_4, l_1_5, l_1_0._y)
	l_1_3 = Interpolator
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 0
	l_1_3 = l_1_3(l_1_4, l_1_5, tweak_data.player.new_hud.tutorial_panel.FADE_IN_SPEED)
	l_1_0._alpha_interpolator = l_1_3
	l_1_3 = l_1_0._alpha_interpolator
	l_1_3, l_1_4 = l_1_3:set_target, l_1_3
	l_1_5 = 1
	l_1_3(l_1_4, l_1_5)
	l_1_3, l_1_4 = l_1_0:_set_alpha, l_1_0
	l_1_5 = 0
	l_1_3(l_1_4, l_1_5)
end

TutorialPanel.panel = function(l_2_0)
	return l_2_0._panel
end

TutorialPanel.show = function(l_3_0, l_3_1)
	if l_3_0._current_tutorial == l_3_1 then
		return 
	end
	l_3_0:_set_alpha(0)
	l_3_0:use_high_frequency_update()
	l_3_0._fade_out = true
	local l_3_2 = l_3_1.background
	local l_3_3 = managers.localizer_mapping:get_localizer_mapping_by_slot(1)
	local l_3_4 = managers.localization:text(l_3_1.text, l_3_3)
	local l_3_5, l_3_6 = l_3_0._panel:text, l_3_0._panel
	local l_3_7 = {}
	l_3_7.text = l_3_4
	l_3_7.font = tweak_data.player.new_hud.tutorial_panel.TEXT_FONT
	l_3_7.font_size = tweak_data.player.new_hud.tutorial_panel.TEXT_FONT_SIZE
	l_3_7.valign = "bottom"
	l_3_7.color = tweak_data.player.new_hud.tutorial_panel.TEXT_FONT_COLOR
	l_3_5 = l_3_5(l_3_6, l_3_7)
	l_3_0._tutorial_text = l_3_5
	l_3_5 = l_3_0._tutorial_text
	l_3_5, l_3_6 = l_3_5:set_wrap, l_3_5
	l_3_7 = true
	l_3_5(l_3_6, l_3_7)
	l_3_5 = l_3_0._tutorial_text
	l_3_5, l_3_6 = l_3_5:set_width, l_3_5
	l_3_7 = l_3_0._safe_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_5(l_3_6, l_3_7)
	l_3_5 = l_3_0._tutorial_text
	l_3_5, l_3_6 = l_3_5:set_righttop, l_3_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_5(l_3_6, l_3_7, 0)
	l_3_5 = l_3_0._tutorial_text
	l_3_5, l_3_6 = l_3_5:set_vertical, l_3_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_5(l_3_6, l_3_7)
	l_3_5 = l_3_0._tutorial_text
	l_3_5, l_3_6 = l_3_5:set_align, l_3_5
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_5(l_3_6, l_3_7)
	l_3_5 = l_3_0._tutorial_text
	l_3_5, l_3_6 = l_3_5:text_rect, l_3_5
	l_3_5 = l_3_5(l_3_6)
	local l_3_8 = nil
	if l_3_1.texture and l_3_1.texture ~= "" then
		local l_3_9, l_3_10 = l_3_0._panel:bitmap, l_3_0._panel
		do
			local l_3_11 = {}
			l_3_11.name = "tutorial_texture"
			l_3_11.texture = l_3_1.texture
			l_3_9 = l_3_9(l_3_10, l_3_11)
			l_3_0._tutorial_texture = l_3_9
			l_3_9 = l_3_0._tutorial_texture
			l_3_9, l_3_10 = l_3_9:set_righttop, l_3_9
			l_3_11 = l_3_0._panel
			 -- DECOMPILER ERROR: Overwrote pending register.

			l_3_9(l_3_10, l_3_11, l_3_8)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_3_0:_set_texture_alpha(l_3_11)
		l_3_0._tutorial_texture = nil
	end
	l_3_0._current_tutorial = l_3_1
	l_3_0._panel:set_righttop(l_3_0._start_x, l_3_0._y)
	l_3_0._slide_interpolator = Interpolator:new(l_3_0._start_x, tweak_data.player.new_hud.tutorial_panel.SLIDE_IN_SPEED)
	l_3_0._slide_interpolator:set_target(l_3_0._safe_panel:right())
	l_3_0._first_slide_done = false
	l_3_0._alpha_interpolator:set_value(0)
	l_3_0:_set_text_alpha(0)
	l_3_0:_set_texture_alpha(1)
end

TutorialPanel.hide = function(l_4_0)
	l_4_0._fade_out = true
	l_4_0:use_high_frequency_update()
	l_4_0._alpha_interpolator:set_target(0)
	l_4_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.tutorial_panel.FADE_OUT_SPEED)
	l_4_0._slide_interpolator = nil
end

TutorialPanel.visible = function(l_5_0)
	return l_5_0._text_alpha > 0 or l_5_0._texture_alpha > 0
end

TutorialPanel._set_alpha = function(l_6_0, l_6_1)
	l_6_0._alpha = l_6_1
	l_6_0:_set_text_alpha(l_6_1)
	l_6_0:_set_texture_alpha(l_6_1)
end

TutorialPanel._set_text_alpha = function(l_7_0, l_7_1)
	if l_7_0._tutorial_text then
		l_7_0._text_alpha = l_7_1
		l_7_0._tutorial_text:set_color(l_7_0._tutorial_text:color():with_alpha(l_7_1))
	if l_7_1 == 1 then
		end
		l_7_0:use_low_frequency_update()
	end
end

TutorialPanel._set_texture_alpha = function(l_8_0, l_8_1)
	HudPanel.set_alpha(l_8_0, l_8_1)
	if l_8_0._tutorial_texture then
		l_8_0._texture_alpha = l_8_1
		l_8_0._tutorial_texture:set_color(l_8_0._tutorial_texture:color():with_alpha(l_8_1))
	end
end

TutorialPanel.update = function(l_9_0, l_9_1)
	l_9_0._alpha_interpolator:update(l_9_1)
	local l_9_2 = l_9_0._alpha_interpolator:value()
	l_9_0:_set_text_alpha(l_9_2)
	if l_9_0._slide_interpolator then
		l_9_0:_update_slide(l_9_1)
	else
		l_9_0:_set_texture_alpha(l_9_2)
	end
end

TutorialPanel._update_slide = function(l_10_0, l_10_1)
	l_10_0._slide_interpolator:update(l_10_1)
	l_10_0._x = l_10_0._slide_interpolator:value()
	if l_10_0._x - l_10_0._slide_interpolator:target() < tweak_data.player.new_hud.tutorial_panel.SHOW_TEXT_AT_PIXELS_LEFT_ON_SLIDE then
		l_10_0._alpha_interpolator:set_target(1)
		l_10_0._alpha_interpolator:set_speed(tweak_data.player.new_hud.tutorial_panel.FADE_IN_SPEED)
	end
	if l_10_0._slide_interpolator:has_reached_target() then
		l_10_0._x = l_10_0._slide_interpolator:target()
		l_10_0._panel:set_righttop(l_10_0._x, l_10_0._y)
		l_10_0._first_slide_done = true
	end
	if not l_10_0._first_slide_done then
		l_10_0._panel:set_righttop(l_10_0._x, l_10_0._y)
	end
end

TutorialPanel.use_splitscreen_position = function(l_11_0)
	local l_11_1 = l_11_0._parent_panel:height() / 2 - l_11_0._height / 2 + l_11_0._safe_panel:top() / 2
	if l_11_0._y == l_11_1 then
		return 
	end
	l_11_0._y = l_11_1
	l_11_0._panel:set_righttop(l_11_0._x, l_11_0._y)
end

TutorialPanel.use_single_player_position = function(l_12_0)
	if l_12_0._y == l_12_0._safe_panel:top() then
		return 
	end
	l_12_0._y = l_12_0._safe_panel:top()
	l_12_0._panel:set_righttop(l_12_0._x, l_12_0._y)
end


