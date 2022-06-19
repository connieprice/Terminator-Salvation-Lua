require("units/beings/player/new_gui/ReticulePiece")
require("units/beings/player/new_gui/HudPanel")
ReticulePanel = ReticulePanel or class(HudPanel)
function ReticulePanel.init(A0_0, A1_1, A2_2)
	HudPanel.init(A0_0, false)
	A0_0:set_mid_frequency_update(0.06666667)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._panel = A0_0._parent_panel:panel({
		name = "reticule_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "center",
		halign = "center"
	})
	A0_0._reticule_pieces = {}
	A0_0:use_circle_reticule()
	A0_0:set_alpha(0)
end
function ReticulePanel.panel(A0_3)
	local L1_4
	L1_4 = A0_3._panel
	return L1_4
end
function ReticulePanel.use_circle_reticule(A0_5)
	if A0_5._reticule_type ~= "circle_reticule" or A0_5._on_rail ~= A0_5._player_data.on_rail_vehicle then
		A0_5._reticule_type = "circle_reticule"
		A0_5._on_rail = A0_5._player_data.on_rail_vehicle
		for 