require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
if not TurretPanel then
	TurretPanel = class(MachineHudPanel)
end
TurretPanel.init = function(l_1_0, l_1_1)
	MachineHudPanel.init(l_1_0, l_1_1)
	l_1_0._parent_panel = l_1_1
	l_1_0._x = l_1_0._parent_panel:width() / 2
	l_1_0._y = l_1_0._parent_panel:height()
	l_1_0._width = tweak_data.machine.hud.TURRET_PANEL_WIDTH
	l_1_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT
	l_1_0._center_x = tweak_data.machine.hud.TURRET_PANEL_WIDTH / 2
	l_1_0._center_y = tweak_data.machine.hud.TURRET_PANEL_HEIGHT / 2
	l_1_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	local l_1_2, l_1_3 = l_1_0._parent_panel:panel, l_1_0._parent_panel
	local l_1_4 = {}
	l_1_4.name = "turret_panel"
	l_1_4.width = l_1_0._width
	l_1_4.height = l_1_0._height
	l_1_4.layer = 100
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._turret_panel = l_1_2
	l_1_2 = l_1_0._turret_panel
	l_1_2, l_1_3 = l_1_2:set_rightbottom, l_1_2
	l_1_4 = l_1_0._x
	l_1_2(l_1_3, l_1_4, l_1_0._y)
	l_1_2 = l_1_0._turret_panel
	l_1_2, l_1_3 = l_1_2:bitmap, l_1_2
	l_1_2, l_1_4 = l_1_2(l_1_3, l_1_4), {name = "gui_machine_tank_bottom", texture = "gui_machine_bottom"}
	l_1_0._tank_texture = l_1_2
	l_1_2 = l_1_0._tank_texture
	l_1_2, l_1_3 = l_1_2:set_center, l_1_2
	l_1_4 = l_1_0._center_x
	l_1_2(l_1_3, l_1_4, l_1_0._center_y)
	l_1_2 = l_1_0._tank_texture
	l_1_2, l_1_3 = l_1_2:set_color, l_1_2
	l_1_4 = l_1_0._color
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_3, l_1_4)
	l_1_2 = l_1_0._tank_texture
	l_1_2, l_1_3 = l_1_2:height, l_1_2
	l_1_2 = l_1_2(l_1_3)
	l_1_0._tank_texture_height = l_1_2
	l_1_2 = l_1_0._tank_texture
	l_1_2, l_1_3 = l_1_2:width, l_1_2
	l_1_2 = l_1_2(l_1_3)
	l_1_0._tank_texture_width = l_1_2
	l_1_2 = l_1_0._turret_panel
	l_1_2, l_1_3 = l_1_2:bitmap, l_1_2
	l_1_2, l_1_4 = l_1_2(l_1_3, l_1_4), {name = "gui_machine_tank_gun", texture = "gui_machine_tank_gun"}
	l_1_0._turret_texture = l_1_2
	l_1_2 = l_1_0._turret_texture
	l_1_2, l_1_3 = l_1_2:set_center, l_1_2
	l_1_4 = l_1_0._center_x
	l_1_2(l_1_3, l_1_4, l_1_0._center_y)
	l_1_2 = l_1_0._turret_texture
	l_1_2, l_1_3 = l_1_2:set_color, l_1_2
	l_1_4 = l_1_0._color
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_3, l_1_4)
	l_1_2 = l_1_0._turret_texture
	l_1_2, l_1_3 = l_1_2:height, l_1_2
	l_1_2 = l_1_2(l_1_3)
	l_1_0._turret_texture_height = l_1_2
	l_1_2 = l_1_0._turret_texture
	l_1_2, l_1_3 = l_1_2:width, l_1_2
	l_1_2 = l_1_2(l_1_3)
	l_1_0._turret_texture_width = l_1_2
	l_1_2 = l_1_0._turret_panel
	l_1_2, l_1_3 = l_1_2:bitmap, l_1_2
	l_1_2, l_1_4 = l_1_2(l_1_3, l_1_4), {name = "gui_machine_turret_radar_df", texture = "gui_machine_tank_aim"}
	l_1_0._turret_radar_texture = l_1_2
	l_1_2 = l_1_0._turret_radar_texture
	l_1_2, l_1_3 = l_1_2:set_center, l_1_2
	l_1_4 = l_1_0._center_x
	l_1_2(l_1_3, l_1_4, l_1_0._center_y)
	l_1_2 = l_1_0._turret_radar_texture
	l_1_2, l_1_3 = l_1_2:set_color, l_1_2
	l_1_4 = l_1_0._color
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_3, l_1_4)
	l_1_2 = l_1_0._turret_radar_texture
	l_1_2, l_1_3 = l_1_2:height, l_1_2
	l_1_2 = l_1_2(l_1_3)
	l_1_0._turret_radar_texture_height = l_1_2
	l_1_2 = l_1_0._turret_radar_texture
	l_1_2, l_1_3 = l_1_2:width, l_1_2
	l_1_2 = l_1_2(l_1_3)
	l_1_0._turret_radar_texture_width = l_1_2
	l_1_0._size_modifier = 1
	l_1_0._radius = 75
	l_1_2, l_1_3 = l_1_0:set_size_y, l_1_0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_3, l_1_4)
