require("units/beings/player_tank/gui/MachineText")
ActionPanel = ActionPanel or class()
function ActionPanel.init(A0_0, A1_1)
	A0_0._safe_panel = A1_1
	A0_0._x = tweak_data.machine.hud.RADAR_PANEL_WIDTH
	A0_0._y = A0_0._safe_panel:height()
	A0_0._width = A0_0._safe_panel:width() - tweak_data.machine.hud.TURRET_PANEL_WIDTH - tweak_data.machine.hud.RADAR_PANEL_WIDTH
	A0_0._height = tweak_data.machine.hud.ACTION_PANEL_HEIGHT
	A0_0._action_panel = A0_0._safe_panel:panel({
		name = "action_panel",
		width = A0_0._width,
		height = A0_0._height
	})
	A0_0._action_panel:set_leftbottom(A0_0._x, A0_0._y)
	A0_0:_set_up_lines()
	A0_0._action_text = MachineText:new(A0_0._action_panel)
	A0_0._action_text:set_static_text(Localizer:lookup("machine_hud_action_caption"))
	A0_0._action_text:set_alignment("center", "bottom")
	A0_0._action_text:set_text_main_alpha(tweak_data.machine.hud.MAIN_ALPHA)
end
function ActionPanel.panel(A0_2)
	local L1_3
	L1_3 = A0_2._action_panel
	return L1_3
end
function ActionPanel._set_up_lines(A0_4)
	local L1_5, L2_6
	L1_5 = {}
	L2_6 = table
	L2_6 = L2_6.insert
	L2_6(L1_5, Vector3(0, A0_4._action_panel:height() * 0.8, 0))
	L2_6 = table
	L2_6 = L2_6.insert
	L2_6(L1_5, Vector3(A0_4._action_panel:width() * 0.45, A0_4._action_panel:height() * 0.8, 0))
	L2_6 = table
	L2_6 = L2_6.insert
	L2_6(L1_5, Vector3(A0_4._action_panel:width() * 0.45, A0_4._action_panel:height() * 0.85, 0))
	L2_6 = A0_4._action_panel
	L2_6 = L2_6.polyline
	L2_6 = L2_6(L2_6, {name = "left_line"})
	A0_4.left_line = L2_6
	L2_6 = A0_4.left_line
	L2_6 = L2_6.set_color
	L2_6(L2_6, Color(1, 1, 1))
	L2_6 = A0_4.left_line
	L2_6 = L2_6.set_points
	L2_6(L2_6, L1_5)
	L2_6 = {}
	table.insert(L2_6, Vector3(A0_4._action_panel:width(), A0_4._action_panel:height() * 0.8, 0))
	table.insert(L2_6, Vector3(A0_4._action_panel:width() * 0.55, A0_4._action_panel:height() * 0.8, 0))
	table.insert(L2_6, Vector3(A0_4._action_panel:width() * 0.55, A0_4._action_panel:height() * 0.85, 0))
	A0_4.right_line = A0_4._action_panel:polyline({name = "right_line"})
	A0_4.right_line:set_color(Color(1, 1, 1))
	A0_4.right_line:set_points(L2_6)
end
function ActionPanel.update(A0_7, A1_8, A2_9)
end
