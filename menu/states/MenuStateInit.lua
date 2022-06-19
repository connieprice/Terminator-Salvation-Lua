if not MenuStateInit then
	MenuStateInit = class(FiniteStateMachineState)
end
MenuStateInit.transition = function(l_1_0)
	local l_1_1 = managers.game:menu_frontend_type()
	local l_1_2, l_1_3 = l_1_0._menu:_frontend_end_sync_state, l_1_0._menu
	local l_1_4 = l_1_1
	return l_1_2(l_1_3, l_1_4)
end


