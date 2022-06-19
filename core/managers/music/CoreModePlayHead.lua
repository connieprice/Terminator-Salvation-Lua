local L0_0
L0_0 = core
L0_0 = L0_0.module
L0_0(L0_0, "CoreModePlayHead")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreSoundPlayHead")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreSong")
L0_0 = core
L0_0 = L0_0.require_module
L0_0(L0_0, "CoreClass")
L0_0 = ModePlayHead
if not L0_0 then
	L0_0 = CoreClass
	L0_0 = L0_0.class
	L0_0 = L0_0()
end
ModePlayHead = L0_0
L0_0 = 0
function ModePlayHead.init(A0_1, A1_2, A2_3, A3_4, A4_5)
	local L5_6
	A0_1._song = A1_2
	A0_1._mode_name = A2_3
	A0_1._time_ctrl = A3_4
	A0_1._stopped_cb = A4_5
	L5_6 = _UPVALUE0_
	A0_1._state1 = L5_6
	A0_1._rule = "default"
	A0_1._playhead1 = nil
	A0_1._playhead2 = nil
	A0_1._next_node = nil
	L5_6 = _UPVALUE1_
	A0_1._state2 = L5_6
	A0_1._master_volume = 1
	A0_1._volume = 0
	A0_1._slope = 1
