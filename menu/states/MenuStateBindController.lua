MenuStateBindControllerState = MenuStateBindControllerState or class(FiniteStateMachineState)
function MenuStateBindControllerState.update(A0_0, A1_1)
	local L2_2, L3_3, L4_4
	L2_2 = managers
	L2_2 = L2_2.menu
	L3_3 = L2_2
	L2_2 = L2_2.is_in_dialog
	L2_2 = L2_2(L3_3)
	if L2_2 then
		return
	end
	L2_2 = managers
	L2_2 = L2_2.save
	L3_3 = L2_2
	L2_2 = L2_2.has_primary_user
	L2_2 = L2_2(L3_3)
	if not L2_2 then
		L2_2 = managers
		L2_2 = L2_2.local_user
		L3_3 = L2_2
		L2_2 = L2_2.users
		L2_2 = L2_2(L3_3)
		L3_3 = managers
		L3_3 = L3_3.menu_input
		L3_3 = L3_3.users_pressing_join
		L4_4 = L2_2
		L3_3 = L3_3(L4_4)
		L4_4 = #L3_3
		if L4_4 > 0 then
			L4_4 = L3_3[1]
			managers.menu_input:set_bound_user(L4_4)
			managers.save:select_primary_user(L4_4)
		end
	end
end
