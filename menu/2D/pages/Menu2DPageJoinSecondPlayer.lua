require("menu/2D/Menu2DPage")
require("menu/menu_animations/Menu2DPulseAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
Menu2DPageJoinSecondPlayer = Menu2DPageJoinSecondPlayer or class(Menu2DPage)
function Menu2DPageJoinSecondPlayer.init(A0_0, A1_1, A2_2)
	Menu2DPage.init(A0_0, A1_1, A2_2)
	A0_0._fade_out_complete = false
end
function Menu2DPageJoinSecondPlayer.update(A0_3, A1_4)
	Menu2DPage.update(A0_3, A1_4)
	if A0_3:_number_of_players_that_wants_to_play() < 2 and not A0_3:_fade_out_active() then
		A0_3:_show_press_start()
	else
		A0_3:_hide_press_start()
	end
	if A0_3._press_start_fade_animation then
		A0_3._fade_out_complete = A0_3._press_start_fade_animation:update(A1_4)
	else
		A0_3._fade_out_complete = nil
	end
	if A0_3._press_start_pulse_animation then
		A0_3._press_start_pulse_animation:update(A1_4)
	end
end
function Menu2DPageJoinSecondPlayer._number_of_players_that_wants_to_play(A0_5)
	local L1_6
	L1_6 = managers
	L1_6 = L1_6.local_user
	L1_6 = L1_6.users
	L1_6 = L1_6(L1_6)
	for 