GameStateHostGame = GameStateHostGame or class(FiniteStateMachineState)
function GameStateHostGame.init(A0_0)
	managers.session = SessionManager:new()
	managers.game_transition:host_game()
end
function GameStateHostGame.transition(A0_1)
	if managers.game_transition:wants_to_join_session() then
		set_level_name_from_profile()
		managers.game_transition:clear_wants_to_host()
		return GameStateJoinSession
	end
end
