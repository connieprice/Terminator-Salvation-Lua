require("menu/2D/states/Menu2DState")
Menu2DStateSaveIconNotification = Menu2DStateSaveIconNotification or class(Menu2DState)
function Menu2DStateSaveIconNotification.init(A0_0)
	Menu2DState.init(A0_0, Menu2DStateSaveIconNotification)
	A0_0._state_data.menu.components.island = Menu2DIsland:new()
	Menu2DIsland:new():change_page("save_icon_notification")
	A0_0:_setup_resources()
	A0_0._state_data.menu.components.page_flipper:changing_resolution_callbacks().add(A0_0, function(...)
		_UPVALUE0_:_shutdown_resources()
	end)
	A0_0._state_data.menu.components.page_flipper:resolution_changed_callbacks().add(A0_0, function(...)
		_UPVALUE0_:_setup_resources()
	end)
end
function Menu2DStateSaveIconNotification.exit(A0_3)
	A0_3:_shutdown_resources()
	A0_3._state_data.menu.components.page_flipper:changing_resolution_callbacks().remove(A0_3)
	A0_3._state_data.menu.components.page_flipper:resolution_changed_callbacks().remove(A0_3)
end
function Menu2DStateSaveIconNotification._setup_resources(A0_4)
	local L1_5
end
function Menu2DStateSaveIconNotification._shutdown_resources(A0_6)
	local L1_7
end
