require("menu/2D/states/Menu2DState")
if not Menu2DStateStartupMovie then
	Menu2DStateStartupMovie = class(Menu2DState)
end
Menu2DStateStartupMovie.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateStartupMovie)
end