end

TurretPanel.panel = function(l_2_0)
	return l_2_0._turret_panel
end

TurretPanel._set_up_frame = function(l_3_0)
	local l_3_1 = {}
	table.insert(l_3_1, Vector3(0, 0, 0))
	table.insert(l_3_1, Vector3(0, l_3_0._turret_panel:height(), 0))
	table.insert(l_3_1, Vector3(l_3_0._turret_panel:width(), l_3_0._turret_panel:height(), 0))
	table.insert(l_3_1, Vector3(l_3_0._turret_panel:width(), 0, 0))
	local l_3_2, l_3_3 = l_3_0._turret_panel:polyline, l_3_0._turret_panel
	local l_3_4 = {}
	l_3_4.name = "frame"
	l_3_4.line_width = 2
	l_3_2 = l_3_2(l_3_3, l_3_4)
	l_3_0._frame = l_3_2
	l_3_2 = l_3_0._frame
	l_3_2, l_3_3 = l_3_2:set_color, l_3_2
	l_3_4 = Color
	l_3_2(l_3_3, l_3_4)
	l_3_2 = l_3_0._frame
	l_3_2, l_3_3 = l_3_2:set_points, l_3_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4)
	l_3_2 = l_3_0._frame
	l_3_2, l_3_3 = l_3_2:set_closed, l_3_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4)
end

TurretPanel.update = function(l_4_0, l_4_1, l_4_2, l_4_3, l_4_4)
	MachineHudPanel.update(l_4_0, l_4_2)
	if l_4_0._disabled then
		return 
	end
	if not l_4_0.startup_done then
		return 
	end
	l_4_0:set_tank_angle(l_4_3)
	l_4_0:set_turret_angle(l_4_4)
end

TurretPanel.set_turret_angle = function(l_5_0, l_5_1)
	l_5_0._turret_texture:set_rotation(l_5_1)
end

TurretPanel.set_tank_angle = function(l_6_0, l_6_1)
	l_6_0._turret_radar_texture:set_rotation(l_6_1)
	if l_6_0._radar_letter then
		l_6_0:_set_radar_letter_positions(l_6_1)
	end
end

