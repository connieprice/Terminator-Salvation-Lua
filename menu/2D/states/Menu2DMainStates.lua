require("menu/2D/states/Menu2DStateInactive")
require("menu/2D/states/Menu2DStateStartup")
require("menu/2D/states/Menu2DStateWorldBackground")
require("menu/2D/states/Menu2DStateIngame")
require("menu/2D/states/Menu2DStateStartSyncToFrontend")
require("menu/2D/states/Menu2DStateStartSyncToFrontend")
require("menu/2D/states/Menu2DStateSyncingToFrontend")
require("menu/2D/states/Menu2DStateStartSyncToIngame")
require("menu/2D/states/Menu2DStateSyncingToIngame")
Menu2DStatesMainTransitions = {
	{
		state_transitions = Menu2DStateWorldBackground.transitions,
		state = Menu2DStateWorldBackground
	},
	{
		state_transitions = Menu2DStateIngame.transitions,
		state = Menu2DStateIngame
	},
	{
		state_transition = "start_sync_to_frontend",
		state = Menu2DStateStartSyncToFrontend
	},
	{
		state_transition = "syncing_to_frontend",
		state = Menu2DStateSyncingToFrontend
	},
	{
		state_transition = "start_sync_to_ingame",
		state = Menu2DStateStartSyncToIngame
	},
	{
		state_transition = "syncing_to_ingame",
		state = Menu2DStateSyncingToIngame
	},
	{
		state_transition = "end_sync_to_editor",
		state = Menu2DStateEndSyncToFrontend
	},
	{state_transition = "editor", state = Menu2DStateInactive},
	{state_transition = "inactive", state = Menu2DStateInactive}
}
