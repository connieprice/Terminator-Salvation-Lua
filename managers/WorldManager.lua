require("managers/ActionManager")
require("managers/AreaManager")
require("managers/triggers/Triggers")
require("mission_objective/AssignedMissionObjectiveManager")
if not WorldManager then
	WorldManager = class(CoreWorldManager)
end
WorldManager.init = function(l_1_0)
	l_1_0._id_to_checkpoint = {}
	CoreWorldManager.init(l_1_0)
	Triggers.init(l_1_0)
	managers.assigned_mission_objective = AssignedMissionObjectiveManager:new()
end

WorldManager.destroy = function(l_2_0)
	managers.assigned_mission_objective:destroy()
	managers.assigned_mission_objective = nil
end

WorldManager.update = function(l_3_0, l_3_1, l_3_2)
	CoreWorldManager.update(l_3_0, l_3_1, l_3_2)
	managers.assigned_mission_objective:update(l_3_2)
end

WorldManager.clear_units = function(l_4_0)
	local l_4_5, l_4_6 = World:find_units_quick, World
	l_4_5 = l_4_5(l_4_6, "all", World:make_slot_mask(2, 3, 4, 5, 6, 8, 9, 12, 13, 15, 25))
	local l_4_1 = nil
	l_4_6 = ipairs
	l_4_1 = l_4_5
	l_4_6 = l_4_6(l_4_1)
	for i_0,i_1 in l_4_6 do
		if alive(l_4_4) and l_4_4:name() ~= "light_streaks" then
			cat_debug("editor", "delete ", l_4_4:name())
			World:delete_unit(l_4_4)
		end
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

WorldManager.stop_simulation = function(l_5_0)
	CoreWorldManager.stop_simulation(l_5_0)
	if Application:editor() then
		l_5_0:clear_units()
	end
	managers.area:stop_simulation()
end

WorldManager.current_stage = function(l_6_0)
	return CoreWorldManager.current_stage(l_6_0)
end

WorldManager.add_checkpoint = function(l_7_0, l_7_1)
	assert(not l_7_0._id_to_checkpoint[l_7_1.checkpoint_index])
	l_7_0._id_to_checkpoint[l_7_1.checkpoint_index] = l_7_1
end

WorldManager.checkpoint = function(l_8_0, l_8_1)
	assert(l_8_0._id_to_checkpoint[l_8_1], "checkpoint_index:" .. l_8_1 .. " not found!")
	return l_8_0._id_to_checkpoint[l_8_1]
end

WorldManager.has_checkpoint = function(l_9_0, l_9_1)
	return l_9_0._id_to_checkpoint[l_9_1] ~= nil
end

WorldManager.activate_current_stage = function(l_10_0)
end

WorldManager.post_sync_stage_activation = function(l_11_0)
	if l_11_0._current_stage then
		CoreWorldManager.activate_current_stage(l_11_0)
	end
end


