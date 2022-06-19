require("menu/2D/states/Menu2DState")
Menu2DStateMainMenu = Menu2DStateMainMenu or class(Menu2DState)
function Menu2DStateMainMenu.init(A0_0)
	Menu2DState.init(A0_0, Menu2DStateMainMenu)
	A0_0._state_data.menu.components.island = Menu2DIsland:new()
	Menu2DIsland:new():change_page("mainmenu")
	A0_0._state_data.menu.components.sound:play("menu_ambience")
	A0_0:_setup_resources()
	A0_0._state_data.menu.components.page_flipper:changing_resolution_callbacks().add(A0_0, function(...)
		_UPVALUE0_:_shutdown_resources()
	end)
	A0_0._state_data.menu.components.page_flipper:resolution_changed_callbacks().add(A0_0, function(...)
		_UPVALUE0_:_setup_resources()
	end)
	if managers.menu_input:is_pc_controller() then
		A0_0._state_data.menu.components.mouse:request_show()
	end
end
function Menu2DStateMainMenu._setup_resources(A0_3)
	local L1_4
end
function Menu2DStateMainMenu._shutdown_resources(A0_5)
	local L1_6
end
function Menu2DStateMainMenu.exit(A0_7)
	local L1_8
	L1_8 = A0_7._state_data
	L1_8 = L1_8.menu
	L1_8 = L1_8.components
	L1_8 = L1_8.page_flipper
	L1_8:changing_resolution_callbacks().remove(A0_7)
	L1_8:resolution_changed_callbacks().remove(A0_7)
	A0_7:_shutdown_resources()
	A0_7._state_data.menu.components.sound:stop("menu_ambience")
end
