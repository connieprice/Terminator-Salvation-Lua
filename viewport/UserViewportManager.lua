require("viewport/UserViewport")
UserViewportManager = UserViewportManager or class()
function UserViewportManager.preload()
	UserViewport.preload()
end
function UserViewportManager.init(A0_0, A1_1)
	A0_0:clear()
	A0_0._root_panel = A1_1
	A0_0._all_listeners_paused = false
	A0_0._far_range_single_player = tweak_data.player.camera.FAR_RANGE_STD
	A0_0._far_range_split_screen = tweak_data.player.camera.FAR_RANGE_STD
	managers.viewport:set_splitscreen_cb(A0_0._adjust_viewport_parameters_event, A0_0)
end
function UserViewportManager.clear(A0_2)
	A0_2._viewport_creation_enabled = false
	A0_2._user_to_viewport = {}
end
function UserViewportManager.destroy(A0_3)
	for 