require("menu/2D/states/Menu2DState")
if not Menu2DStateIngameEmpty then
	Menu2DStateIngameEmpty = class(Menu2DState)
end
Menu2DStateIngameEmpty.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateIngameEmpty)
	l_1_0._state_data.menu.components.island = nil
end


