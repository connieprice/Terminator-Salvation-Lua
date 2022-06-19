require("shared/updatescheduler/UpdateSchedulerNode")
if not UpdateSchedulerGroup then
	UpdateSchedulerGroup = class()
end
UpdateSchedulerGroup.init = function(l_1_0, l_1_1, l_1_2)
	l_1_0._name = l_1_1
	l_1_0._nodes = {}
	l_1_0._num_nodes = 0
	l_1_0._node_index = 1
	l_1_0._updates_per_frame = l_1_2
	l_1_0._enabled = true
end

UpdateSchedulerGroup.disable = function(l_2_0)
	l_2_0:enable_all_nodes()
	l_2_0._enabled = false
end

UpdateSchedulerGroup.enable = function(l_3_0)
	l_3_0._enabled = true
end

UpdateSchedulerGroup.set_updates_per_frame = function(l_4_0, l_4_1)
	l_4_0._updates_per_frame = l_4_1
end

UpdateSchedulerGroup.add_node = function(l_5_0, l_5_1)
	table.insert(l_5_0._nodes, l_5_1)
	l_5_0._num_nodes = l_5_0._num_nodes + 1
end

UpdateSchedulerGroup.enable_all_nodes = function(l_6_0)
	local l_6_4, l_6_5, l_6_6, l_6_7 = nil
	for i_0,i_1 in ipairs(l_6_0._nodes) do
		i_1:enable_update()
	end
	l_6_0._enabled_nodes = l_6_0._nodes
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

UpdateSchedulerGroup.update = function(l_7_0)
	local l_7_1 = l_7_0._updates_per_frame
	local l_7_2 = l_7_0._num_nodes
	local l_7_3 = math.min(l_7_1, l_7_2)
	local l_7_4 = l_7_0._nodes
	local l_7_5 = l_7_0._node_index
	for l_7_9 = 1, l_7_3 do
		local l_7_10 = l_7_4[l_7_5]
		if l_7_10:alive() then
			l_7_10:disable_update()
			l_7_5 = l_7_5 + 1
			if l_7_2 < l_7_5 then
				l_7_5 = 1
			end
		else
			table.remove(l_7_4, l_7_5)
			l_7_2 = l_7_2 - 1
			if l_7_2 < l_7_5 then
				l_7_5 = 1
			end
			l_7_3 = math.min(l_7_1, l_7_2)
		end
	end
	l_7_0._node_index = l_7_5
	for l_7_14 = 1, l_7_3 do
		local l_7_15 = l_7_4[l_7_5]
		if l_7_15:alive() then
			l_7_15:enable_update()
		end
		l_7_5 = l_7_5 + 1
		if l_7_2 < l_7_5 then
			l_7_5 = 1
		end
	end
	l_7_0._num_nodes = l_7_2
end


