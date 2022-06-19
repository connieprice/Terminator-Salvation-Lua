require("menu/ScreenFader")
require("menu/MenuUtility")
OverlayGui = OverlayGui or class()
function OverlayGui.init(A0_0)
	A0_0:_setup_resources()
	managers.viewport:add_resolution_changed_func(callback(A0_0, A0_0, "callback_resolution_changed"))
end
function OverlayGui._setup_resources(A0_1)
	A0_1._gui = MenuOverlay:newgui()
	A0_1._width = 1280
	A0_1._height = 720 * (1.7777778 / core_setup.aspect_ratio)
	A0_1._workspace = A0_1._gui:create_scaled_screen_workspace(A0_1._width, A0_1._height, 0, 0, RenderSettings.resolution.x, RenderSettings.resolution.y)
	A0_1._panel = A0_1._workspace:panel()
	A0_1._engine_viewport = Application:create_scene_viewport(0, 0, 1, 1)
	A0_1._overlay_camera = Overlay:create_camera()
	A0_1._engine_viewport:set_camera(A0_1._overlay_camera)
	A0_1._fader = ScreenFader:new(A0_1._panel:panel({layer = 99}))
	if A0_1._fader_data then
		A0_1._fader:restore_state(A0_1._fader_data)
		A0_1._fader_data = nil
	end
end
function OverlayGui._shutdown_resources(A0_2)
	A0_2._gui:destroy_workspace(A0_2._workspace)
	A0_2._gui = nil
	A0_2._workspace = nil
	A0_2._panel = nil
	Application:destroy_viewport(A0_2._engine_viewport)
	Overlay:delete_camera(A0_2._overlay_camera)
	A0_2._fader_data = {}
	A0_2._fader:save_state(A0_2._fader_data)
	A0_2._fader:destroy()
	A0_2._fader = nil
end
function OverlayGui.safe_rect(A0_3)
	return MenuUtility.safe_rect()
end
function OverlayGui.full_rect(A0_4)
	local L1_5, L2_6
	L1_5 = {}
	L2_6 = A0_4._width
	L1_5.w = L2_6
	L2_6 = A0_4._height
	L1_5.h = L2_6
	return L1_5
end
function OverlayGui.destroy(A0_7)
	A0_7:_shutdown_resources()
	A0_7._fader_data = nil
end
function OverlayGui.show(A0_8)
	A0_8._panel:show()
end
function OverlayGui.hide(A0_9)
	A0_9._panel:hide()
end
function OverlayGui.fade_down_with_speed(A0_10, A1_11)
	A0_10:fade_down()
	A0_10._fader:set_speed(A1_11)
end
function OverlayGui.fade_down_slow(A0_12)
	A0_12:fade_down()
	A0_12._fader:set_speed(3)
end
function OverlayGui.fade_down(A0_13)
	print("fade down")
	A0_13._fader:fade_down()
	A0_13._fader:set_speed(9)
end
function OverlayGui.set_faded_down(A0_14)
	A0_14._fader:set_faded_down()
end
function OverlayGui.fade_up(A0_15)
	A0_15._fader:fade_up()
	A0_15._fader:set_speed(2)
end
function OverlayGui.fade_up_slow(A0_16)
	A0_16:fade_up()
	A0_16._fader:set_speed(1)
end
function OverlayGui.update(A0_17, A1_18)
	if A0_17._fader then
		A0_17._fader:update(A1_18)
	end
end
function OverlayGui.root_panel(A0_19)
	local L1_20
	L1_20 = A0_19._panel
	return L1_20
end
function OverlayGui.is_fading(A0_21)
	local L1_22
	L1_22 = A0_21._fader
	return L1_22
end
function OverlayGui.fade_value(A0_23)
	if A0_23._fader then
		return A0_23._fader:value()
	else
		return 0
	end
end
function OverlayGui.is_faded_down(A0_24)
	return A0_24._fader and A0_24._fader:fade_down_done()
end
function OverlayGui.callback_resolution_changed(A0_25)
	A0_25:_shutdown_resources()
	A0_25:_setup_resources()
end
