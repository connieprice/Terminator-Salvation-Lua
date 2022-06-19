require("menu/2D/Menu2DPage")
if not Menu2DPageController then
	Menu2DPageController = class(Menu2DPage)
end
Menu2DPageController.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPage.init(l_1_0, l_1_1, l_1_2)
	l_1_0._root_panel = l_1_2
	l_1_0._layer = tweak_data.menu2d.layer_normal
	l_1_0._configuration = 1
	do
		local l_1_3 = {}
		 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_1_3("default_controls")
	end
	 -- WARNING: undefined locals caused missing assignments!
end

Menu2DPageController.update = function(l_2_0, l_2_1)
	Menu2DPage.update(l_2_0, l_2_1)
end

Menu2DPageController.input = function(l_3_0, l_3_1, l_3_2)
	if l_3_1.back then
		managers.menu2d:back()
		return 
	end
end

Menu2DPageController.confirm_mode = function(l_4_0)
	local l_4_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_4_1
end

Menu2DPageController.open = function(l_5_0, l_5_1, l_5_2)
	Menu2DPage.open(l_5_0, l_5_1, l_5_2, tweak_data.menu2d.layer_normal)
	l_5_0:_parse_xml()
	local l_5_3 = managers.save:profile()
	l_5_0._configuration = l_5_3.control_settings.configuration or 1
	local l_5_4 = nil
	if SystemInfo:platform() == "WIN32" or SystemInfo:platform() == "X360" then
		l_5_4 = "gui_menu_controller_360"
	else
		if SystemInfo:platform() == "PS3" then
			l_5_4 = "gui_menu_controller_ps3"
		end
	end
	local l_5_5, l_5_6 = l_5_0._root_panel:bitmap, l_5_0._root_panel
	local l_5_7 = {}
	l_5_7.texture = l_5_4
	l_5_7.x = 0
	l_5_7.y = 0
	l_5_7.blend_mode = "add"
	l_5_7.color = Color.white:with_alpha(0)
	l_5_7.layer = l_5_0._layer
	l_5_5 = l_5_5(l_5_6, l_5_7)
	l_5_0._controller = l_5_5
	l_5_5 = l_5_0._controller
	l_5_5, l_5_6 = l_5_5:set_center, l_5_5
	l_5_7 = l_5_0._root_panel
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_5_8, l_5_9 = .end
	l_5_5(l_5_6, l_5_7, l_5_8, l_5_9)
	l_5_0._texts, l_5_5 = l_5_5, {}
	l_5_5 = l_5_0._panel
	l_5_5, l_5_6 = l_5_5:width, l_5_5
	l_5_5 = l_5_5(l_5_6)
	l_5_5 = l_5_5 * 0.5
	l_5_0._center_x = l_5_5
	l_5_5 = l_5_0._panel
	l_5_5, l_5_6 = l_5_5:height, l_5_5
	l_5_5 = l_5_5(l_5_6)
	l_5_5 = l_5_5 * 0.5
	l_5_0._center_y = l_5_5
	l_5_5 = pairs
	l_5_6 = l_5_0._controller_texts
	l_5_5 = l_5_5(l_5_6)
	for l_5_8,l_5_9 in l_5_5 do
		l_5_0:_create_text(l_5_9.text_id, l_5_9.align, l_5_9.x, l_5_9.y)
	end
	l_5_0._bg = l_5_0._root_panel:rect({color = Color.black:with_alpha(0), layer = l_5_0._layer - 1})
	l_5_0:fade_in()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageController.fade_in = function(l_6_0)
	local l_6_5, l_6_6 = nil
	local l_6_4 = l_6_0:_fade_in
	l_6_4(l_6_0, l_6_0._bg, 0.5)
	l_6_4(l_6_0, l_6_0._controller)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	for i_0,i_1 in l_6_4 do
		l_6_0:_fade_in(i_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageController._parse_xml = function(l_7_0)
	local l_7_6, l_7_7, l_7_8, l_7_9 = nil
	l_7_0._controller_texts = {}
	local l_7_1 = "data/lib/menu/PadMappingCoordinates.xml"
	if File:exists(l_7_1) then
		local l_7_2 = File:parse_xml(l_7_1)
		for i_0 in l_7_2:children() do
			table.insert(l_7_0._controller_texts, {text_id = l_7_10:parameter("text_id"), align = l_7_10:parameter("align"), x = tonumber(l_7_10:parameter("x")), y = tonumber(l_7_10:parameter("y"))})
		end
	end
end

Menu2DPageController._fade_in = function(l_8_0, l_8_1, l_8_2)
	local l_8_3, l_8_4 = l_8_1:animate, l_8_1
	local l_8_5 = Menu2DAnimations.fade_in
	local l_8_6 = 0
	local l_8_7 = tweak_data.menu2d.animation.fade_out_page_name_time
	do
		l_8_3(l_8_4, l_8_5, l_8_6, l_8_7, l_8_2 or 1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageController.fade_out = function(l_9_0)
	local l_9_4, l_9_5, l_9_6, l_9_7 = nil
	l_9_0._anim_handle = l_9_0:_fade_out(l_9_0._bg)
	l_9_0._anim_handle = l_9_0:_fade_out(l_9_0._controller)
	for i_0,i_1 in pairs(l_9_0._texts) do
		l_9_0:_fade_out(i_1)
	end
end

Menu2DPageController._fade_out = function(l_10_0, l_10_1)
	local l_10_2, l_10_3 = l_10_1:animate, l_10_1
	local l_10_4 = Menu2DAnimations.fade_out
	local l_10_5 = 0
	local l_10_6 = tweak_data.menu2d.animation.fade_out_page_name_time
	local l_10_7 = 0
	return l_10_2(l_10_3, l_10_4, l_10_5, l_10_6, l_10_7)
end

Menu2DPageController._create_text = function(l_11_0, l_11_1, l_11_2, l_11_3, l_11_4)
	local l_11_5 = (managers.localization:text(l_11_1))
	local l_11_6, l_11_7 = nil, nil
	if SystemInfo:platform() ~= "WIN32" and managers.localization:exists(l_11_1 .. "_button") then
		l_11_6 = managers.localization:text(l_11_1 .. "_button")
	end
	local l_11_8, l_11_9 = l_11_0._panel:text, l_11_0._panel
	local l_11_10 = {}
	l_11_10.text = l_11_5
	l_11_10.font = "faith_font_22"
	l_11_10.font_scale = tweak_data.menu2d.controls.text_scale
	l_11_10.valign = "center"
	l_11_10.color = Color.white:with_alpha(0)
	l_11_10.layer = l_11_0._layer
	l_11_10.wrap = true
	l_11_10.word_wrap = true
	l_11_8 = l_11_8(l_11_9, l_11_10)
	if l_11_6 then
		l_11_9 = l_11_0._panel
		l_11_9, l_11_10 = l_11_9:text, l_11_9
		local l_11_11 = {}
		l_11_11.text = l_11_6
		l_11_11.font = "faith_font_22"
		l_11_11.font_scale = tweak_data.menu2d.controls.button_scale
		l_11_11.valign = "center"
		l_11_11.color = Color.white:with_alpha(0)
		l_11_11.layer = l_11_0._layer
		l_11_11.wrap = true
		l_11_11.word_wrap = true
		l_11_9 = l_11_9(l_11_10, l_11_11)
		l_11_7 = l_11_9
	end
	l_11_9, l_11_10 = l_11_8:text_rect, l_11_8
	l_11_9 = l_11_9(l_11_10)
	local l_11_12, l_11_13 = nil
	if l_11_2 == "right" then
		l_11_3 = l_11_3 - l_11_12
	elseif l_11_2 == "center" then
		l_11_3 = l_11_3 - l_11_12 / 2
	elseif l_11_6 then
		l_11_3 = l_11_3 + tweak_data.menu2d.controls.text_offset
	end
	l_11_8:set_x(l_11_0._center_x + (l_11_3))
	l_11_8:set_y(l_11_0._center_y + l_11_4)
	l_11_12 = l_11_0._panel:width() - l_11_8:x()
	l_11_8:set_width(l_11_12)
	table.insert(l_11_0._texts, l_11_8)
	if l_11_6 then
		local l_11_14, l_11_15, l_11_16, l_11_17, l_11_20, l_11_21 = l_11_7:text_rect()
		l_11_20, l_11_21 = l_11_7:set_x, l_11_7
		local l_11_25 = l_11_8:x() - l_11_16
		l_11_25 = l_11_25 - tweak_data.menu2d.controls.button_extra_space
		l_11_20(l_11_21, l_11_25)
		l_11_20, l_11_21 = l_11_7:set_y, l_11_7
		l_11_25 = l_11_0._center_y
		l_11_25 = l_11_25 + l_11_4
		l_11_25 = l_11_25 - 4
		l_11_20(l_11_21, l_11_25)
		l_11_20 = table
		l_11_20 = l_11_20.insert
		local l_11_22 = nil
		l_11_21 = l_11_0._texts
		local l_11_23 = nil
		l_11_25 = l_11_7
		local l_11_24 = nil
		l_11_20(l_11_21, l_11_25)
	end
	local l_11_18, l_11_19 = l_11_8:left, l_11_8
	return l_11_18(l_11_19)
end

Menu2DPageController.destroy = function(l_12_0)
	local l_12_4, l_12_5, l_12_6, l_12_7 = nil
	l_12_0._root_panel:remove(l_12_0._controller)
	for i_0,i_1 in pairs(l_12_0._texts) do
		l_12_0._root_panel:remove(i_1)
	end
	l_12_0._root_panel:remove(l_12_0._bg)
	l_12_0._texts = {}
	Menu2DPage.destroy(l_12_0)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageController.set_transition = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7, l_13_8 = nil
	Menu2DPage.set_transition(l_13_0, l_13_1)
	l_13_0._controller:stop()
	for i_0,i_1 in pairs(l_13_0._texts) do
		i_1:stop()
	end
	l_13_0._bg:stop()
	l_13_0:fade_out()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageController._transition = function(l_14_0)
	return l_14_0._transition_active
end

Menu2DPageController._transition_end = function(l_15_0)
	if l_15_0._anim_handle and managers.menu2d:animation_dead(l_15_0._anim_handle) then
		Menu2DPage._transition_end(l_15_0)
	end
end


