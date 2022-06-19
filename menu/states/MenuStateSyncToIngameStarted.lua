require("menu/states/MenuStateSyncStarted")
if not MenuStateSyncToIngameStarted then
	MenuStateSyncToIngameStarted = class(MenuStateSyncStarted)
end
MenuStateSyncToIngameStarted.init = function(l_1_0)
	MenuStateSyncStarted.init(l_1_0)
	l_1_0._menu:gui_interface():set_state("syncing_to_ingame")
end


