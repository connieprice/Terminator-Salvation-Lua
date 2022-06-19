SyncedSoundManager = SyncedSoundManager or class()
function SyncedSoundManager.init(A0_0)
	local L1_1, L2_2
	A0_0._time_scale = 1
	L1_1 = TimerManager
	L2_2 = L1_1
	L1_1 = L1_1.ramp_multiplier
	L1_1(L2_2, TimerManager:game(), 1, 0.001, TimerManager:pausable())
	L1_1 = TimerManager
	L2_2 = L1_1
	L1_1 = L1_1.ramp_multiplier
	L1_1(L2_2, TimerManager:game_animation(), 1, 0.001, TimerManager:pausable())
end
function SyncedSoundManager.set_time_scale(A0_3, A1_4)
	A0_3._time_scale = A1_4
end
function SyncedSoundManager.get_speed(A0_5)
	local L1_6
	L1_6 = A0_5._time_scale
	return L1_6
end
function SyncedSoundManager.time_scaled(A0_7)
	return A0_7._time_scale ~= 1
end
function SyncedSoundManager.set_prime_sound(A0_8, A1_9)
	A0_8._next_sound_object = A1_9
end
function SyncedSoundManager.set_paused(A0_10, A1_11)
	local L2_12, L3_13
	L2_12 = A0_10._time_scale
	if L2_12 ~= 1 then
		if A1_11 then
			L2_12 = TimerManager
			L3_13 = L2_12
			L2_12 = L2_12.ramp_multiplier
			L2_12(L3_13, TimerManager:game(), 1, 0.001, TimerManager:pausable())
			L2_12 = TimerManager
			L3_13 = L2_12
			L2_12 = L2_12.ramp_multiplier
			L2_12(L3_13, TimerManager:game_animation(), 1, 0.001, TimerManager:pausable())
		else
			L2_12 = TimerManager
			L3_13 = L2_12
			L2_12 = L2_12.ramp_multiplier
			L2_12(L3_13, TimerManager:game(), A0_10._time_scale, 0.001, TimerManager:pausable())
			L2_12 = TimerManager
			L3_13 = L2_12
			L2_12 = L2_12.ramp_multiplier
			L2_12(L3_13, TimerManager:game_animation(), A0_10._time_scale, 0.001, TimerManager:pausable())
		end
	end
end
