if not MenuStateInEditor then
	MenuStateInEditor = class(MenuStateFadeUp)
end
MenuStateInEditor.transition = function(l_1_0)
	if managers.game_transition:wants_to_host_session() then
		return MenuStateStartSyncToIngame
	end
	l_1_0._menu:gui_interface():set_state("ingame")
end


