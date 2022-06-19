require("menu/loading_screen/LoadingScreenTweakData")
require("menu/loading_screen/LoadingIconPanel")
require("menu/ScreenFader")
LoadingScreen = LoadingScreen or class()
LoadingScreen.fonts = {
	"faith_font_22"
}
LoadingScreen.textures = {
	"gui_disc_icon"
}
function LoadingScreen.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7)
	local L8_8
	A0_0._resources = A1_1
	A0_0._camera = A2_2
	L8_8 = A3_3.create_scaled_screen_workspace
	L8_8 = L8_8(A3_3, A6_6.width, A6_6.height, 0, 0, A7_7.width, A7_7.height)
	A0_0._workspace = L8_8
	A0_0._level_load_progress_func = A4_4
	L8_8 = A0_0._workspace
	L8_8 = L8_8.panel
	L8_8 = L8_8(L8_8)
	A0_0._panel = L8_8
	L8_8 = A0_0._panel
	L8_8 = L8_8.panel
	L8_8 = L8_8(L8_8, {
		name = "safe_panel",
		valign = "grow",
		halign = "grow"
	})
	A0_0._safe_panel = L8_8
	L8_8 = A0_0._safe_panel
	L8_8 = L8_8.set_shape
	L8_8(L8_8, A5_5.x, A5_5.y, A5_5.w, A5_5.h)
	L8_8 = ScreenFader
	L8_8 = L8_8.new
	L8_8 = L8_8(L8_8, A0_0._panel:panel({layer = 99}), "OverlayVertexColor")
	A0_0._fader = L8_8
	L8_8 = LoadingIconPanel
	L8_8 = L8_8.new
	L8_8 = L8_8(L8_8, A0_0._safe_panel)
	A0_0._icon_panel = L8_8
	L8_8 = loading_screen_tweak_data
	L8_8 = L8_8.TEXT_INTENSITY
	A0_0._loading_text = A0_0._safe_panel:text({
		h = 2 * loading_screen_tweak_data.TEXT_SIZE,
		color = Color(loading_screen_tweak_data.TEXT_ALPHA, L8_8, L8_8, L8_8),
		align = "right",
		vertical = "center",
		font_size = loading_screen_tweak_data.TEXT_SIZE,
		layer = 90,
		font = "faith_font_22",
		text_id = "loading_loading"
	})
	A0_0._loading_text:set_right(A0_0._icon_panel:panel():left() + loading_screen_tweak_data.TEXT_OFFSET_X)
	A0_0._loading_text:set_center_y(A0_0._icon_panel:panel():center_y() + loading_screen_tweak_data.TEXT_OFFSET_Y)
	A0_0._loading_text:set_render_template("OverlayVertexColorTextured")
	A0_0:start()
end
function LoadingScreen.destroy(A0_9)
	A0_9._resources.head:set_slot(0)
	A0_9._fader:destroy()
	A0_9._icon_panel:destroy()
end
function LoadingScreen.start(A0_10)
	A0_10._panel:show()
	A0_10._fader:set_speed(0.3)
	A0_10._fader:fade_up()
	A0_10._icon_panel:show()
end
function LoadingScreen.update(A0_11, A1_12)
	A0_11._fader:update(A1_12)
	A0_11._icon_panel:update(A1_12)
end
function LoadingScreen.fade_down(A0_13)
	A0_13._fader:set_speed(0.2)
	A0_13._fader:fade_down()
end
function LoadingScreen.is_fading_down(A0_14)
	A0_14._fader:is_fading_down()
end
function LoadingScreen.fade_down_done(A0_15)
	return A0_15._fader:fade_down_done()
end
