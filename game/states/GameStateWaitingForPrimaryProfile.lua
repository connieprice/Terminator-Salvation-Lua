GameStateWaitingForPrimaryProfile = GameStateWaitingForPrimaryProfile or class(FiniteStateMachineState)
function GameStateWaitingForPrimaryProfile.init(A0_0)
	local L1_1
end
function GameStateWaitingForPrimaryProfile.transition(A0_2)
	local L1_3
end
function GameStateWaitingForPrimaryProfile.exit(A0_4)
	if managers.game_transition:wants_to_go_to_pre_frontend() or not managers.save:primary_user() then
		return GameStateWaitingForPrimaryUser
	end
end
