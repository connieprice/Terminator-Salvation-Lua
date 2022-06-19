AMSceneTrigger = AMSceneTrigger or class(CoreActionElement)
function AMSceneTrigger.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMSceneTrigger.activate_now(A0_3)
	A0_3:deactivate_now()
end
