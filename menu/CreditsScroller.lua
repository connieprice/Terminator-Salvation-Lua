if not CreditsScrollerText then
	CreditsScrollerText = class()
end
if not CreditsScroller then
	CreditsScroller = class()
end
CreditsScroller.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._parent_panel = l_1_1
	local l_1_3 = 99999
	local l_1_4 = File:open(l_1_2, "r")
	local l_1_5 = Node.from_xml(l_1_4:read())
	local l_1_6 = l_1_1:width()
	l_1_0._panel_height = l_1_1:height()
	l_1_0._scroller_x = 0
	l_1_0._scroller_y = l_1_0._panel_height
	local l_1_7, l_1_8 = l_1_1:panel, l_1_1
	local l_1_9 = {}
	l_1_9.width = l_1_1:width()
	l_1_9.height = l_1_3
	l_1_9.halign = "grow"
	l_1_9.valign = "grow"
	l_1_7 = l_1_7(l_1_8, l_1_9)
	l_1_0._scroller = l_1_7
	l_1_7 = l_1_0._scroller
	l_1_7, l_1_8 = l_1_7:set_position, l_1_7
	l_1_9 = l_1_0._scroller_x
	l_1_7(l_1_8, l_1_9, l_1_0._scroller_y)
	l_1_7 = 15
	l_1_8 = l_1_0._scroller
	l_1_8, l_1_9 = l_1_8:panel, l_1_8
	local l_1_10 = {}
	l_1_10.y = 0
	l_1_10.halign = "left"
	l_1_10.height = l_1_3
	l_1_10.width = l_1_6 / 2 - l_1_7
	l_1_8 = l_1_8(l_1_9, l_1_10)
	l_1_0._left_column = l_1_8
	l_1_8 = l_1_0._scroller
	l_1_8, l_1_9 = l_1_8:panel, l_1_8
	l_1_8, l_1_10 = l_1_8(l_1_9, l_1_10), {y = 0, x = l_1_6 / 2 + l_1_7, halign = "right", height = l_1_3, width = l_1_6}
	l_1_0._right_column = l_1_8
	l_1_0._row = 0
	l_1_0._name_font_size = 30
	l_1_0._font = "faith_font_22"
	l_1_8, l_1_9 = l_1_0:construct_credits, l_1_0
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_8(l_1_9, l_1_10)
	l_1_8 = l_1_0._scroller
	l_1_8, l_1_9 = l_1_8:set_height, l_1_8
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_1_8(l_1_9, l_1_10)
	l_1_0.NORMAL_SPEED = 24
	l_1_8 = l_1_0.NORMAL_SPEED
	l_1_0._scroll_speed = l_1_8
	l_1_0.INPUT_SCROLL_ACCEL = 2
	l_1_8 = l_1_0.NORMAL_SPEED
	l_1_0._target_speed = l_1_8
	l_1_8 = managers
	l_1_8 = l_1_8.menu2d
	l_1_8 = l_1_8._components
	l_1_8 = l_1_8.root_panel
	l_1_0._fullscreen_panel = l_1_8
	l_1_8 = l_1_0._fullscreen_panel
	l_1_8, l_1_9 = l_1_8:panel, l_1_8
	l_1_8, l_1_10 = l_1_8(l_1_9, l_1_10), {valign = "grow", halign = "grow", layer = 99999}
	l_1_0._own_fullscreen_panel = l_1_8
	l_1_8 = l_1_0._own_fullscreen_panel
	l_1_8, l_1_9 = l_1_8:panel, l_1_8
	l_1_8, l_1_10 = l_1_8(l_1_9, l_1_10), {valign = "grow", halign = "grow"}
	l_1_0._safe_panel = l_1_8
	l_1_8 = managers
	l_1_8 = l_1_8.menu2d
	l_1_8 = l_1_8._components
	l_1_8 = l_1_8.root_panel
	l_1_8, l_1_9 = l_1_8:panel, l_1_8
	l_1_8 = l_1_8(l_1_9)
	l_1_0._black_rect_parent = l_1_8
	l_1_8 = l_1_0._black_rect_parent
	l_1_8, l_1_9 = l_1_8:rect, l_1_8
	l_1_8, l_1_10 = l_1_8(l_1_9, l_1_10), {color = Color(0.5, 0, 0, 0)}
	l_1_0._black_rect = l_1_8
	l_1_8 = l_1_0._safe_panel
	l_1_8, l_1_9 = l_1_8:height, l_1_8
	l_1_8 = l_1_8(l_1_9)
	l_1_9, l_1_10 = l_1_0:_draw_gradient, l_1_0
	l_1_9(l_1_10, 0, 50)
	l_1_9, l_1_10 = l_1_0:_draw_gradient, l_1_0
	l_1_9(l_1_10, l_1_8, l_1_8 - 50)
