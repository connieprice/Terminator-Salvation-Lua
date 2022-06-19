require("menu/2D/Menu2DPage")
require("menu/menu_animations/Menu2DPulseAnimation")
require("menu/menu_animations/Menu2DFadeInAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
require("menu/2D/Menu2DUtilities")
Menu2DPageMessage = Menu2DPageMessage or class(Menu2DPage)
function Menu2DPageMessage.init(A0_0, A1_1, A2_2, A3_3)
	local L4_4, L5_5, L6_6, L7_7, L8_8
	L7_7 = A2_2
	L4_4(L5_5, L6_6, L7_7)
	L7_7 = "show_saving_icon"
	L8_8 = L5_5(L6_6, L7_7)
	A0_0._show_saving_icon = L4_4
	A0_0._confirm_code = L4_4
	A0_0._abort_code = L4_4
	L7_7 = "auto_abort"
	L8_8 = L5_5(L6_6, L7_7)
	A0_0._auto_abort = L4_4
	L7_7 = "text"
	L8_8 = L5_5(L6_6, L7_7)
	A0_0._message_text = L4_4
	L7_7 = "disable_background"
	L8_8 = L5_5(L6_6, L7_7)
	A0_0._disable_background = L4_4
	A0_0._choice_options = L4_4
	for L7_7 in L4_4(L5_5) do
		L8_8 = {}
		L8_8.text = L7_7:parameter("text")
		L8_8.callback_code = L7_7:parameter("code")
		if not L7_7:parameter("platform") or L7_7:parameter("platform") == SystemInfo:platform() then
			table.insert(A0_0._choice_options, L8_8)
		end
		if toboolean(L7_7:parameter("selected_option")) and toboolean(L7_7:parameter("selected_option")) == true then
			A0_0._default_selected_option_index = #A0_0._choice_options
		end
	end
	A0_0._single_option = false
	if L4_4 < 2 then
		A0_0._single_option = true
	end
	A0_0._fade_out_started = false
	A0_0._option_animation = nil
end
function Menu2DPageMessage.destroy(A0_9)
	Menu2DPage.destroy(A0_9)
	if A0_9._background then
		A0_9._full_screen_panel:remove(A0_9._background)
		A0_9._background = nil
	end
end
function Menu2DPageMessage.set_transition(A0_10)
	A0_10:_fade_all()
end
function Menu2DPageMessage._call(A0_11, A1_12)
	local L2_13, L3_14
	L2_13 = loadstring
	L3_14 = "return "
	L3_14 = L3_14 .. A1_12
	L2_13 = L2_13(L3_14)
	L3_14 = L2_13
	L3_14()
end
function Menu2DPageMessage._fade_all(A0_15)
	if not A0_15._disable_background then
		A0_15._background_animation = Menu2DFadeOutAnimation:new(A0_15._background, 0, A0_15._animation_speed, 0)
	end
	A0_15._message_animation = Menu2DFadeOutAnimation:new(A0_15._message, 0, A0_15._animation_speed, 0)
	A0_15._line_animation = Menu2DFadeOutAnimation:new(A0_15._line, 0, A0_15._animation_speed, 0)
	if A0_15._options and 0 < #A0_15._options then
		for 