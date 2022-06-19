require("shared/FiniteStateMachineState")
if not WalkerState then
	WalkerState = class(FiniteStateMachineState)
end
WalkerState.init = function(l_1_0)
	local l_1_1 = l_1_0._base
	l_1_0._unit = l_1_1._unit
	l_1_0._emitter = l_1_1._emitter
end

WalkerState._request_stun = function(l_2_0)
	l_2_0._unit:play_redirect("pre_stun")
end


