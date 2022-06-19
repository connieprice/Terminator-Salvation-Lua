CreditsScrollerText = CreditsScrollerText or class()
CreditsScroller = CreditsScroller or class()
function CreditsScroller.init(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5, L6_6, L7_7, L8_8
	A0_0._parent_panel = A1_1
	L3_3 = 99999
	L4_4 = File
	L5_5 = L4_4
	L4_4 = L4_4.open
	L6_6 = A2_2
	L7_7 = "r"
	L4_4 = L4_4(L5_5, L6_6, L7_7)
	L5_5 = Node
	L5_5 = L5_5.from_xml
	L7_7 = L4_4
	L6_6 = L4_4.read
	L8_8 = L6_6(L7_7)
	L5_5 = L5_5(L6_6, L7_7, L8_8, L6_6(L7_7))
	L7_7 = A1_1
	L6_6 = A1_1.width
	L6_6 = L6_6(L7_7)
	L8_8 = A1_1
	L7_7 = A1_1.height
	L7_7 = L7_7(L8_8)
	A0_0._panel_height = L7_7
	A0_0._scroller_x = 0
	L7_7 = A0_0._panel_height
	A0_0._scroller_y = L7_7
	L8_8 = A1_1
	L7_7 = A1_1.panel
	L7_7 = L7_7(L8_8, {
		width = A1_1:width(),
		height = L3_3,
		halign = "grow",
		valign = "grow"
	})
	A0_0._scroller = L7_7
	L7_7 = A0_0._scroller
	L8_8 = L7_7
	L7_7 = L7_7.set_position
	L7_7(L8_8, A0_0._scroller_x, A0_0._scroller_y)
	L7_7 = 15
	L8_8 = A0_0._scroller
	L8_8 = L8_8.panel
	L8_8 = L8_8(L8_8, {
		y = 0,
		halign = "left",
		height = L3_3,
		width = L6_6 / 2 - L7_7
	})
	A0_0._left_column = L8_8
	L8_8 = A0_0._scroller
	L8_8 = L8_8.panel
	L8_8 = L8_8(L8_8, {
		y = 0,
		x = L6_6 / 2 + L7_7,
		halign = "right",
		height = L3_3,
		width = L6_6
	})
	A0_0._right_column = L8_8
	A0_0._row = 0
	A0_0._name_font_size = 30
	A0_0._font = "faith_font_22"
	L8_8 = A0_0.construct_credits
	L8_8(A0_0, L5_5:children())
	L8_8 = A0_0._scroller
	L8_8 = L8_8.set_height
	L8_8(L8_8, A0_0._row)
	A0_0.NORMAL_SPEED = 24
	L8_8 = A0_0.NORMAL_SPEED
	A0_0._scroll_speed = L8_8
	A0_0.INPUT_SCROLL_ACCEL = 2
	L8_8 = A0_0.NORMAL_SPEED
	A0_0._target_speed = L8_8
	L8_8 = managers
	L8_8 = L8_8.menu2d
	L8_8 = L8_8._components
	L8_8 = L8_8.root_panel
	A0_0._fullscreen_panel = L8_8
	L8_8 = A0_0._fullscreen_panel
	L8_8 = L8_8.panel
	L8_8 = L8_8(L8_8, {
		valign = "grow",
		halign = "grow",
		layer = 99999
	})
	A0_0._own_fullscreen_panel = L8_8
	L8_8 = A0_0._own_fullscreen_panel
	L8_8 = L8_8.panel
	L8_8 = L8_8(L8_8, {valign = "grow", halign = "grow"})
	A0_0._safe_panel = L8_8
	L8_8 = managers
	L8_8 = L8_8.menu2d
	L8_8 = L8_8._components
	L8_8 = L8_8.root_panel
	L8_8 = L8_8.panel
	L8_8 = L8_8(L8_8)
	A0_0._black_rect_parent = L8_8
	L8_8 = A0_0._black_rect_parent
	L8_8 = L8_8.rect
	L8_8 = L8_8(L8_8, {
		color = Color(0.5, 0, 0, 0)
	})
	A0_0._black_rect = L8_8
	L8_8 = A0_0._safe_panel
	L8_8 = L8_8.height
	L8_8 = L8_8(L8_8)
	A0_0:_draw_gradient(0, 50)
	A0_0:_draw_gradient(L8_8, L8_8 - 50)
end
function CreditsScroller._draw_gradient(A0_9, A1_10, A2_11)
	local L3_12, L4_13, L5_14, L6_15, L7_16, L8_17, L9_18, L10_19
	L3_12 = A0_9._safe_panel
	L4_13 = managers
	L4_13 = L4_13.menu
	L5_14 = L4_13
	L4_13 = L4_13.ingame_gui
	L4_13 = L4_13(L5_14)
	L5_14 = L4_13
	L4_13 = L4_13.safe_rect
	L4_13 = L4_13(L5_14)
	L5_14 = math
	L5_14 = L5_14.sign
	L6_15 = A2_11 - A1_10
	L5_14 = L5_14(L6_15)
	L7_16 = L3_12
	L6_15 = L3_12.height
	L6_15 = L6_15(L7_16)
	L7_16 = L4_13.h
	L6_15 = L6_15 - L7_16
	L6_15 = L6_15 / 2
	L7_16 = nil
	if L5_14 > 0 then
		L7_16 = A1_10
	else
		L7_16 = A1_10 - L6_15
	end
	L8_17 = L6_15 * L5_14
	A1_10 = A1_10 + L8_17
	L8_17 = L6_15 * L5_14
	A2_11 = A2_11 + L8_17
	L9_18 = L3_12
	L8_17 = L3_12.width
	L8_17 = L8_17(L9_18)
	L10_19 = L3_12
	L9_18 = L3_12.rect
	L9_18(L10_19, {
		x = 0,
		y = L7_16,
		width = L8_17,
		height = L6_15,
		color = Color(1, 0, 0, 0),
		halign = "center",
		align = "center"
	})
	L9_18 = math
	L9_18 = L9_18.abs
	L10_19 = A2_11 - A1_10
	L9_18 = L9_18(L10_19)
	L9_18 = 1 / L9_18
	L10_19 = 1
	for _FORV_14_ = A1_10, A2_11, L5_14 do
		L3_12:rect({
			x = 0,
			y = _FORV_14_,
			width = L8_17,
			height = 1,
			color = Color(L10_19, 0, 0, 0),
			halign = "center",
			align = "center"
		})
		L10_19 = L10_19 - L9_18
	end
end
function CreditsScroller.destroy(A0_20)
	A0_20._parent_panel:remove(A0_20._scroller)
	A0_20._black_rect_parent:remove(A0_20._black_rect)
	A0_20._fullscreen_panel:remove(A0_20._own_fullscreen_panel)
end
function CreditsScroller.add_header(A0_21, A1_22)
	A0_21._scroller:text({
		font = "faith_font_44",
		font_size = 44,
		color = Color(1, 1, 1, 1),
		halign = "center",
		align = "center",
		text = A1_22
	}):set_y(A0_21._row)
	A0_21._row = A0_21._row + A0_21._scroller:text({
		font = "faith_font_44",
		font_size = 44,
		color = Color(1, 1, 1, 1),
		halign = "center",
		align = "center",
		text = A1_22
	}):line_height()
end
function CreditsScroller.add_section(A0_23, A1_24)
	A0_23._scroller:text({
		font = A0_23._font,
		color = Color(1, 1, 1, 1),
		halign = "center",
		align = "center",
		text = A1_24
	}):set_y(A0_23._row)
	A0_23._row = A0_23._row + A0_23._scroller:text({
		font = A0_23._font,
		color = Color(1, 1, 1, 1),
		halign = "center",
		align = "center",
		text = A1_24
	}):line_height()
end
function CreditsScroller.add_single(A0_25, A1_26, A2_27)
	if A1_26 then
		A0_25._left_column:text({
			font = A0_25._font,
			font_scale = 0.8,
			color = Color(0.6, 1, 1, 1),
			align = "right",
			text = A1_26
		}):set_y(A0_25._row)
	end
	A0_25._right_column:text({
		font = A0_25._font,
		font_scale = 0.8,
		color = Color(1, 1, 1, 1),
		align = "left",
		text = A2_27
	}):set_y(A0_25._row)
	A0_25._row = A0_25._row + A0_25._right_column:text({
		font = A0_25._font,
		font_scale = 0.8,
		color = Color(1, 1, 1, 1),
		align = "left",
		text = A2_27
	}):line_height()
end
function CreditsScroller.add_spacing(A0_28, A1_29)
	local L2_30
	L2_30 = A0_28._row
	L2_30 = L2_30 + A1_29
	A0_28._row = L2_30
end
function CreditsScroller.add_group(A0_31, A1_32, A2_33)
	local L3_34, L4_35, L5_36, L6_37
	for L6_37 in A2_33, nil, nil do
		assert(L6_37:name() == "name")
		A0_31:add_single(A1_32, L6_37:parameter("text"))
		A1_32 = nil
	end
end
function CreditsScroller.add_vgroup_title(A0_38, A1_39)
	A0_38._scroller:text({
		font = A0_38._font,
		font_scale = 0.8,
		color = Color(0.6, 1, 1, 1),
		halign = "center",
		align = "center",
		text = A1_39
	}):set_y(A0_38._row)
	A0_38._row = A0_38._row + A0_38._scroller:text({
		font = A0_38._font,
		font_scale = 0.8,
		color = Color(0.6, 1, 1, 1),
		halign = "center",
		align = "center",
		text = A1_39
	}):line_height()
end
function CreditsScroller.add_vgroup_name(A0_40, A1_41)
	A0_40._scroller:text({
		font = A0_40._font,
		font_scale = 0.8,
		color = Color(1, 1, 1, 1),
		halign = "center",
		align = "center",
		text = A1_41
	}):set_y(A0_40._row)
	A0_40._row = A0_40._row + A0_40._scroller:text({
		font = A0_40._font,
		font_scale = 0.8,
		color = Color(1, 1, 1, 1),
		halign = "center",
		align = "center",
		text = A1_41
	}):line_height()
end
function CreditsScroller.add_vgroup(A0_42, A1_43, A2_44)
	if A1_43 ~= "" then
		A0_42:add_vgroup_title(A1_43)
	end
	for 