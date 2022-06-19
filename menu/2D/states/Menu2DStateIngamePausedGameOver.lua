require("menu/2D/states/Menu2DStateIngamePaused")
if not Menu2DStateIngamePausedGameOver then
	Menu2DStateIngamePausedGameOver = class(Menu2DStateIngamePaused)
end
Menu2DStateIngamePausedGameOver.init = function(l_1_0)
	Menu2DStateIngamePaused.init(l_1_0, Menu2DStateIngamePausedGameOver)
	local l_1_1 = Menu2DIsland:new()
	l_1_0._state_data.menu.components.island = l_1_1
	l_1_1:change_page("game_over")
end


