if not MenuStateMainMenuTitle then
	MenuStateMainMenuTitle = class(MenuStateBindControllerState)
end
MenuStateMainMenuTitle.init = function(l_1_0)
	MenuStateFadeUp.init(l_1_0)
	managers.menu_input:release_bound_user()
	l_1_0._enter_time = 0
	l_1_0._menu:gui_interface():set_state("title")
	l_1_0._menu._is_in_title_screen = true
end

MenuStateMainMenuTitle.exit = function(l_2_0)
	l_2_0._menu._is_in_title_screen = false
	if not managers.menu_input:has_bound_user() then
		local l_2_1 = managers.save:primary_user()
	if l_2_1 then
		end
		managers.menu_input:set_bound_user(l_2_1)
	end
end

MenuStateMainMenuTitle.update = function(l_3_0, l_3_1)
	MenuStateBindControllerState.update(l_3_0, l_3_1)
	if Input:any_input() then
		l_3_0._enter_time = 0
	else
		l_3_0._enter_time = l_3_0._enter_time + l_3_1
	end
end

MenuStateMainMenuTitle.transition = function(l_4_0)
	if l_4_0._enter_time > 30 then
		return MenuStateAttract
	end
end


