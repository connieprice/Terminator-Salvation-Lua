require("menu/2D/states/Menu2DStateStartSync")
if not Menu2DStateStartSyncToFrontend then
	Menu2DStateStartSyncToFrontend = class(Menu2DStateStartSync)
end
Menu2DStateStartSyncToFrontend.init = function(l_1_0)
	Menu2DStateStartSync.init(l_1_0, "frontend", Menu2DStateStartSyncToFrontend)
end

Menu2DStateStartSyncToFrontend._setup_sync_screen = function(l_2_0)
	managers.sync_screen:setup_minimal_sync_screen()
end


