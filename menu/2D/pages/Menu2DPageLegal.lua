require("menu/2D/Menu2DPage")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
if not Menu2DPageLegal then
	Menu2DPageLegal = class(Menu2DPage)
end
Menu2DPageLegal.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPage.init(l_1_0, l_1_1, l_1_2)
	l_1_0._goto = l_1_1:parameter("goto_page")
end

Menu2DPageLegal.update = function(l_2_0, l_2_1)
	Menu2DPage.update(l_2_0, l_2_1)
	if l_2_0._legal_animation then
		local l_2_2 = l_2_0._legal_animation:update(l_2_1)
	if l_2_2 == true then
		end
	if l_2_0._animation_done ~= nil then
		end
		l_2_0._animation_done = l_2_2
	end
end

Menu2DPageLegal.open = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = "gui_legalinfo_screen_global"
	local l_3_4 = SystemInfo:platform()
	if (l_3_4 == "X360" and XboxLive:game_region() == "north_america") or l_3_4 == "PS3" and PS3:get_region_id() == 1 then
		l_3_3 = "gui_legalinfo_screen"
	end
	local l_3_5, l_3_6 = l_3_0._root_panel:panel, l_3_0._root_panel
	local l_3_7 = {}
	l_3_7.layer = tweak_data.menu2d.layer_legal
	l_3_5 = l_3_5(l_3_6, l_3_7)
	l_3_0._panel = l_3_5
	l_3_5 = l_3_0._panel
	l_3_5, l_3_6 = l_3_5:rect, l_3_5
	l_3_5, l_3_7 = l_3_5(l_3_6, l_3_7), {color = Color.black:with_alpha(1), layer = 1}
	l_3_0._background = l_3_5
	l_3_5 = l_3_0._panel
	l_3_5, l_3_6 = l_3_5:bitmap, l_3_5
	l_3_5, l_3_7 = l_3_5(l_3_6, l_3_7), {texture = l_3_3, blend_mode = "add", color = Color.white:with_alpha(0), layer = tweak_data.menu2d.layer_legal}
	l_3_0._legal_page = l_3_5
	l_3_5 = l_3_0._panel
	l_3_5, l_3_6 = l_3_5:width, l_3_5
	l_3_5 = l_3_5(l_3_6)
	l_3_5 = l_3_5 / 2
	l_3_6 = l_3_0._panel
	l_3_6, l_3_7 = l_3_6:height, l_3_6
	l_3_6 = l_3_6(l_3_7)
	l_3_6 = l_3_6 / 2
	l_3_7 = l_3_0._legal_page
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_3_8 = l_3_6 - l_3_0._legal_page:texture_height() / 2
	l_3_0._legal_page:set_x(l_3_7)
	l_3_0._legal_page:set_y(l_3_8)
	l_3_0._legal_animation = Menu2DFadeInAnimation:new(l_3_0._legal_page, 0, 0.25, 1)
end

Menu2DPageLegal.destroy = function(l_4_0)
	l_4_0._root_panel:remove(l_4_0._background)
	l_4_0._root_panel:remove(l_4_0._panel)
end

Menu2DPageLegal.set_transition = function(l_5_0, l_5_1)
	Menu2DPage.set_transition(l_5_0, l_5_1)
	if l_5_1 then
		l_5_0._legal_animation = Menu2DFadeOutAnimation:new(l_5_0._legal_page, 0, 0.5, 0)
		l_5_0._animation_done = false
	end
end

Menu2DPageLegal._transition = function(l_6_0)
	if l_6_0._animation_done then
		return true
	end
end


