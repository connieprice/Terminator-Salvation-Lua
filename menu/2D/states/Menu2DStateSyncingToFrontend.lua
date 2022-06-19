require("menu/2D/states/Menu2DState")
if not Menu2DStateSyncingToFrontend then
	Menu2DStateSyncingToFrontend = class(Menu2DState)
end
Menu2DStateSyncingToFrontend.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateSyncingToFrontend)
end


