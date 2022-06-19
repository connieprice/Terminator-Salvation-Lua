require("shared/updatescheduler/UpdateSchedulerExtensionNode")
require("shared/updatescheduler/UpdateSchedulerFunctionNode")
require("shared/updatescheduler/UpdateSchedulerGroup")
UpdateScheduler = UpdateScheduler or class()
function UpdateScheduler.init(A0_0)
	A0_0._groups = {}
	A0_0._enabled = true
end
function UpdateScheduler.disable(A0_1)
	for 