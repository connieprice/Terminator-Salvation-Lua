if not AMPlayerTankCheckPoint then
	AMPlayerTankCheckPoint = class(CoreActionElement)
end
AMPlayerTankCheckPoint.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	managers.world:add_checkpoint(l_1_0)
end

AMPlayerTankCheckPoint.activate_now = function(l_2_0)
	local l_2_9, l_2_10 = nil
	local l_2_1 = l_2_0.checkpoint
	local l_2_2 = l_2_1.spawnpoints
	local l_2_3 = 1
	if not l_2_0.unit_names then
		local l_2_4 = PlayerTankCheckPointHubElementData.default_unit_names
	end
	if not l_2_0.brain_name then
		local l_2_5 = nil
	end
	for i_0,i_1 in pairs(l_2_2) do
		local l_2_6, l_2_7 = , PlayerTankCheckPointHubElementData.brain_names[1]
		managers.player_slot:set_spawn_point(l_2_3, l_2_6[l_2_3], l_2_0.position + i_1.position, i_1.rotation, false, true, l_2_7)
		l_2_3 = l_2_3 + 1
	end
	assert(l_2_0.checkpoint_index)
	managers.save:save_progress(l_2_0.checkpoint_index)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end


