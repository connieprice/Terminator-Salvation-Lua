require("menu/states/MenuStateSyncStarted")
MenuStateSyncToIngameStarted = MenuStateSyncToIngameStarted or class(MenuStateSyncStarted)
function MenuStateSyncToIngameStarted.init(A0_0)
	MenuStateSyncStarted.init(A0_0)
	A0_0._menu:gui_interface():set_state("syncing_to_ingame")
end
