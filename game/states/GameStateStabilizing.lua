if not GameStateStabilizing then
	GameStateStabilizing = class(FiniteStateMachineState)
end
GameStateStabilizing.init = function(l_1_0)
	l_1_0._wait_time = 0
	l_1_0._frames = 0
end

GameStateStabilizing.transition = function(l_2_0)
	if l_2_0._wait_time > 0.5 and l_2_0._frames > 15 then
		return GameStateWaitingForMenuSyncToFinish
	end
end

GameStateStabilizing.update = function(l_3_0, l_3_1)
	l_3_0._wait_time = l_3_0._wait_time + l_3_1
	l_3_0._frames = l_3_0._frames + 1
end


