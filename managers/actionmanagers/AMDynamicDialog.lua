AMDynamicDialog = AMDynamicDialog or class(CoreActionElement)
function AMDynamicDialog.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
end
function AMDynamicDialog.activate_now(A0_3)
	managers.dynamic_dialog:say(A0_3.position, A0_3.dialog_name)
	A0_3:deactivate_now()
end
