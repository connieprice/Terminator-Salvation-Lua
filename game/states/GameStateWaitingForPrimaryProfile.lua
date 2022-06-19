if not GameStateWaitingForPrimaryProfile then
	GameStateWaitingForPrimaryProfile = class(FiniteStateMachineState)
end
GameStateWaitingForPrimaryProfile.init = function(l_1_0)
end

GameStateWaitingForPrimaryProfile.transition = function(l_2_0)
end

GameStateWaitingForPrimaryProfile.exit = function(l_3_0)
	if managers.game_transition:wants_to_go_to_pre_frontend() or not managers.save:primary_user() then
		return GameStateWaitingForPrimaryUser
	end
end


