require("shared/FiniteStateMachine")
if not ContextItemIdleState then
	ContextItemIdleState = class()
end
ContextItemIdleState.transition = function(l_1_0)
	if l_1_0._context_item:wants_to_fade_in() then
		return ContextItemFadeInState
	else
		if l_1_0._context_item:wants_to_fade_out() then
			return ContextItemFadeOutState
		end
	end
end

if not ContextItemFadeInState then
	ContextItemFadeInState = class()
end
ContextItemFadeInState.init = function(l_2_0)
	l_2_0._alpha = l_2_0._context_item:get_alpha()
	l_2_0._alpha_interpolator = Interpolator:new(l_2_0._alpha, tweak_data.player.new_hud.context_panel.FADE_IN_SPEED)
	l_2_0._alpha_interpolator:set_target(1)
	l_2_0._time = 0
	l_2_0._timeout = l_2_0._context_item:get_timeout()
end

ContextItemFadeInState.update = function(l_3_0, l_3_1)
	if l_3_0._context_item.is_instant_hide then
		return 
	end
	if l_3_0._timeout and l_3_0._timeout < l_3_0._time then
		l_3_0._context_item:set_timed_out()
	end
	if l_3_0._alpha_interpolator:has_reached_target() then
		l_3_0._context_item:idle()
		return 
	end
	l_3_0._time = l_3_0._time + l_3_1
	l_3_0._alpha_interpolator:update(l_3_1)
	local l_3_2 = l_3_0._alpha_interpolator:value()
	l_3_0._context_item:set_alpha(l_3_2)
end

ContextItemFadeInState.transition = function(l_4_0)
	if l_4_0._context_item:wants_to_idle() then
		return ContextItemIdleState
	else
		if l_4_0._context_item:wants_to_fade_out() then
			return ContextItemFadeOutState
		end
	end
end

if not ContextItemFadeOutState then
	ContextItemFadeOutState = class()
end
ContextItemFadeOutState.init = function(l_5_0)
	l_5_0._alpha = l_5_0._context_item:get_alpha()
	l_5_0._alpha_interpolator = Interpolator:new(l_5_0._alpha, tweak_data.player.new_hud.context_panel.FADE_OUT_SPEED)
	l_5_0._alpha_interpolator:set_target(0)
end

ContextItemFadeOutState.update = function(l_6_0, l_6_1)
	if l_6_0._context_item.is_instant_hide then
		return 
	end
	if l_6_0._alpha_interpolator:has_reached_target() then
		l_6_0._context_item:idle()
		return 
	end
	l_6_0._alpha_interpolator:update(l_6_1)
	local l_6_2 = l_6_0._alpha_interpolator:value()
	if l_6_0._alpha_interpolator:has_reached_target() then
		l_6_2 = 0
	end
	l_6_0._context_item:set_alpha(l_6_2)
end

ContextItemFadeOutState.transition = function(l_7_0)
	if l_7_0._context_item:wants_to_idle() then
		return ContextItemIdleState
	else
		if l_7_0._context_item:wants_to_fade_in() then
			return ContextItemFadeInState
		end
	end
end


