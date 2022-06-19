if not MenuStateBindControllerState then
	MenuStateBindControllerState = class(FiniteStateMachineState)
end
MenuStateBindControllerState.update = function(l_1_0, l_1_1)
	if managers.menu:is_in_dialog() then
		return 
	end
	if not managers.save:has_primary_user() then
		local l_1_2 = managers.local_user:users()
		local l_1_3 = managers.menu_input.users_pressing_join(l_1_2)
	if #l_1_3 > 0 then
		end
		local l_1_4 = l_1_3[1]
		managers.menu_input:set_bound_user(l_1_4)
		managers.save:select_primary_user(l_1_4)
	end
end


