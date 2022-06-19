if not SceneTriggerManager then
	SceneTriggerManager = class()
end
SceneTriggerManager.init = function(l_1_0)
	l_1_0._start_triggers = {}
	l_1_0._end_triggers = {}
end

SceneTriggerManager.add_start_line_trigger = function(l_2_0, l_2_1)
	l_2_0._start_triggers[l_2_1.voice_line_name] = l_2_1
end

SceneTriggerManager.add_end_line_trigger = function(l_3_0, l_3_1)
	l_3_0._end_triggers[l_3_1.voice_line_name] = l_3_1
end

SceneTriggerManager.remove_start_line_trigger = function(l_4_0, l_4_1)
	l_4_0._start_triggers[l_4_1.voice_line_name] = nil
end

SceneTriggerManager.remove_end_line_trigger = function(l_5_0, l_5_1)
	l_5_0._end_triggers[l_5_1.voice_line_name] = nil
end

SceneTriggerManager.voice_line_started = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0._start_triggers[l_6_1]
	if not l_6_2 then
		return 
	end
	l_6_2:line_spoken()
end

SceneTriggerManager.voice_line_ended = function(l_7_0, l_7_1)
	local l_7_2 = l_7_0._end_triggers[l_7_1]
	if not l_7_2 then
		return 
	end
	l_7_2:line_spoken()
end


