if not ScreenFader then
	ScreenFader = class()
end
ScreenFader.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._panel = l_1_1
	assert(l_1_0._panel)
	local l_1_3, l_1_4 = l_1_0._panel:rect, l_1_0._panel
	local l_1_5 = {}
	l_1_5.valign = "grow"
	l_1_5.halign = "grow"
	l_1_5.color = Color(0, 0, 0, 0)
	l_1_3 = l_1_3(l_1_4, l_1_5)
	l_1_0._fader = l_1_3
	l_1_3 = l_1_0._fader
	l_1_3, l_1_4 = l_1_3:color, l_1_3
	l_1_3 = l_1_3(l_1_4)
	l_1_0._color = l_1_3
	l_1_3 = Interpolator
	l_1_3, l_1_4 = l_1_3:new, l_1_3
	l_1_5 = 1
	l_1_3 = l_1_3(l_1_4, l_1_5, 1)
	l_1_0._alpha = l_1_3
	l_1_0._hidden = false
	if l_1_2 then
		l_1_3 = l_1_0._fader
		l_1_3, l_1_4 = l_1_3:set_render_template, l_1_3
		l_1_5 = l_1_2
		l_1_3(l_1_4, l_1_5)
	end
end

ScreenFader.save_state = function(l_2_0, l_2_1)
	l_2_1.alpha_target = l_2_0._alpha:target()
	l_2_1.hidden = l_2_0._hidden
end

ScreenFader.restore_state = function(l_3_0, l_3_1)
	l_3_0._hidden = l_3_1.hidden
	l_3_0._alpha:set_target(l_3_1.alpha_target)
end

ScreenFader.destroy = function(l_4_0)
	l_4_0._panel:remove(l_4_0._fader)
end

ScreenFader.update = function(l_5_0, l_5_1)
	l_5_0._alpha:update(l_5_1)
	local l_5_2 = l_5_0._alpha:value()
	l_5_0._fader:set_color(l_5_0._color:with_alpha(l_5_2))
	if l_5_2 == 0 and not l_5_0._hidden then
		l_5_0._fader:hide()
		l_5_0._hidden = true
	elseif l_5_2 > 0 and l_5_0._hidden then
		l_5_0._fader:show()
		l_5_0._hidden = false
	end
end

ScreenFader.fade_up = function(l_6_0)
	l_6_0:set_speed(5)
	l_6_0._alpha:set_target(0)
end

ScreenFader.fade_down = function(l_7_0)
	l_7_0:set_speed(10)
	l_7_0._alpha:set_target(1)
end

ScreenFader.set_faded_down = function(l_8_0)
	l_8_0._alpha:set_value(1)
end

ScreenFader.set_faded_up = function(l_9_0)
	l_9_0._alpha:set_value(0)
end

ScreenFader.fade_down_target = function(l_10_0)
	return l_10_0._alpha:target() == 1
end

ScreenFader.fade_up_target = function(l_11_0)
	return l_11_0._alpha:target() == 0
end

ScreenFader.is_fading_down = function(l_12_0)
	if l_12_0:fade_down_target() then
		return not l_12_0._alpha:has_reached_target()
	end
end

ScreenFader.is_fading_up = function(l_13_0)
	if l_13_0:fade_up_target() then
		return not l_13_0._alpha:has_reached_target()
	end
end

ScreenFader.is_fading = function(l_14_0)
	return not l_14_0._alpha:has_reached_target()
end

ScreenFader.fade_down_done = function(l_15_0)
	if not l_15_0:is_fading() then
		local l_15_1 = l_15_0:fade_down_target()
	else
		return false
	end
end

ScreenFader.fade_up_done = function(l_16_0)
	if not l_16_0:is_fading() then
		local l_16_1 = l_16_0:fade_up_target()
	else
		return false
	end
end

ScreenFader.value = function(l_17_0)
	local l_17_1, l_17_2 = l_17_0._alpha:value, l_17_0._alpha
	return l_17_1(l_17_2)
end

ScreenFader.set_speed = function(l_18_0, l_18_1)
	l_18_0._alpha:set_speed(l_18_1)
end