TurretPanel._set_radar_letter_positions = function(l_7_0, l_7_1)
	local l_7_2 = 11
	local l_7_3 = 7
	local l_7_4 = l_7_1 - 90
	local l_7_5 = l_7_0._center_x + l_7_0._radius * math.cos(l_7_4) - l_7_3
	local l_7_6 = l_7_0._center_y + l_7_0._radius * math.sin(l_7_4) - l_7_2
	l_7_0._radar_letter.N:set_lefttop(l_7_5, l_7_6)
	l_7_4 = l_7_1
	l_7_5 = l_7_0._center_x + l_7_0._radius * math.cos(l_7_4) - l_7_3
	l_7_6 = l_7_0._center_y + l_7_0._radius * math.sin(l_7_4) - l_7_2 + 3
	l_7_0._radar_letter.E:set_lefttop(l_7_5, l_7_6)
	l_7_4 = l_7_1 + 90
	l_7_5 = l_7_0._center_x + l_7_0._radius * math.cos(l_7_4) - l_7_3
	l_7_6 = l_7_0._center_y + l_7_0._radius * math.sin(l_7_4) - l_7_2
	l_7_0._radar_letter.S:set_lefttop(l_7_5, l_7_6)
	l_7_4 = l_7_1 + 180
	l_7_5 = l_7_0._center_x + l_7_0._radius * math.cos(l_7_4) - l_7_3 + 3
	l_7_6 = l_7_0._center_y + l_7_0._radius * math.sin(l_7_4) - l_7_2
	l_7_0._radar_letter.W:set_lefttop(l_7_5, l_7_6)
end

TurretPanel.get_target_size = function(l_8_0)
	return l_8_0._width, l_8_0._height
end

TurretPanel.set_startup_done = function(l_9_0)
	if not l_9_0._startup_done and l_9_0._size_modifier == 1 and l_9_0._use_radar_letters then
		l_9_0._radar_letter = {}
		local l_9_1 = l_9_0._radar_letter
		local l_9_2, l_9_3 = l_9_0._turret_panel:text, l_9_0._turret_panel
		local l_9_4 = {}
		l_9_4.font = tweak_data.machine.hud.text.TEXT_FONT
		l_9_4.font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE
		l_9_4.color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA)
		l_9_4.text = "N"
		l_9_2 = l_9_2(l_9_3, l_9_4)
		l_9_1.N = l_9_2
		l_9_1 = l_9_0._radar_letter
		l_9_2 = l_9_0._turret_panel
		l_9_2, l_9_3 = l_9_2:text, l_9_2
		l_9_2, l_9_4 = l_9_2(l_9_3, l_9_4), {font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA), text = "S"}
		l_9_1.S = l_9_2
		l_9_1 = l_9_0._radar_letter
		l_9_2 = l_9_0._turret_panel
		l_9_2, l_9_3 = l_9_2:text, l_9_2
		l_9_2, l_9_4 = l_9_2(l_9_3, l_9_4), {font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA), text = "W"}
		l_9_1.W = l_9_2
		l_9_1 = l_9_0._radar_letter
		l_9_2 = l_9_0._turret_panel
		l_9_2, l_9_3 = l_9_2:text, l_9_2
		l_9_2, l_9_4 = l_9_2(l_9_3, l_9_4), {font = tweak_data.machine.hud.text.TEXT_FONT, font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE, color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA), text = "E"}
		l_9_1.E = l_9_2
		l_9_1, l_9_2 = l_9_0:set_size_y, l_9_0
		l_9_3 = l_9_0._height
		l_9_1(l_9_2, l_9_3)
	end
	MachineHudPanel.set_startup_done(l_9_0)
end

TurretPanel.set_size_y = function(l_10_0, l_10_1)
	local l_10_2 = l_10_1 / l_10_0._height
	l_10_0._tank_texture:set_height(l_10_2 * l_10_0._tank_texture_height * l_10_0._size_modifier)
	l_10_0._tank_texture:set_center_y(l_10_0._center_y)
	l_10_0._turret_texture:set_height(l_10_2 * l_10_0._turret_texture_height * l_10_0._size_modifier)
	l_10_0._turret_texture:set_center_y(l_10_0._center_y)
	l_10_0._turret_radar_texture:set_height(l_10_2 * l_10_0._turret_radar_texture_height * l_10_0._size_modifier)
	l_10_0._turret_radar_texture:set_center_y(l_10_0._center_y)
end

