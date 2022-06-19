require("units/beings/player/new_gui/HudPanel")
require("units/beings/player/new_gui/NextCoverIndicatorIcon")
NextCoverIndicatorPanel = NextCoverIndicatorPanel or class(HudPanel)
function NextCoverIndicatorPanel.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4, L5_5, L6_6, L7_7
	L4_4(L5_5, L6_6)
	A0_0._safe_panel = A1_1
	A0_0._player_unit = A2_2
	A0_0._player_data = L4_4
	A0_0._width = L4_4
	A0_0._height = L4_4
	L6_6.name = "next_cover_indicator_panel"
	L7_7 = A0_0._width
	L6_6.width = L7_7
	L7_7 = A0_0._height
	L6_6.height = L7_7
	L6_6.valign = "center"
	L6_6.halign = "center"
	A0_0._panel = L4_4
	A0_0._next_cover_indicator_icons = L4_4
	for L7_7 = 1, 5 do
		A0_0._next_cover_indicator_icons[L7_7] = NextCoverIndicatorIcon:new(A0_0._panel, L7_7)
	end
	L7_7 = tweak_data
	L7_7 = L7_7.player
	L7_7 = L7_7.new_hud
	L7_7 = L7_7.next_cover_indicator_panel
	L7_7 = L7_7.FADE_SPEED
	A0_0._alpha_interpolator = L4_4
	L4_4(L5_5, L6_6)
	L4_4(L5_5, L6_6)
end
function NextCoverIndicatorPanel.panel(A0_8)
	local L1_9
	L1_9 = A0_8._panel
	return L1_9
end
function NextCoverIndicatorPanel.show(A0_10)
	A0_10._alpha_interpolator:set_target(1)
end
function NextCoverIndicatorPanel.hide(A0_11)
	local L1_12, L2_13, L3_14, L4_15
	L1_12(L2_13, L3_14)
	if not L1_12 then
		for L4_15, 