local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreSoundPlayHead")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
L0_0 = SoundPlayHead
if not L0_0 then
	L0_0 = CoreClass
	L0_0 = L0_0.class
	L0_0 = L0_0()
end
SoundPlayHead = L0_0
L0_0 = 0
ENGINE_PLAY_SPEED = 1
function SoundPlayHead.init(A0_1, A1_2, A2_3, A3_4, A4_5, A5_6, A6_7)
	A0_1._soundbank_name = A1_2
	A0_1._sound_name = A2_3
	A0_1._bar_offset = A3_4
	A0_1._time_ctrl = A4_5
	A0_1._master_volume = A5_6
	A0_1._master_changed = false
	A0_1._state = _UPVALUE0_
	A0_1._sound_object = A0_1._time_ctrl:new_soundobject(A1_2, A2_3, A6_7)
end
function SoundPlayHead.update(A0_8, A1_9, A2_10, A3_11)
	local L4_12, L5_13
	L4_12 = A0_8._state
	L5_13 = _UPVALUE0_
	if L4_12 == L5_13 then
	else
		L4_12 = A0_8._state
		L5_13 = _UPVALUE1_
		if L4_12 == L5_13 then
			L4_12 = A0_8._time_ctrl
			L5_13 = L4_12
			L4_12 = L4_12.time
			L4_12 = L4_12(L5_13)
			A0_8._start_time = L4_12
			A0_8._master_changed = false
			L4_12 = A0_8._fade
			if L4_12 == 0 then
				L4_12 = A0_8._sound_object
				L5_13 = L4_12
				L4_12 = L4_12.set_control
				L4_12(L5_13, "gain_abs", A0_8._master_volume)
				L4_12 = A0_8._sound_object
				L5_13 = L4_12
				L4_12 = L4_12.play
				L4_12(L5_13, "offset", ENGINE_PLAY_SPEED * A0_8._start_pos)
				L4_12 = _UPVALUE2_
				A0_8._state = L4_12
			else
				L4_12 = A0_8._start_time
				L5_13 = A0_8._fade
				L4_12 = L4_12 + L5_13
				A0_8._fade_complete_time = L4_12
				L4_12 = A0_8._sound_object
				L5_13 = L4_12
				L4_12 = L4_12.set_control_ramp
				L4_12(L5_13, "gain_abs", 0, A0_8._master_volume, A0_8._fade)
				L4_12 = A0_8._sound_object
				L5_13 = L4_12
				L4_12 = L4_12.play
				L4_12(L5_13, "offset", ENGINE_PLAY_SPEED * A0_8._start_pos)
				L4_12 = _UPVALUE3_
				A0_8._state = L4_12
			end
		else
			L4_12 = A0_8._state
			L5_13 = _UPVALUE4_
			if L4_12 == L5_13 then
				L4_12 = A0_8._time_ctrl
				L5_13 = L4_12
				L4_12 = L4_12.time
				L4_12 = L4_12(L5_13)
				L5_13 = A0_8._start_time
				L4_12 = L4_12 - L5_13
				L5_13 = A0_8._sound_object
				L5_13 = L5_13.play
				L5_13(L5_13, "running_offset", ENGINE_PLAY_SPEED * (A0_8._start_pos + L4_12))
				L5_13 = A0_8._sound_object
				L5_13 = L5_13.set_control
				L5_13(L5_13, "gain_abs", 0)
				L5_13 = A0_8._start_time
				L5_13 = L5_13 + A0_8._wait
				A0_8._start_fade_time = L5_13
				L5_13 = _UPVALUE5_
				A0_8._state = L5_13
			else
				L4_12 = A0_8._state
				L5_13 = _UPVALUE5_
				if L4_12 == L5_13 then
					L4_12 = A0_8._start_fade_time
					if A3_11 > L4_12 then
						L4_12 = A0_8._fade
						L4_12 = A3_11 + L4_12
						A0_8._fade_complete_time = L4_12
						L4_12 = A0_8._sound_object
						L5_13 = L4_12
						L4_12 = L4_12.set_control_ramp
						L4_12(L5_13, "gain_abs", 0, A0_8._master_volume, A0_8._fade)
						A0_8._master_changed = false
						L4_12 = _UPVALUE3_
						A0_8._state = L4_12
					end
				else
					L4_12 = A0_8._state
					L5_13 = _UPVALUE3_
					if L4_12 == L5_13 then
						L4_12 = A0_8._fade_complete_time
						L4_12 = L4_12 - A3_11
						if L4_12 <= 0 then
							L5_13 = _UPVALUE2_
							A0_8._state = L5_13
						else
							L5_13 = A0_8._master_changed
							if L5_13 then
								L5_13 = A0_8._sound_object
								L5_13 = L5_13.get_control
								L5_13 = L5_13(L5_13, "gain_abs")
								A0_8._sound_object:set_control_ramp("gain_abs", L5_13, A0_8._master_volume, math.max(L4_12, A2_10))
								A0_8._master_changed = false
							end
						end
					else
						L4_12 = A0_8._state
						L5_13 = _UPVALUE2_
						if L4_12 == L5_13 then
							L4_12 = A0_8._master_changed
							if L4_12 then
								L4_12 = A0_8._sound_object
								L5_13 = L4_12
								L4_12 = L4_12.get_control
								L4_12 = L4_12(L5_13, "gain_abs")
								L5_13 = A0_8._sound_object
								L5_13 = L5_13.set_control_ramp
								L5_13(L5_13, "gain_abs", L4_12, A0_8._master_volume, A2_10)
								A0_8._master_changed = false
							end
						else
							L4_12 = A0_8._state
							L5_13 = _UPVALUE6_
							if L4_12 == L5_13 then
								L4_12 = A0_8._start_fade_time
								if A3_11 > L4_12 then
									L4_12 = A0_8._fade
									L4_12 = A3_11 + L4_12
									A0_8._fade_complete_time = L4_12
									L4_12 = A0_8._sound_object
									L5_13 = L4_12
									L4_12 = L4_12.get_control
									L4_12 = L4_12(L5_13, "gain_abs")
									L5_13 = A0_8._sound_object
									L5_13 = L5_13.set_control_ramp
									L5_13(L5_13, "gain_abs", L4_12, 0, A0_8._fade)
									L5_13 = _UPVALUE7_
									A0_8._state = L5_13
								else
									L4_12 = A0_8._master_changed
									if L4_12 then
										L4_12 = A0_8._sound_object
										L5_13 = L4_12
										L4_12 = L4_12.get_control
										L4_12 = L4_12(L5_13, "gain_abs")
										L5_13 = A0_8._sound_object
										L5_13 = L5_13.set_control_ramp
										L5_13(L5_13, "gain_abs", L4_12, A0_8._master_volume, A2_10)
										A0_8._master_changed = false
									end
								end
							else
								L4_12 = A0_8._state
								L5_13 = _UPVALUE7_
								if L4_12 == L5_13 then
									L4_12 = A0_8._fade_complete_time
									L4_12 = L4_12 - A3_11
									if L4_12 <= -0.25 then
										L5_13 = A0_8._sound_object
										L5_13 = L5_13.stop
										L5_13(L5_13)
										A0_8._sound_object = nil
										L5_13 = _UPVALUE8_
										A0_8._state = L5_13
									end
								else
									L4_12 = A0_8._state
									L5_13 = _UPVALUE8_
									if L4_12 == L5_13 then
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
function SoundPlayHead.play(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19)
	if A0_14._state == _UPVALUE0_ then
		A0_14._start_pos = A1_15
		A0_14._stop_pos = A2_16
		A0_14._start_time = A0_14._time_ctrl:time()
		A0_14._wait = 0
		A0_14._fade = A3_17
		A0_14._new_section = A4_18
		A0_14._section_change_pos = A5_19
		A0_14._state = _UPVALUE1_
	else
		error("Can only play a fresh SoundPlayHead")
	end
