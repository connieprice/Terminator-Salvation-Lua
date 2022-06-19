local L0_0
L0_0 = SpiderEffects
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
SpiderEffects = L0_0
L0_0 = "a_eye"
SpiderEffects._BODY_SEQUENCES = {
	b_arm_left = "arm_left",
	b_gun_left = "arm_left",
	b_arm_right = "arm_right",
	b_gun_right = "arm_right",
	b_shield_top = "back",
	b_shield_left = "left",
	b_shield_right = "right"
}
SpiderEffects._KILL_SEQUENCES = {
	bullet = {"kill"},
	explosion = {
		"kill_blow_off_head",
		"kill_blow_off_leg"
	},
	battery = {"battery"}
}
function SpiderEffects.init(A0_1, A1_2)
	A0_1._unit = A1_2
	managers.action_event:register_listener(A0_1, A1_2, A1_2)
	A0_1._sounds = {}
	A0_1._enemy_data = A1_2:enemy_data()
end
function SpiderEffects.destroy(A0_3, A1_4)
	managers.action_event:unregister_listener(A0_3)
	A0_3:_kill_sounds()
end
function SpiderEffects.unit_stun_enter(A0_5)
	A0_5:_play_effect("enter_stun")
	assert(A0_5._enemy_data.stunned_sound and A0_5._enemy_data.stunned_sound ~= "")
	A0_5._sounds.stun_start_sound = A0_5._unit:play(A0_5._enemy_data.stunned_sound)
end
function SpiderEffects.unit_stun_exit(A0_6)
	local L1_7
	L1_7 = A0_6._play_effect
	L1_7(A0_6, "leave_stun")
	L1_7 = A0_6._sounds
	if L1_7 then
		L1_7 = alive
		L1_7 = L1_7(A0_6._sounds.stun_start_sound)
		if L1_7 then
			L1_7 = A0_6._sounds
			L1_7 = L1_7.stun_start_sound
			L1_7 = L1_7.is_playing
			L1_7 = L1_7(L1_7)
			if L1_7 then
				L1_7 = A0_6._sounds
				L1_7 = L1_7.stun_start_sound
				L1_7 = L1_7.get_control
				L1_7 = L1_7(L1_7, "gain_abs")
				A0_6._sounds.stun_start_sound:set_control_ramp("gain_abs", L1_7, 0, 0.2)
			end
		end
	end
end
function SpiderEffects.unit_stun_body_damaged(A0_8)
	A0_8:_play_effect("stun_hit")
end
function SpiderEffects.unit_fully_damaged(A0_9, A1_10, A2_11)
	local L3_12, L4_13, L5_14
	L3_12 = assert
	L4_13 = A2_11 ~= nil and A2_11 ~= ""
	L3_12(L4_13)
	L3_12 = SpiderEffects
	L3_12 = L3_12._KILL_SEQUENCES
	L3_12 = L3_12[A2_11]
	if L3_12 then
		L4_13 = #L3_12
		L5_14 = math
		L5_14 = L5_14.random
		L5_14 = L5_14(1, L4_13)
		L5_14 = L3_12[L5_14]
		managers.sequence:run_sequence_simple(L5_14, A0_9._unit)
	end
end
function SpiderEffects.unit_damaged(A0_15, A1_16, A2_17, A3_18)
	local L4_19
	L4_19 = A0_15._damage_sequence
	if not L4_19 then
		L4_19 = A0_15._unit
		L4_19 = L4_19.damage_data
		L4_19 = L4_19(L4_19)
		L4_19 = L4_19.damage
		if L4_19 > A0_15._unit:damage_data().health * tweak_data.enemy.spider.TRIGGER_SEQUENCE_AT_DAMAGE_LEVEL then
			L4_19 = SpiderEffects
			L4_19 = L4_19._BODY_SEQUENCES
			L4_19 = L4_19[A2_17:name()]
			if L4_19 and L4_19 ~= "" then
				A0_15._damage_sequence = true
				A0_15:_play_effect(L4_19)
			end
		end
	end
