HarvesterSoundBase = HarvesterSoundBase or class()
HarvesterSoundBase._SOUND_OUTPUT_OBJECT_NAME = "rp_empty"
function HarvesterSoundBase.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._sound_output_object = A0_0._unit:get_object(HarvesterSoundBase._SOUND_OUTPUT_OBJECT_NAME)
	A0_0._step_sound = nil
	A0_0._step_sound_instance_left = nil
	A0_0._step_sound_instance_right = nil
	A0_0._step_sound_cnt = 0
	A0_0._step_sound_time = 0
	A0_0._scream_sound = nil
	A0_0._scream_sound_instance = nil
	A0_0._scream_sound_time = 0
	A0_0._velocity = nil
	A0_0._eta = nil
	A0_0:_init_sounds()
end
function HarvesterSoundBase._init_sounds(A0_2, A1_3)
	A0_2._step_sound = Sound:make_bank(A0_2._soundbank_name, A0_2._step_sound_name)
	A0_2._step_sound:set_output(A0_2._sound_output_object)
	A0_2._scream_sound = Sound:make_bank(A0_2._soundbank_name, A0_2._scream_sound_name)
	A0_2._scream_sound:set_output(A0_2._sound_output_object)
end
function HarvesterSoundBase.start_move(A0_4, A1_5, A2_6)
	A0_4._velocity = (A2_6 - A0_4._unit:position()):normalized() * A1_5
	A0_4._eta = Application:time() + (A2_6 - A0_4._unit:position()):length() / A1_5
end
function HarvesterSoundBase.update(A0_7, A1_8, A2_9, A3_10)
	A0_7:_update_step_sound(A2_9, A3_10)
	A0_7:_update_scream_sound(A2_9, A3_10)
	A0_7:_update_move(A2_9, A3_10)
	if Global.category_debug_render.harvester_boss then
		A0_7:_debug()
	end
end
function HarvesterSoundBase._update_step_sound(A0_11, A1_12, A2_13)
	if A1_12 >= A0_11._step_sound_time then
		if A0_11._step_sound_cnt % 2 == 0 then
			A0_11._step_sound_instance_left = A0_11._step_sound:play()
		else
			A0_11._step_sound_instance_right = A0_11._step_sound:play()
		end
		managers.rumble:play_preset(A0_11._rumble_effect, A0_11._sound_output_object:position())
		A0_11._step_sound_time = Application:time() + (A0_11._step_sound_min_delay + math.random() * (A0_11._step_sound_max_delay - A0_11._step_sound_min_delay))
		A0_11._step_sound_cnt = A0_11._step_sound_cnt + 1
	end
end
function HarvesterSoundBase._update_scream_sound(A0_14, A1_15, A2_16)
	if A1_15 >= A0_14._scream_sound_time then
		A0_14._scream_sound_instance = A0_14._scream_sound:play()
		A0_14._scream_sound_time = Application:time() + (A0_14._scream_sound_min_delay + math.random() * (A0_14._scream_sound_max_delay - A0_14._scream_sound_min_delay))
	end
end
function HarvesterSoundBase._update_move(A0_17, A1_18, A2_19)
	if A0_17._eta and A1_18 >= A0_17._eta then
		A0_17._unit:set_slot(0)
	elseif A0_17._velocity then
		A0_17._unit:move(A0_17._velocity * A2_19)
	end
end
function HarvesterSoundBase.destroy(A0_20)
	if alive(A0_20._step_sound_instance_left) then
		A0_20._step_sound_instance_left:stop()
	end
	if alive(A0_20._step_sound_instance_right) then
		A0_20._step_sound_instance_right:stop()
	end
	if alive(A0_20._scream_sound_instance) then
		A0_20._scream_sound_instance:stop()
	end
end
function HarvesterSoundBase._debug(A0_21)
	Draw:brush():set_color(Color(1, 1, 0, 0))
	Draw:brush():sphere(A0_21._unit:position(), 100)
end
