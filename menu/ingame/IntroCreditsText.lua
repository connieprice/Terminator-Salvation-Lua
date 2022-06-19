IntroCreditsText = IntroCreditsText or class()
function IntroCreditsText.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8)
	local L9_9, L10_10, L11_11, L12_12, L13_13, L14_14
	L9_9 = tweak_data
	L9_9 = L9_9.hud
	L9_9 = L9_9.intro_credits
	L9_9 = L9_9.HEADER_FONT_NAME
	L10_10 = tweak_data
	L10_10 = L10_10.hud
	L10_10 = L10_10.intro_credits
	L10_10 = L10_10.HEADER_FONT_SIZE
	A0_0._panel = A1_1
	L12_12 = A1_1
	L11_11 = A1_1.width
	L11_11 = L11_11(L12_12)
	L11_11 = L11_11 / 2
	A0_0._line_widget_center_x = L11_11
	L12_12 = A1_1
	L11_11 = A1_1.text
	L13_13 = {}
	L13_13.font = L9_9
	L13_13.font_size = L10_10
	L14_14 = Color
	L14_14 = L14_14(0, 0.8, 0.8, 0.8)
	L13_13.color = L14_14
	L13_13.halign = "center"
	L13_13.valign = "center"
	L13_13.align = "left"
	L13_13.height = 100
	L13_13.text = A3_3
	L11_11 = L11_11(L12_12, L13_13)
	A0_0._head_widget = L11_11
	L11_11 = A0_0._head_widget
	L12_12 = L11_11
	L11_11 = L11_11.text_rect
	L14_14 = L11_11(L12_12)
	A0_0._head_widget:set_w(L13_13)
	A0_0._head_widget:set_center_y(A6_6)
	A6_6 = A6_6 + L10_10 + 2
	L9_9 = tweak_data.hud.intro_credits.TEXT_FONT_NAME
	L10_10 = tweak_data.hud.intro_credits.TEXT_FONT_SIZE
	A0_0._line_widget = A1_1:text({
		font = L9_9,
		color = Color(0, 0.8, 0.8, 0.8),
		halign = "center",
		valign = "center",
		align = "center",
		height = 100,
		text = A4_4
	})
	L14_14, L14_14, L13_13, L14_14 = A0_0._line_widget:text_rect()
	A0_0._line_widget:set_w(L13_13)
	A0_0._line_widget:set_center_x(A0_0._line_widget_center_x)
	A0_0._line_widget:set_center_y(A6_6)
	A0_0._head_widget_left = A0_0._line_widget:left() - 10
	A0_0._head_widget:set_left(A0_0._head_widget_left)
	A0_0._alpha_interpolator = Interpolator:new(0, tweak_data.hud.intro_credits.FADE_IN_SPEED)
	A0_0._alpha_interpolator:set_target(1)
	A0_0._time = A2_2
	A0_0._show_time = A5_5
	A0_0._is_done = false
	A0_0._is_fading_in = true
	if A7_7 ~= nil then
		A0_0._use_slide_in = A7_7
	else
		A0_0._use_slide_in = tweak_data.hud.intro_credits.USE_SLIDE_IN
	end
	if A8_8 ~= nil then
		A0_0._use_slide_out = A8_8
	else
		A0_0._use_slide_out = tweak_data.hud.intro_credits.USE_SLIDE_OUT
	end
end
function IntroCreditsText.destroy(A0_15)
	A0_15._panel:remove(A0_15._head_widget)
	A0_15._panel:remove(A0_15._line_widget)
	A0_15._head_widget = nil
	A0_15._line_widget = nil
end
function IntroCreditsText.is_active(A0_16, A1_17)
	return A1_17 >= A0_16._time
end
function IntroCreditsText.set_alpha(A0_18, A1_19)
	local L2_20, L3_21
	L3_21 = A1_19
	L2_20 = A1_19.set_color
	L2_20(L3_21, A1_19:color():with_alpha(A0_18._alpha_interpolator:value()))
end
function IntroCreditsText.update(A0_22, A1_23)
	if A0_22._is_done then
		return A0_22._is_done
	end
	if A0_22._show_time > 0 then
		A0_22._show_time = A0_22._show_time - A1_23
	elseif A0_22._is_fading_in then
		A0_22._alpha_interpolator:set_target(0)
		A0_22._alpha_interpolator:set_speed(tweak_data.hud.intro_credits.FADE_OUT_SPEED)
		A0_22._is_fading_in = false
		A0_22._is_fading_out = true
	end
	A0_22._alpha_interpolator:update(A1_23)
	if A0_22._alpha_interpolator:has_reached_target() and A0_22._is_fading_out then
		A0_22._is_done = true
	end
	A0_22:set_alpha(A0_22._head_widget)
	A0_22:set_alpha(A0_22._line_widget)
	if A0_22._use_slide_in and A0_22._is_fading_in or A0_22._use_slide_out and A0_22._is_fading_out then
		A0_22._head_widget:set_left(A0_22._head_widget_left - (tweak_data.hud.intro_credits.SLIDE_DISTANCE - A0_22._alpha_interpolator:value() * tweak_data.hud.intro_credits.SLIDE_DISTANCE))
		if tweak_data.hud.intro_credits.SLIDE_DIFFERENT_DIRECTIONS then
			A0_22._line_widget:set_center_x(A0_22._line_widget_center_x + (tweak_data.hud.intro_credits.SLIDE_DISTANCE - A0_22._alpha_interpolator:value() * tweak_data.hud.intro_credits.SLIDE_DISTANCE))
		else
			A0_22._line_widget:set_center_x(A0_22._line_widget_center_x - (tweak_data.hud.intro_credits.SLIDE_DISTANCE - A0_22._alpha_interpolator:value() * tweak_data.hud.intro_credits.SLIDE_DISTANCE))
		end
	end
	return A0_22._is_done
end
