require("menu/2D/pages/Menu2DPageNormal")
require("menu/2D/Menu2DGameOverScreen.lua")
Menu2DPageGameOver = Menu2DPageGameOver or class(Menu2DPageNormal)
function Menu2DPageGameOver.init(A0_0, A1_1, A2_2)
	Menu2DPageNormal.init(A0_0, A1_1, A2_2)
	A0_0._screen = Menu2DGameOverScreen:new(A0_0._panel, A0_0)
end
function Menu2DPageGameOver.parse(A0_3, A1_4)
	Menu2DPageNormal.parse(A0_3, A1_4)
	A0_3._center_all_text = toboolean(A1_4:parameter("center_all_text"))
end
function Menu2DPageGameOver.update(A0_5, A1_6)
	Menu2DPageNormal.update(A0_5, A1_6)
end
function Menu2DPageGameOver.close(A0_7)
	Menu2DPageNormal.close(A0_7)
	A0_7._full_screen_panel = managers.menu:ingame_gui():full_screen_panel()
	A0_7._full_screen_panel:remove(A0_7._background_red)
	A0_7._full_screen_panel:remove(A0_7._background_black)
end
function Menu2DPageGameOver.open(A0_8, A1_9, A2_10)
	local L3_11, L4_12
	L3_11 = Menu2DPageNormal
	L3_11 = L3_11.open
	L4_12 = A0_8
	L3_11(L4_12, A1_9, A2_10)
	L3_11 = managers
	L3_11 = L3_11.menu
	L4_12 = L3_11
	L3_11 = L3_11.ingame_gui
	L3_11 = L3_11(L4_12)
	L4_12 = L3_11
	L3_11 = L3_11.full_screen_panel
	L3_11 = L3_11(L4_12)
	A0_8._full_screen_panel = L3_11
	L3_11 = Color
	L4_12 = 0.2
	L3_11 = L3_11(L4_12, 0, 0)
	L4_12 = A0_8._full_screen_panel
	L4_12 = L4_12.rect
	L4_12 = L4_12(L4_12, {
		color = L3_11:with_alpha(0.6),
		layer = 1,
		blend_mode = "normal"
	})
	A0_8._background_red = L4_12
	L4_12 = A0_8._full_screen_panel
	L4_12 = L4_12.rect
	L4_12 = L4_12(L4_12, {
		color = Color.black:with_alpha(0.4),
		layer = 2,
		blend_mode = "normal"
	})
	A0_8._background_black = L4_12
	L4_12 = A0_8._screen
	L4_12 = L4_12.slots
	L4_12 = L4_12(L4_12)
	for 