end
function ModePlayHead.update(A0_7, A1_8, A2_9)
	local L3_10
	L3_10 = A0_7._state1
	if L3_10 == _UPVALUE0_ then
	else
		L3_10 = A0_7._state1
		if L3_10 == _UPVALUE1_ then
			L3_10 = A0_7._time_ctrl
			L3_10 = L3_10.time
			L3_10 = L3_10(L3_10)
			if L3_10 > A0_7._playhead1:get_stop_time() then
				L3_10 = A0_7._song
				L3_10 = L3_10.pick_transition
				L3_10 = L3_10(L3_10, A0_7._next_node, A0_7._rule)
				if L3_10.action == "fade_to_end" then
					A0_7._playhead1:set_fadeout(L3_10.wait_fadeout, L3_10.fadeout)
					A0_7._state1 = _UPVALUE2_
				elseif L3_10.action == "continue" then
					A0_7._playhead1:continue_playing(L3_10.new_stop_pos, L3_10.new_section, L3_10.new_section_change_pos)
					A0_7._next_node = L3_10.new_next_node
				elseif L3_10.action == "crossfade" then
					A0_7._playhead2 = A0_7._playhead1
					A0_7._playhead2:set_fadeout(L3_10.wait_fadeout, L3_10.fadeout)
					A0_7._playhead1 = CoreSoundPlayHead.SoundPlayHead:new(L3_10.soundbank_name, L3_10.sound_name, L3_10.bar_offset, A0_7._time_ctrl, A0_7._volume * A0_7._master_volume, A0_7._state2 == _UPVALUE3_)
					A0_7._playhead1:play_synchronized(L3_10.start_pos, L3_10.stop_pos, A0_7._playhead2:get_stop_time(), L3_10.wait_fadein, L3_10.fadein, L3_10.new_section, L3_10.section_change_pos)
					A0_7._mode_name = L3_10.new_mode
					A0_7._next_node = L3_10.next_node
					A0_7._state1 = _UPVALUE4_
				else
					error("unknown transition action")
				end
			end
		else
			L3_10 = A0_7._state1
			if L3_10 == _UPVALUE4_ then
				L3_10 = A0_7._playhead2
				L3_10 = L3_10.is_stopped
				L3_10 = L3_10(L3_10)
				if L3_10 then
					A0_7._playhead2 = nil
					L3_10 = _UPVALUE1_
					A0_7._state1 = L3_10
				end
			else
				L3_10 = A0_7._state1
				if L3_10 == _UPVALUE2_ then
					L3_10 = A0_7._playhead1
					L3_10 = L3_10.is_stopped
					L3_10 = L3_10(L3_10)
					if L3_10 and (not A0_7._playhead2 or not not A0_7._playhead2:is_stopped()) then
						A0_7._stopped_cb(A0_7)
						A0_7._playhead1 = nil
						A0_7._playhead2 = nil
						A0_7._state1 = _UPVALUE5_
						A0_7._state2 = _UPVALUE6_
					end
				else
					L3_10 = A0_7._state1
					if L3_10 == _UPVALUE5_ then
					end
				end
			end
		end
	end
	L3_10 = A0_7._state2
	if L3_10 == _UPVALUE6_ then
	else
		L3_10 = A0_7._state2
		if L3_10 == _UPVALUE7_ then
			L3_10 = A0_7._time_ctrl
			L3_10 = L3_10.time
			L3_10 = L3_10(L3_10)
			if L3_10 > A0_7._start_fade_time then
				L3_10 = math
				L3_10 = L3_10.min
				L3_10 = L3_10(A0_7._volume + A0_7._slope * A2_9, 1)
				A0_7._volume = L3_10
				L3_10 = A0_7._playhead1
				if L3_10 then
					L3_10 = A0_7._playhead1
					L3_10 = L3_10.set_master_volume
					L3_10(L3_10, A0_7._volume * A0_7._master_volume)
				end
				L3_10 = A0_7._playhead2
				if L3_10 then
					L3_10 = A0_7._playhead2
					L3_10 = L3_10.set_master_volume
					L3_10(L3_10, A0_7._volume * A0_7._master_volume)
				end
				L3_10 = A0_7._volume
				if L3_10 == 1 then
					L3_10 = _UPVALUE6_
					A0_7._state2 = L3_10
				end
			end
		else
			L3_10 = A0_7._state2
			if L3_10 == _UPVALUE3_ then
				L3_10 = A0_7._time_ctrl
				L3_10 = L3_10.time
				L3_10 = L3_10(L3_10)
				if L3_10 > A0_7._start_fade_time then
					L3_10 = math
					L3_10 = L3_10.max
					L3_10 = L3_10(A0_7._volume + A0_7._slope * A2_9, 0)
					A0_7._volume = L3_10
					L3_10 = A0_7._playhead1
					if L3_10 then
						L3_10 = A0_7._playhead1
						L3_10 = L3_10.set_master_volume
						L3_10(L3_10, A0_7._volume * A0_7._master_volume)
					end
					L3_10 = A0_7._playhead2
					if L3_10 then
						L3_10 = A0_7._playhead2
						L3_10 = L3_10.set_master_volume
						L3_10(L3_10, A0_7._volume * A0_7._master_volume)
					end
					L3_10 = A0_7._volume
					if L3_10 == 0 then
						L3_10 = A0_7._playhead1
						if L3_10 then
							L3_10 = A0_7._playhead1
							L3_10 = L3_10.stop_now
							L3_10(L3_10)
						end
						L3_10 = A0_7._playhead2
						if L3_10 then
							L3_10 = A0_7._playhead2
							L3_10 = L3_10.stop_now
							L3_10(L3_10)
						end
						L3_10 = _UPVALUE2_
						A0_7._state1 = L3_10
						L3_10 = _UPVALUE6_
						A0_7._state2 = L3_10
					end
				end
			end
		end
	end
	L3_10 = A0_7._time_ctrl
	L3_10 = L3_10.time
	L3_10 = L3_10(L3_10)
	if A0_7._playhead1 then
		A0_7._playhead1:update(A1_8, A2_9, L3_10)
	end
	if A0_7._playhead2 then
		A0_7._playhead2:update(A1_8, A2_9, L3_10)
	end
end
function ModePlayHead.play(A0_11, A1_12)
	local L2_13
	L2_13 = A0_11._state1
	if L2_13 == _UPVALUE0_ then
		if A1_12 == 0 then
			L2_13 = A0_11._master_volume
			A0_11._volume = L2_13
			L2_13 = _UPVALUE1_
			A0_11._state2 = L2_13
		else
			A0_11._volume = 0
			L2_13 = A0_11._time_ctrl
			L2_13 = L2_13.time
			L2_13 = L2_13(L2_13)
			A0_11._start_fade_time = L2_13
			L2_13 = math
			L2_13 = L2_13.max
			L2_13 = L2_13(A1_12, 0.01)
			L2_13 = 1 / L2_13
			A0_11._slope = L2_13
			L2_13 = _UPVALUE2_
			A0_11._state2 = L2_13
		end
		L2_13 = A0_11._song
		L2_13 = L2_13.get_default_start_node
		L2_13 = L2_13(L2_13, A0_11._mode_name)
		A0_11._playhead1 = CoreSoundPlayHead.SoundPlayHead:new(A0_11._song:pick_start_transition(L2_13).soundbank_name, A0_11._song:pick_start_transition(L2_13).sound_name, A0_11._song:pick_start_transition(L2_13).bar_offset, A0_11._time_ctrl, A0_11._volume * A0_11._master_volume, false)
		A0_11._playhead1:play(A0_11._song:pick_start_transition(L2_13).start_pos, A0_11._song:pick_start_transition(L2_13).stop_pos, A0_11._song:pick_start_transition(L2_13).fadein, A0_11._song:pick_start_transition(L2_13).new_section, A0_11._song:pick_start_transition(L2_13).section_change_pos)
		A0_11._mode_name = A0_11._song:pick_start_transition(L2_13).new_mode
		A0_11._next_node = A0_11._song:pick_start_transition(L2_13).next_node
		A0_11._state1 = _UPVALUE3_
	else
		L2_13 = error
		L2_13("Can only play fresh ModePlayHead")
	end
