ScreenFader = ScreenFader or class()
function ScreenFader.init(A0_0, A1_1, A2_2)
	A0_0._panel = A1_1
	assert(A0_0._panel)
	A0_0._fader = A0_0._panel:rect({
		valign = "grow",
		halign = "grow",
		color = Color(0, 0, 0, 0)
	})
	A0_0._color = A0_0._fader:color()
	A0_0._alpha = Interpolator:new(1, 1)
	A0_0._hidden = false
	if A2_2 then
		A0_0._fader:set_render_template(A2_2)
	end
end
function ScreenFader.save_state(A0_3, A1_4)
	A1_4.alpha_target = A0_3._alpha:target()
	A1_4.hidden = A0_3._hidden
end
function ScreenFader.restore_state(A0_5, A1_6)
	A0_5._hidden = A1_6.hidden
	A0_5._alpha:set_target(A1_6.alpha_target)
end
function ScreenFader.destroy(A0_7)
	A0_7._panel:remove(A0_7._fader)
end
function ScreenFader.update(A0_8, A1_9)
	local L2_10
	L2_10 = A0_8._alpha
	L2_10 = L2_10.update
	L2_10(L2_10, A1_9)
	L2_10 = A0_8._alpha
	L2_10 = L2_10.value
	L2_10 = L2_10(L2_10)
	A0_8._fader:set_color(A0_8._color:with_alpha(L2_10))
	if L2_10 == 0 and not A0_8._hidden then
		A0_8._fader:hide()
		A0_8._hidden = true
	elseif L2_10 > 0 and A0_8._hidden then
		A0_8._fader:show()
		A0_8._hidden = false
	end
end
function ScreenFader.fade_up(A0_11)
	A0_11:set_speed(5)
	A0_11._alpha:set_target(0)
end
function ScreenFader.fade_down(A0_12)
	A0_12:set_speed(10)
	A0_12._alpha:set_target(1)
end
function ScreenFader.set_faded_down(A0_13)
	A0_13._alpha:set_value(1)
end
function ScreenFader.set_faded_up(A0_14)
	A0_14._alpha:set_value(0)
end
function ScreenFader.fade_down_target(A0_15)
	return A0_15._alpha:target() == 1
end
function ScreenFader.fade_up_target(A0_16)
	return A0_16._alpha:target() == 0
end
function ScreenFader.is_fading_down(A0_17)
	return A0_17:fade_down_target() and not A0_17._alpha:has_reached_target()
end
function ScreenFader.is_fading_up(A0_18)
	return A0_18:fade_up_target() and not A0_18._alpha:has_reached_target()
end
function ScreenFader.is_fading(A0_19)
	return not A0_19._alpha:has_reached_target()
end
function ScreenFader.fade_down_done(A0_20)
	return not A0_20:is_fading() and A0_20:fade_down_target()
end
function ScreenFader.fade_up_done(A0_21)
	return not A0_21:is_fading() and A0_21:fade_up_target()
end
function ScreenFader.value(A0_22)
	return A0_22._alpha:value()
end
function ScreenFader.set_speed(A0_23, A1_24)
	A0_23._alpha:set_speed(A1_24)
end
