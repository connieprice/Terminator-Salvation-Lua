if not Menu2DDebug then
	Menu2DDebug = class()
end
Menu2DDebug._profile = function(l_1_0)
	local l_1_1 = managers.menu_input:bound_user()
	do
		if l_1_1 and l_1_1:is_profile_ready() then
			return l_1_1:profile()
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

Menu2DDebug.unlock_levels = function(l_2_0, l_2_1, l_2_2)
	if not l_2_1 then
		l_2_1 = 1
	end
	if not l_2_2 then
		l_2_2 = 18
	end
	local l_2_3 = l_2_0:_profile()
	assert(l_2_3)
	for l_2_7 = l_2_1, l_2_2 do
		l_2_3.levels[l_2_7].maximum_checkpoint_id = 1
	end
	l_2_3.has_progress = true
	managers.save:primary_user():save_profile()
end

Menu2DDebug.callback_create_levels_page = function(l_3_0, l_3_1)
	local l_3_2 = nil
	l_3_1:clear()
	local l_3_5, l_3_6 = pairs, managers.world_info:level_infos()
	l_3_5 = l_3_5(l_3_6)
	for i_0,i_1 in l_3_5 do
		l_3_2 = Menu2DChoice:new()
		l_3_2:set_param("text", i_1.name)
		l_3_2:set_param("goto_page", "debug_level_checkpoints")
		l_3_2:set_param("event", "replay_set_start_level")
		l_3_2:set_param("level_name", i_1.name)
		l_3_2:set_param("level_id", l_3_4)
		l_3_2:set_param("ignore_localization", true)
		l_3_1:add_choice(l_3_2)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

Menu2DDebug.callback_create_level_checkpoints_page = function(l_4_0, l_4_1)
	local l_4_2 = nil
	l_4_1:clear()
	local l_4_3 = nil
	local l_4_4 = managers.menu2d:menu_island_instance_data().start_level_id
	local l_4_5 = nil
	for l_4_9 = 1, math.max(l_4_0:_profile().levels[l_4_4].maximum_checkpoint_id, 1) do
		local l_4_6 = nil
		l_4_2 = Menu2DChoice:new()
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_4_2:set_param("text", "" .. R10_PC27)
		l_4_2:set_param("goto_page", "difficulty_level")
		l_4_2:set_param("event", "set_start_checkpoint")
		l_4_2:set_param("checkpoint_id", R10_PC27)
		l_4_2:set_param("ignore_localization", true)
		l_4_1:add_choice(l_4_2)
	end
end

Menu2DDebug.set_start_level = function(l_5_0, l_5_1)
	managers.menu2d:menu_island_instance_data().start_level_checkpoint = tonumber(l_5_1.checkpoint_id)
end


