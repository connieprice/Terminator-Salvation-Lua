require("menu/2D/states/Menu2DState")
if not Menu2DStateCredits then
	Menu2DStateCredits = class(Menu2DState)
end
Menu2DStateCredits.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateCredits)
	local l_1_1 = Menu2DIsland:new()
	l_1_0._state_data.menu.components.island = l_1_1
	l_1_1:change_page("credits")
	l_1_1:island_data().credits_done = false
	managers.music:player():play_nice("credits")
end

Menu2DStateCredits.exit = function(l_2_0)
	managers.music:player():stop_nice()
end


