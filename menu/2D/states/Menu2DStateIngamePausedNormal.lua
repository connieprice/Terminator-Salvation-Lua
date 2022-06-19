require("menu/2D/states/Menu2DStateIngamePaused")
Menu2DStateIngamePausedNormal = Menu2DStateIngamePausedNormal or class(Menu2DStateIngamePaused)
function Menu2DStateIngamePausedNormal.init(A0_0)
	Menu2DStateIngamePaused.init(A0_0, Menu2DStateIngamePausedNormal)
	A0_0._state_data.menu.components.island = Menu2DIsland:new()
	Menu2DIsland:new():change_page("pause")
end
