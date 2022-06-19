require("menu/states/MenuStateSyncTypes")
if not MenuStateIngame then
	MenuStateIngame = class(FiniteStateMachineState)
end
MenuStateIngame.init = function(l_1_0)
	l_1_0._ingame_menu = FiniteStateMachine:new(l_1_0._menu, "_menu", MenuStateIngameEndSync)
	l_1_0._ingame_menu:set_debug(true)
end

MenuStateIngame.exit = function(l_2_0)
	l_2_0._ingame_menu:destroy()
end

MenuStateIngame.update = function(l_3_0, l_3_1)
	l_3_0._ingame_menu:update(l_3_1)
end

MenuStateIngame.transition = function(l_4_0)
	if managers.game:requested_menu_sync_start() then
		local l_4_1 = managers.game:requested_menu_sync_type()
		local l_4_2 = MenuStateSyncTypes.get_sync_type_class
		local l_4_3 = l_4_1
		return l_4_2(l_4_3)
	end
end


