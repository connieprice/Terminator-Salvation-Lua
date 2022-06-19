UnitDynamicDialog = UnitDynamicDialog or class()
function UnitDynamicDialog.init(A0_0, A1_1)
	A0_0._unit = A1_1
	managers.action_event:register_listener(A0_0, A1_1, A1_1)
	A0_0._was_low_ammo = false
	A0_0._need_help_with_ammo_timer = 0
	A0_0._need_help_with_reviving_timer = 0
	A0_0._emitter = managers.action_event:create_emitter()
end
function UnitDynamicDialog.destroy(A0_2)
	A0_2._emitter:destroy()
	managers.action_event:unregister_listener(A0_2)
end
function UnitDynamicDialog.update(A0_3, A1_4, A2_5, A3_6)
	A0_3:_detect_low_ammo()
	A0_3:_detect_help_for_low_ammo(A3_6)
	A0_3:_check_help_line(A3_6)
end
function UnitDynamicDialog._detect_low_ammo(A0_7)
	if not A0_7._was_low_ammo and A0_7._unit:base():is_low_on_ammo() and A0_7._unit:base():can_receive_ammo_for_weapon() then
		A0_7:_try_to_say("low-ammo")
	end
	A0_7._was_low_ammo = A0_7._unit:base():is_low_on_ammo()
end
function UnitDynamicDialog._detect_help_for_low_ammo(A0_8, A1_9)
	if not A0_8._unit:base():is_low_on_ammo() then
		return
	end
	A0_8._need_help_with_ammo_timer = A0_8._need_help_with_ammo_timer + A1_9
	if A0_8._need_help_with_ammo_timer > tweak_data.dynamic_dialog.HELP_WITH_AMMO_TIME_OUT then
		A0_8._emitter:player_need_ammo(A0_8._unit)
		A0_8._need_help_with_ammo_timer = 0
	end
end
function UnitDynamicDialog._check_help_line(A0_10, A1_11)
	if A0_10._unit_needs_reviving then
		A0_10._need_help_with_reviving_timer = A0_10._need_help_with_reviving_timer + A1_11
		if A0_10._need_help_with_reviving_timer > tweak_data.dynamic_dialog.HELP_WITH_REVIVING_TIME_OUT then
			A0_10:_try_to_say("help")
			A0_10._need_help_with_reviving_timer = 0
		end
	end
end
function UnitDynamicDialog.human_character_entered_idle(A0_12, A1_13)
	A0_12:_try_to_say("inactive")
end
function UnitDynamicDialog.combat_banter(A0_14)
	A0_14:_try_to_say("banter")
end
function UnitDynamicDialog.unit_player_damage(A0_15, A1_16, A2_17, A3_18, A4_19, A5_20, A6_21)
	A0_15:_try_to_say("grunt")
end
function UnitDynamicDialog.player_need_ammo(A0_22, A1_23)
	if A1_23 == A0_22._unit then
		return
	end
	if A0_22._unit:base():can_give_ammo() and A1_23:base():can_receive_ammo_for_weapon() then
		A0_22:_try_to_say("give-ammo")
	end
end
function UnitDynamicDialog.unit_killed_machine(A0_24, A1_25, A2_26)
	A0_24:_try_to_say("score")
end
function UnitDynamicDialog.stun_enter(A0_27, A1_28)
	A0_27:_try_to_say("stunned")
end
function UnitDynamicDialog.unit_player_received_ammo_from_player(A0_29, A1_30, A2_31)
	A0_29:_try_to_say("thanks")
end
function UnitDynamicDialog.unit_explode(A0_32, A1_33, A2_34, A3_35)
	if (A2_34 - A1_33:position()):length() < tweak_data.dynamic_dialog.EXPLOSION_DISTANCE then
		A0_32:_try_to_say("explosion")
	end
end
function UnitDynamicDialog.unit_player_dead(A0_36, A1_37)
	if A0_36._unit_needs_reviving then
		A0_36._unit_needs_reviving = nil
	end
	A1_37:drama():death(A1_37, "scream")
end
function UnitDynamicDialog.unit_player_reloading(A0_38, A1_39)
	if not managers.dynamic_dialog:is_in_combat() then
		return
	end
	A0_38:_try_to_say("reload")
end
function UnitDynamicDialog.unit_revive_help(A0_40, A1_41)
	A0_40._unit_needs_reviving = true
end
function UnitDynamicDialog.unit_revive_thanks(A0_42, A1_43)
	A0_42._unit_needs_reviving = nil
	if A0_42._unit:player_data() and not A0_42._unit:player_data().warping then
		A0_42:_try_to_say("thanks", true)
	end
end
function UnitDynamicDialog._try_to_say(A0_44, A1_45, A2_46)
	managers.dynamic_dialog:try_to_say(A0_44._unit, A1_45, A2_46)
end