end

CreditsScroller._draw_gradient = function(l_2_0, l_2_1, l_2_2)
	local l_2_3 = l_2_0._safe_panel
	local l_2_4 = managers.menu:ingame_gui():safe_rect()
	local l_2_5 = math.sign(l_2_2 - l_2_1)
	local l_2_6 = (l_2_3:height() - l_2_4.h) / 2
	local l_2_7 = nil
	if l_2_5 > 0 then
		l_2_7 = l_2_1
	else
		l_2_7 = l_2_1 - l_2_6
	end
	l_2_1 = l_2_1 + l_2_6 * l_2_5
	l_2_2 = l_2_2 + l_2_6 * l_2_5
	local l_2_8 = l_2_3:width()
	local l_2_9, l_2_10 = l_2_3:rect, l_2_3
	local l_2_11 = {}
	l_2_11.x = 0
	l_2_11.y = l_2_7
	l_2_11.width = l_2_8
	l_2_11.height = l_2_6
	l_2_11.color = Color(1, 0, 0, 0)
	l_2_11.halign = "center"
	l_2_11.align = "center"
	l_2_9(l_2_10, l_2_11)
	l_2_9 = math
	l_2_9 = l_2_9.abs
	l_2_10 = l_2_2 - (l_2_1)
	l_2_9 = l_2_9(l_2_10)
	l_2_9 = 1 / l_2_9
	l_2_10 = 1
	l_2_11 = l_2_1
	for i = l_2_11, l_2_2, l_2_5 do
		local l_2_15, l_2_16 = l_2_3:rect, l_2_3
		local l_2_17 = {}
		l_2_17.x = 0
		l_2_17.y = l_2_14
		l_2_17.width = l_2_8
		l_2_17.height = 1
		l_2_17.color = Color(l_2_10, 0, 0, 0)
		l_2_17.halign = "center"
		l_2_17.align = "center"
		l_2_15(l_2_16, l_2_17)
		l_2_10 = l_2_10 - l_2_9
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CreditsScroller.destroy = function(l_3_0)
	l_3_0._parent_panel:remove(l_3_0._scroller)
	l_3_0._black_rect_parent:remove(l_3_0._black_rect)
	l_3_0._fullscreen_panel:remove(l_3_0._own_fullscreen_panel)
end

CreditsScroller.add_header = function(l_4_0, l_4_1)
	local l_4_2, l_4_3 = l_4_0._scroller:text, l_4_0._scroller
	local l_4_4 = {}
	l_4_4.font = "faith_font_44"
	l_4_4.font_size = 44
	l_4_4.color = Color(1, 1, 1, 1)
	l_4_4.halign = "center"
	l_4_4.align = "center"
	l_4_4.text = l_4_1
	l_4_2 = l_4_2(l_4_3, l_4_4)
	l_4_3, l_4_4 = l_4_2:set_y, l_4_2
	l_4_3(l_4_4, l_4_0._row)
	l_4_3 = l_4_0._row
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_4_3 = l_4_3 + l_4_4
	l_4_0._row = l_4_3
end

CreditsScroller.add_section = function(l_5_0, l_5_1)
	local l_5_2, l_5_3 = l_5_0._scroller:text, l_5_0._scroller
	local l_5_4 = {}
	l_5_4.font = l_5_0._font
	l_5_4.color = Color(1, 1, 1, 1)
	l_5_4.halign = "center"
	l_5_4.align = "center"
	l_5_4.text = l_5_1
	l_5_2 = l_5_2(l_5_3, l_5_4)
	l_5_3, l_5_4 = l_5_2:set_y, l_5_2
	l_5_3(l_5_4, l_5_0._row)
	l_5_3 = l_5_0._row
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_5_3 = l_5_3 + l_5_4
	l_5_0._row = l_5_3
end

