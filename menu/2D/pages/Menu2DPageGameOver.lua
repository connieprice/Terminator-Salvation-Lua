require("menu/2D/pages/Menu2DPageNormal")
require("menu/2D/Menu2DGameOverScreen.lua")
if not Menu2DPageGameOver then
	Menu2DPageGameOver = class(Menu2DPageNormal)
end
Menu2DPageGameOver.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPageNormal.init(l_1_0, l_1_1, l_1_2)
	l_1_0._screen = Menu2DGameOverScreen:new(l_1_0._panel, l_1_0)
end

Menu2DPageGameOver.parse = function(l_2_0, l_2_1)
	Menu2DPageNormal.parse(l_2_0, l_2_1)
	l_2_0._center_all_text = toboolean(l_2_1:parameter("center_all_text"))
end

Menu2DPageGameOver.update = function(l_3_0, l_3_1)
	Menu2DPageNormal.update(l_3_0, l_3_1)
end

Menu2DPageGameOver.close = function(l_4_0)
	Menu2DPageNormal.close(l_4_0)
	l_4_0._full_screen_panel = managers.menu:ingame_gui():full_screen_panel()
	l_4_0._full_screen_panel:remove(l_4_0._background_red)
	l_4_0._full_screen_panel:remove(l_4_0._background_black)
end

Menu2DPageGameOver.open = function(l_5_0, l_5_1, l_5_2)
	Menu2DPageNormal.open(l_5_0, l_5_1, l_5_2)
	l_5_0._full_screen_panel = managers.menu:ingame_gui():full_screen_panel()
	local l_5_3 = Color(0.2, 0, 0)
	local l_5_4, l_5_5 = l_5_0._full_screen_panel:rect, l_5_0._full_screen_panel
	local l_5_6 = {}
	l_5_6.color = l_5_3:with_alpha(0.6)
	l_5_6.layer = 1
	l_5_6.blend_mode = "normal"
	l_5_4 = l_5_4(l_5_5, l_5_6)
	l_5_0._background_red = l_5_4
	l_5_4 = l_5_0._full_screen_panel
	l_5_4, l_5_5 = l_5_4:rect, l_5_4
	local l_5_8 = Color.black:with_alpha
	local l_5_9 = Color.black
	l_5_8 = l_5_8(l_5_9, 0.4)
	l_5_4, l_5_6 = l_5_4(l_5_5, l_5_6), {color = l_5_8, layer = 2, blend_mode = "normal"}
	l_5_0._background_black = l_5_4
	l_5_4 = l_5_0._screen
	l_5_4, l_5_5 = l_5_4:slots, l_5_4
	l_5_4 = l_5_4(l_5_5)
	l_5_5 = pairs
	l_5_6 = l_5_4
	l_5_5 = l_5_5(l_5_6)
	for l_5_9,i_1 in l_5_5 do
		l_5_7:disable_selection_bar()
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


