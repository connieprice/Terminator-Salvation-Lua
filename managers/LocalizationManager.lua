core:require_module("CoreLocalizationManager")
LocalizationManager = LocalizationManager or {}
function LocalizationManager.add_default_macros()
	local L0_0, L1_1, L2_2, L3_3, L4_4, L5_5, L6_6, L7_7, L8_8, L9_9, L10_10, L11_11, L12_12, L13_13, L14_14, L15_15, L16_16, L17_17
	L0_0 = utf8
	L0_0 = L0_0.char
	L1_1 = 57344
	L0_0 = L0_0(L1_1)
	L1_1 = utf8
	L1_1 = L1_1.char
	L2_2 = 57345
	L1_1 = L1_1(L2_2)
	L2_2 = utf8
	L2_2 = L2_2.char
	L3_3 = 57346
	L2_2 = L2_2(L3_3)
	L3_3 = utf8
	L3_3 = L3_3.char
	L4_4 = 57347
	L3_3 = L3_3(L4_4)
	L4_4 = utf8
	L4_4 = L4_4.char
	L5_5 = 57348
	L4_4 = L4_4(L5_5)
	L5_5 = utf8
	L5_5 = L5_5.char
	L6_6 = 57349
	L5_5 = L5_5(L6_6)
	L6_6 = utf8
	L6_6 = L6_6.char
	L7_7 = 57350
	L6_6 = L6_6(L7_7)
	L7_7 = utf8
	L7_7 = L7_7.char
	L8_8 = 57351
	L7_7 = L7_7(L8_8)
	L8_8 = utf8
	L8_8 = L8_8.char
	L9_9 = 57352
	L8_8 = L8_8(L9_9)
	L9_9 = utf8
	L9_9 = L9_9.char
	L10_10 = 57353
	L9_9 = L9_9(L10_10)
	L10_10 = utf8
	L10_10 = L10_10.char
	L11_11 = 57354
	L10_10 = L10_10(L11_11)
	L11_11 = utf8
	L11_11 = L11_11.char
	L12_12 = 57355
	L11_11 = L11_11(L12_12)
	L12_12 = utf8
	L12_12 = L12_12.char
	L13_13 = 57356
	L12_12 = L12_12(L13_13)
	L13_13 = utf8
	L13_13 = L13_13.char
	L14_14 = 57357
	L13_13 = L13_13(L14_14)
	L14_14 = SystemInfo
	L15_15 = L14_14
	L14_14 = L14_14.platform
	L14_14 = L14_14(L15_15)
	if L14_14 == "WIN32" then
		L14_14 = "[YOUR BUTTON HERE]"
		L0_0 = L14_14
		L1_1 = L14_14
		L2_2 = L14_14
		L3_3 = L14_14
		L4_4 = L14_14
		L5_5 = L14_14
		L6_6 = L14_14
		L7_7 = L14_14
		L8_8 = L14_14
		L9_9 = L14_14
		L10_10 = L14_14
		L11_11 = L14_14
		L12_12 = L14_14
		L13_13 = L14_14
	end
	L14_14 = L0_0
	L15_15 = L1_1
	L16_16 = false
	L17_17 = SystemInfo
	L17_17 = L17_17.platform
	L17_17 = L17_17(L17_17)
	if L17_17 == "PS3" then
		L17_17 = PS3
		L17_17 = L17_17.pad_cross_circle_inverted
		L17_17 = L17_17(L17_17)
		if L17_17 then
			L16_16 = true
		end
	end
	if L16_16 then
		L14_14 = L1_1
		L15_15 = L0_0
	end
	L17_17 = SystemInfo
	L17_17 = L17_17.platform
	L17_17 = L17_17(L17_17)
	if L17_17 ~= "PS3" then
		L13_13 = L7_7
		L12_12 = L6_6
		L17_17 = managers
		L17_17 = L17_17.localization
		L17_17.btn_zoom = L13_13
		L17_17 = managers
		L17_17 = L17_17.localization
		L17_17.btn_center_camera = L12_12
	end
	L17_17 = {
		{"BTN_BACK", L4_4},
		{"BTN_START", L5_5},
		{"BTN_A", L0_0},
		{"BTN_B", L1_1},
		{"BTN_X", L2_2},
		{"BTN_Y", L3_3},
		{"BTN_TOP_L", L8_8},
		{"BTN_TOP_R", L9_9},
		{
			"BTN_BOTTOM_L",
			L10_10
		},
		{
			"BTN_BOTTOM_R",
			L11_11
		},
		{
			"BTN_STICK_L",
			L12_12
		},
		{
			"BTN_STICK_R",
			L13_13
		},
		{"STICK_L", L6_6},
		{"STICK_R", L7_7},
		{"BTN_ACCEPT", L14_14},
		{"BTN_CANCEL", L15_15}
	}
	for 