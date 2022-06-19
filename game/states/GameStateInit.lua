if not GameStateInit then
	GameStateInit = class(FiniteStateMachineState)
end
GameStateInit.init = function(l_1_0)
end

GameStateInit.transition = function(l_2_0)
	return GameStatePreFrontend
end


