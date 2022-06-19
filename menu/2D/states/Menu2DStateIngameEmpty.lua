require("menu/2D/states/Menu2DState")
Menu2DStateIngameEmpty = Menu2DStateIngameEmpty or class(Menu2DState)
function Menu2DStateIngameEmpty.init(A0_0)
	Menu2DState.init(A0_0, Menu2DStateIngameEmpty)
	A0_0._state_data.menu.components.island = nil
end
