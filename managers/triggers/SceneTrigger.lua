SceneTrigger = SceneTrigger or class(CoreTriggerBase)
function SceneTrigger.init(A0_0, A1_1, A2_2, A3_3)
	CoreTriggerBase.init(A0_0, A1_1, A2_2, A3_3)
	if A0_0._mode == "voice_line_started" then
		managers.scene_trigger:add_start_line_trigger(A0_0)
	elseif A0_0._mode == "voice_line_completed" then
		managers.scene_trigger:add_end_line_trigger(A0_0)
	end
end
function SceneTrigger.destroy(A0_4)
	if A0_4._mode == "voice_line_started" then
		managers.scene_trigger:remove_start_line_trigger(A0_4)
	elseif A0_4._mode == "voice_line_completed" then
		managers.scene_trigger:remove_end_line_trigger(A0_4)
	end
end
function SceneTrigger.line_spoken(A0_5)
	A0_5._user:trigger_activated(A0_5._id, 1)
end
