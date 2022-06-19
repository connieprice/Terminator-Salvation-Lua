require("menu/2D/states/Menu2DStateIngamePaused")
Menu2DStateIngamePausedGameOver = Menu2DStateIngamePausedGameOver or class(Menu2DStateIngamePaused)
function Menu2DStateIngamePausedGameOver.init(A0_0)
	Menu2DStateIngamePaused.init(A0_0, Menu2DStateIngamePausedGameOver)
	A0_0._state_data.menu.components.island = Menu2DIsland:new()
	Menu2DIsland:new():change_page("game_over")
end
