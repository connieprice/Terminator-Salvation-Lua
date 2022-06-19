SoundInstance = SoundInstance or class()
function SoundInstance.init(A0_0, A1_1)
	A0_0._sound_instance = A1_1
	A0_0._wall_clock = TimerManager:game()
	A0_0._start_time = A0_0._wall_clock:time()
end
function SoundInstance.destroy(A0_2)
	local L1_3
	A0_2._sound_instance = nil
end
function SoundInstance.stop(A0_4)
	if alive(A0_4._sound_instance) and A0_4._sound_instance:is_playing() then
		A0_4._sound_instance:stop()
	end
end
function SoundInstance.is_playing(A0_5)
	if not alive(A0_5._sound_instance) or not A0_5._sound_instance:is_playing() then
		return false
	end
	return A0_5._sound_instance:length_in_seconds() + 1 > A0_5._wall_clock:time() - A0_5._start_time
end
