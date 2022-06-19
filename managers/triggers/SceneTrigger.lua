if not SceneTrigger then
	SceneTrigger = class(CoreTriggerBase)
end
SceneTrigger.init = function(l_1_0, l_1_1, l_1_2, l_1_3)
	CoreTriggerBase.init(l_1_0, l_1_1, l_1_2, l_1_3)
	if l_1_0._mode == "voice_line_started" then
		managers.scene_trigger:add_start_line_trigger(l_1_0)
	elseif l_1_0._mode == "voice_line_completed" then
		managers.scene_trigger:add_end_line_trigger(l_1_0)
	end
end

SceneTrigger.destroy = function(l_2_0)
	if l_2_0._mode == "voice_line_started" then
		managers.scene_trigger:remove_start_line_trigger(l_2_0)
	elseif l_2_0._mode == "voice_line_completed" then
		managers.scene_trigger:remove_end_line_trigger(l_2_0)
	end
end

SceneTrigger.line_spoken = function(l_3_0)
	l_3_0._user:trigger_activated(l_3_0._id, 1)
end


