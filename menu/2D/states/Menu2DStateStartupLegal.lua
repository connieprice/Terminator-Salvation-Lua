require("menu/2D/states/Menu2DState")
Menu2DStateStartupLegal = Menu2DStateStartupLegal or class(Menu2DState)
function Menu2DStateStartupLegal.init(A0_0)
	Menu2DState.init(A0_0, Menu2DStateStartupLegal)
	A0_0._state_data.menu.components.island = Menu2DIsland:new()
	Menu2DIsland:new():change_page("legal_page")
end
function Menu2DStateStartupLegal.exit(A0_1)
	local L1_2
	L1_2 = A0_1._state_data
	L1_2 = L1_2.menu
	L1_2 = L1_2.components
	L1_2.island = nil
end
