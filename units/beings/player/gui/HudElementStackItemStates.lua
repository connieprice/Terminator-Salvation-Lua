require("units/beings/player/gui/PanelFader")
if not HudElementStackItemStateFading then
	HudElementStackItemStateFading = class(FiniteStateMachineState)
end
HudElementStackItemStateFading.update = function(l_1_0, l_1_1)
	if l_1_0._fader then
		l_1_0._fader:update(l_1_1)
	end
end

if not HudElementStackItemStateInvisible then
	HudElementStackItemStateInvisible = class(HudElementStackItemStateFading)
end
HudElementStackItemStateInvisible.init = function(l_2_0)
	l_2_0._fader = PanelFader:new(l_2_0.item._panel)
end

HudElementStackItemStateInvisible.transition = function(l_3_0)
	if l_3_0.item:should_show() then
		return HudElementStackItemStateFadingIn
	end
end

if not HudElementStackItemStateFadingIn then
	HudElementStackItemStateFadingIn = class(HudElementStackItemStateFading)
end
HudElementStackItemStateFadingIn.init = function(l_4_0)
	l_4_0._fader = PanelFader:new(l_4_0.item._panel)
	l_4_0._fader:set_target(1)
end

HudElementStackItemStateFadingIn.transition = function(l_5_0)
	if not l_5_0._fader:has_reached_target() then
		return 
	end
	return HudElementStackItemStateIdle
end

if not HudElementStackItemStateIdle then
	HudElementStackItemStateIdle = class(FiniteStateMachineState)
end
HudElementStackItemStateIdle.transition = function(l_6_0)
	if l_6_0.item:is_done() then
		return HudElementStackItemStateTimeout
	end
end

if not HudElementStackItemStateTimeout then
	HudElementStackItemStateTimeout = class(FiniteStateMachineState)
end
HudElementStackItemStateTimeout.init = function(l_7_0)
	l_7_0._timer = 0
end

HudElementStackItemStateTimeout.update = function(l_8_0, l_8_1)
	l_8_0._timer = l_8_0._timer + l_8_1
end

HudElementStackItemStateTimeout.transition = function(l_9_0)
	if l_9_0.item:show_timeout() == nil or l_9_0.item:show_timeout() < l_9_0._timer then
		return HudElementStackItemStateFadingOut
	end
end

if not HudElementStackItemStateFadingOut then
	HudElementStackItemStateFadingOut = class(HudElementStackItemStateFading)
end
HudElementStackItemStateFadingOut.init = function(l_10_0)
	l_10_0._fader = PanelFader:new(l_10_0.item._panel, 1)
	l_10_0._fader:set_target(0)
	l_10_0.item:mark_fading_out()
end

HudElementStackItemStateFadingOut.transition = function(l_11_0)
	if not l_11_0._fader:has_reached_target() then
		return 
	end
	return HudElementStackItemStateDone
end

if not HudElementStackItemStateDone then
	HudElementStackItemStateDone = class(FiniteStateMachineState)
end
HudElementStackItemStateDone.init = function(l_12_0)
	l_12_0.item:set_wants_to_be_removed()
end

HudElementStackItemStateDone.transition = function(l_13_0)
end