end
function SoundPlayHead.play_synchronized(A0_20, A1_21, A2_22, A3_23, A4_24, A5_25, A6_26, A7_27)
	if A0_20._state == _UPVALUE0_ then
		A0_20._start_pos = A1_21
		A0_20._stop_pos = A2_22
		A0_20._start_time = A3_23
		A0_20._wait = A4_24
		A0_20._fade = math.max(A5_25, 0.01)
		A0_20._new_section = A6_26
		A0_20._section_change_pos = A7_27
		if A0_20._time_ctrl:time() < A0_20:get_stop_time() then
			A0_20._state = _UPVALUE1_
		else
			A0_20._state = _UPVALUE0_
		end
	else
		error("Can only play a fresh SoundPlayHead")
	end
end
function SoundPlayHead.continue_playing(A0_28, A1_29, A2_30, A3_31)
	if A0_28._state == _UPVALUE0_ then
		A0_28._stop_pos = A1_29
		A0_28._new_section = A2_30
		A0_28._section_change_pos = A3_31
		assert(A0_28._start_pos)
		assert(A0_28._start_time)
		assert(A0_28._wait)
		assert(A0_28._fade)
		if A0_28._time_ctrl:time() < A0_28:get_stop_time() then
			A0_28._state = _UPVALUE1_
		else
			A0_28._state = _UPVALUE0_
		end
	elseif A0_28._state == _UPVALUE2_ or A0_28._state == _UPVALUE1_ or A0_28._state == _UPVALUE3_ or A0_28._state == _UPVALUE4_ or A0_28._state == _UPVALUE5_ then
		A0_28._stop_pos = A1_29
		A0_28._new_section = A2_30
		A0_28._section_change_pos = A3_31
	elseif A0_28._state == _UPVALUE6_ or A0_28._state == _UPVALUE7_ or A0_28._state == _UPVALUE8_ then
		error("'SoundPlayHead:set_new_stop_pos' in wrong state (" .. A0_28._state .. "), contact core team.")
	end
