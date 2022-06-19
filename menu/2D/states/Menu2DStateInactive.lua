require("menu/2D/states/Menu2DState")
Menu2DStateInactive = Menu2DStateInactive or class(Menu2DState)
function Menu2DStateInactive.init(A0_0)
	Menu2DState.init(A0_0, Menu2DStateInactive)
	A0_0._state_data.menu.components.island = nil
end
