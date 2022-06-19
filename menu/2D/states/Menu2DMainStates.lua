require("menu/2D/states/Menu2DStateInactive")
require("menu/2D/states/Menu2DStateStartup")
require("menu/2D/states/Menu2DStateWorldBackground")
require("menu/2D/states/Menu2DStateIngame")
require("menu/2D/states/Menu2DStateStartSyncToFrontend")
require("menu/2D/states/Menu2DStateStartSyncToFrontend")
require("menu/2D/states/Menu2DStateSyncingToFrontend")
require("menu/2D/states/Menu2DStateStartSyncToIngame")
require("menu/2D/states/Menu2DStateSyncingToIngame")
local l_0_0 = {}
local l_0_1 = {}
l_0_1.state_transitions = Menu2DStateWorldBackground.transitions
l_0_1.state = Menu2DStateWorldBackground
local l_0_2 = {}
l_0_2.state_transitions = Menu2DStateIngame.transitions
l_0_2.state = Menu2DStateIngame
local l_0_3 = {}
l_0_3.state_transition = "start_sync_to_frontend"
l_0_3.state = Menu2DStateStartSyncToFrontend
local l_0_4 = {}
l_0_4.state_transition = "syncing_to_frontend"
l_0_4.state = Menu2DStateSyncingToFrontend
local l_0_5 = {}
l_0_5.state_transition = "start_sync_to_ingame"
l_0_5.state = Menu2DStateStartSyncToIngame
local l_0_6 = {}
l_0_6.state_transition = "syncing_to_ingame"
l_0_6.state = Menu2DStateSyncingToIngame
local l_0_7 = {}
l_0_7.state_transition = "end_sync_to_editor"
l_0_7.state = Menu2DStateEndSyncToFrontend
local l_0_8 = {}
l_0_8.state_transition = "editor"
l_0_8.state = Menu2DStateInactive
local l_0_9 = {}
l_0_9.state_transition = "inactive"
l_0_9.state = Menu2DStateInactive
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

Menu2DStatesMainTransitions = l_0_0

