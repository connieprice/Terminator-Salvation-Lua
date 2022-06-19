require("menu/loading_screen/LoadingScreenTweakData")
require("menu/loading_screen/LoadingIconPanel")
require("menu/ScreenFader")
if not LoadingScreen then
	LoadingScreen = class()
end
local l_0_0 = LoadingScreen
local l_0_1 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_0.textures, l_0_1 = l_0_1, {"faith_font_22"}
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	l_1_0._resources = l_1_1
	l_1_0._camera = l_1_2
	l_1_0._workspace = l_1_3:create_scaled_screen_workspace(l_1_6.width, l_1_6.height, 0, 0, l_1_7.width, l_1_7.height)
	l_1_0._level_load_progress_func = l_1_4
	l_1_0._panel = l_1_0._workspace:panel()
	local l_1_8, l_1_9 = l_1_0._panel:panel, l_1_0._panel
	local l_1_10 = {}
	l_1_10.name = "safe_panel"
	l_1_10.valign = "grow"
	l_1_10.halign = "grow"
	l_1_8 = l_1_8(l_1_9, l_1_10)
	l_1_0._safe_panel = l_1_8
	l_1_8 = l_1_0._safe_panel
	l_1_8, l_1_9 = l_1_8:set_shape, l_1_8
	l_1_10 = l_1_5.x
	l_1_8(l_1_9, l_1_10, l_1_5.y, l_1_5.w, l_1_5.h)
	l_1_8 = ScreenFader
	l_1_8, l_1_9 = l_1_8:new, l_1_8
	l_1_10 = l_1_0._panel
	local l_1_11 = l_1_10
	local l_1_12 = {}
	l_1_12.layer = 99
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_11 = "OverlayVertexColor"
	l_1_8 = l_1_8(l_1_9, l_1_10, l_1_11)
	l_1_0._fader = l_1_8
	l_1_8 = LoadingIconPanel
	l_1_8, l_1_9 = l_1_8:new, l_1_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_8 = l_1_8(l_1_9, l_1_10)
	l_1_0._icon_panel = l_1_8
	l_1_8 = loading_screen_tweak_data
	l_1_8 = l_1_8.TEXT_INTENSITY
	l_1_9 = l_1_0._safe_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_9 = l_1_9:text
	l_1_12 = loading_screen_tweak_data
	l_1_12 = l_1_12.TEXT_SIZE
	l_1_12 = 2 * l_1_12
	l_1_12 = Color
	l_1_12 = l_1_12(loading_screen_tweak_data.TEXT_ALPHA, l_1_8, l_1_8, l_1_8)
	l_1_12 = loading_screen_tweak_data
	l_1_12 = l_1_12.TEXT_SIZE
	l_1_9, l_1_11 = l_1_9(l_1_10, l_1_11), {h = l_1_12, color = l_1_12, align = "right", vertical = "center", font_size = l_1_12, layer = 90, font = "faith_font_22", text_id = "loading_loading"}
	l_1_0._loading_text = l_1_9
	l_1_9 = l_1_0._loading_text
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_9 = l_1_9:set_right
	l_1_11 = l_1_0._icon_panel
	l_1_11, l_1_12 = l_1_11:panel, l_1_11
	l_1_11 = l_1_11(l_1_12)
	l_1_11, l_1_12 = l_1_11:left, l_1_11
	l_1_11 = l_1_11(l_1_12)
	l_1_12 = loading_screen_tweak_data
	l_1_12 = l_1_12.TEXT_OFFSET_X
	l_1_11 = l_1_11 + l_1_12
	l_1_9(l_1_10, l_1_11)
	l_1_9 = l_1_0._loading_text
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_9 = l_1_9:set_center_y
	l_1_11 = l_1_0._icon_panel
	l_1_11, l_1_12 = l_1_11:panel, l_1_11
	l_1_11 = l_1_11(l_1_12)
	l_1_11, l_1_12 = l_1_11:center_y, l_1_11
	l_1_11 = l_1_11(l_1_12)
	l_1_12 = loading_screen_tweak_data
	l_1_12 = l_1_12.TEXT_OFFSET_Y
	l_1_11 = l_1_11 + l_1_12
	l_1_9(l_1_10, l_1_11)
	l_1_9 = l_1_0._loading_text
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_9 = l_1_9:set_render_template
	l_1_11 = "OverlayVertexColorTextured"
	l_1_9(l_1_10, l_1_11)
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_9 = l_1_0:start
	l_1_9(l_1_10)
end

l_0_0.init = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_2_0)
	l_2_0._resources.head:set_slot(0)
	l_2_0._fader:destroy()
	l_2_0._icon_panel:destroy()
end

l_0_0.destroy = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_3_0)
	l_3_0._panel:show()
	l_3_0._fader:set_speed(0.3)
	l_3_0._fader:fade_up()
	l_3_0._icon_panel:show()
end

l_0_0.start = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_4_0, l_4_1)
	l_4_0._fader:update(l_4_1)
	l_4_0._icon_panel:update(l_4_1)
end

l_0_0.update = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_5_0)
	l_5_0._fader:set_speed(0.2)
	l_5_0._fader:fade_down()
end

l_0_0.fade_down = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_6_0)
	l_6_0._fader:is_fading_down()
end

l_0_0.is_fading_down = l_0_1
 -- DECOMPILER ERROR: Overwrote pending register.

l_0_1 = function(l_7_0)
	local l_7_1, l_7_2 = l_7_0._fader:fade_down_done, l_7_0._fader
	return l_7_1(l_7_2)
end

l_0_0.fade_down_done = l_0_1

