require("units/beings/player/new_gui/TeammateName")
TeammateNamePanel = TeammateNamePanel or class()
function TeammateNamePanel.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._width = A0_0._parent_panel:width()
	A0_0._height = A0_0._parent_panel:height()
	A0_0._user_viewport = A3_3
	A0_0._camera = A0_0._user_viewport:engine_camera()
	A0_0._teammate_name_panel = A0_0._parent_panel:panel({
		name = "teammate_name_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "grow",
		halign = "grow",
		layer = tweak_data.player.new_hud.teammate_name_panel.LAYER
	})
	A0_0._teammate_name_panel:set_lefttop(0, 0)
	A0_0._player_data.teammate_with_visible_names = {}
	A0_0._displayed_units = {}
	A0_0._t = 0
	A0_0._next_scan_time = 0
end
function TeammateNamePanel.panel(A0_4)
	local L1_5
	L1_5 = A0_4._teammate_name_panel
	return L1_5
end
function TeammateNamePanel.update(A0_6, A1_7)
	local L2_8, L3_9, L4_10, L5_11
	A0_6._t = L2_8
	if L2_8 > L3_9 then
		for L5_11, 