require("menu/2D/states/Menu2DState")
Menu2DStateCredits = Menu2DStateCredits or class(Menu2DState)
function Menu2DStateCredits.init(A0_0)
	Menu2DState.init(A0_0, Menu2DStateCredits)
	A0_0._state_data.menu.components.island = Menu2DIsland:new()
	Menu2DIsland:new():change_page("credits")
	Menu2DIsland:new():island_data().credits_done = false
	managers.music:player():play_nice("credits")
end
function Menu2DStateCredits.exit(A0_1)
	managers.music:player():stop_nice()
end
