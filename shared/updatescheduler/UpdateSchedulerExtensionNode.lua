require("shared/updatescheduler/UpdateSchedulerNode")
UpdateSchedulerExtensionNode = UpdateSchedulerExtensionNode or class(UpdateSchedulerNode)
function UpdateSchedulerExtensionNode.init(A0_0, A1_1, A2_2)
	assert(A1_1)
	A0_0._unit = A1_1
	A0_0._extension_name = A2_2
	UpdateSchedulerNode.init(A0_0, A1_1:name() .. ":" .. A2_2)
end
function UpdateSchedulerExtensionNode.enable_update(A0_3)
	UpdateSchedulerNode.enable_update(A0_3)
	if alive(A0_3._unit) then
		A0_3._unit:set_extension_update_enabled(A0_3._extension_name, true)
	end
end
function UpdateSchedulerExtensionNode.disable_update(A0_4)
	UpdateSchedulerNode.disable_update(A0_4)
	if alive(A0_4._unit) then
		A0_4._unit:set_extension_update_enabled(A0_4._extension_name, false)
	end
end
function UpdateSchedulerExtensionNode.alive(A0_5)
	return alive(A0_5._unit)
end