end
function ModePlayHead.play_synchronized(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19, A6_20)
	if A0_14._state1 == _UPVALUE0_ then
		A0_14._volume = 0
		A0_14._start_fade_time = A0_14._time_ctrl:time() + A5_19
		A0_14._slope = 1 / math.max(A6_20, 0.01)
		A0_14._state2 = _UPVALUE1_
		A0_14._playhead1 = CoreSoundPlayHead.SoundPlayHead:new(A0_14._song:pick_start_transition(A1_15).soundbank_name, A0_14._song:pick_start_transition(A1_15).sound_name, A0_14._song:pick_start_transition(A1_15).bar_offset, A0_14._time_ctrl, A0_14._volume * A0_14._master_volume, false)
		A0_14._playhead1:play_synchronized(A0_14._song:pick_start_transition(A1_15).start_pos, A0_14._song:pick_start_transition(A1_15).stop_pos, A0_14._time_ctrl:time() - A2_16 - ((A4_18 - (A0_14._song:pick_start_transition(A1_15).start_pos + (A3_17 - (A0_14._time_ctrl:time() - A2_16)) - A0_14._song:pick_start_transition(A1_15).bar_offset) % (tonumber(A0_14._song:get_mode(A0_14._mode_name).time_signature) * 60 / tonumber(A0_14._song:get_mode(A0_14._mode_name).bpm)) / (tonumber(A0_14._song:get_mode(A0_14._mode_name).time_signature) * 60 / tonumber(A0_14._song:get_mode(A0_14._mode_name).bpm)) + CoreSong.ENGINE_WAIT / 2 / (tonumber(A0_14._song:get_mode(A0_14._mode_name).time_signature) * 60 / tonumber(A0_14._song:get_mode(A0_14._mode_name).bpm))) % 1 - CoreSong.ENGINE_WAIT / 2 / (tonumber(A0_14._song:get_mode(A0_14._mode_name).time_signature) * 60 / tonumber(A0_14._song:get_mode(A0_14._mode_name).bpm))) * (tonumber(A0_14._song:get_mode(A0_14._mode_name).time_signature) * 60 / tonumber(A0_14._song:get_mode(A0_14._mode_name).bpm)), A0_14._song:pick_start_transition(A1_15).wait_fadein, A0_14._song:pick_start_transition(A1_15).fadein, A0_14._song:pick_start_transition(A1_15).new_section, A0_14._song:pick_start_transition(A1_15).section_change_pos)
		A0_14._mode_name = A0_14._song:pick_start_transition(A1_15).new_mode
		A0_14._next_node = A0_14._song:pick_start_transition(A1_15).next_node
		A0_14._state1 = _UPVALUE2_
	else
		error("Can only play fresh ModePlayHead")
	end
end
function ModePlayHead.stop_nice(A0_21)
	local L1_22
	L1_22 = A0_21._state1
	if L1_22 == _UPVALUE0_ then
		L1_22 = A0_21._stopped_cb
		L1_22(A0_21)
		L1_22 = _UPVALUE1_
		A0_21._state1 = L1_22
	else
		L1_22 = A0_21._state1
		if L1_22 == _UPVALUE2_ then
			L1_22 = A0_21._song
			L1_22 = L1_22.get_use_fadeout_to_stop_mode
			L1_22 = L1_22(L1_22, A0_21._mode_name)
			if L1_22 then
				A0_21:stop_with_fadeout(0, L1_22)
			else
				A0_21._rule = A0_21._song:get_stop_rule()
			end
		else
			L1_22 = A0_21._state1
			if L1_22 == _UPVALUE3_ then
				L1_22 = A0_21._song
				L1_22 = L1_22.get_use_fadeout_to_stop_mode
				L1_22 = L1_22(L1_22, A0_21._mode_name)
				if L1_22 then
					A0_21:stop_with_fadeout(0, L1_22)
				else
					A0_21._rule = A0_21._song:get_stop_rule()
				end
			else
				L1_22 = A0_21._state1
				if L1_22 == _UPVALUE4_ then
				else
					L1_22 = A0_21._state1
					if L1_22 == _UPVALUE1_ then
					end
				end
			end
		end
	end