end
function SpiderEffects.unit_scan_enter(A0_20)
	local L1_21
	L1_21 = A0_20._unit
	A0_20:_kill_sound(A0_20._sounds.scan_start_sound)
	A0_20._sounds.scan_start_sound = L1_21:play("spider_patrol_start")
	A0_20:_kill_sound(A0_20._sounds.scan_loop_sound)
	if L1_21:play("spider_patrol_loop", "gain_abs", 0) then
		L1_21:play("spider_patrol_loop", "gain_abs", 0):set_control_ramp("gain_abs", 0, 1, 0.5)
	end
	A0_20._sounds.scan_loop_sound = L1_21:play("spider_patrol_loop", "gain_abs", 0)
end
function SpiderEffects.unit_scan_leave(A0_22)
	local L1_23, L2_24
	L1_23 = A0_22._unit
	L2_24 = A0_22._sounds
	L2_24 = L2_24.scan_loop_sound
	if L2_24 and L2_24:is_playing() then
		L1_23:play("silence", "crossfade_with", L2_24, "crossfade_time", 0.5)
	end
	A0_22:_kill_sound(A0_22._scan_end_sound)
	A0_22._scan_end_sound = L1_23:play("spider_patrol_end")
end
function SpiderEffects.unit_scan_beam_enter(A0_25)
	local L1_26
	L1_26 = A0_25._unit
	A0_25:_kill_sound(A0_25._sounds.beam_start_sound)
	A0_25._sounds.beam_start_sound = L1_26:play_at("spider_beam_start", _UPVALUE0_)
	A0_25:_kill_sound(A0_25._sounds.beam_loop_sound)
	if L1_26:play_at("spider_beam_loop", _UPVALUE0_, "gain_abs", 0) then
		L1_26:play_at("spider_beam_loop", _UPVALUE0_, "gain_abs", 0):set_control_ramp("gain_abs", 0, 1, 0.5)
	end
	A0_25._sounds.beam_loop_sound = L1_26:play_at("spider_beam_loop", _UPVALUE0_, "gain_abs", 0)
	A0_25._laser_beam_effect_id = World:effect_manager():spawn({
		effect = "t100_laser_beam",
		parent = A0_25._unit:get_object("a_eye"),
		rotation = Rotation(-90, 90, 0)
	})
	A0_25:_play_effect("start_scan")
end
function SpiderEffects.unit_scan_beam_leave(A0_27)
	local L1_28, L2_29
	L1_28 = A0_27._unit
	L2_29 = A0_27._sounds
	L2_29 = L2_29.beam_loop_sound
	if L2_29 and L2_29:is_playing() then
		L1_28:play_at("silence", _UPVALUE0_, "crossfade_with", L2_29, "crossfade_time", 0.5)
	end
	A0_27:_kill_sound(A0_27._beam_end_sound)
	A0_27._beam_end_sound = L1_28:play_at("spider_beam_end", _UPVALUE0_)
	World:effect_manager():kill(A0_27._laser_beam_effect_id)
	A0_27._laser_beam_effect_id = nil
	A0_27:_play_effect("stop_scan")
end
function SpiderEffects._play_effect(A0_30, A1_31)
	managers.sequence:run_sequence_simple(A1_31, A0_30._unit)
	A0_30:_kill_not_playing_sounds()
end
function SpiderEffects._kill_not_playing_sounds(A0_32)
	TableAlgorithms.remove_if(A0_32._sounds, function(A0_33)
		return not A0_33:is_playing()
	end)
end
function SpiderEffects._kill_sounds(A0_34)
	local L1_35, L2_36, L3_37, L4_38, L5_39
	for L4_38, L5_39 in L1_35(L2_36) do
		A0_34:_kill_sound(L5_39)
	end
	A0_34._sounds = nil
end
function SpiderEffects._kill_sound(A0_40, A1_41)
	if A1_41 and A1_41:is_playing() then
		A1_41:stop()
	end
end
