require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
TurretPanel = TurretPanel or class(MachineHudPanel)
function TurretPanel.init(A0_0, A1_1)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._x = A0_0._parent_panel:width() / 2
	A0_0._y = A0_0._parent_panel:height()
	A0_0._width = tweak_data.machine.hud.TURRET_PANEL_WIDTH
	A0_0._height = tweak_data.machine.hud.TURRET_PANEL_HEIGHT
	A0_0._center_x = tweak_data.machine.hud.TURRET_PANEL_WIDTH / 2
	A0_0._center_y = tweak_data.machine.hud.TURRET_PANEL_HEIGHT / 2
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._turret_panel = A0_0._parent_panel:panel({
		name = "turret_panel",
		width = A0_0._width,
		height = A0_0._height,
		layer = 100
	})
	A0_0._turret_panel:set_rightbottom(A0_0._x, A0_0._y)
	A0_0._tank_texture = A0_0._turret_panel:bitmap({
		name = "gui_machine_tank_bottom",
		texture = "gui_machine_bottom"
	})
	A0_0._tank_texture:set_center(A0_0._center_x, A0_0._center_y)
	A0_0._tank_texture:set_color(A0_0._color:with_alpha(tweak_data.machine.hud.MAIN_ALPHA))
	A0_0._tank_texture_height = A0_0._tank_texture:height()
	A0_0._tank_texture_width = A0_0._tank_texture:width()
	A0_0._turret_texture = A0_0._turret_panel:bitmap({
		name = "gui_machine_tank_gun",
		texture = "gui_machine_tank_gun"
	})
	A0_0._turret_texture:set_center(A0_0._center_x, A0_0._center_y)
	A0_0._turret_texture:set_color(A0_0._color:with_alpha(tweak_data.machine.hud.MAIN_ALPHA))
	A0_0._turret_texture_height = A0_0._turret_texture:height()
	A0_0._turret_texture_width = A0_0._turret_texture:width()
	A0_0._turret_radar_texture = A0_0._turret_panel:bitmap({
		name = "gui_machine_turret_radar_df",
		texture = "gui_machine_tank_aim"
	})
	A0_0._turret_radar_texture:set_center(A0_0._center_x, A0_0._center_y)
	A0_0._turret_radar_texture:set_color(A0_0._color:with_alpha(0.8 * tweak_data.machine.hud.MAIN_ALPHA))
	A0_0._turret_radar_texture_height = A0_0._turret_radar_texture:height()
	A0_0._turret_radar_texture_width = A0_0._turret_radar_texture:width()
	A0_0._size_modifier = 1
	A0_0._radius = 75
	A0_0:set_size_y(0)
end
function TurretPanel.panel(A0_2)
	local L1_3
	L1_3 = A0_2._turret_panel
	return L1_3
end
function TurretPanel._set_up_frame(A0_4)
	local L1_5
	L1_5 = {}
	table.insert(L1_5, Vector3(0, 0, 0))
	table.insert(L1_5, Vector3(0, A0_4._turret_panel:height(), 0))
	table.insert(L1_5, Vector3(A0_4._turret_panel:width(), A0_4._turret_panel:height(), 0))
	table.insert(L1_5, Vector3(A0_4._turret_panel:width(), 0, 0))
	A0_4._frame = A0_4._turret_panel:polyline({name = "frame", line_width = 2})
	A0_4._frame:set_color(Color(1, 1, 1))
	A0_4._frame:set_points(L1_5)
	A0_4._frame:set_closed(true)
end
function TurretPanel.update(A0_6, A1_7, A2_8, A3_9, A4_10)
	MachineHudPanel.update(A0_6, A2_8)
	if A0_6._disabled then
		return
	end
	if not A0_6.startup_done then
		return
	end
	A0_6:set_tank_angle(A3_9)
	A0_6:set_turret_angle(A4_10)
end
function TurretPanel.set_turret_angle(A0_11, A1_12)
	A0_11._turret_texture:set_rotation(A1_12)
end
function TurretPanel.set_tank_angle(A0_13, A1_14)
	A0_13._turret_radar_texture:set_rotation(A1_14)
	if A0_13._radar_letter then
		A0_13:_set_radar_letter_positions(A1_14)
	end
