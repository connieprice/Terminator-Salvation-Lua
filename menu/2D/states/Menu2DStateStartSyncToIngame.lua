require("menu/2D/states/Menu2DStateStartSync")
Menu2DStateStartSyncToIngame = Menu2DStateStartSyncToIngame or class(Menu2DStateStartSync)
function Menu2DStateStartSyncToIngame.init(A0_0)
	Menu2DStateStartSync.init(A0_0, "ingame", Menu2DStateStartSyncToIngame)
end
function Menu2DStateStartSyncToIngame._setup_sync_screen(A0_1)
	managers.sync_screen:setup_sync_screen()
end