CreditsScroller.add_single = function(l_6_0, l_6_1, l_6_2)
	if l_6_1 then
		local l_6_3, l_6_4 = l_6_0._left_column:text, l_6_0._left_column
		local l_6_5 = {}
		l_6_5.font = l_6_0._font
		l_6_5.font_scale = 0.8
		l_6_5.color = Color(0.6, 1, 1, 1)
		l_6_5.align = "right"
		l_6_5.text = l_6_1
		l_6_3 = l_6_3(l_6_4, l_6_5)
		l_6_4, l_6_5 = l_6_3:set_y, l_6_3
		l_6_4(l_6_5, l_6_0._row)
	end
	local l_6_6, l_6_7 = l_6_0._right_column:text, l_6_0._right_column
	local l_6_8 = {}
	l_6_8.font = l_6_0._font
	l_6_8.font_scale = 0.8
	l_6_8.color = Color(1, 1, 1, 1)
	l_6_8.align = "left"
	l_6_8.text = l_6_2
	l_6_6 = l_6_6(l_6_7, l_6_8)
	l_6_7, l_6_8 = l_6_6:set_y, l_6_6
	l_6_7(l_6_8, l_6_0._row)
	l_6_7 = l_6_0._row
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_6_7 = l_6_7 + l_6_8
	l_6_0._row = l_6_7
end

CreditsScroller.add_spacing = function(l_7_0, l_7_1)
	l_7_0._row = l_7_0._row + l_7_1
end

CreditsScroller.add_group = function(l_8_0, l_8_1, l_8_2)
	local l_8_6, l_8_7 = nil
	local l_8_3 = l_8_2
	for i_0 in l_8_3 do
		assert(l_8_8:name() == "name")
		l_8_0:add_single(l_8_1, l_8_8:parameter("text"))
		l_8_1 = nil
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CreditsScroller.add_vgroup_title = function(l_9_0, l_9_1)
	local l_9_2, l_9_3 = l_9_0._scroller:text, l_9_0._scroller
	local l_9_4 = {}
	l_9_4.font = l_9_0._font
	l_9_4.font_scale = 0.8
	l_9_4.color = Color(0.6, 1, 1, 1)
	l_9_4.halign = "center"
	l_9_4.align = "center"
	l_9_4.text = l_9_1
	l_9_2 = l_9_2(l_9_3, l_9_4)
	l_9_3, l_9_4 = l_9_2:set_y, l_9_2
	l_9_3(l_9_4, l_9_0._row)
	l_9_3 = l_9_0._row
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_9_3 = l_9_3 + l_9_4
	l_9_0._row = l_9_3
end

CreditsScroller.add_vgroup_name = function(l_10_0, l_10_1)
	local l_10_2, l_10_3 = l_10_0._scroller:text, l_10_0._scroller
	local l_10_4 = {}
	l_10_4.font = l_10_0._font
	l_10_4.font_scale = 0.8
	l_10_4.color = Color(1, 1, 1, 1)
	l_10_4.halign = "center"
	l_10_4.align = "center"
	l_10_4.text = l_10_1
	l_10_2 = l_10_2(l_10_3, l_10_4)
	l_10_3, l_10_4 = l_10_2:set_y, l_10_2
	l_10_3(l_10_4, l_10_0._row)
	l_10_3 = l_10_0._row
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_10_3 = l_10_3 + l_10_4
	l_10_0._row = l_10_3
end

CreditsScroller.add_vgroup = function(l_11_0, l_11_1, l_11_2)
	local l_11_6, l_11_7, l_11_8 = nil
	if l_11_1 ~= "" then
		l_11_0:add_vgroup_title(l_11_1)
	end
	local l_11_3 = l_11_2
	for i_0 in l_11_3 do
		assert(l_11_9:name() == "name" or l_11_9:name() == "text")
		l_11_0:add_vgroup_name(l_11_9:parameter("text"))
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CreditsScroller.add_bitmap = function(l_12_0, l_12_1)
	local l_12_2, l_12_3 = l_12_0._scroller:bitmap, l_12_0._scroller
	local l_12_4 = {}
	l_12_4.y = l_12_0._row
	l_12_4.texture = l_12_1
	l_12_4.halign = "center"
	l_12_2 = l_12_2(l_12_3, l_12_4)
	l_12_3 = l_12_0._row
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_12_3 = l_12_3 + l_12_4
	l_12_0._row = l_12_3
	 -- DECOMPILER ERROR: Overwrote pending register.

	l_12_3 = l_12_2:set_center_x
	l_12_3(l_12_4, l_12_0._scroller:center())
end

CreditsScroller.header = function(l_13_0, l_13_1, l_13_2)
	l_13_0:add_spacing(40)
	l_13_0:add_stellan_line()
	l_13_0:add_spacing(50)
	l_13_0:add_header(l_13_1)
	l_13_0:add_spacing(15)
	l_13_0:construct_credits(l_13_2)
end

