require("menu/2D/states/Menu2DState")
if not Menu2DStateSyncingToIngame then
	Menu2DStateSyncingToIngame = class(Menu2DState)
end
Menu2DStateSyncingToIngame.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateSyncingToIngame)
end


