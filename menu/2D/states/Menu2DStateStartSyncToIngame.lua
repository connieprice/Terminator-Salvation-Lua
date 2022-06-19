require("menu/2D/states/Menu2DStateStartSync")
if not Menu2DStateStartSyncToIngame then
	Menu2DStateStartSyncToIngame = class(Menu2DStateStartSync)
end
Menu2DStateStartSyncToIngame.init = function(l_1_0)
	Menu2DStateStartSync.init(l_1_0, "ingame", Menu2DStateStartSyncToIngame)
end

Menu2DStateStartSyncToIngame._setup_sync_screen = function(l_2_0)
	managers.sync_screen:setup_sync_screen()
end


