require("menu/2D/states/Menu2DStateStartSync")
Menu2DStateStartSyncToFrontend = Menu2DStateStartSyncToFrontend or class(Menu2DStateStartSync)
function Menu2DStateStartSyncToFrontend.init(A0_0)
	Menu2DStateStartSync.init(A0_0, "frontend", Menu2DStateStartSyncToFrontend)
end
function Menu2DStateStartSyncToFrontend._setup_sync_screen(A0_1)
	managers.sync_screen:setup_minimal_sync_screen()
end
