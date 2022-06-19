require("menu/states/MenuStateSyncTypes")
MenuStateFrontend = MenuStateFrontend or class(MenuStateFadeTransition)
function MenuStateFrontend.init(A0_0)
	local L1_1, L2_2, L3_3
	L1_1 = MenuStateFadeUp
	L1_1 = L1_1.init
	L2_2 = A0_0
	L1_1(L2_2)
	L1_1 = managers
	L1_1 = L1_1.menu_input
	L2_2 = L1_1
	L1_1 = L1_1.bound_user
	L1_1 = L1_1(L2_2)
	L3_3 = L1_1
	L2_2 = L1_1.save_disabled
	L2_2 = L2_2(L3_3)
	L3_3 = nil
	if not L2_2 then
		L3_3 = MenuStateSaveIconNotification
	else
		L3_3 = MenuStateMainMenu
	end
	A0_0._machine = FiniteStateMachine:new(A0_0._menu, "_menu", L3_3)
end
function MenuStateFrontend.exit(A0_4)
	A0_4._machine:destroy()
end
function MenuStateFrontend.update(A0_5, A1_6)
	A0_5._machine:update(A1_6)
	if managers.game_transition:should_pass_through_menu() then
		A0_5._wait_time = (A0_5._wait_time or 0) + A1_6
	end
end
function MenuStateFrontend.transition(A0_7)
	local L1_8
	L1_8 = managers
	L1_8 = L1_8.game
	L1_8 = L1_8.is_in_pre_frontend
	L1_8 = L1_8(L1_8)
	if L1_8 then
		L1_8 = MenuStatePreFrontend
		return L1_8
	end
	L1_8 = managers
	L1_8 = L1_8.game_transition
	L1_8 = L1_8.should_pass_through_menu
	L1_8 = L1_8(L1_8)
	if L1_8 then
		L1_8 = A0_7._wait_time
		if L1_8 < 5 then
			return
		end
	end
	L1_8 = managers
	L1_8 = L1_8.game
	L1_8 = L1_8.requested_menu_sync_start
	L1_8 = L1_8(L1_8)
	if L1_8 then
		L1_8 = managers
		L1_8 = L1_8.game
		L1_8 = L1_8.requested_menu_sync_type
		L1_8 = L1_8(L1_8)
		return MenuStateSyncTypes.get_sync_type_class(L1_8)
	end
end
