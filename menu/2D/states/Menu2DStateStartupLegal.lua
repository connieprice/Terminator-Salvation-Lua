require("menu/2D/states/Menu2DState")
if not Menu2DStateStartupLegal then
	Menu2DStateStartupLegal = class(Menu2DState)
end
Menu2DStateStartupLegal.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateStartupLegal)
	local l_1_1 = Menu2DIsland:new()
	l_1_0._state_data.menu.components.island = l_1_1
	l_1_1:change_page("legal_page")
end

Menu2DStateStartupLegal.exit = function(l_2_0)
	l_2_0._state_data.menu.components.island = nil
end


