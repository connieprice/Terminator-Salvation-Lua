require("units/beings/player_tank/gui/MachineHudPanel")
if not BackgroundPanel then
	BackgroundPanel = class(MachineHudPanel)
end
BackgroundPanel.init = function(l_1_0, l_1_1)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	local l_1_2, l_1_3 = l_1_1:panel, l_1_1
	local l_1_4 = {}
	l_1_4.layer = -100
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._panel = l_1_2
	l_1_2, l_1_3 = l_1_0:setup_panel, l_1_0
	l_1_2(l_1_3)
	l_1_2, l_1_3 = l_1_0:set_size_y, l_1_0
	l_1_4 = 0
	l_1_2(l_1_3, l_1_4)
	l_1_2 = l_1_0._panel
	l_1_2, l_1_3 = l_1_2:hide, l_1_2
	l_1_2(l_1_3)
end

BackgroundPanel.setup_panel = function(l_2_0)
	l_2_0._width = l_2_0._panel:width()
	l_2_0._height = l_2_0._panel:height()
	l_2_0._x = l_2_0._panel:x()
	l_2_0._y = l_2_0._panel:y()
	l_2_0._center_y = l_2_0._height / 2
	if not l_2_0._red_tint_rectangle then
		local l_2_1, l_2_2 = l_2_0._panel:rect, l_2_0._panel
		local l_2_3 = {}
		l_2_3.blend_mode = "mul"
		l_2_3.render_template = "hud_vertex_color_tint"
		l_2_1 = l_2_1(l_2_2, l_2_3)
		l_2_0._red_tint_rectangle = l_2_1
	end
	l_2_0._red_tint_rectangle:set_size(l_2_0._panel:size())
	l_2_0:_update_tint()
	if not l_2_0._inner_shadow_texture then
		local l_2_4, l_2_5 = l_2_0._panel:bitmap, l_2_0._panel
		local l_2_6 = {}
		l_2_6.name = "gui_machine_inner_shadow"
		l_2_6.texture = "gui_machine_inner_shadow_df"
		l_2_6.valign = "grow"
		l_2_6.halign = "grow"
		l_2_4 = l_2_4(l_2_5, l_2_6)
		l_2_0._inner_shadow_texture = l_2_4
	end
	l_2_0._inner_shadow_texture:set_size(l_2_0._panel:size())
	if not l_2_0._black_rectangles then
		l_2_0._black_rectangles = {}
		l_2_0._black_rectangles.top = l_2_0._panel:rect({})
		l_2_0._black_rectangles.top:set_color(Color(0, 0, 0))
		l_2_0._black_rectangles.bottom = l_2_0._panel:rect({})
		l_2_0._black_rectangles.bottom:set_color(Color(0, 0, 0))
		l_2_0._black_rectangles.top:set_size(l_2_0._width, l_2_0._height / 2)
		l_2_0._black_rectangles.top:set_position(l_2_0._x, l_2_0._y)
		l_2_0._black_rectangles.bottom:set_size(l_2_0._width, l_2_0._height / 2)
		l_2_0._black_rectangles.bottom:set_position(l_2_0._x, l_2_0._y)
	end
end

BackgroundPanel.panel = function(l_3_0)
	return l_3_0._panel
end

BackgroundPanel.set_alpha = function(l_4_0, l_4_1)
	l_4_0._red_tint_rectangle:set_color(l_4_0._red_tint_rectangle:color():with_alpha(l_4_1))
end

BackgroundPanel.update = function(l_5_0, l_5_1)
	MachineHudPanel.update(l_5_0, l_5_1)
end

BackgroundPanel._update_tint = function(l_6_0)
	local l_6_1 = tweak_data.machine.hud.TINT_COLOR
	l_6_0._red_tint_rectangle:set_color(Color(l_6_1.a, l_6_1.r, l_6_1.g, l_6_1.b))
end

BackgroundPanel.get_target_size = function(l_7_0)
	return l_7_0._width, l_7_0._height
end

BackgroundPanel.set_size_y = function(l_8_0, l_8_1)
	l_8_0._red_tint_rectangle:set_height(l_8_1)
	l_8_0._red_tint_rectangle:set_center_y(l_8_0._center_y)
	l_8_0._black_rectangles.top:set_height(l_8_0._center_y - l_8_1 / 2)
	l_8_0._black_rectangles.bottom:set_height(l_8_0._center_y - l_8_1 / 2)
	l_8_0._black_rectangles.bottom:set_bottom(l_8_0._height)
end

BackgroundPanel.resolution_changed = function(l_9_0)
	l_9_0:setup_panel()
end

BackgroundPanel.set_startup_done = function(l_10_0)
	if not l_10_0._startup_done then
		l_10_0:set_size_y(l_10_0._height)
	end
	MachineHudPanel.set_startup_done(l_10_0)
end

BackgroundPanel.show = function(l_11_0)
	if l_11_0._black_rectangles then
		l_11_0._black_rectangles.top:set_color(l_11_0._black_rectangles.top:color():with_alpha(1))
		l_11_0._black_rectangles.bottom:set_color(l_11_0._black_rectangles.bottom:color():with_alpha(1))
	end
	if l_11_0._inner_shadow_texture then
		l_11_0._inner_shadow_texture:set_color(l_11_0._inner_shadow_texture:color():with_alpha(1))
	end
end

BackgroundPanel.startup = function(l_12_0, l_12_1, l_12_2)
	l_12_0._panel:show()
	MachineHudPanel.startup(l_12_0, l_12_1, l_12_2)
end


