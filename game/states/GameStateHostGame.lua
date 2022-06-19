if not GameStateHostGame then
	GameStateHostGame = class(FiniteStateMachineState)
end
GameStateHostGame.init = function(l_1_0)
	managers.session = SessionManager:new()
	managers.game_transition:host_game()
end

GameStateHostGame.transition = function(l_2_0)
	if managers.game_transition:wants_to_join_session() then
		set_level_name_from_profile()
		managers.game_transition:clear_wants_to_host()
		return GameStateJoinSession
	end
end


