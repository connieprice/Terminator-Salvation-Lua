require("menu/2D/Menu2DPage")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
Menu2DPageLegal = Menu2DPageLegal or class(Menu2DPage)
function Menu2DPageLegal.init(A0_0, A1_1, A2_2)
	Menu2DPage.init(A0_0, A1_1, A2_2)
	A0_0._goto = A1_1:parameter("goto_page")
end
function Menu2DPageLegal.update(A0_3, A1_4)
	Menu2DPage.update(A0_3, A1_4)
	if A0_3._legal_animation and A0_3._legal_animation:update(A1_4) == true and A0_3._animation_done ~= nil then
		A0_3._animation_done = A0_3._legal_animation:update(A1_4)
	end
end
function Menu2DPageLegal.open(A0_5, A1_6, A2_7)
	local L3_8, L4_9, L5_10, L6_11, L7_12, L8_13
	L3_8 = "gui_legalinfo_screen_global"
	L4_9 = SystemInfo
	L5_10 = L4_9
	L4_9 = L4_9.platform
	L4_9 = L4_9(L5_10)
	if L4_9 == "X360" then
		L5_10 = XboxLive
		L6_11 = L5_10
		L5_10 = L5_10.game_region
		L5_10 = L5_10(L6_11)
	else
		if L5_10 ~= "north_america" then
			if L4_9 == "PS3" then
				L5_10 = PS3
				L6_11 = L5_10
				L5_10 = L5_10.get_region_id
				L5_10 = L5_10(L6_11)
			end
	end
	elseif L5_10 == 1 then
		L3_8 = "gui_legalinfo_screen"
	end
	L5_10 = A0_5._root_panel
	L6_11 = L5_10
	L5_10 = L5_10.panel
	L7_12 = {}
	L8_13 = tweak_data
	L8_13 = L8_13.menu2d
	L8_13 = L8_13.layer_legal
	L7_12.layer = L8_13
	L5_10 = L5_10(L6_11, L7_12)
	A0_5._panel = L5_10
	L5_10 = A0_5._panel
	L6_11 = L5_10
	L5_10 = L5_10.rect
	L7_12 = {}
	L8_13 = Color
	L8_13 = L8_13.black
	L8_13 = L8_13.with_alpha
	L8_13 = L8_13(L8_13, 1)
	L7_12.color = L8_13
	L7_12.layer = 1
	L5_10 = L5_10(L6_11, L7_12)
	A0_5._background = L5_10
	L5_10 = A0_5._panel
	L6_11 = L5_10
	L5_10 = L5_10.bitmap
	L7_12 = {}
	L7_12.texture = L3_8
	L7_12.blend_mode = "add"
	L8_13 = Color
	L8_13 = L8_13.white
	L8_13 = L8_13.with_alpha
	L8_13 = L8_13(L8_13, 0)
	L7_12.color = L8_13
	L8_13 = tweak_data
	L8_13 = L8_13.menu2d
	L8_13 = L8_13.layer_legal
	L7_12.layer = L8_13
	L5_10 = L5_10(L6_11, L7_12)
	A0_5._legal_page = L5_10
	L5_10 = A0_5._panel
	L6_11 = L5_10
	L5_10 = L5_10.width
	L5_10 = L5_10(L6_11)
	L5_10 = L5_10 / 2
	L6_11 = A0_5._panel
	L7_12 = L6_11
	L6_11 = L6_11.height
	L6_11 = L6_11(L7_12)
	L6_11 = L6_11 / 2
	L7_12 = A0_5._legal_page
	L8_13 = L7_12
	L7_12 = L7_12.texture_width
	L7_12 = L7_12(L8_13)
	L7_12 = L7_12 / 2
	L7_12 = L5_10 - L7_12
	L8_13 = A0_5._legal_page
	L8_13 = L8_13.texture_height
	L8_13 = L8_13(L8_13)
	L8_13 = L8_13 / 2
	L8_13 = L6_11 - L8_13
	A0_5._legal_page:set_x(L7_12)
	A0_5._legal_page:set_y(L8_13)
	A0_5._legal_animation = Menu2DFadeInAnimation:new(A0_5._legal_page, 0, 0.25, 1)
end
function Menu2DPageLegal.destroy(A0_14)
	A0_14._root_panel:remove(A0_14._background)
	A0_14._root_panel:remove(A0_14._panel)
end
function Menu2DPageLegal.set_transition(A0_15, A1_16)
	Menu2DPage.set_transition(A0_15, A1_16)
	if A1_16 then
		A0_15._legal_animation = Menu2DFadeOutAnimation:new(A0_15._legal_page, 0, 0.5, 0)
		A0_15._animation_done = false
	end
end
function Menu2DPageLegal._transition(A0_17)
	if A0_17._animation_done then
		return true
	end
end
