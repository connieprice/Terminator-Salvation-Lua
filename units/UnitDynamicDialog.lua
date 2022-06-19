if not UnitDynamicDialog then
	UnitDynamicDialog = class()
end
UnitDynamicDialog.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
	l_1_0._was_low_ammo = false
	l_1_0._need_help_with_ammo_timer = 0
	l_1_0._need_help_with_reviving_timer = 0
	l_1_0._emitter = managers.action_event:create_emitter()
end

UnitDynamicDialog.destroy = function(l_2_0)
	l_2_0._emitter:destroy()
	managers.action_event:unregister_listener(l_2_0)
end

UnitDynamicDialog.update = function(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0:_detect_low_ammo()
	l_3_0:_detect_help_for_low_ammo(l_3_3)
	l_3_0:_check_help_line(l_3_3)
end

UnitDynamicDialog._detect_low_ammo = function(l_4_0)
	local l_4_1 = l_4_0._unit:base():is_low_on_ammo()
	if not l_4_0._was_low_ammo and l_4_1 and l_4_0._unit:base():can_receive_ammo_for_weapon() then
		l_4_0:_try_to_say("low-ammo")
	end
	l_4_0._was_low_ammo = l_4_1
end

UnitDynamicDialog._detect_help_for_low_ammo = function(l_5_0, l_5_1)
	local l_5_2 = l_5_0._unit:base():is_low_on_ammo()
	if not l_5_2 then
		return 
	end
	l_5_0._need_help_with_ammo_timer = l_5_0._need_help_with_ammo_timer + l_5_1
	if tweak_data.dynamic_dialog.HELP_WITH_AMMO_TIME_OUT < l_5_0._need_help_with_ammo_timer then
		l_5_0._emitter:player_need_ammo(l_5_0._unit)
		l_5_0._need_help_with_ammo_timer = 0
	end
end

UnitDynamicDialog._check_help_line = function(l_6_0, l_6_1)
	if l_6_0._unit_needs_reviving then
		l_6_0._need_help_with_reviving_timer = l_6_0._need_help_with_reviving_timer + l_6_1
	if tweak_data.dynamic_dialog.HELP_WITH_REVIVING_TIME_OUT < l_6_0._need_help_with_reviving_timer then
		end
		l_6_0:_try_to_say("help")
		l_6_0._need_help_with_reviving_timer = 0
	end
end

UnitDynamicDialog.human_character_entered_idle = function(l_7_0, l_7_1)
	l_7_0:_try_to_say("inactive")
end

UnitDynamicDialog.combat_banter = function(l_8_0)
	l_8_0:_try_to_say("banter")
end

UnitDynamicDialog.unit_player_damage = function(l_9_0, l_9_1, l_9_2, l_9_3, l_9_4, l_9_5, l_9_6)
	l_9_0:_try_to_say("grunt")
end

UnitDynamicDialog.player_need_ammo = function(l_10_0, l_10_1)
	if l_10_1 == l_10_0._unit then
		return 
	end
	if l_10_0._unit:base():can_give_ammo() and l_10_1:base():can_receive_ammo_for_weapon() then
		l_10_0:_try_to_say("give-ammo")
	end
end

UnitDynamicDialog.unit_killed_machine = function(l_11_0, l_11_1, l_11_2)
	l_11_0:_try_to_say("score")
end

UnitDynamicDialog.stun_enter = function(l_12_0, l_12_1)
	l_12_0:_try_to_say("stunned")
end

UnitDynamicDialog.unit_player_received_ammo_from_player = function(l_13_0, l_13_1, l_13_2)
	l_13_0:_try_to_say("thanks")
end

UnitDynamicDialog.unit_explode = function(l_14_0, l_14_1, l_14_2, l_14_3)
	local l_14_4 = l_14_2 - l_14_1:position()
	if l_14_4:length() < tweak_data.dynamic_dialog.EXPLOSION_DISTANCE then
		l_14_0:_try_to_say("explosion")
	end
end

UnitDynamicDialog.unit_player_dead = function(l_15_0, l_15_1)
	if l_15_0._unit_needs_reviving then
		l_15_0._unit_needs_reviving = nil
	end
	l_15_1:drama():death(l_15_1, "scream")
end

UnitDynamicDialog.unit_player_reloading = function(l_16_0, l_16_1)
	if not managers.dynamic_dialog:is_in_combat() then
		return 
	end
	l_16_0:_try_to_say("reload")
end

UnitDynamicDialog.unit_revive_help = function(l_17_0, l_17_1)
	l_17_0._unit_needs_reviving = true
end

UnitDynamicDialog.unit_revive_thanks = function(l_18_0, l_18_1)
	l_18_0._unit_needs_reviving = nil
	local l_18_2 = l_18_0._unit:player_data()
	if l_18_2 and not l_18_2.warping then
		l_18_0:_try_to_say("thanks", true)
	end
end

UnitDynamicDialog._try_to_say = function(l_19_0, l_19_1, l_19_2)
	managers.dynamic_dialog:try_to_say(l_19_0._unit, l_19_1, l_19_2)
end


