require("shared/Interpolator")
require("shared/FiniteStateMachine")
require("units/beings/player/gui/HudElementStackItemStates")
if not HudElementStackItem then
	HudElementStackItem = class()
end
HudElementStackItem.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._panel = l_1_1
	l_1_0._show_timeout = l_1_2
	l_1_0._state = FiniteStateMachine:new(l_1_0, "item", HudElementStackItemStateInvisible)
end

HudElementStackItem.update = function(l_2_0, l_2_1)
	l_2_0._state:update(l_2_1)
end

HudElementStackItem.y_has_been_set = function(l_3_0)
	return l_3_0._y_has_been_set
end

HudElementStackItem.use_top_align = function(l_4_0, l_4_1)
	l_4_0._use_top_align = l_4_1
end

HudElementStackItem.set_y = function(l_5_0, l_5_1)
	if l_5_0._use_top_align then
		l_5_0._panel:set_bottom(l_5_1)
	else
		l_5_0._panel:set_y(l_5_1)
	end
	l_5_0._y_has_been_set = true
end

HudElementStackItem.set_bottom = function(l_6_0, l_6_1)
	l_6_0._panel:set_bottom(l_6_1)
	l_6_0._y_has_been_set = true
end

HudElementStackItem.y = function(l_7_0)
	if l_7_0._use_top_align then
		local l_7_1, l_7_2 = l_7_0._panel:bottom, l_7_0._panel
		return l_7_1(l_7_2)
	else
		local l_7_3, l_7_4 = l_7_0._panel:y, l_7_0._panel
		return l_7_3(l_7_4)
	end
end

HudElementStackItem.mark_should_show = function(l_8_0)
	l_8_0._should_show = true
end

HudElementStackItem.should_show = function(l_9_0)
	return l_9_0._should_show
end

HudElementStackItem.mark_as_done = function(l_10_0)
	l_10_0._is_done = true
end

HudElementStackItem.is_done = function(l_11_0)
	return l_11_0._is_done
end

HudElementStackItem.mark_fading_out = function(l_12_0)
	l_12_0._is_fading_out = true
end

HudElementStackItem.is_fading_out = function(l_13_0)
	return l_13_0._is_fading_out
end

HudElementStackItem.set_wants_to_be_removed = function(l_14_0)
	l_14_0._wants_to_be_removed = true
end

HudElementStackItem.wants_to_be_removed = function(l_15_0)
	return l_15_0._wants_to_be_removed
end

HudElementStackItem.show_timeout = function(l_16_0)
	return l_16_0._show_timeout
end


