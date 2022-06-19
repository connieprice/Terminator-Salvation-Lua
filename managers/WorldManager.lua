require("managers/ActionManager")
require("managers/AreaManager")
require("managers/triggers/Triggers")
require("mission_objective/AssignedMissionObjectiveManager")
WorldManager = WorldManager or class(CoreWorldManager)
function WorldManager.init(A0_0)
	A0_0._id_to_checkpoint = {}
	CoreWorldManager.init(A0_0)
	Triggers.init(A0_0)
	managers.assigned_mission_objective = AssignedMissionObjectiveManager:new()
end
function WorldManager.destroy(A0_1)
	managers.assigned_mission_objective:destroy()
	managers.assigned_mission_objective = nil
end
function WorldManager.update(A0_2, A1_3, A2_4)
	CoreWorldManager.update(A0_2, A1_3, A2_4)
	managers.assigned_mission_objective:update(A2_4)
end
function WorldManager.clear_units(A0_5)
	local L1_6, L2_7, L3_8, L4_9, L5_10, L6_11
	L1_6 = World
	L1_6 = L1_6.find_units_quick
	L5_10 = L4_9
	L6_11 = 2
	L6_11 = L4_9(L5_10, L6_11, 3, 4, 5, 6, 8, 9, 12, 13, 15, 25)
	L1_6 = L1_6(L2_7, L3_8, L4_9, L5_10, L6_11, L4_9(L5_10, L6_11, 3, 4, 5, 6, 8, 9, 12, 13, 15, 25))
	for L5_10, L6_11 in L2_7(L3_8) do
		if alive(L6_11) and L6_11:name() ~= "light_streaks" then
			cat_debug("editor", "delete ", L6_11:name())
			World:delete_unit(L6_11)
		end
	end
end
function WorldManager.stop_simulation(A0_12)
	CoreWorldManager.stop_simulation(A0_12)
	if Application:editor() then
		A0_12:clear_units()
	end
	managers.area:stop_simulation()
end
function WorldManager.current_stage(A0_13)
	return (CoreWorldManager.current_stage(A0_13))
end
function WorldManager.add_checkpoint(A0_14, A1_15)
	assert(not A0_14._id_to_checkpoint[A1_15.checkpoint_index])
	A0_14._id_to_checkpoint[A1_15.checkpoint_index] = A1_15
end
function WorldManager.checkpoint(A0_16, A1_17)
	assert(A0_16._id_to_checkpoint[A1_17], "checkpoint_index:" .. A1_17 .. " not found!")
	return A0_16._id_to_checkpoint[A1_17]
end
function WorldManager.has_checkpoint(A0_18, A1_19)
	local L2_20
	L2_20 = A0_18._id_to_checkpoint
	L2_20 = L2_20[A1_19]
	L2_20 = L2_20 ~= nil
	return L2_20
end
function WorldManager.activate_current_stage(A0_21)
	local L1_22
end
function WorldManager.post_sync_stage_activation(A0_23)
	if A0_23._current_stage then
		CoreWorldManager.activate_current_stage(A0_23)
	end
end
