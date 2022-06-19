MenuStateIngameSyncDone = MenuStateIngameSyncDone or class(FiniteStateMachineState)
function MenuStateIngameSyncDone.init(A0_0)
	A0_0._menu:_set_ingame_ready()
end
function MenuStateIngameSyncDone.exit(A0_1)
	A0_1._menu:_clear_ingame_ready()
end
function MenuStateIngameSyncDone.transition(A0_2)
	if managers.game:show_menu_ingame_requested() then
		return MenuStateIngameRunning
	end
end
