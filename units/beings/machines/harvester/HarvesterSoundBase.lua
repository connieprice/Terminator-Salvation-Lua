if not HarvesterSoundBase then
	HarvesterSoundBase = class()
end
HarvesterSoundBase._SOUND_OUTPUT_OBJECT_NAME = "rp_empty"
HarvesterSoundBase.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._sound_output_object = l_1_0._unit:get_object(HarvesterSoundBase._SOUND_OUTPUT_OBJECT_NAME)
	l_1_0._step_sound = nil
	l_1_0._step_sound_instance_left = nil
	l_1_0._step_sound_instance_right = nil
	l_1_0._step_sound_cnt = 0
	l_1_0._step_sound_time = 0
	l_1_0._scream_sound = nil
	l_1_0._scream_sound_instance = nil
	l_1_0._scream_sound_time = 0
	l_1_0._velocity = nil
	l_1_0._eta = nil
	l_1_0:_init_sounds()
end

HarvesterSoundBase._init_sounds = function(l_2_0, l_2_1)
	l_2_0._step_sound = Sound:make_bank(l_2_0._soundbank_name, l_2_0._step_sound_name)
	l_2_0._step_sound:set_output(l_2_0._sound_output_object)
	l_2_0._scream_sound = Sound:make_bank(l_2_0._soundbank_name, l_2_0._scream_sound_name)
	l_2_0._scream_sound:set_output(l_2_0._sound_output_object)
end

HarvesterSoundBase.start_move = function(l_3_0, l_3_1, l_3_2)
	local l_3_3 = l_3_2 - l_3_0._unit:position()
	local l_3_4 = l_3_3:length()
	l_3_0._velocity = l_3_3:normalized() * l_3_1
	l_3_0._eta = Application:time() + l_3_4 / l_3_1
end

HarvesterSoundBase.update = function(l_4_0, l_4_1, l_4_2, l_4_3)
	l_4_0:_update_step_sound(l_4_2, l_4_3)
	l_4_0:_update_scream_sound(l_4_2, l_4_3)
	l_4_0:_update_move(l_4_2, l_4_3)
	if Global.category_debug_render.harvester_boss then
		l_4_0:_debug()
	end
end

HarvesterSoundBase._update_step_sound = function(l_5_0, l_5_1, l_5_2)
	if l_5_0._step_sound_time <= l_5_1 then
		if l_5_0._step_sound_cnt % 2 == 0 then
			l_5_0._step_sound_instance_left = l_5_0._step_sound:play()
		else
			l_5_0._step_sound_instance_right = l_5_0._step_sound:play()
		end
		managers.rumble:play_preset(l_5_0._rumble_effect, l_5_0._sound_output_object:position())
		local l_5_3 = l_5_0._step_sound_min_delay + math.random() * (l_5_0._step_sound_max_delay - l_5_0._step_sound_min_delay)
		l_5_0._step_sound_time = Application:time() + l_5_3
		l_5_0._step_sound_cnt = l_5_0._step_sound_cnt + 1
	end
end

HarvesterSoundBase._update_scream_sound = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._scream_sound_time <= l_6_1 then
		l_6_0._scream_sound_instance = l_6_0._scream_sound:play()
		local l_6_3 = l_6_0._scream_sound_min_delay + math.random() * (l_6_0._scream_sound_max_delay - l_6_0._scream_sound_min_delay)
		l_6_0._scream_sound_time = Application:time() + l_6_3
	end
end

HarvesterSoundBase._update_move = function(l_7_0, l_7_1, l_7_2)
	if l_7_0._eta and l_7_0._eta <= l_7_1 then
		l_7_0._unit:set_slot(0)
	elseif l_7_0._velocity then
		l_7_0._unit:move(l_7_0._velocity * l_7_2)
	end
end

HarvesterSoundBase.destroy = function(l_8_0)
	if alive(l_8_0._step_sound_instance_left) then
		l_8_0._step_sound_instance_left:stop()
	end
	if alive(l_8_0._step_sound_instance_right) then
		l_8_0._step_sound_instance_right:stop()
	end
	if alive(l_8_0._scream_sound_instance) then
		l_8_0._scream_sound_instance:stop()
	end
end

HarvesterSoundBase._debug = function(l_9_0)
	local l_9_1 = Draw:brush()
	l_9_1:set_color(Color(1, 1, 0, 0))
	l_9_1:sphere(l_9_0._unit:position(), 100)
end


