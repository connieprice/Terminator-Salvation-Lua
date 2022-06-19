require("menu/2D/Menu2DPage")
require("menu/menu_animations/Menu2DPulseAnimation")
require("menu/menu_animations/Menu2DFadeOutAnimation")
if not Menu2DPageJoinSecondPlayer then
	Menu2DPageJoinSecondPlayer = class(Menu2DPage)
end
Menu2DPageJoinSecondPlayer.init = function(l_1_0, l_1_1, l_1_2)
	Menu2DPage.init(l_1_0, l_1_1, l_1_2)
	l_1_0._fade_out_complete = false
end

Menu2DPageJoinSecondPlayer.update = function(l_2_0, l_2_1)
	Menu2DPage.update(l_2_0, l_2_1)
	if l_2_0:_number_of_players_that_wants_to_play() < 2 and not l_2_0:_fade_out_active() then
		l_2_0:_show_press_start()
	else
		l_2_0:_hide_press_start()
	end
	if l_2_0._press_start_fade_animation then
		l_2_0._fade_out_complete = l_2_0._press_start_fade_animation:update(l_2_1)
	else
		l_2_0._fade_out_complete = nil
	end
	if l_2_0._press_start_pulse_animation then
		l_2_0._press_start_pulse_animation:update(l_2_1)
	end
end

Menu2DPageJoinSecondPlayer._number_of_players_that_wants_to_play = function(l_3_0)
	local l_3_6, l_3_7 = nil
	local l_3_1 = managers.local_user:users()
	local l_3_2 = 0
	for i_0,i_1 in pairs(l_3_1) do
		if i_1:wants_to_play() then
			l_3_2 = l_3_2 + 1
		end
	end
	return l_3_2
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageJoinSecondPlayer._is_slot_wanted = function(l_4_0, l_4_1)
	local l_4_6, l_4_7, l_4_8, l_4_9 = nil
	local l_4_2 = managers.local_user:users()
	for i_0,i_1 in pairs(l_4_2) do
		if i_1:wants_to_play() and i_1:wanted_player_slot_id() == l_4_1 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DPageJoinSecondPlayer.input = function(l_5_0, l_5_1, l_5_2)
	local l_5_9, l_5_10, l_5_11, l_5_12, l_5_13, l_5_14, l_5_15, l_5_16, l_5_17, l_5_18, l_5_19, l_5_20, l_5_21, l_5_22, l_5_27, l_5_28, l_5_29, l_5_30, l_5_31, l_5_32, l_5_33, l_5_34, l_5_35, l_5_36 = nil
	local l_5_3 = false
	local l_5_4 = managers.local_user:users()
	local l_5_5 = managers.menu_input.users_pressing_join(l_5_4)
	for i_0,i_1 in ipairs(l_5_5) do
		if managers.menu_input:bound_user() ~= i_1 and not l_5_0:_is_slot_wanted(2) then
			l_5_3 = true
			i_1:set_wanted_player_slot_id(2)
			i_1:prime_profile()
			l_5_0:_show_press_start()
			if not managers.game:is_in_game() then
				local l_5_25 = managers.menu2d:raise_event
				do
					local l_5_26 = managers.menu2d
					l_5_25(l_5_26, "new_game", {mode = "coop", user2 = l_5_24})
			end
			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			 -- DECOMPILER ERROR: Confused about usage of registers!

			else
				if l_5_24:is_profile_ready() then
					managers.network:peer():join_game(l_5_24, l_5_24:wanted_player_slot_id())
					managers.menu2d:back()
				end
			end
	else
		end
	end
	if not l_5_3 and l_5_1.back and l_5_0:_number_of_players_that_wants_to_play() < 2 then
		managers.menu2d:back()
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DPageJoinSecondPlayer.open = function(l_6_0, l_6_1, l_6_2, l_6_3)
	Menu2DPage.open(l_6_0, l_6_1, l_6_2, l_6_3)
	l_6_0._shows_press_start = false
	local l_6_4, l_6_5 = l_6_0._panel:text, l_6_0._panel
	local l_6_6 = {}
	l_6_6.text = managers.localization:text("menu_join_player_2")
	l_6_6.font = "faith_font_22"
	l_6_6.font_size = 44
	l_6_6.color = Color(1, 1, 1, 1)
	l_6_6.align = "center"
	l_6_6.vertical = "center"
	l_6_6.w = l_6_0._panel:w()
	l_6_6.h = l_6_0._panel:h()
	l_6_6.x = 0
	l_6_6.y = 0
	l_6_4 = l_6_4(l_6_5, l_6_6)
	l_6_0._press_start = l_6_4
	l_6_4, l_6_5 = l_6_0:_show_press_start, l_6_0
	l_6_4(l_6_5)
end

Menu2DPageJoinSecondPlayer.set_transition = function(l_7_0, l_7_1)
	Menu2DPage.set_transition(l_7_0, l_7_1)
	l_7_0:_hide_press_start()
end

Menu2DPageJoinSecondPlayer._transition = function(l_8_0)
	return l_8_0._transition_active
end

Menu2DPageJoinSecondPlayer._fade_out_active = function(l_9_0)
	return l_9_0._press_start_fade_animation ~= nil
end

Menu2DPageJoinSecondPlayer._transition_end = function(l_10_0)
	if l_10_0._fade_out_complete == true or not l_10_0._press_start_fade_animation then
		Menu2DPage._transition_end(l_10_0)
	end
end

Menu2DPageJoinSecondPlayer._show_press_start = function(l_11_0)
	if not l_11_0._shows_press_start then
		l_11_0._press_start_pulse_animation = Menu2DPulseAnimation:new(l_11_0._press_start, 0.4, 0.4, 1)
		l_11_0._shows_press_start = true
		l_11_0._press_start_fade_animation = nil
	end
end

Menu2DPageJoinSecondPlayer._hide_press_start = function(l_12_0)
	if l_12_0._shows_press_start then
		l_12_0._press_start_fade_animation = Menu2DFadeOutAnimation:new(l_12_0._press_start, 0, 0.2, 0)
		l_12_0._shows_press_start = false
		l_12_0._press_start_pulse_animation = nil
	end
end


