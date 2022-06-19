if not GameStateWaitingForAllUserProfiles then
	GameStateWaitingForAllUserProfiles = class(FiniteStateMachineState)
end
GameStateWaitingForAllUserProfiles._playing_ready_user_count = function(l_1_0)
	local l_1_6, l_1_7, l_1_8, l_1_9 = nil
	local l_1_1 = managers.local_user:users()
	local l_1_2 = 0
	for i_0,i_1 in pairs(l_1_1) do
		if i_1:wants_to_play() and i_1:is_profile_ready() then
			l_1_2 = l_1_2 + 1
		end
	end
	return l_1_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

GameStateWaitingForAllUserProfiles.transition = function(l_2_0)
	if managers.game_transition:wants_to_go_to_pre_frontend() then
		return GameStatePreFrontend
	else
		if not managers.game_transition:wants_to_host_session() then
			return GameStateFrontend
		end
	else
		if l_2_0:_playing_ready_user_count() == managers.game_transition:slot_count_needed_to_host() then
			if l_2_0:_playing_ready_user_count() > 1 then
				managers.unit_frequency:apply_coop_frequencies()
			else
				managers.unit_frequency:reset_frequencies()
			end
			return GameStateWaitingForMenuSyncStart
		end
	end
end


