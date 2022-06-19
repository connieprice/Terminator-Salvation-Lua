require("units/beings/player/new_gui/ReticulePiece")
WeakspotsPanel = WeakspotsPanel or class()
function WeakspotsPanel.init(A0_0, A1_1, A2_2, A3_3)
	A0_0._parent_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = A2_2:player_data()
	A0_0._user_viewport = A3_3
	A0_0._camera = A0_0._user_viewport:engine_camera()
	A0_0._width = A1_1:width()
	A0_0._height = A1_1:height()
	A0_0._size_modifier = 1
	A0_0._weakspots = {}
	A0_0._weakspots_panel = A0_0._parent_panel:panel({
		name = "weakspots_panel",
		width = A0_0._width,
		height = A0_0._height,
		valign = "center",
		halign = "center"
	})
	A0_0._damage_listeners = {}
	A0_0._weakspot_color_interpolators = {}
end
function WeakspotsPanel.panel(A0_4)
	local L1_5
	L1_5 = A0_4._weakspots_panel
	return L1_5
end
function WeakspotsPanel.update(A0_6, A1_7)
	local L2_8, L3_9, L4_10, L5_11, L6_12, L7_13, L8_14, L9_15, L10_16, L11_17, L12_18, L13_19, L14_20, L15_21
	L2_8(L3_9, L4_10)
	for L5_11, L6_12 in L2_8(L3_9) do
		L7_13 = {}
		if L8_14 then
			if L8_14 then
				for L14_20, L15_21 in L11_17(L12_18) do
					A0_6:_draw_weakspot(L5_11, L15_21, L10_16, L6_12)
				end
				if not L11_17 then
					L11_17[L6_12] = L12_18
				end
			else
				L11_17(L12_18, L13_19)
			end
		else
			L8_14(L9_15, L10_16)
		end
		if L8_14 > 0 then
			for L11_17, L12_18 in L8_14(L9_15) do
				L13_19(L14_20, L15_21)
				if L13_19 then
					for 