MenuStateMainMenuTitle = MenuStateMainMenuTitle or class(MenuStateBindControllerState)
function MenuStateMainMenuTitle.init(A0_0)
	MenuStateFadeUp.init(A0_0)
	managers.menu_input:release_bound_user()
	A0_0._enter_time = 0
	A0_0._menu:gui_interface():set_state("title")
	A0_0._menu._is_in_title_screen = true
end
function MenuStateMainMenuTitle.exit(A0_1)
	local L1_2
	L1_2 = A0_1._menu
	L1_2._is_in_title_screen = false
	L1_2 = managers
	L1_2 = L1_2.menu_input
	L1_2 = L1_2.has_bound_user
	L1_2 = L1_2(L1_2)
	if not L1_2 then
		L1_2 = managers
		L1_2 = L1_2.save
		L1_2 = L1_2.primary_user
		L1_2 = L1_2(L1_2)
		if L1_2 then
			managers.menu_input:set_bound_user(L1_2)
		end
	end
end
function MenuStateMainMenuTitle.update(A0_3, A1_4)
	MenuStateBindControllerState.update(A0_3, A1_4)
	if Input:any_input() then
		A0_3._enter_time = 0
	else
		A0_3._enter_time = A0_3._enter_time + A1_4
	end
end
function MenuStateMainMenuTitle.transition(A0_5)
	if A0_5._enter_time > 30 then
		return MenuStateAttract
	end
end
