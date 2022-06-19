AMTimescale = AMTimescale or class(CoreActionElement)
function AMTimescale.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMTimescale.activate_now(A0_3)
	TimerManager:ramp_multiplier(TimerManager:game(), A0_3.time_scale, A0_3.ramp_time, TimerManager:pausable())
	TimerManager:ramp_multiplier(TimerManager:game_animation(), A0_3.time_scale, A0_3.ramp_time, TimerManager:pausable())
	managers.synced_sound:set_time_scale(A0_3.time_scale)
	A0_3:deactivate_now()
end
