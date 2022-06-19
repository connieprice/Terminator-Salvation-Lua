require("menu/2D/states/Menu2DState")
if not Menu2DStateTitle then
	Menu2DStateTitle = class(Menu2DState)
end
Menu2DStateTitle.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateTitle)
	managers.volume:activate_set("title")
	do
		local l_1_1 = Menu2DIsland:new()
		l_1_0._state_data.menu.components.island = l_1_1
		l_1_1:change_page("start_page", true)
		l_1_0._state_data.menu.components.sound:play("menu_splash_ambience")
	end
	 -- WARNING: undefined locals caused missing assignments!
end

Menu2DStateTitle.exit = function(l_2_0)
	local l_2_1 = l_2_0._state_data.menu.components.page_flipper
	l_2_0._state_data.menu.components.sound:stop("menu_splash_ambience")
	l_2_0._state_data.menu.components.sound:play("menu_enter")
	managers.volume:deactivate_set("title")
end

Menu2DStateTitle.update = function(l_3_0, l_3_1)
end


