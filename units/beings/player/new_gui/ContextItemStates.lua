require("shared/FiniteStateMachine")
ContextItemIdleState = ContextItemIdleState or class()
function ContextItemIdleState.transition(A0_0)
	if A0_0._context_item:wants_to_fade_in() then
		return ContextItemFadeInState
	elseif A0_0._context_item:wants_to_fade_out() then
		return ContextItemFadeOutState
	end
end
ContextItemFadeInState = ContextItemFadeInState or class()
function ContextItemFadeInState.init(A0_1)
	A0_1._alpha = A0_1._context_item:get_alpha()
	A0_1._alpha_interpolator = Interpolator:new(A0_1._alpha, tweak_data.player.new_hud.context_panel.FADE_IN_SPEED)
	A0_1._alpha_interpolator:set_target(1)
	A0_1._time = 0
	A0_1._timeout = A0_1._context_item:get_timeout()
end
function ContextItemFadeInState.update(A0_2, A1_3)
	local L2_4
	L2_4 = A0_2._context_item
	L2_4 = L2_4.is_instant_hide
	if L2_4 then
		return
	end
	L2_4 = A0_2._timeout
	if L2_4 then
		L2_4 = A0_2._time
		if L2_4 > A0_2._timeout then
			L2_4 = A0_2._context_item
			L2_4 = L2_4.set_timed_out
			L2_4(L2_4)
		end
	end
	L2_4 = A0_2._alpha_interpolator
	L2_4 = L2_4.has_reached_target
	L2_4 = L2_4(L2_4)
	if L2_4 then
		L2_4 = A0_2._context_item
		L2_4 = L2_4.idle
		L2_4(L2_4)
		return
	end
	L2_4 = A0_2._time
	L2_4 = L2_4 + A1_3
	A0_2._time = L2_4
	L2_4 = A0_2._alpha_interpolator
	L2_4 = L2_4.update
	L2_4(L2_4, A1_3)
	L2_4 = A0_2._alpha_interpolator
	L2_4 = L2_4.value
	L2_4 = L2_4(L2_4)
	A0_2._context_item:set_alpha(L2_4)
end
function ContextItemFadeInState.transition(A0_5)
	if A0_5._context_item:wants_to_idle() then
		return ContextItemIdleState
	elseif A0_5._context_item:wants_to_fade_out() then
		return ContextItemFadeOutState
	end
end
ContextItemFadeOutState = ContextItemFadeOutState or class()
function ContextItemFadeOutState.init(A0_6)
	A0_6._alpha = A0_6._context_item:get_alpha()
	A0_6._alpha_interpolator = Interpolator:new(A0_6._alpha, tweak_data.player.new_hud.context_panel.FADE_OUT_SPEED)
	A0_6._alpha_interpolator:set_target(0)
end
function ContextItemFadeOutState.update(A0_7, A1_8)
	local L2_9
	L2_9 = A0_7._context_item
	L2_9 = L2_9.is_instant_hide
	if L2_9 then
		return
	end
	L2_9 = A0_7._alpha_interpolator
	L2_9 = L2_9.has_reached_target
	L2_9 = L2_9(L2_9)
	if L2_9 then
		L2_9 = A0_7._context_item
		L2_9 = L2_9.idle
		L2_9(L2_9)
		return
	end
	L2_9 = A0_7._alpha_interpolator
	L2_9 = L2_9.update
	L2_9(L2_9, A1_8)
	L2_9 = A0_7._alpha_interpolator
	L2_9 = L2_9.value
	L2_9 = L2_9(L2_9)
	if A0_7._alpha_interpolator:has_reached_target() then
		L2_9 = 0
	end
	A0_7._context_item:set_alpha(L2_9)
end
function ContextItemFadeOutState.transition(A0_10)
	if A0_10._context_item:wants_to_idle() then
		return ContextItemIdleState
	elseif A0_10._context_item:wants_to_fade_in() then
		return ContextItemFadeInState
	end
end
