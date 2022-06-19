if not AMTimescale then
	AMTimescale = class(CoreActionElement)
end
AMTimescale.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMTimescale.activate_now = function(l_2_0)
	TimerManager:ramp_multiplier(TimerManager:game(), l_2_0.time_scale, l_2_0.ramp_time, TimerManager:pausable())
	TimerManager:ramp_multiplier(TimerManager:game_animation(), l_2_0.time_scale, l_2_0.ramp_time, TimerManager:pausable())
	managers.synced_sound:set_time_scale(l_2_0.time_scale)
	l_2_0:deactivate_now()
end