end
function TurretPanel._set_radar_letter_positions(A0_15, A1_16)
	local L2_17, L3_18, L4_19, L5_20, L6_21
	L2_17 = 11
	L3_18 = 7
	L4_19 = A1_16 - 90
	L5_20 = A0_15._center_x
	L6_21 = A0_15._radius
	L6_21 = L6_21 * math.cos(L4_19)
	L5_20 = L5_20 + L6_21
	L5_20 = L5_20 - L3_18
	L6_21 = A0_15._center_y
	L6_21 = L6_21 + A0_15._radius * math.sin(L4_19)
	L6_21 = L6_21 - L2_17
	A0_15._radar_letter.N:set_lefttop(L5_20, L6_21)
	L4_19 = A1_16
	L5_20 = A0_15._center_x + A0_15._radius * math.cos(L4_19) - L3_18
	L6_21 = A0_15._center_y + A0_15._radius * math.sin(L4_19) - L2_17 + 3
	A0_15._radar_letter.E:set_lefttop(L5_20, L6_21)
	L4_19 = A1_16 + 90
	L5_20 = A0_15._center_x + A0_15._radius * math.cos(L4_19) - L3_18
	L6_21 = A0_15._center_y + A0_15._radius * math.sin(L4_19) - L2_17
	A0_15._radar_letter.S:set_lefttop(L5_20, L6_21)
	L4_19 = A1_16 + 180
	L5_20 = A0_15._center_x + A0_15._radius * math.cos(L4_19) - L3_18 + 3
	L6_21 = A0_15._center_y + A0_15._radius * math.sin(L4_19) - L2_17
	A0_15._radar_letter.W:set_lefttop(L5_20, L6_21)
end
function TurretPanel.get_target_size(A0_22)
	local L1_23, L2_24
	L1_23 = A0_22._width
	L2_24 = A0_22._height
	return L1_23, L2_24
end
function TurretPanel.set_startup_done(A0_25)
	if not A0_25._startup_done and A0_25._size_modifier == 1 and A0_25._use_radar_letters then
		A0_25._radar_letter = {}
		A0_25._radar_letter.N = A0_25._turret_panel:text({
			font = tweak_data.machine.hud.text.TEXT_FONT,
			font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE,
			color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA),
			text = "N"
		})
		A0_25._radar_letter.S = A0_25._turret_panel:text({
			font = tweak_data.machine.hud.text.TEXT_FONT,
			font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE,
			color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA),
			text = "S"
		})
		A0_25._radar_letter.W = A0_25._turret_panel:text({
			font = tweak_data.machine.hud.text.TEXT_FONT,
			font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE,
			color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA),
			text = "W"
		})
		A0_25._radar_letter.E = A0_25._turret_panel:text({
			font = tweak_data.machine.hud.text.TEXT_FONT,
			font_size = tweak_data.machine.hud.text.TEXT_FONT_SIZE,
			color = tweak_data.machine.hud.text.TEXT_FONT_COLOR:with_alpha(tweak_data.machine.hud.MAIN_ALPHA),
			text = "E"
		})
		A0_25:set_size_y(A0_25._height)
	end
	MachineHudPanel.set_startup_done(A0_25)
end
function TurretPanel.set_size_y(A0_26, A1_27)
	local L2_28
	L2_28 = A0_26._height
	L2_28 = A1_27 / L2_28
	A0_26._tank_texture:set_height(L2_28 * A0_26._tank_texture_height * A0_26._size_modifier)
	A0_26._tank_texture:set_center_y(A0_26._center_y)
	A0_26._turret_texture:set_height(L2_28 * A0_26._turret_texture_height * A0_26._size_modifier)
	A0_26._turret_texture:set_center_y(A0_26._center_y)
	A0_26._turret_radar_texture:set_height(L2_28 * A0_26._turret_radar_texture_height * A0_26._size_modifier)
	A0_26._turret_radar_texture:set_center_y(A0_26._center_y)
end
function TurretPanel.shutdown(A0_29, A1_30, A2_31)
	if A0_29._radar_letter then
		for 