if not SyncedSoundManager then
	SyncedSoundManager = class()
end
SyncedSoundManager.init = function(l_1_0)
	l_1_0._time_scale = 1
	TimerManager:ramp_multiplier(TimerManager:game(), 1, 0.001, TimerManager:pausable())
	TimerManager:ramp_multiplier(TimerManager:game_animation(), 1, 0.001, TimerManager:pausable())
end

SyncedSoundManager.set_time_scale = function(l_2_0, l_2_1)
	l_2_0._time_scale = l_2_1
end

SyncedSoundManager.get_speed = function(l_3_0)
	return l_3_0._time_scale
end

SyncedSoundManager.time_scaled = function(l_4_0)
	return l_4_0._time_scale ~= 1
end

SyncedSoundManager.set_prime_sound = function(l_5_0, l_5_1)
	l_5_0._next_sound_object = l_5_1
end

SyncedSoundManager.set_paused = function(l_6_0, l_6_1)
	if l_6_0._time_scale ~= 1 then
		if l_6_1 then
			TimerManager:ramp_multiplier(TimerManager:game(), 1, 0.001, TimerManager:pausable())
			TimerManager:ramp_multiplier(TimerManager:game_animation(), 1, 0.001, TimerManager:pausable())
		end
	else
		TimerManager:ramp_multiplier(TimerManager:game(), l_6_0._time_scale, 0.001, TimerManager:pausable())
		TimerManager:ramp_multiplier(TimerManager:game_animation(), l_6_0._time_scale, 0.001, TimerManager:pausable())
	end
end


