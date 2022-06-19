require("menu/2D/states/Menu2DState")
Menu2DStateTitle = Menu2DStateTitle or class(Menu2DState)
function Menu2DStateTitle.init(A0_0)
	Menu2DState.init(A0_0, Menu2DStateTitle)
	managers.volume:activate_set("title")
	A0_0._state_data.menu.components.island = Menu2DIsland:new()
	Menu2DIsland:new():change_page("start_page", true)
	A0_0._state_data.menu.components.sound:play("menu_splash_ambience")
end
function Menu2DStateTitle.exit(A0_1)
	local L1_2
	L1_2 = A0_1._state_data
	L1_2 = L1_2.menu
	L1_2 = L1_2.components
	L1_2 = L1_2.page_flipper
	A0_1._state_data.menu.components.sound:stop("menu_splash_ambience")
	A0_1._state_data.menu.components.sound:play("menu_enter")
	managers.volume:deactivate_set("title")
end
function Menu2DStateTitle.update(A0_3, A1_4)
end
