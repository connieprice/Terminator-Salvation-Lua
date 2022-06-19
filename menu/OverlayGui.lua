require("menu/ScreenFader")
require("menu/MenuUtility")
if not OverlayGui then
	OverlayGui = class()
end
OverlayGui.init = function(l_1_0)
	l_1_0:_setup_resources()
	managers.viewport:add_resolution_changed_func(callback(l_1_0, l_1_0, "callback_resolution_changed"))
end

OverlayGui._setup_resources = function(l_2_0)
	l_2_0._gui = MenuOverlay:newgui()
	local l_2_1 = RenderSettings.resolution
	l_2_0._width = 1280
	l_2_0._height = 720 * (1.7777778 / core_setup.aspect_ratio)
	l_2_0._workspace = l_2_0._gui:create_scaled_screen_workspace(l_2_0._width, l_2_0._height, 0, 0, l_2_1.x, l_2_1.y)
	l_2_0._panel = l_2_0._workspace:panel()
	l_2_0._engine_viewport = Application:create_scene_viewport(0, 0, 1, 1)
	l_2_0._overlay_camera = Overlay:create_camera()
	l_2_0._engine_viewport:set_camera(l_2_0._overlay_camera)
	local l_2_2, l_2_3 = ScreenFader:new, ScreenFader
	local l_2_4, l_2_5 = l_2_0._panel:panel, l_2_0._panel
	l_2_5, l_2_4 = .end, l_2_4(l_2_5, {layer = 99})
	local l_2_6 = nil
	l_2_2 = l_2_2(l_2_3, l_2_4, l_2_5, l_2_6)
	l_2_0._fader = l_2_2
	l_2_2 = l_2_0._fader_data
	if l_2_2 then
		l_2_2 = l_2_0._fader
		l_2_2, l_2_3 = l_2_2:restore_state, l_2_2
		l_2_4 = l_2_0._fader_data
		l_2_2(l_2_3, l_2_4)
		l_2_0._fader_data = nil
	end
end

OverlayGui._shutdown_resources = function(l_3_0)
	l_3_0._gui:destroy_workspace(l_3_0._workspace)
	l_3_0._gui = nil
	l_3_0._workspace = nil
	l_3_0._panel = nil
	Application:destroy_viewport(l_3_0._engine_viewport)
	Overlay:delete_camera(l_3_0._overlay_camera)
	l_3_0._fader_data = {}
	l_3_0._fader:save_state(l_3_0._fader_data)
	l_3_0._fader:destroy()
	l_3_0._fader = nil
end

OverlayGui.safe_rect = function(l_4_0)
	local l_4_1 = MenuUtility.safe_rect
	return l_4_1()
end

OverlayGui.full_rect = function(l_5_0)
	local l_5_1 = {}
	l_5_1.w = l_5_0._width
	l_5_1.h = l_5_0._height
	return l_5_1
end

OverlayGui.destroy = function(l_6_0)
	l_6_0:_shutdown_resources()
	l_6_0._fader_data = nil
end

OverlayGui.show = function(l_7_0)
	l_7_0._panel:show()
end

OverlayGui.hide = function(l_8_0)
	l_8_0._panel:hide()
end

OverlayGui.fade_down_with_speed = function(l_9_0, l_9_1)
	l_9_0:fade_down()
	l_9_0._fader:set_speed(l_9_1)
end

OverlayGui.fade_down_slow = function(l_10_0)
	l_10_0:fade_down()
	l_10_0._fader:set_speed(3)
end

OverlayGui.fade_down = function(l_11_0)
	print("fade down")
	l_11_0._fader:fade_down()
	l_11_0._fader:set_speed(9)
end

OverlayGui.set_faded_down = function(l_12_0)
	l_12_0._fader:set_faded_down()
end

OverlayGui.fade_up = function(l_13_0)
	l_13_0._fader:fade_up()
	l_13_0._fader:set_speed(2)
end

OverlayGui.fade_up_slow = function(l_14_0)
	l_14_0:fade_up()
	l_14_0._fader:set_speed(1)
end

OverlayGui.update = function(l_15_0, l_15_1)
	if l_15_0._fader then
		l_15_0._fader:update(l_15_1)
	end
end

OverlayGui.root_panel = function(l_16_0)
	return l_16_0._panel
end

OverlayGui.is_fading = function(l_17_0)
	return l_17_0._fader
end

OverlayGui.fade_value = function(l_18_0)
	if l_18_0._fader then
		local l_18_1, l_18_2 = l_18_0._fader:value, l_18_0._fader
		return l_18_1(l_18_2)
	else
		return 0
	end
end

OverlayGui.is_faded_down = function(l_19_0)
	if l_19_0._fader then
		return l_19_0._fader:fade_down_done()
	end
end

OverlayGui.callback_resolution_changed = function(l_20_0)
	l_20_0:_shutdown_resources()
	l_20_0:_setup_resources()
end


