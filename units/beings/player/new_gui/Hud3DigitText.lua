Hud3DigitText = Hud3DigitText or class()
function Hud3DigitText.init(A0_0, A1_1)
	A0_0._gui_text = A1_1
	A0_0._red_alpha_interpolator = Interpolator:new(0, tweak_data.player.new_hud.ammo_panel.RED_FADE_IN_SPEED)
	A0_0._gui_text_color = A0_0._gui_text:color()
	A0_0:set_red_alpha(0)
end
function Hud3DigitText.instant_red(A0_2)
	A0_2._red_alpha_interpolator:set_target(1)
	A0_2._red_alpha_interpolator:set_value(1)
end
function Hud3DigitText.show_red(A0_3)
	A0_3._red_alpha_interpolator:set_target(1)
	A0_3._red_alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.RED_FADE_IN_SPEED)
end
function Hud3DigitText.hide_red(A0_4)
	A0_4._red_alpha_interpolator:set_target(0)
	A0_4._red_alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.RED_FADE_OUT_SPEED)
end
function Hud3DigitText.instant_hide_red(A0_5)
	A0_5._red_alpha_interpolator:set_target(0)
	A0_5._red_alpha_interpolator:set_value(0)
	A0_5._red_alpha_interpolator:set_speed(tweak_data.player.new_hud.ammo_panel.RED_FADE_OUT_SPEED)
end
function Hud3DigitText.set_red_alpha(A0_6, A1_7)
	local L2_8, L3_9, L4_10, L5_11
	L2_8 = A0_6._red_alpha
	if L2_8 then
		L2_8 = A0_6._red_alpha
		if L2_8 == A1_7 then
			return
		end
	end
	A0_6._red_alpha = A1_7
	L2_8 = tweak_data
	L2_8 = L2_8.player
	L2_8 = L2_8.new_hud
	L2_8 = L2_8.health_panel
	L2_8 = L2_8.RED_HEALTH_RGB
	L3_9 = L2_8.red
	L3_9 = 1 - L3_9
	L3_9 = L3_9 * A1_7
	L3_9 = 1 - L3_9
	L4_10 = L2_8.green
	L4_10 = 1 - L4_10
	L4_10 = L4_10 * A1_7
	L4_10 = 1 - L4_10
	L5_11 = L2_8.blue
	L5_11 = 1 - L5_11
	L5_11 = L5_11 * A1_7
	L5_11 = 1 - L5_11
	A0_6._current_color = Color(L3_9, L4_10, L5_11)
	A0_6._gui_text:set_color((A0_6._gui_text_color * A0_6._current_color):with_alpha(A0_6._alpha))
	A0_6:_update_alpha()
end
function Hud3DigitText.update(A0_12, A1_13)
	local L2_14
	L2_14 = A0_12._red_alpha_interpolator
	L2_14 = L2_14.update
	L2_14(L2_14, A1_13)
	L2_14 = A0_12._red_alpha_interpolator
	L2_14 = L2_14.value
	L2_14 = L2_14(L2_14)
	A0_12:set_red_alpha(L2_14)
end
function Hud3DigitText.set_text(A0_15, A1_16)
	local L2_17
	L2_17 = A0_15._parse
	L2_17 = L2_17(A0_15, A1_16)
	if A0_15._text == L2_17 then
		return
	end
	A0_15._text = L2_17
	A0_15._gui_text:set_text(L2_17)
	A0_15:_update_alpha()
end
function Hud3DigitText._parse(A0_18, A1_19)
	local L2_20
	L2_20 = "000"
	L2_20 = L2_20 .. A1_19
	L2_20 = L2_20:sub(-3)
	return L2_20
end
function Hud3DigitText.set_alpha(A0_21, A1_22)
	A0_21._alpha = A1_22
	A0_21:_update_alpha()
end
function Hud3DigitText._update_alpha(A0_23)
	local L1_24, L2_25, L3_26, L4_27
	L1_24 = A0_23._alpha
	L1_24 = L1_24 or 0
	L2_25 = 0
	L3_26 = A0_23._gui_text
	L4_27 = L3_26
	L3_26 = L3_26.color
	L3_26 = L3_26(L4_27)
	L4_27 = L3_26
	L3_26 = L3_26.with_alpha
	L3_26 = L3_26(L4_27, 0.5 * L1_24)
	L4_27 = A0_23._gui_text
	L4_27 = L4_27.color
	L4_27 = L4_27(L4_27)
	L4_27 = L4_27.with_alpha
	L4_27 = L4_27(L4_27, L1_24)
	if tonumber(A0_23._text) and tonumber(A0_23._text) == 0 then
		L2_25 = 3
	elseif tonumber(A0_23._text) and tonumber(A0_23._text) < 10 then
		L2_25 = 2
	elseif tonumber(A0_23._text) and tonumber(A0_23._text) < 100 then
		L2_25 = 1
	end
	A0_23._gui_text:set_range_color(0, L2_25, L3_26)
	A0_23._gui_text:set_range_color(L2_25, 4, L4_27)
end
function Hud3DigitText.get_red_color(A0_28)
	local L1_29
	L1_29 = A0_28._current_color
	return L1_29
end
function Hud3DigitText.instant_hide(A0_30)
	local L2_31, L3_32, L4_33
	L2_31 = A0_30._gui_text
	L3_32 = L2_31
	L2_31 = L2_31.set_range_color
	L4_33 = 0
	L2_31(L3_32, L4_33, 3, A0_30._gui_text:color():with_alpha(0))
end
