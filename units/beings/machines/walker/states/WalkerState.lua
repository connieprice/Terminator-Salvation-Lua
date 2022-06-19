require("shared/FiniteStateMachineState")
WalkerState = WalkerState or class(FiniteStateMachineState)
function WalkerState.init(A0_0)
	local L1_1, L2_2
	L1_1 = A0_0._base
	L2_2 = L1_1._unit
	A0_0._unit = L2_2
	L2_2 = L1_1._emitter
	A0_0._emitter = L2_2
end
function WalkerState._request_stun(A0_3)
	A0_3._unit:play_redirect("pre_stun")
end
