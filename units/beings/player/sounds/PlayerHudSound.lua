if not PlayerHudSound then
	PlayerHudSound = class()
end
PlayerHudSound.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._objective_complete_sound = Sound:make_bank("stingers_sound", "stinger_objective_complete")
	l_1_0._new_objective_sound = Sound:make_bank("stingers_sound", "stinger_new_objective")
	l_1_0._checkpoint_sound = Sound:make_bank("stingers_sound", "stinger_checkpoint")
	l_1_0._look_at_available_sound = Sound:make_bank("ui_menu_sound", "hud_look_at_stinger")
	l_1_0._look_at_enter_sound = Sound:make_bank("ui_menu_sound", "ui_look_at_enter")
	l_1_0._look_at_exit_sound = Sound:make_bank("ui_menu_sound", "ui_look_at_exit")
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
end

PlayerHudSound.destroy = function(l_2_0)
	managers.action_event:unregister_listener(l_2_0)
end

PlayerHudSound.unit_hud_mission_objective_new = function(l_3_0, l_3_1)
	local l_3_2 = assert
	l_3_2(l_3_0._unit == l_3_1)
	l_3_2 = l_3_0._new_objective_sound
	l_3_2(l_3_2)
end

PlayerHudSound.unit_hud_mission_objective_completed = function(l_4_0, l_4_1)
	local l_4_2 = assert
	l_4_2(l_4_0._unit == l_4_1)
	l_4_2 = l_4_0._objective_complete_sound
	l_4_2(l_4_2)
end

PlayerHudSound.progress_updated = function(l_5_0)
	l_5_0._checkpoint_sound:play()
end

PlayerHudSound.update = function(l_6_0, l_6_1, l_6_2, l_6_3)
	l_6_0:_check_if_look_at_is_available()
	l_6_0:_check_if_look_at_pressed()
end

PlayerHudSound._check_if_look_at_is_available = function(l_7_0)
	local l_7_1 = l_7_0._unit:player_data().look_at_position
	if l_7_1 and not l_7_0._look_at_position then
		l_7_0._look_at_available_sound:play()
	end
	l_7_0._look_at_position = l_7_1
end

PlayerHudSound._check_if_look_at_pressed = function(l_8_0)
	local l_8_1 = l_8_0._unit:camera_data().look_at_position_override
	if not l_8_0._look_at_is_pressed and l_8_1 then
		l_8_0._look_at_enter_sound:play()
	elseif l_8_0._look_at_is_pressed and not l_8_1 then
		l_8_0._look_at_exit_sound:play()
	end
	l_8_0._look_at_is_pressed = l_8_1
end