CreditsScroller.add_stellan_line = function(l_14_0)
	local l_14_1 = 350
	local l_14_2, l_14_3 = l_14_0._scroller:rect, l_14_0._scroller
	local l_14_4 = {}
	l_14_4.x = l_14_0._scroller:center() - l_14_1 * 0.5
	l_14_4.y = l_14_0._row
	l_14_4.width = l_14_1
	l_14_4.height = 2
	l_14_4.color = Color(0.2, 1, 1, 1)
	l_14_4.halign = "center"
	l_14_4.align = "center"
	l_14_2 = l_14_2(l_14_3, l_14_4)
	l_14_3 = l_14_0._row
	l_14_3 = l_14_3 + 2
	l_14_0._row = l_14_3
end

CreditsScroller.section = function(l_15_0, l_15_1, l_15_2)
	l_15_0:add_spacing(50)
	l_15_0:add_section(l_15_1)
	l_15_0:add_spacing(10)
	l_15_0:construct_credits(l_15_2)
end

CreditsScroller.group = function(l_16_0, l_16_1, l_16_2)
	l_16_0:add_group(l_16_1, l_16_2)
	l_16_0:add_spacing(20)
end

CreditsScroller.vgroup = function(l_17_0, l_17_1, l_17_2)
	l_17_0:add_spacing(5)
	l_17_0:add_vgroup(l_17_1, l_17_2)
	l_17_0:add_spacing(10)
end

CreditsScroller.single = function(l_18_0, l_18_1, l_18_2)
	l_18_0:add_single(l_18_1, l_18_2)
	l_18_0:add_spacing(25)
end

CreditsScroller.bitmap = function(l_19_0, l_19_1)
	l_19_0:add_bitmap(l_19_1)
end

CreditsScroller.text = function(l_20_0, l_20_1)
	l_20_0:add_vgroup_name(l_20_1)
	l_20_0:add_spacing(5)
end

CreditsScroller.construct_credits = function(l_21_0, l_21_1)
	local l_21_5, l_21_6, l_21_7, l_21_8, l_21_9, l_21_10, l_21_11, l_21_12, l_21_13, l_21_14, l_21_15, l_21_16, l_21_17, l_21_18, l_21_19, l_21_20, l_21_21, l_21_22, l_21_23, l_21_24, l_21_25, l_21_26, l_21_27, l_21_28, l_21_29, l_21_30, l_21_31, l_21_32 = nil
	local l_21_2 = l_21_1
	for i_0 in l_21_2 do
		if i_0:name() == "header" then
			l_21_0:header(i_0:parameter("text"), i_0:children())
		else
			if i_0:name() == "section" then
				l_21_0:section(i_0:parameter("text"), i_0:children())
			end
		else
			if i_0:name() == "group" then
				l_21_0:group(i_0:parameter("title"), i_0:children())
			end
		else
			if i_0:name() == "vgroup" then
				l_21_0:vgroup(i_0:parameter("title"), i_0:children())
			end
		else
			if i_0:name() == "single" then
				l_21_0:single(i_0:parameter("title"), i_0:parameter("name"))
			end
		else
			if i_0:name() == "bitmap" then
				l_21_0:bitmap(i_0:parameter("texture"))
			end
		else
			if i_0:name() == "text" then
				l_21_0:text(i_0:parameter("text"))
			end
		else
			error("Unknown node:" .. i_0:name())
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CreditsScroller.input_update = function(l_22_0, l_22_1)
	if math.abs(l_22_1) > 0.1 then
		local l_22_2 = 1
		if Application:debug_build() then
			l_22_2 = 30
		end
		l_22_0._target_speed = l_22_0.NORMAL_SPEED + l_22_1 * l_22_0.NORMAL_SPEED * l_22_0.INPUT_SCROLL_ACCEL * l_22_2
	else
		l_22_0._target_speed = l_22_0.NORMAL_SPEED
	end
end

CreditsScroller.update = function(l_23_0, l_23_1)
	l_23_0._scroller:set_position(l_23_0._scroller_x, l_23_0._scroller_y)
	l_23_0._scroll_speed = l_23_0._scroll_speed + (l_23_0._target_speed - l_23_0._scroll_speed) * l_23_1
	l_23_0._scroller_y = l_23_0._scroller_y - l_23_0._scroll_speed * l_23_1
	l_23_0._scroller_y = math.min(l_23_0._scroller_y, l_23_0._panel_height)
end

CreditsScroller.is_done = function(l_24_0)
	return l_24_0._scroller_y < -l_24_0._scroller:height() or l_24_0._panel_height < l_24_0._scroller_y
end


