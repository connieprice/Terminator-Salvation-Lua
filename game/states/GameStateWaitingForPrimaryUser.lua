GameStateWaitingForPrimaryUser = GameStateWaitingForPrimaryUser or class(FiniteStateMachineState)
function GameStateWaitingForPrimaryUser.init(A0_0)
	A0_0.game._profile_loaded = false
	managers.save:release_primary_user()
	managers.menu_input:release_bound_user()
	A0_0:_init_storage_states_for_all_users()
end
function GameStateWaitingForPrimaryUser._init_storage_states_for_all_users(A0_1)
	local L1_2
	L1_2 = cat_print
	L1_2("debug", "*** Init storage states for all users!")
	L1_2 = managers
	L1_2 = L1_2.local_user
	L1_2 = L1_2.users
	L1_2 = L1_2(L1_2)
	for 