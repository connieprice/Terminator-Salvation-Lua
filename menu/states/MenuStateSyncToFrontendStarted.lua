require("menu/states/MenuStateSyncStarted")
MenuStateSyncToFrontendStarted = MenuStateSyncToFrontendStarted or class(MenuStateSyncStarted)
function MenuStateSyncToFrontendStarted.init(A0_0)
	MenuStateSyncStarted.init(A0_0)
	A0_0._menu:gui_interface():set_state("syncing_to_frontend")
end
