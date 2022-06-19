require("shared/updatescheduler/UpdateSchedulerNode")
if not UpdateSchedulerExtensionNode then
	UpdateSchedulerExtensionNode = class(UpdateSchedulerNode)
end
UpdateSchedulerExtensionNode.init = function(l_1_0, l_1_1, l_1_2)
	assert(l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._extension_name = l_1_2
	UpdateSchedulerNode.init(l_1_0, l_1_1:name() .. ":" .. l_1_2)
end

UpdateSchedulerExtensionNode.enable_update = function(l_2_0)
	UpdateSchedulerNode.enable_update(l_2_0)
	if alive(l_2_0._unit) then
		l_2_0._unit:set_extension_update_enabled(l_2_0._extension_name, true)
	end
end

UpdateSchedulerExtensionNode.disable_update = function(l_3_0)
	UpdateSchedulerNode.disable_update(l_3_0)
	if alive(l_3_0._unit) then
		l_3_0._unit:set_extension_update_enabled(l_3_0._extension_name, false)
	end
end

UpdateSchedulerExtensionNode.alive = function(l_4_0)
	local l_4_1 = alive
	local l_4_2 = l_4_0._unit
	return l_4_1(l_4_2)
end