end
function SoundPlayHead.set_fadeout(A0_32, A1_33, A2_34)
	if A0_32._state == _UPVALUE0_ then
		A0_32._state = _UPVALUE1_
	elseif A0_32._state == _UPVALUE2_ then
		A0_32._state = _UPVALUE1_
	elseif A0_32._state == _UPVALUE3_ then
		A0_32._state = _UPVALUE1_
	elseif A0_32._state == _UPVALUE4_ then
		A0_32._state = _UPVALUE1_
	elseif A0_32._state == _UPVALUE5_ then
		A0_32._start_fade_time = A0_32:get_stop_time() + A1_33
		A0_32._fade = math.max(A2_34, 0.01)
		A0_32._state = _UPVALUE6_
	elseif A0_32._state == _UPVALUE7_ then
		A0_32._start_fade_time = A0_32:get_stop_time() + A1_33
		A0_32._fade = math.max(A2_34, 0.01)
		A0_32._state = _UPVALUE6_
	elseif A0_32._state == _UPVALUE6_ then
		A0_32._start_fade_time = math.min(A0_32._start_fade_time, A0_32:get_stop_time() + A1_33)
		A0_32._fade = math.max(math.min(A0_32._fade, A2_34), 0.01)
	elseif A0_32._state == _UPVALUE8_ then
	elseif A0_32._state == _UPVALUE1_ then
	end
end
function SoundPlayHead.stop_now(A0_35)
	if A0_35._state == _UPVALUE0_ then
		A0_35._state = _UPVALUE1_
	elseif A0_35._state == _UPVALUE2_ then
		A0_35._state = _UPVALUE1_
	elseif A0_35._state == _UPVALUE3_ then
		A0_35._state = _UPVALUE1_
	elseif A0_35._state == _UPVALUE4_ then
		A0_35._state = _UPVALUE1_
	elseif A0_35._state == _UPVALUE5_ then
		A0_35:_stop_now()
	elseif A0_35._state == _UPVALUE6_ then
		A0_35:_stop_now()
	elseif A0_35._state == _UPVALUE7_ then
		A0_35:_stop_now()
	elseif A0_35._state == _UPVALUE8_ then
		A0_35:_stop_now()
	elseif A0_35._state == _UPVALUE1_ then
	end
end
function SoundPlayHead._stop_now(A0_36)
	local L1_37
	A0_36._fade = 0.01
	L1_37 = A0_36._time_ctrl
	L1_37 = L1_37.time
	L1_37 = L1_37(L1_37)
	L1_37 = L1_37 + A0_36._fade
	A0_36._fade_complete_time = L1_37
	L1_37 = A0_36._sound_object
	L1_37 = L1_37.get_control
	L1_37 = L1_37(L1_37, "gain_abs")
	A0_36._sound_object:set_control_ramp("gain_abs", L1_37, 0, A0_36._fade)
	A0_36._state = _UPVALUE0_
end
function SoundPlayHead.get_section_info(A0_38)
	local L1_39
	L1_39 = A0_38._time_ctrl
	L1_39 = L1_39.time
	L1_39 = L1_39(L1_39)
	L1_39 = L1_39 - A0_38._start_time
	L1_39 = L1_39 - (A0_38._section_change_pos - A0_38._start_pos)
	return A0_38._new_section, L1_39
end
function SoundPlayHead.get_timing_info(A0_40)
	local L1_41, L2_42
	L1_41 = {}
	L2_42 = A0_40._start_pos
	L1_41.start_pos = L2_42
	L2_42 = A0_40._start_time
	L1_41.start_time = L2_42
	L2_42 = A0_40._bar_offset
	L1_41.bar_offset = L2_42
	return L1_41
end
function SoundPlayHead.get_stop_time(A0_43)
	local L2_44
	L2_44 = A0_43._start_time
	L2_44 = L2_44 + (A0_43._stop_pos - A0_43._start_pos)
	return L2_44
end
function SoundPlayHead.is_stopped(A0_45)
	return A0_45._state == _UPVALUE0_
end
function SoundPlayHead.set_master_volume(A0_46, A1_47)
	A0_46._master_volume = A1_47
	A0_46._master_changed = true
end