end
function ModePlayHead.stop_with_fadeout(A0_23, A1_24, A2_25)
	if A0_23._state1 == _UPVALUE0_ then
		A0_23._stopped_cb(A0_23)
		A0_23._state1 = _UPVALUE1_
	elseif A0_23._state1 == _UPVALUE1_ then
	else
		A0_23._start_fade_time = A0_23._time_ctrl:time() + A1_24
		A0_23._slope = math.min(-1 / math.max(A2_25, 0.01), A0_23._slope)
		A0_23._state2 = _UPVALUE2_
	end
end
function ModePlayHead.set_rule(A0_26, A1_27)
	A0_26._rule = A1_27
end
function ModePlayHead.set_master_volume(A0_28, A1_29)
	A0_28._master_volume = A1_29
	if A0_28._playhead1 then
		A0_28._playhead1:set_master_volume(A0_28._volume * A0_28._master_volume)
	end
	if A0_28._playhead2 then
		A0_28._playhead2:set_master_volume(A0_28._volume * A0_28._master_volume)
	end
end
function ModePlayHead.get_mode(A0_30)
	local L1_31
	L1_31 = A0_30._mode_name
	return L1_31
end
function ModePlayHead.get_section_info(A0_32)
	local L1_33, L2_34
	L1_33 = A0_32._state1
	L2_34 = _UPVALUE0_
	if L1_33 ~= L2_34 then
		L1_33 = A0_32._state1
		L2_34 = _UPVALUE1_
		if L1_33 ~= L2_34 then
			L1_33 = A0_32._state1
			L2_34 = _UPVALUE2_
		end
	else
		if L1_33 == L2_34 then
			L1_33 = A0_32._playhead1
			L2_34 = L1_33
			L1_33 = L1_33.get_section_info
			L2_34 = L1_33(L2_34)
			if L2_34 < 0 and A0_32.playhead2 then
				L1_33, L2_34 = A0_32._playhead2:get_section_info()
			end
			L2_34 = math.max(0, L2_34)
			return {section = L1_33, time_since_jump = L2_34}
	end
	else
		L1_33 = error
		L2_34 = "ModePlayHead:get_section_info() called in wrong state, contact core team..."
		L1_33(L2_34)
	end
end
function ModePlayHead.get_timing_info(A0_35, A1_36)
	if A0_35._state1 == _UPVALUE0_ or A0_35._state1 == _UPVALUE1_ or A0_35._state1 == _UPVALUE2_ then
		return {
			mode_name = A0_35._mode_name,
			bpm = A0_35._song:get_mode(A0_35._mode_name).bpm,
			time_signature = A0_35._song:get_mode(A0_35._mode_name).time_signature,
			bar_pos = (A0_35._playhead1:get_timing_info().start_pos + (A1_36 - A0_35._playhead1:get_timing_info().start_time) - A0_35._playhead1:get_timing_info().bar_offset) / (A0_35._song:get_mode(A0_35._mode_name).time_signature * 60 / A0_35._song:get_mode(A0_35._mode_name).bpm) % 1,
			bar_len = A0_35._song:get_mode(A0_35._mode_name).time_signature * 60 / A0_35._song:get_mode(A0_35._mode_name).bpm
		}
	else
		error("ModePlayHead:get_now_playing() called in wrong state, contact core team...")
	end
end
function ModePlayHead.is_playing(A0_37)
	local L1_38, L2_39
	L1_38 = A0_37._state1
	L2_39 = _UPVALUE0_
	if L1_38 ~= L2_39 then
		L1_38 = A0_37._state1
		L2_39 = _UPVALUE1_
		if L1_38 ~= L2_39 then
			L1_38 = A0_37._state1
			L2_39 = _UPVALUE2_
		end
	else
		if L1_38 == L2_39 then
			L1_38 = true
			return L1_38
	end
	else
		L1_38 = false
		return L1_38
	end
end
