require("units/beings/player_tank/gui/MachineHudPanel")
require("units/beings/player_tank/gui/MachineText")
require("units/beings/player_tank/gui/ReticuleArrow")
require("units/beings/player_tank/gui/ReticuleAngularArrow")
MachineReticulePanel = MachineReticulePanel or class(MachineHudPanel)
function MachineReticulePanel.init(A0_0, A1_1)
	MachineHudPanel.init(A0_0, A1_1)
	A0_0._parent_panel = A1_1
	A0_0._width = A0_0._parent_panel:width()
	A0_0._height = A0_0._parent_panel:height()
	A0_0._center_x = A0_0._width / 2
	A0_0._center_y = A0_0._height / 2
	A0_0._color = tweak_data.machine.hud.HIGHLIGHT_COLOR_TWEAK
	A0_0._reticule_panel = A0_0._parent_panel:panel({
		name = "reticule_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "center",
		halign = "center",
		layer = 100
	})
	A0_0._reticule_radius = 60
	A0_0._size_modifier = 1
	A0_0:_setup_reticule()
	A0_0:set_size_y(0)
end
function MachineReticulePanel.panel(A0_2)
	local L1_3
	L1_3 = A0_2._reticule_panel
	return L1_3
end
function MachineReticulePanel._setup_reticule(A0_4)
	local L1_5, L2_6
	A0_4._reticule_aim_circle = L1_5
	L1_5.right_top = L2_6
	L1_5(L2_6, 64 * A0_4._size_modifier, 64 * A0_4._size_modifier)
	L1_5(L2_6, A0_4._width / 2, A0_4._height / 2)
	L1_5.left_top = L2_6
	L1_5(L2_6, 64 * A0_4._size_modifier, 64 * A0_4._size_modifier)
	L1_5(L2_6, A0_4._width / 2, A0_4._height / 2)
	L1_5(L2_6, 270)
	L1_5.right_bottom = L2_6
	L1_5(L2_6, 64 * A0_4._size_modifier, 64 * A0_4._size_modifier)
	L1_5(L2_6, A0_4._width / 2, A0_4._height / 2)
	L1_5(L2_6, 90)
	L1_5.left_bottom = L2_6
	L1_5(L2_6, 64 * A0_4._size_modifier, 64 * A0_4._size_modifier)
	L1_5(L2_6, A0_4._width / 2, A0_4._height / 2)
	L1_5(L2_6, 180)
	for 