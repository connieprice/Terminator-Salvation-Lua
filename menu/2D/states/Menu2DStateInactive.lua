require("menu/2D/states/Menu2DState")
if not Menu2DStateInactive then
	Menu2DStateInactive = class(Menu2DState)
end
Menu2DStateInactive.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateInactive)
	l_1_0._state_data.menu.components.island = nil
end


