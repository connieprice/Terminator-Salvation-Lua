require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
if not CoreTimerSpeedCutsceneKey then
	CoreTimerSpeedCutsceneKey = class(CoreCutsceneKeyBase)
end
CoreTimerSpeedCutsceneKey.ELEMENT_NAME = "timer_speed"
CoreTimerSpeedCutsceneKey.NAME = "Timer Speed"
CoreTimerSpeedCutsceneKey:register_serialized_attribute("speed", 1, tonumber)
CoreTimerSpeedCutsceneKey:register_serialized_attribute("duration", 0, tonumber)
CoreTimerSpeedCutsceneKey.__tostring = function(l_1_0)
	local l_1_1 = string.format
	local l_1_2 = "Change timer speed to \"%g\" over \"%g\" seconds."
	local l_1_3 = l_1_0:speed()
	local l_1_4, l_1_5 = l_1_0:duration(), .end
	return l_1_1(l_1_2, l_1_3, l_1_4, l_1_5)
end

CoreTimerSpeedCutsceneKey.unload = function(l_2_0, l_2_1)
	l_2_0:_set_timer_speed(1, 0)
end

CoreTimerSpeedCutsceneKey.play = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_2 then
		local l_3_4 = l_3_0:preceeding_key()
		if l_3_4 then
			l_3_0:_set_timer_speed(l_3_4:speed(), l_3_4:duration())
		else
			l_3_0:_set_timer_speed(1, 0)
		end
	else
		l_3_0:_set_timer_speed(l_3_0:speed(), l_3_0:duration())
	end
end

CoreTimerSpeedCutsceneKey._set_timer_speed = function(l_4_0, l_4_1, l_4_2)
	l_4_1 = math.max(l_4_1, 0)
	l_4_2 = math.max(l_4_2, 0)
	if l_4_1 > 0 and l_4_1 < 0.035 then
		l_4_1 = 0.035
	end
	if l_4_2 > 0 and l_4_2 < 0.035 then
		l_4_2 = 0
	end
	TimerManager:ramp_multiplier(TimerManager:game(), l_4_1, l_4_2, TimerManager:pausable())
	TimerManager:ramp_multiplier(TimerManager:game_animation(), l_4_1, l_4_2, TimerManager:pausable())
end

CoreTimerSpeedCutsceneKey.is_valid_speed = function(l_5_0, l_5_1)
	return l_5_1 ~= nil and l_5_1 >= 0.035
end

CoreTimerSpeedCutsceneKey.is_valid_duration = function(l_6_0, l_6_1)
	return l_6_1 ~= nil and l_6_1 >= 0
end


