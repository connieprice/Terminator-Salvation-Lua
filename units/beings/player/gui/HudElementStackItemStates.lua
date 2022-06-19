require("units/beings/player/gui/PanelFader")
HudElementStackItemStateFading = HudElementStackItemStateFading or class(FiniteStateMachineState)
function HudElementStackItemStateFading.update(A0_0, A1_1)
	if A0_0._fader then
		A0_0._fader:update(A1_1)
	end
end
HudElementStackItemStateInvisible = HudElementStackItemStateInvisible or class(HudElementStackItemStateFading)
function HudElementStackItemStateInvisible.init(A0_2)
	A0_2._fader = PanelFader:new(A0_2.item._panel)
end
function HudElementStackItemStateInvisible.transition(A0_3)
	if A0_3.item:should_show() then
		return HudElementStackItemStateFadingIn
	end
end
HudElementStackItemStateFadingIn = HudElementStackItemStateFadingIn or class(HudElementStackItemStateFading)
function HudElementStackItemStateFadingIn.init(A0_4)
	A0_4._fader = PanelFader:new(A0_4.item._panel)
	A0_4._fader:set_target(1)
end
function HudElementStackItemStateFadingIn.transition(A0_5)
	if not A0_5._fader:has_reached_target() then
		return
	end
	return HudElementStackItemStateIdle
end
HudElementStackItemStateIdle = HudElementStackItemStateIdle or class(FiniteStateMachineState)
function HudElementStackItemStateIdle.transition(A0_6)
	if A0_6.item:is_done() then
		return HudElementStackItemStateTimeout
	end
end
HudElementStackItemStateTimeout = HudElementStackItemStateTimeout or class(FiniteStateMachineState)
function HudElementStackItemStateTimeout.init(A0_7)
	local L1_8
	A0_7._timer = 0
end
function HudElementStackItemStateTimeout.update(A0_9, A1_10)
	local L2_11
	L2_11 = A0_9._timer
	L2_11 = L2_11 + A1_10
	A0_9._timer = L2_11
end
function HudElementStackItemStateTimeout.transition(A0_12)
	if A0_12.item:show_timeout() == nil or A0_12._timer > A0_12.item:show_timeout() then
		return HudElementStackItemStateFadingOut
	end
end
HudElementStackItemStateFadingOut = HudElementStackItemStateFadingOut or class(HudElementStackItemStateFading)
function HudElementStackItemStateFadingOut.init(A0_13)
	A0_13._fader = PanelFader:new(A0_13.item._panel, 1)
	A0_13._fader:set_target(0)
	A0_13.item:mark_fading_out()
end
function HudElementStackItemStateFadingOut.transition(A0_14)
	if not A0_14._fader:has_reached_target() then
		return
	end
	return HudElementStackItemStateDone
end
HudElementStackItemStateDone = HudElementStackItemStateDone or class(FiniteStateMachineState)
function HudElementStackItemStateDone.init(A0_15)
	A0_15.item:set_wants_to_be_removed()
end
function HudElementStackItemStateDone.transition(A0_16)
	local L1_17
end
