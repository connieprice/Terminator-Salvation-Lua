require("units/beings/player_tank/gui/MachineText")
if not ActionPanel then
	ActionPanel = class()
end
ActionPanel.init = function(l_1_0, l_1_1)
	l_1_0._safe_panel = l_1_1
	l_1_0._x = tweak_data.machine.hud.RADAR_PANEL_WIDTH
	l_1_0._y = l_1_0._safe_panel:height()
	l_1_0._width = l_1_0._safe_panel:width() - tweak_data.machine.hud.TURRET_PANEL_WIDTH - tweak_data.machine.hud.RADAR_PANEL_WIDTH
	l_1_0._height = tweak_data.machine.hud.ACTION_PANEL_HEIGHT
	local l_1_2, l_1_3 = l_1_0._safe_panel:panel, l_1_0._safe_panel
	local l_1_4 = {}
	l_1_4.name = "action_panel"
	l_1_4.width = l_1_0._width
	l_1_4.height = l_1_0._height
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._action_panel = l_1_2
	l_1_2 = l_1_0._action_panel
	l_1_2, l_1_3 = l_1_2:set_leftbottom, l_1_2
	l_1_4 = l_1_0._x
	l_1_2(l_1_3, l_1_4, l_1_0._y)
	l_1_2, l_1_3 = l_1_0:_set_up_lines, l_1_0
	l_1_2(l_1_3)
	l_1_2 = MachineText
	l_1_2, l_1_3 = l_1_2:new, l_1_2
	l_1_4 = l_1_0._action_panel
	l_1_2 = l_1_2(l_1_3, l_1_4)
	l_1_0._action_text = l_1_2
	l_1_2 = l_1_0._action_text
	l_1_2, l_1_3 = l_1_2:set_static_text, l_1_2
	l_1_4 = Localizer
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_3, l_1_4)
	l_1_2 = l_1_0._action_text
	l_1_2, l_1_3 = l_1_2:set_alignment, l_1_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_3, l_1_4, "bottom")
	l_1_2 = l_1_0._action_text
	l_1_2, l_1_3 = l_1_2:set_text_main_alpha, l_1_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_2(l_1_3, l_1_4)
end

ActionPanel.panel = function(l_2_0)
	return l_2_0._action_panel
end

ActionPanel._set_up_lines = function(l_3_0)
	local l_3_1 = {}
	table.insert(l_3_1, Vector3(0, l_3_0._action_panel:height() * 0.8, 0))
	table.insert(l_3_1, Vector3(l_3_0._action_panel:width() * 0.45, l_3_0._action_panel:height() * 0.8, 0))
	table.insert(l_3_1, Vector3(l_3_0._action_panel:width() * 0.45, l_3_0._action_panel:height() * 0.85, 0))
	local l_3_2, l_3_3 = l_3_0._action_panel:polyline, l_3_0._action_panel
	local l_3_4 = {}
	l_3_4.name = "left_line"
	l_3_2 = l_3_2(l_3_3, l_3_4)
	l_3_0.left_line = l_3_2
	l_3_2 = l_3_0.left_line
	l_3_2, l_3_3 = l_3_2:set_color, l_3_2
	l_3_4 = Color
	l_3_2(l_3_3, l_3_4)
	l_3_2 = l_3_0.left_line
	l_3_2, l_3_3 = l_3_2:set_points, l_3_2
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3, l_3_4)
	l_3_3 = table
	l_3_3 = l_3_3.insert
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2 = {}
	l_3_3(l_3_4, Vector3(l_3_0._action_panel:width(), l_3_0._action_panel:height() * 0.8, 0))
	l_3_3 = table
	l_3_3 = l_3_3.insert
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_3(l_3_4, Vector3(l_3_0._action_panel:width() * 0.55, l_3_0._action_panel:height() * 0.8, 0))
	l_3_3 = table
	l_3_3 = l_3_3.insert
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_3(l_3_4, Vector3(l_3_0._action_panel:width() * 0.55, l_3_0._action_panel:height() * 0.85, 0))
	l_3_3 = l_3_0._action_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_3 = l_3_3:polyline
	local l_3_5 = {}
	l_3_5.name = "right_line"
	l_3_3 = l_3_3(l_3_4, l_3_5)
	l_3_0.right_line = l_3_3
	l_3_3 = l_3_0.right_line
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_3 = l_3_3:set_color
	l_3_5 = Color
	l_3_3(l_3_4, l_3_5)
	l_3_3 = l_3_0.right_line
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_3 = l_3_3:set_points
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_3(l_3_4, l_3_5)
end

ActionPanel.update = function(l_4_0, l_4_1, l_4_2)
end


