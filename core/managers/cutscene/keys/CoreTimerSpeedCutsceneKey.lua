require("core/managers/cutscene/keys/CoreCutsceneKeyBase")
CoreTimerSpeedCutsceneKey = CoreTimerSpeedCutsceneKey or class(CoreCutsceneKeyBase)
CoreTimerSpeedCutsceneKey.ELEMENT_NAME = "timer_speed"
CoreTimerSpeedCutsceneKey.NAME = "Timer Speed"
CoreTimerSpeedCutsceneKey:register_serialized_attribute("speed", 1, tonumber)
CoreTimerSpeedCutsceneKey:register_serialized_attribute("duration", 0, tonumber)
function CoreTimerSpeedCutsceneKey.__tostring(A0_0)
	local L2_1
	L2_1 = string
	L2_1 = L2_1.format
	return L2_1("Change timer speed to \"%g\" over \"%g\" seconds.", A0_0:speed(), A0_0:duration())
end
function CoreTimerSpeedCutsceneKey.unload(A0_2, A1_3)
	A0_2:_set_timer_speed(1, 0)
end
function CoreTimerSpeedCutsceneKey.play(A0_4, A1_5, A2_6, A3_7)
	if A2_6 then
		if A0_4:preceeding_key() then
			A0_4:_set_timer_speed(A0_4:preceeding_key():speed(), A0_4:preceeding_key():duration())
		else
			A0_4:_set_timer_speed(1, 0)
		end
	else
		A0_4:_set_timer_speed(A0_4:speed(), A0_4:duration())
	end
end
function CoreTimerSpeedCutsceneKey._set_timer_speed(A0_8, A1_9, A2_10)
	A1_9 = math.max(A1_9, 0)
	A2_10 = math.max(A2_10, 0)
	if A1_9 > 0 and A1_9 < 0.035 then
		A1_9 = 0.035
	end
	if A2_10 > 0 and A2_10 < 0.035 then
		A2_10 = 0
	end
	TimerManager:ramp_multiplier(TimerManager:game(), A1_9, A2_10, TimerManager:pausable())
	TimerManager:ramp_multiplier(TimerManager:game_animation(), A1_9, A2_10, TimerManager:pausable())
end
function CoreTimerSpeedCutsceneKey.is_valid_speed(A0_11, A1_12)
	local L2_13
	L2_13 = A1_12 ~= nil and A1_12 >= 0.035
	return L2_13
end
function CoreTimerSpeedCutsceneKey.is_valid_duration(A0_14, A1_15)
	local L2_16
	L2_16 = A1_15 ~= nil and A1_15 >= 0
	return L2_16
end
