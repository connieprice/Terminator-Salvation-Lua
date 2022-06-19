require("menu/2D/states/Menu2DState")
if not Menu2DStateSaveIconNotification then
	Menu2DStateSaveIconNotification = class(Menu2DState)
end
Menu2DStateSaveIconNotification.init = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateSaveIconNotification)
	local l_1_1 = Menu2DIsland:new()
	l_1_0._state_data.menu.components.island = l_1_1
	l_1_1:change_page("save_icon_notification")
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
end

Menu2DStateSaveIconNotification.exit = function(l_2_0)
	l_2_0:_shutdown_resources()
	local l_2_1 = l_2_0._state_data.menu.components.page_flipper
	l_2_1:changing_resolution_callbacks().remove(l_2_0)
	l_2_1:resolution_changed_callbacks().remove(l_2_0)
end

Menu2DStateSaveIconNotification._setup_resources = function(l_3_0)
end

Menu2DStateSaveIconNotification._shutdown_resources = function(l_4_0)
end


