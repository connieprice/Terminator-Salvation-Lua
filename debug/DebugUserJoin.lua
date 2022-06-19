DebugUserJoinStateFindController = DebugUserJoinStateFindController or class(FiniteStateMachineState)
function DebugUserJoinStateFindController.update(A0_0)
	local L1_1
	L1_1 = managers
	L1_1 = L1_1.local_user
	L1_1 = L1_1.users
	L1_1 = L1_1(L1_1)
	for 