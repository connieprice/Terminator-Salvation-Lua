require("menu/2D/Menu2DPage")
Menu2DPageController = Menu2DPageController or class(Menu2DPage)
function Menu2DPageController.init(A0_0, A1_1, A2_2)
	Menu2DPage.init(A0_0, A1_1, A2_2)
	A0_0._root_panel = A2_2
	A0_0._layer = tweak_data.menu2d.layer_normal
	A0_0._configuration = 1
	A0_0._controller_sets = {
		"default_controls",
		"controller_set1"
	}
	A0_0:_parse_xml()
end
function Menu2DPageController.update(A0_3, A1_4)
	Menu2DPage.update(A0_3, A1_4)
end
function Menu2DPageController.input(A0_5, A1_6, A2_7)
	if A1_6.back then
		managers.menu2d:back()
		return
	end
end
function Menu2DPageController.confirm_mode(A0_8)
	local L1_9
	return L1_9
end
function Menu2DPageController.open(A0_10, A1_11, A2_12)
	Menu2DPage.open(A0_10, A1_11, A2_12, tweak_data.menu2d.layer_normal)
	A0_10:_parse_xml()
	A0_10._configuration = managers.save:profile().control_settings.configuration or 1
	if SystemInfo:platform() == "WIN32" or SystemInfo:platform() == "X360" then
	else
	end
	A0_10._controller = A0_10._root_panel:bitmap({
		texture = "gui_menu_controller_ps3",
		x = 0,
		y = 0,
		blend_mode = "add",
		color = Color.white:with_alpha(0),
		layer = A0_10._layer
	})
	A0_10._controller:set_center(A0_10._root_panel:center())
	A0_10._texts = {}
	A0_10._center_x = A0_10._panel:width() * 0.5
	A0_10._center_y = A0_10._panel:height() * 0.5
	for 