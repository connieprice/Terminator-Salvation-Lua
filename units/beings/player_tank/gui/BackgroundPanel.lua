require("units/beings/player_tank/gui/MachineHudPanel")
BackgroundPanel = BackgroundPanel or class(MachineHudPanel)
function BackgroundPanel.init(A0_0, A1_1)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._panel = A1_1:panel({layer = -100})
	A0_0:setup_panel()
	A0_0:set_size_y(0)
	A0_0._panel:hide()
end
function BackgroundPanel.setup_panel(A0_2)
	A0_2._width = A0_2._panel:width()
	A0_2._height = A0_2._panel:height()
	A0_2._x = A0_2._panel:x()
	A0_2._y = A0_2._panel:y()
	A0_2._center_y = A0_2._height / 2
	if not A0_2._red_tint_rectangle then
		A0_2._red_tint_rectangle = A0_2._panel:rect({
			blend_mode = "mul",
			render_template = "hud_vertex_color_tint"
		})
	end
	A0_2._red_tint_rectangle:set_size(A0_2._panel:size())
	A0_2:_update_tint()
	if not A0_2._inner_shadow_texture then
		A0_2._inner_shadow_texture = A0_2._panel:bitmap({
			name = "gui_machine_inner_shadow",
			texture = "gui_machine_inner_shadow_df",
			valign = "grow",
			halign = "grow"
		})
	end
	A0_2._inner_shadow_texture:set_size(A0_2._panel:size())
	if not A0_2._black_rectangles then
		A0_2._black_rectangles = {}
		A0_2._black_rectangles.top = A0_2._panel:rect({})
		A0_2._black_rectangles.top:set_color(Color(0, 0, 0))
		A0_2._black_rectangles.bottom = A0_2._panel:rect({})
		A0_2._black_rectangles.bottom:set_color(Color(0, 0, 0))
		A0_2._black_rectangles.top:set_size(A0_2._width, A0_2._height / 2)
		A0_2._black_rectangles.top:set_position(A0_2._x, A0_2._y)
		A0_2._black_rectangles.bottom:set_size(A0_2._width, A0_2._height / 2)
		A0_2._black_rectangles.bottom:set_position(A0_2._x, A0_2._y)
	end
end
function BackgroundPanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._panel
	return L1_4
end
function BackgroundPanel.set_alpha(A0_5, A1_6)
	local L3_7
	L3_7 = A0_5._red_tint_rectangle
	L3_7 = L3_7.set_color
	L3_7(L3_7, A0_5._red_tint_rectangle:color():with_alpha(A1_6))
end
function BackgroundPanel.update(A0_8, A1_9)
	MachineHudPanel.update(A0_8, A1_9)
end
function BackgroundPanel._update_tint(A0_10)
	local L1_11, L3_12
	L1_11 = tweak_data
	L1_11 = L1_11.machine
	L1_11 = L1_11.hud
	L1_11 = L1_11.TINT_COLOR
	L3_12 = A0_10._red_tint_rectangle
	L3_12 = L3_12.set_color
	L3_12(L3_12, Color(L1_11.a, L1_11.r, L1_11.g, L1_11.b))
end
function BackgroundPanel.get_target_size(A0_13)
	local L1_14, L2_15
	L1_14 = A0_13._width
	L2_15 = A0_13._height
	return L1_14, L2_15
end
function BackgroundPanel.set_size_y(A0_16, A1_17)
	A0_16._red_tint_rectangle:set_height(A1_17)
	A0_16._red_tint_rectangle:set_center_y(A0_16._center_y)
	A0_16._black_rectangles.top:set_height(A0_16._center_y - A1_17 / 2)
	A0_16._black_rectangles.bottom:set_height(A0_16._center_y - A1_17 / 2)
	A0_16._black_rectangles.bottom:set_bottom(A0_16._height)
end
function BackgroundPanel.resolution_changed(A0_18)
	A0_18:setup_panel()
end
function BackgroundPanel.set_startup_done(A0_19)
	if not A0_19._startup_done then
		A0_19:set_size_y(A0_19._height)
	end
	MachineHudPanel.set_startup_done(A0_19)
end
function BackgroundPanel.show(A0_20)
	local L1_21, L2_22
	L1_21 = A0_20._black_rectangles
	if L1_21 then
		L1_21 = A0_20._black_rectangles
		L1_21 = L1_21.top
		L2_22 = L1_21
		L1_21 = L1_21.set_color
		L1_21(L2_22, A0_20._black_rectangles.top:color():with_alpha(1))
		L1_21 = A0_20._black_rectangles
		L1_21 = L1_21.bottom
		L2_22 = L1_21
		L1_21 = L1_21.set_color
		L1_21(L2_22, A0_20._black_rectangles.bottom:color():with_alpha(1))
	end
	L1_21 = A0_20._inner_shadow_texture
	if L1_21 then
		L1_21 = A0_20._inner_shadow_texture
		L2_22 = L1_21
		L1_21 = L1_21.set_color
		L1_21(L2_22, A0_20._inner_shadow_texture:color():with_alpha(1))
	end
end
function BackgroundPanel.startup(A0_23, A1_24, A2_25)
	A0_23._panel:show()
	MachineHudPanel.startup(A0_23, A1_24, A2_25)
end
