MenuStateInEditor = MenuStateInEditor or class(MenuStateFadeUp)
function MenuStateInEditor.transition(A0_0)
	if managers.game_transition:wants_to_host_session() then
		return MenuStateStartSyncToIngame
	end
	A0_0._menu:gui_interface():set_state("ingame")
end
