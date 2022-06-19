GameStateStabilizing = GameStateStabilizing or class(FiniteStateMachineState)
function GameStateStabilizing.init(A0_0)
	local L1_1
	A0_0._wait_time = 0
	A0_0._frames = 0
end
function GameStateStabilizing.transition(A0_2)
	local L1_3
	L1_3 = A0_2._wait_time
	if L1_3 > 0.5 then
		L1_3 = A0_2._frames
		if L1_3 > 15 then
			L1_3 = GameStateWaitingForMenuSyncToFinish
			return L1_3
		end
	end
end
function GameStateStabilizing.update(A0_4, A1_5)
	local L2_6
	L2_6 = A0_4._wait_time
	L2_6 = L2_6 + A1_5
	A0_4._wait_time = L2_6
	L2_6 = A0_4._frames
	L2_6 = L2_6 + 1
	A0_4._frames = L2_6
end
