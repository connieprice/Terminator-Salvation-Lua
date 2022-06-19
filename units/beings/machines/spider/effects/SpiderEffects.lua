if not SpiderEffects then
	SpiderEffects = class()
end
local l_0_0 = "a_eye"
local l_0_1 = SpiderEffects
local l_0_2 = {}
l_0_2.b_arm_left = "arm_left"
l_0_2.b_gun_left = "arm_left"
l_0_2.b_arm_right = "arm_right"
l_0_2.b_gun_right = "arm_right"
l_0_2.b_shield_top = "back"
l_0_2.b_shield_left = "left"
l_0_2.b_shield_right = "right"
l_0_1._BODY_SEQUENCES = l_0_2
l_0_1 = SpiderEffects
local l_0_3 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

l_0_3 = {"kill", "kill_blow_off_leg"}
l_0_3 = {"battery"}
l_0_1._KILL_SEQUENCES, l_0_2 = l_0_2, {bullet = l_0_3, explosion = l_0_3, battery = l_0_3}
l_0_1 = SpiderEffects
l_0_2 = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
	l_1_0._sounds = {}
	l_1_0._enemy_data = l_1_1:enemy_data()
end

l_0_1.init = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_2_0, l_2_1)
	managers.action_event:unregister_listener(l_2_0)
	l_2_0:_kill_sounds()
end

l_0_1.destroy = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_3_0)
	l_3_0:_play_effect("enter_stun")
	local l_3_1 = assert
	l_3_1(not l_3_0._enemy_data.stunned_sound or l_3_0._enemy_data.stunned_sound ~= "")
	l_3_1 = l_3_0._sounds
	l_3_1.stun_start_sound = l_3_0._unit:play(l_3_0._enemy_data.stunned_sound)
end

l_0_1.unit_stun_enter = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_4_0)
	l_4_0:_play_effect("leave_stun")
	if l_4_0._sounds and alive(l_4_0._sounds.stun_start_sound) and l_4_0._sounds.stun_start_sound:is_playing() then
		local l_4_1 = l_4_0._sounds.stun_start_sound:get_control("gain_abs")
		l_4_0._sounds.stun_start_sound:set_control_ramp("gain_abs", l_4_1, 0, 0.2)
	end
end

l_0_1.unit_stun_exit = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_5_0)
	l_5_0:_play_effect("stun_hit")
end

l_0_1.unit_stun_body_damaged = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = assert
	l_6_3(l_6_2 ~= nil and l_6_2 ~= "")
	l_6_3 = SpiderEffects
	l_6_3 = l_6_3._KILL_SEQUENCES
	l_6_3 = l_6_3[l_6_2]
	if l_6_3 then
		local l_6_6 = #l_6_3
		local l_6_7 = l_6_3[math.random(1, l_6_6)]
		managers.sequence:run_sequence_simple(l_6_7, l_6_0._unit)
	end
end

l_0_1.unit_fully_damaged = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if not l_7_0._damage_sequence and l_7_0._unit:damage_data().health * tweak_data.enemy.spider.TRIGGER_SEQUENCE_AT_DAMAGE_LEVEL < l_7_0._unit:damage_data().damage then
		local l_7_4 = SpiderEffects._BODY_SEQUENCES[l_7_2:name()]
	if l_7_4 and l_7_4 ~= "" then
		end
		l_7_0._damage_sequence = true
		l_7_0:_play_effect(l_7_4)
	end
end

l_0_1.unit_damaged = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_8_0)
	local l_8_1 = l_8_0._unit
	l_8_0:_kill_sound(l_8_0._sounds.scan_start_sound)
	l_8_0._sounds.scan_start_sound = l_8_1:play("spider_patrol_start")
	l_8_0:_kill_sound(l_8_0._sounds.scan_loop_sound)
	local l_8_2 = l_8_1:play("spider_patrol_loop", "gain_abs", 0)
	if l_8_2 then
		l_8_2:set_control_ramp("gain_abs", 0, 1, 0.5)
	end
	l_8_0._sounds.scan_loop_sound = l_8_2
end

l_0_1.unit_scan_enter = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_9_0)
	local l_9_1 = l_9_0._unit
	local l_9_2 = l_9_0._sounds.scan_loop_sound
	if l_9_2 and l_9_2:is_playing() then
		l_9_1:play("silence", "crossfade_with", l_9_2, "crossfade_time", 0.5)
	end
	l_9_0:_kill_sound(l_9_0._scan_end_sound)
	l_9_0._scan_end_sound = l_9_1:play("spider_patrol_end")
end

l_0_1.unit_scan_leave = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_10_0)
	-- upvalues: l_0_0
	local l_10_1 = l_10_0._unit
	l_10_0:_kill_sound(l_10_0._sounds.beam_start_sound)
	l_10_0._sounds.beam_start_sound = l_10_1:play_at("spider_beam_start", l_0_0)
	l_10_0:_kill_sound(l_10_0._sounds.beam_loop_sound)
	local l_10_2 = l_10_1:play_at("spider_beam_loop", l_0_0, "gain_abs", 0)
	if l_10_2 then
		l_10_2:set_control_ramp("gain_abs", 0, 1, 0.5)
	end
	l_10_0._sounds.beam_loop_sound = l_10_2
	local l_10_3 = l_10_0._unit:get_object("a_eye")
	local l_10_4 = "t100_laser_beam"
	local l_10_5 = Rotation(-90, 90, 0)
	local l_10_6, l_10_7 = World:effect_manager():spawn, World:effect_manager()
	local l_10_8 = {}
	l_10_8.effect = l_10_4
	l_10_8.parent = l_10_3
	l_10_8.rotation = l_10_5
	l_10_6 = l_10_6(l_10_7, l_10_8)
	l_10_0._laser_beam_effect_id = l_10_6
	l_10_6, l_10_7 = l_10_0:_play_effect, l_10_0
	l_10_8 = "start_scan"
	l_10_6(l_10_7, l_10_8)
end

l_0_1.unit_scan_beam_enter = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_11_0)
	-- upvalues: l_0_0
	local l_11_1 = l_11_0._unit
	local l_11_2 = l_11_0._sounds.beam_loop_sound
	if l_11_2 and l_11_2:is_playing() then
		l_11_1:play_at("silence", l_0_0, "crossfade_with", l_11_2, "crossfade_time", 0.5)
	end
	l_11_0:_kill_sound(l_11_0._beam_end_sound)
	l_11_0._beam_end_sound = l_11_1:play_at("spider_beam_end", l_0_0)
	World:effect_manager():kill(l_11_0._laser_beam_effect_id)
	l_11_0._laser_beam_effect_id = nil
	l_11_0:_play_effect("stop_scan")
end

l_0_1.unit_scan_beam_leave = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_12_0, l_12_1)
	managers.sequence:run_sequence_simple(l_12_1, l_12_0._unit)
	l_12_0:_kill_not_playing_sounds()
end

l_0_1._play_effect = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_13_0)
	TableAlgorithms.remove_if(l_13_0._sounds, function(l_14_0)
		return not l_14_0:is_playing()
  end)
end

l_0_1._kill_not_playing_sounds = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_14_0)
	local l_14_4, l_14_5, l_14_6, l_14_7 = nil
	for i_0,i_1 in pairs(l_14_0._sounds) do
		l_14_0:_kill_sound(i_1)
	end
	l_14_0._sounds = nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_1._kill_sounds = l_0_2
l_0_1 = SpiderEffects
l_0_2 = function(l_15_0, l_15_1)
	if l_15_1 and l_15_1:is_playing() then
		l_15_1:stop()
	end
end

l_0_1._kill_sound = l_0_2

