PlayerHudSound = PlayerHudSound or class()
function PlayerHudSound.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._objective_complete_sound = Sound:make_bank("stingers_sound", "stinger_objective_complete")
	A0_0._new_objective_sound = Sound:make_bank("stingers_sound", "stinger_new_objective")
	A0_0._checkpoint_sound = Sound:make_bank("stingers_sound", "stinger_checkpoint")
	A0_0._look_at_available_sound = Sound:make_bank("ui_menu_sound", "hud_look_at_stinger")
	A0_0._look_at_enter_sound = Sound:make_bank("ui_menu_sound", "ui_look_at_enter")
	A0_0._look_at_exit_sound = Sound:make_bank("ui_menu_sound", "ui_look_at_exit")
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
end
function PlayerHudSound.destroy(A0_2)
	managers.action_event:unregister_listener(A0_2)
end
function PlayerHudSound.unit_hud_mission_objective_new(A0_3, A1_4)
	assert(A0_3._unit == A1_4)
	A0_3._new_objective_sound:play()
end
function PlayerHudSound.unit_hud_mission_objective_completed(A0_5, A1_6)
	assert(A0_5._unit == A1_6)
	A0_5._objective_complete_sound:play()
end
function PlayerHudSound.progress_updated(A0_7)
	A0_7._checkpoint_sound:play()
end
function PlayerHudSound.update(A0_8, A1_9, A2_10, A3_11)
	A0_8:_check_if_look_at_is_available()
	A0_8:_check_if_look_at_pressed()
end
function PlayerHudSound._check_if_look_at_is_available(A0_12)
	if A0_12._unit:player_data().look_at_position and not A0_12._look_at_position then
		A0_12._look_at_available_sound:play()
	end
	A0_12._look_at_position = A0_12._unit:player_data().look_at_position
end
function PlayerHudSound._check_if_look_at_pressed(A0_13)
	if not A0_13._look_at_is_pressed and A0_13._unit:camera_data().look_at_position_override then
		A0_13._look_at_enter_sound:play()
	elseif A0_13._look_at_is_pressed and not A0_13._unit:camera_data().look_at_position_override then
		A0_13._look_at_exit_sound:play()
	end
	A0_13._look_at_is_pressed = A0_13._unit:camera_data().look_at_position_override
end
