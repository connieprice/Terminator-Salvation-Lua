require("shared/updatescheduler/UpdateSchedulerNode")
UpdateSchedulerGroup = UpdateSchedulerGroup or class()
function UpdateSchedulerGroup.init(A0_0, A1_1, A2_2)
	A0_0._name = A1_1
	A0_0._nodes = {}
	A0_0._num_nodes = 0
	A0_0._node_index = 1
	A0_0._updates_per_frame = A2_2
	A0_0._enabled = true
end
function UpdateSchedulerGroup.disable(A0_3)
	A0_3:enable_all_nodes()
	A0_3._enabled = false
end
function UpdateSchedulerGroup.enable(A0_4)
	local L1_5
	A0_4._enabled = true
end
function UpdateSchedulerGroup.set_updates_per_frame(A0_6, A1_7)
	A0_6._updates_per_frame = A1_7
end
function UpdateSchedulerGroup.add_node(A0_8, A1_9)
	table.insert(A0_8._nodes, A1_9)
	A0_8._num_nodes = A0_8._num_nodes + 1
end
function UpdateSchedulerGroup.enable_all_nodes(A0_10)
	for 