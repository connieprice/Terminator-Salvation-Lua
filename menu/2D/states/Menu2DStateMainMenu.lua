require("menu/2D/states/Menu2DState")
if not Menu2DStateMainMenu then
	Menu2DStateMainMenu = class(Menu2DState)
end
Menu2DStateMainMenu.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateMainMenu)
	local l_1_1 = Menu2DIsland:new()
	l_1_0._state_data.menu.components.island = l_1_1
	l_1_1:change_page("mainmenu")
	l_1_0._state_data.menu.components.sound:play("menu_ambience")
	l_1_0:_setup_resources()
	local l_1_2 = l_1_0._state_data.menu.components.page_flipper
	l_1_2:changing_resolution_callbacks().add(l_1_0, function(...)
		-- upvalues: l_1_0
		l_1_0:_shutdown_resources()
  end)
	l_1_2:resolution_changed_callbacks().add(l_1_0, function(...)
		-- upvalues: l_1_0
		l_1_0:_setup_resources()
  end)
	if managers.menu_input:is_pc_controller() then
		l_1_0._state_data.menu.components.mouse:request_show()
	end
end

Menu2DStateMainMenu._setup_resources = function(l_2_0)
end

Menu2DStateMainMenu._shutdown_resources = function(l_3_0)
end

Menu2DStateMainMenu.exit = function(l_4_0)
	local l_4_1 = l_4_0._state_data.menu.components.page_flipper
	l_4_1:changing_resolution_callbacks().remove(l_4_0)
	l_4_1:resolution_changed_callbacks().remove(l_4_0)
	l_4_0:_shutdown_resources()
	l_4_0._state_data.menu.components.sound:stop("menu_ambience")
end


