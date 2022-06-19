if not IntroCreditsText then
	IntroCreditsText = class()
end
IntroCreditsText.init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7, l_1_8)
	local l_1_9 = tweak_data.hud.intro_credits.HEADER_FONT_NAME
	local l_1_10 = tweak_data.hud.intro_credits.HEADER_FONT_SIZE
	l_1_0._panel = l_1_1
	l_1_0._line_widget_center_x = l_1_1:width() / 2
	local l_1_11, l_1_12 = l_1_1:text, l_1_1
	local l_1_13 = {}
	l_1_13.font = l_1_9
	l_1_13.font_size = l_1_10
	l_1_13.color = Color(0, 0.8, 0.8, 0.8)
	l_1_13.halign = "center"
	l_1_13.valign = "center"
	l_1_13.align = "left"
	l_1_13.height = 100
	l_1_13.text = l_1_3
	l_1_11 = l_1_11(l_1_12, l_1_13)
	l_1_0._head_widget = l_1_11
	l_1_11 = l_1_0._head_widget
	l_1_11, l_1_12 = l_1_11:text_rect, l_1_11
	l_1_11 = l_1_11(l_1_12)
	local l_1_14 = nil
	l_1_0._head_widget:set_w(R17_PC37)
	l_1_0._head_widget:set_center_y(R17_PC37)
	local l_1_15 = 2
	l_1_6 = l_1_6 + l_1_10 + l_1_15
	l_1_9 = tweak_data.hud.intro_credits.TEXT_FONT_NAME
	l_1_10 = tweak_data.hud.intro_credits.TEXT_FONT_SIZE
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_1_16, l_1_17 = l_1_1:text, R17_PC37
	local l_1_18 = {}
	l_1_18.font = l_1_9
	l_1_18.color = Color(0, 0.8, 0.8, 0.8)
	l_1_18.halign = "center"
	l_1_18.valign = "center"
	l_1_18.align = "center"
	l_1_18.height = 100
	l_1_18.text = l_1_4
	l_1_16 = l_1_16(l_1_17, l_1_18)
	l_1_0._line_widget = l_1_16
	l_1_16 = l_1_0._line_widget
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_16 = l_1_16:text_rect
	l_1_16 = l_1_16(l_1_17)
	l_1_14 = 
	l_1_13 = 
	l_1_14 = 
	l_1_14 = l_1_16
	l_1_16 = l_1_0._line_widget
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_16 = l_1_16:set_w
	l_1_18 = l_1_13
	l_1_16(l_1_17, l_1_18)
	l_1_16 = l_1_0._line_widget
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_16 = l_1_16:set_center_x
	l_1_18 = l_1_0._line_widget_center_x
	l_1_16(l_1_17, l_1_18)
	l_1_16 = l_1_0._line_widget
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_16 = l_1_16:set_center_y
	l_1_18 = l_1_6
	l_1_16(l_1_17, l_1_18)
	l_1_16 = l_1_0._line_widget
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_16 = l_1_16:left
	l_1_16 = l_1_16(l_1_17)
	l_1_16 = l_1_16 - 10
	l_1_0._head_widget_left = l_1_16
	l_1_16 = l_1_0._head_widget
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_16 = l_1_16:set_left
	l_1_18 = l_1_0._head_widget_left
	l_1_16(l_1_17, l_1_18)
	l_1_16 = Interpolator
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_16 = l_1_16:new
	l_1_18 = 0
	l_1_16 = l_1_16(l_1_17, l_1_18, tweak_data.hud.intro_credits.FADE_IN_SPEED)
	l_1_0._alpha_interpolator = l_1_16
	l_1_16 = l_1_0._alpha_interpolator
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_16 = l_1_16:set_target
	l_1_18 = 1
	l_1_16(l_1_17, l_1_18)
	l_1_0._time = l_1_2
	l_1_0._show_time = l_1_5
	l_1_0._is_done = false
	l_1_0._is_fading_in = true
	if l_1_7 ~= nil then
		l_1_0._use_slide_in = l_1_7
	else
		l_1_16 = tweak_data
		l_1_16 = l_1_16.hud
		l_1_16 = l_1_16.intro_credits
		l_1_16 = l_1_16.USE_SLIDE_IN
		l_1_0._use_slide_in = l_1_16
	end
	if l_1_8 ~= nil then
		l_1_0._use_slide_out = l_1_8
	else
		l_1_16 = tweak_data
		l_1_16 = l_1_16.hud
		l_1_16 = l_1_16.intro_credits
		l_1_16 = l_1_16.USE_SLIDE_OUT
		l_1_0._use_slide_out = l_1_16
	end
end

IntroCreditsText.destroy = function(l_2_0)
	l_2_0._panel:remove(l_2_0._head_widget)
	l_2_0._panel:remove(l_2_0._line_widget)
	l_2_0._head_widget = nil
	l_2_0._line_widget = nil
end

IntroCreditsText.is_active = function(l_3_0, l_3_1)
	return l_3_0._time <= l_3_1
end

IntroCreditsText.set_alpha = function(l_4_0, l_4_1)
	l_4_1:set_color(l_4_1:color():with_alpha(l_4_0._alpha_interpolator:value()))
end

IntroCreditsText.update = function(l_5_0, l_5_1)
	if l_5_0._is_done then
		return l_5_0._is_done
	end
	if l_5_0._show_time > 0 then
		l_5_0._show_time = l_5_0._show_time - l_5_1
	elseif l_5_0._is_fading_in then
		l_5_0._alpha_interpolator:set_target(0)
		l_5_0._alpha_interpolator:set_speed(tweak_data.hud.intro_credits.FADE_OUT_SPEED)
		l_5_0._is_fading_in = false
		l_5_0._is_fading_out = true
	end
	l_5_0._alpha_interpolator:update(l_5_1)
	if l_5_0._alpha_interpolator:has_reached_target() and l_5_0._is_fading_out then
		l_5_0._is_done = true
	end
	l_5_0:set_alpha(l_5_0._head_widget)
	l_5_0:set_alpha(l_5_0._line_widget)
	if (l_5_0._use_slide_in and l_5_0._is_fading_in) or l_5_0._use_slide_out and l_5_0._is_fading_out then
		local l_5_2 = tweak_data.hud.intro_credits.SLIDE_DISTANCE - l_5_0._alpha_interpolator:value() * tweak_data.hud.intro_credits.SLIDE_DISTANCE
		l_5_0._head_widget:set_left(l_5_0._head_widget_left - l_5_2)
		if tweak_data.hud.intro_credits.SLIDE_DIFFERENT_DIRECTIONS then
			l_5_0._line_widget:set_center_x(l_5_0._line_widget_center_x + l_5_2)
		end
	else
		l_5_0._line_widget:set_center_x(l_5_0._line_widget_center_x - l_5_2)
	end
	return l_5_0._is_done
end


