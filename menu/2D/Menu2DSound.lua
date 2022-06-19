Menu2DSound = Menu2DSound or class()
Menu2DSound._SOUNDS = {
	"menu_up",
	"menu_down",
	"menu_select",
	"menu_toggle",
	"menu_move",
	"menu_back",
	"menu_up",
	"menu_enter",
	"menu_exit",
	"menu_splash_ambience",
	"menu_ambience",
	"menu_title_static",
	"menu_camera_move_in",
	"menu_camera_move_out",
	"menu_small_select"
}
Menu2DSound._SOUND_BANK = "ui_menu_sound"
Menu2DSound._FADE_TIME = 1
Menu2DSound._page_change_sounds = {
	mainmenu = {start_page = "menu_exit"}
}
function Menu2DSound.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._sounds = L1_1
	L1_1 = {}
	A0_0._stopping_sound_times = L1_1
end
function Menu2DSound.preload(A0_2)
	local L1_3, L2_4, L3_5, L4_6, L5_7
	L1_3(L2_4, L3_5)
	L1_3(L2_4, L3_5)
	L1_3(L2_4, L3_5)
	for L4_6, L5_7 in L1_3(L2_4) do
		A0_2._sounds[L5_7] = Sound:make_bank(Menu2DSound._SOUND_BANK, L5_7)
	end
end
function Menu2DSound.preload_sound(A0_8, A1_9, A2_10)
	local L3_11
	L3_11 = A0_8._sounds
	L3_11 = L3_11[A1_9]
	if not L3_11 then
		L3_11 = A0_8._sounds
		L3_11[A1_9] = Sound:make_bank(Menu2DSound._SOUND_BANK, A2_10)
	end
end
function Menu2DSound.is_playing(A0_12, A1_13)
	A0_12._sounds[A1_13]:is_playing()
end
function Menu2DSound.stop(A0_14, A1_15)
	local L2_16, L3_17
	L2_16 = A0_14._sounds
	L2_16 = L2_16[A1_15]
	L3_17 = L2_16.get_control
	L3_17 = L3_17(L2_16, "gain_abs")
	L2_16:set_control_ramp("gain_abs", L3_17, -50, A0_14._FADE_TIME)
	A0_14._stopping_sound_times[A1_15] = 0
	print("Stopping menu sound " .. A1_15)
end
function Menu2DSound.play(A0_18, A1_19)
	if A0_18._sounds[A1_19] then
		A0_18._sounds[A1_19]:play()
	end
end
function Menu2DSound.update(A0_20, A1_21)
	local L2_22
	L2_22 = {}
	for 