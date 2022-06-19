require("menu/OverlayMovie")
require("shared/FiniteStateMachine")
require("menu/states/MenuStates")
require("LevelLoadingEnvironment")
require("MenuLoadingEnvironment")
Menu = Menu or class()
Menu.is_production_mode = false
Menu.EASY = 1
Menu.MEDIUM = 2
Menu.HARD = 3
function Menu.init(A0_0, A1_1, A2_2)
	local L3_3, L4_4, L5_5
	A0_0._gui_interface = A2_2
	L3_3 = A1_1.dialog_local_user_index
	if L3_3 then
		L4_4 = A0_0
		L3_3 = A0_0._set_dialog_user_index
		L3_3(L4_4, L5_5)
	end
	L3_3 = _G
	L4_4 = A1_1.start_state
	L3_3 = L3_3[L4_4]
	L4_4 = A0_0.show_ingame_gui
	L4_4(L5_5)
	L4_4 = FiniteStateMachine
	L4_4 = L4_4.new
	L4_4 = L4_4(L5_5, A0_0, "_menu", L3_3)
	A0_0._machine = L4_4
	L4_4 = A0_0._machine
	L4_4 = L4_4.set_debug
	L4_4(L5_5, true)
	L4_4 = Application
	L4_4 = L4_4.argv
	L4_4 = L4_4(L5_5)
	for 