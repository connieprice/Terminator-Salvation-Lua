if not MenuStateIngameSyncDone then
	MenuStateIngameSyncDone = class(FiniteStateMachineState)
end
MenuStateIngameSyncDone.init = function(l_1_0)
	l_1_0._menu:_set_ingame_ready()
end

MenuStateIngameSyncDone.exit = function(l_2_0)
	l_2_0._menu:_clear_ingame_ready()
end

MenuStateIngameSyncDone.transition = function(l_3_0)
	if managers.game:show_menu_ingame_requested() then
		return MenuStateIngameRunning
	end
end


