if not GameStateWaitingForPrimaryUser then
	GameStateWaitingForPrimaryUser = class(FiniteStateMachineState)
end
GameStateWaitingForPrimaryUser.init = function(l_1_0)
	l_1_0.game._profile_loaded = false
	managers.save:release_primary_user()
	managers.menu_input:release_bound_user()
	l_1_0:_init_storage_states_for_all_users()
end

GameStateWaitingForPrimaryUser._init_storage_states_for_all_users = function(l_2_0)
	local l_2_5, l_2_6, l_2_7, l_2_8 = nil
	cat_print("debug", "*** Init storage states for all users!")
	local l_2_1 = managers.local_user:users()
	for i_0,i_1 in pairs(l_2_1) do
		i_1:set_wants_to_init()
	end
end

GameStateWaitingForPrimaryUser.update = function(l_3_0, l_3_1)
end

GameStateWaitingForPrimaryUser.transition = function(l_4_0)
	if managers.save:has_primary_user() then
		return GameStateWaitingForPrimaryProfile
	end
end