TurretPanel.shutdown = function(l_11_0, l_11_1, l_11_2)
	local l_11_6, l_11_7, l_11_8, l_11_9, l_11_10, l_11_11 = nil
	if l_11_0._radar_letter then
		for i_0,i_1 in pairs(l_11_0._radar_letter) do
			i_1:set_color(i_1:color():with_alpha(0))
		end
	end
	MachineHudPanel.shutdown(l_11_0, l_11_1, l_11_2)
end

TurretPanel.enable = function(l_12_0, l_12_1, l_12_2)
	l_12_0._size_modifier = l_12_1
	if not l_12_2 then
		l_12_2 = 1
	end
	l_12_0._center_x = tweak_data.machine.hud.TURRET_PANEL_WIDTH / 2 * l_12_1
	l_12_0._center_y = tweak_data.machine.hud.TURRET_PANEL_HEIGHT / 2 * l_12_1
	l_12_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT * l_12_1
	l_12_0._width = tweak_data.machine.hud.TURRET_PANEL_WIDTH * l_12_1
	l_12_0._turret_panel:set_height(l_12_0._height)
	l_12_0._turret_panel:set_width(l_12_0._width)
	if l_12_2 == 0.75 then
		l_12_0._turret_panel:set_rightbottom(l_12_0._x + 20, l_12_0._y + 30)
	elseif l_12_2 == 0.5 then
		l_12_0._turret_panel:set_rightbottom(l_12_0._x + 20, l_12_0._y + 27)
	else
		l_12_0._turret_panel:set_rightbottom(l_12_0._x, l_12_0._y)
	end
	l_12_0._tank_texture:set_width(l_12_0._tank_texture_width * l_12_1)
	l_12_0._turret_texture:set_width(l_12_0._turret_texture_width * l_12_1)
	l_12_0._turret_radar_texture:set_width(l_12_0._turret_radar_texture_width * l_12_1)
	if l_12_0._startup_done then
		l_12_0._tank_texture:set_height(l_12_0._tank_texture_height * l_12_1)
		l_12_0._tank_texture:set_center_y(l_12_0._center_y)
		l_12_0._turret_texture:set_height(l_12_0._turret_texture_height * l_12_1)
		l_12_0._turret_texture:set_center_y(l_12_0._center_y)
		l_12_0._turret_radar_texture:set_height(l_12_0._turret_radar_texture_height * l_12_1)
		l_12_0._turret_radar_texture:set_center_y(l_12_0._center_y)
	end
	l_12_0._radius = 75 * l_12_1
	l_12_0._disabled = false
end

TurretPanel.disable = function(l_13_0)
	l_13_0._tank_texture:set_color(l_13_0._tank_texture:color():with_alpha(0))
	l_13_0._turret_texture:set_color(l_13_0._turret_texture:color():with_alpha(0))
	l_13_0._turret_radar_texture:set_color(l_13_0._turret_radar_texture:color():with_alpha(0))
	l_13_0._disabled = true
end

TurretPanel.show = function(l_14_0)
	if l_14_0._disabled then
		return 
	end
	MachineHudPanel.show(l_14_0)
	l_14_0:_set_alpha(tweak_data.machine.hud.MAIN_ALPHA)
end

TurretPanel.hide = function(l_15_0)
	MachineHudPanel.hide(l_15_0)
	l_15_0:_set_alpha(0)
end

TurretPanel._set_alpha = function(l_16_0, l_16_1)
	l_16_0._tank_texture:set_color(l_16_0._tank_texture:color():with_alpha(l_16_1))
	l_16_0._turret_texture:set_color(l_16_0._turret_texture:color():with_alpha(l_16_1))
	local l_16_5, l_16_6 = l_16_0._turret_radar_texture:set_color, l_16_0._turret_radar_texture
	l_16_5(l_16_6, l_16_0._turret_radar_texture:color():with_alpha(l_16_1))
	l_16_5 = l_16_0._radar_letter
	if l_16_5 then
		l_16_5 = pairs
		l_16_6 = l_16_0._radar_letter
		l_16_5 = l_16_5(l_16_6)
		for i_0,i_1 in l_16_5 do
			l_16_4:set_color(l_16_4:color():with_alpha(l_16_1))
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end


