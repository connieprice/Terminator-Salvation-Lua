if not SoundInstance then
	SoundInstance = class()
end
SoundInstance.init = function(l_1_0, l_1_1)
	l_1_0._sound_instance = l_1_1
	l_1_0._wall_clock = TimerManager:game()
	l_1_0._start_time = l_1_0._wall_clock:time()
end

SoundInstance.destroy = function(l_2_0)
	l_2_0._sound_instance = nil
end

SoundInstance.stop = function(l_3_0)
	if alive(l_3_0._sound_instance) and l_3_0._sound_instance:is_playing() then
		l_3_0._sound_instance:stop()
	end
end

SoundInstance.is_playing = function(l_4_0)
	if not alive(l_4_0._sound_instance) or not l_4_0._sound_instance:is_playing() then
		return false
	end
	return l_4_0._wall_clock:time() - l_4_0._start_time < l_4_0._sound_instance:length_in_seconds() + 1
end


