if not AMDynamicDialog then
	AMDynamicDialog = class(CoreActionElement)
end
AMDynamicDialog.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
end

AMDynamicDialog.activate_now = function(l_2_0)
	managers.dynamic_dialog:say(l_2_0.position, l_2_0.dialog_name)
	l_2_0:deactivate_now()
end


