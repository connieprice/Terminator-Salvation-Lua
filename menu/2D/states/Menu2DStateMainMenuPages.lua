require("menu/2D/states/Menu2DState")
require("shared/FiniteStateMachine")
require("menu/2D/states/Menu2DStateMainMenu")
require("menu/2D/states/Menu2DStateTitle")
require("menu/2D/states/Menu2DStateInactive")
require("menu/2D/states/Menu2DStateSaveIconNotification")
if not Menu2DStateMainMenuPages then
	Menu2DStateMainMenuPages = class(Menu2DState)
end
local l_0_0 = Menu2DStateMainMenuPages
local l_0_1 = {}
local l_0_2 = {}
l_0_2.state_transition = "main_menu"
l_0_2.state = Menu2DStateMainMenu
local l_0_3 = {}
l_0_3.state_transition = "title"
l_0_3.state = Menu2DStateTitle
local l_0_4 = {}
l_0_4.state_transition = "attract"
l_0_4.state = Menu2DStateInactive
local l_0_5 = {}
l_0_5.state_transition = "save_icon_notification"
l_0_5.state = Menu2DStateSaveIconNotification
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

l_0_0.transitions = l_0_1
l_0_0 = Menu2DStateMainMenuPages
l_0_1 = function(l_1_0)
	Menu2DState.init(l_1_0, Menu2DStateMainMenuPages)
	local l_1_1 = {}
	l_1_1.menu = l_1_0._state_data.menu
	l_1_1.state_transitions = l_1_0.transitions
	local l_1_2 = l_1_0._state_data.menu.state_transition_data.requested_state
	local l_1_3 = Menu2DStateTransitionLookup:new(l_1_0.transitions):state(l_1_2)
	l_1_0._sub_state_machine = FiniteStateMachine:new(l_1_1, "_state_data", l_1_3)
	managers.music:player():play_nice("menu_radio")
end

l_0_0.init = l_0_1
l_0_0 = Menu2DStateMainMenuPages
l_0_1 = function(l_2_0)
	managers.music:player():stop_nice()
	l_2_0._sub_state_machine:destroy()
end

l_0_0.exit = l_0_1
l_0_0 = Menu2DStateMainMenuPages
l_0_1 = function(l_3_0, l_3_1)
	l_3_0._sub_state_machine:update(l_3_1)
end

l_0_0.update = l_0_1

