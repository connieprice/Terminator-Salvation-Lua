require("menu/states/MenuStateSyncTypes")
MenuStateIngame = MenuStateIngame or class(FiniteStateMachineState)
function MenuStateIngame.init(A0_0)
	A0_0._ingame_menu = FiniteStateMachine:new(A0_0._menu, "_menu", MenuStateIngameEndSync)
	A0_0._ingame_menu:set_debug(true)
end
function MenuStateIngame.exit(A0_1)
	A0_1._ingame_menu:destroy()
end
function MenuStateIngame.update(A0_2, A1_3)
	A0_2._ingame_menu:update(A1_3)
end
function MenuStateIngame.transition(A0_4)
	local L1_5
	L1_5 = managers
	L1_5 = L1_5.game
	L1_5 = L1_5.requested_menu_sync_start
	L1_5 = L1_5(L1_5)
	if L1_5 then
		L1_5 = managers
		L1_5 = L1_5.game
		L1_5 = L1_5.requested_menu_sync_type
		L1_5 = L1_5(L1_5)
		return MenuStateSyncTypes.get_sync_type_class(L1_5)
	end
end
