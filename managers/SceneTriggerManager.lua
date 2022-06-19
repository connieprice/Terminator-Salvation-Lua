SceneTriggerManager = SceneTriggerManager or class()
function SceneTriggerManager.init(A0_0)
	local L1_1
	L1_1 = {}
	A0_0._start_triggers = L1_1
	L1_1 = {}
	A0_0._end_triggers = L1_1
end
function SceneTriggerManager.add_start_line_trigger(A0_2, A1_3)
	A0_2._start_triggers[A1_3.voice_line_name] = A1_3
end
function SceneTriggerManager.add_end_line_trigger(A0_4, A1_5)
	A0_4._end_triggers[A1_5.voice_line_name] = A1_5
end
function SceneTriggerManager.remove_start_line_trigger(A0_6, A1_7)
	A0_6._start_triggers[A1_7.voice_line_name] = nil
end
function SceneTriggerManager.remove_end_line_trigger(A0_8, A1_9)
	A0_8._end_triggers[A1_9.voice_line_name] = nil
end
function SceneTriggerManager.voice_line_started(A0_10, A1_11)
	local L2_12
	L2_12 = A0_10._start_triggers
	L2_12 = L2_12[A1_11]
	if not L2_12 then
		return
	end
	L2_12:line_spoken()
end
function SceneTriggerManager.voice_line_ended(A0_13, A1_14)
	local L2_15
	L2_15 = A0_13._end_triggers
	L2_15 = L2_15[A1_14]
	if not L2_15 then
		return
	end
	L2_15:line_spoken()
end
