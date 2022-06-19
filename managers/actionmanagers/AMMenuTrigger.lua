AMMenuTrigger = AMMenuTrigger or class(CoreActionElement)
function AMMenuTrigger.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMMenuTrigger.activate_now(A0_3)
	A0_3:deactivate_now()
end
