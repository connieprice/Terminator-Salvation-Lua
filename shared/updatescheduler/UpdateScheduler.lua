require("shared/updatescheduler/UpdateSchedulerExtensionNode")
require("shared/updatescheduler/UpdateSchedulerFunctionNode")
require("shared/updatescheduler/UpdateSchedulerGroup")
if not UpdateScheduler then
	UpdateScheduler = class()
end
UpdateScheduler.init = function(l_1_0)
	l_1_0._groups = {}
	l_1_0._enabled = true
end

UpdateScheduler.disable = function(l_2_0)
	local l_2_4, l_2_5, l_2_6, l_2_7 = nil
	for i_0,i_1 in pairs(l_2_0._groups) do
		i_1:disable()
	end
	l_2_0._enabled = false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UpdateScheduler.enable = function(l_3_0)
	local l_3_4, l_3_5, l_3_6, l_3_7 = nil
	for i_0,i_1 in pairs(l_3_0._groups) do
		i_1:enable()
	end
	l_3_0._enabled = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UpdateScheduler.update = function(l_4_0, l_4_1)
	local l_4_5, l_4_6, l_4_7, l_4_8 = nil
	if l_4_0._enabled then
		for i_0,i_1 in pairs(l_4_0._groups) do
			i_1:update()
		end
	end
end

UpdateScheduler.add_group = function(l_5_0, l_5_1, l_5_2)
	if not l_5_0._groups[l_5_1] then
		l_5_0._groups[l_5_1] = UpdateSchedulerGroup:new(l_5_1, l_5_2)
	end
end

UpdateScheduler.set_group = function(l_6_0, l_6_1, l_6_2)
	l_6_0._groups[l_6_1]:set_updates_per_frame(l_6_2)
end

UpdateScheduler.add_unit_extension = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_4 = UpdateSchedulerExtensionNode:new(l_7_1, l_7_2)
	l_7_0:_add_node(l_7_4, l_7_3)
	return l_7_4
end

UpdateScheduler.add_function = function(l_8_0, l_8_1, l_8_2)
	local l_8_3 = UpdateSchedulerFunctionNode:new(l_8_1)
	l_8_0:_add_node(l_8_3, l_8_2)
	return l_8_3
end

UpdateScheduler._add_node = function(l_9_0, l_9_1, l_9_2)
	local l_9_3 = l_9_0._groups[l_9_2]
	assert(l_9_3, l_9_2)
	if l_9_0._enabled then
		l_9_1:disable_update()
	else
		l_9_1:enable_update()
	end
	l_9_3:add_node(l_9_1)
end


