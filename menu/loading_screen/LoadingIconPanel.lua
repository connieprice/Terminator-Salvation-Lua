require("menu/loading_screen/LoadingScreenTweakData")
require("shared/Interpolator")
LoadingIconPanel = LoadingIconPanel or class()
function LoadingIconPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._width = loading_screen_tweak_data.ICON_WIDTH
	A0_0._height = loading_screen_tweak_data.ICON_HEIGHT
	A0_0._x = A1_1:width()
	A0_0._y = A1_1:height()
	A0_0._center_x = A0_0._width / 2
	A0_0._center_y = A0_0._height / 2
	A0_0._icon_offset = 8
	A0_0._io_icon_panel = A0_0._parent_panel:panel({
		name = "io_icon_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "bottom",
		halign = "right",
		layer = 90
	})
	A0_0._io_icon_panel:set_rightbottom(A0_0._x, A0_0._y)
	A0_0._icons = {}
	A0_0._icons.main = A0_0._io_icon_panel:bitmap({
		name = "icon_main",
		texture = "gui_disc_icon"
	})
	A0_0._icons.main:set_rightbottom(A0_0._io_icon_panel:width() + A0_0._icon_offset, A0_0._io_icon_panel:height() + A0_0._icon_offset)
	A0_0._icons.main:set_render_template("OverlayVertexColorTextured")
	A0_0._current_angle = 0
	A0_0:set_alpha(0)
	A0_0._showing = false
end
function LoadingIconPanel.panel(A0_2)
	local L1_3
	L1_3 = A0_2._io_icon_panel
	return L1_3
end
function LoadingIconPanel.show(A0_4)
	A0_4:set_alpha(1)
	A0_4._showing = true
end
function LoadingIconPanel.hide(A0_5)
	A0_5:set_alpha(0)
	A0_5._showing = false
end
function LoadingIconPanel.visible(A0_6)
	return A0_6._alpha > 0 or A0_6._showing
end
function LoadingIconPanel.set_alpha(A0_7, A1_8)
	A0_7._alpha = A1_8
	for 