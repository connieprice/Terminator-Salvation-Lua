if not DebugCommands then
	DebugCommands = class()
end
DebugCommands.init = function(l_1_0)
end

DebugCommands.set_god_mode = function(l_2_0, l_2_1)
	l_2_0:_for_each_player(function(l_3_0)
		-- upvalues: l_2_1
		if l_3_0:damage() then
			l_3_0:damage():set_immune_to_damage(l_2_1)
		end
  end)
end

DebugCommands.show_huds = function(l_3_0, l_3_1)
	local l_3_2 = managers.user_viewport:viewports()
	l_3_0:_for_each(l_3_2, function(l_4_0)
		-- upvalues: l_3_1
		if l_3_1 then
			l_4_0:add_hud()
		else
			l_4_0:remove_hud()
		end
  end)
end

DebugCommands.kill_all_living_enemies = function(l_4_0)
	l_4_0:_for_each_enemy(function(l_5_0)
		if alive(l_5_0) and l_5_0:damage() then
			l_5_0:damage():set_fully_damaged()
		end
  end)
end

DebugCommands.drop_player_at_camera_position = function(l_5_0)
	local l_5_1 = l_5_0:_first_user()
	local l_5_2 = l_5_0:_camera()
	if l_5_1 and l_5_2 then
		local l_5_3 = l_5_1:assigned_unit()
	if l_5_3 then
		end
		UnitSpawnUtility.warp_to(l_5_3, l_5_3:rotation(), l_5_2:position())
	end
end

DebugCommands.control_unit = function(l_6_0, l_6_1)
	if l_6_1 then
		local l_6_2 = select_character()
		if l_6_2 then
			view_unit(l_6_2)
			control_unit(l_6_2)
		end
	else
		reset_view_and_control()
	end
end

DebugCommands._for_each = function(l_7_0, l_7_1, l_7_2)
	local l_7_6, l_7_7, l_7_8, l_7_9 = nil
	for i_0,i_1 in pairs(l_7_1) do
		l_7_2(i_1)
	end
end

DebugCommands._for_each_player = function(l_8_0, l_8_1)
	local l_8_2 = managers.player:human_players()
	l_8_0:_for_each(l_8_2, l_8_1)
end

DebugCommands._for_each_enemy = function(l_9_0, l_9_1)
	local l_9_2 = World:find_units_quick("all", managers.slot:get_mask("enemies"))
	l_9_0:_for_each(l_9_2, l_9_1)
end

DebugCommands._for_each_friend = function(l_10_0, l_10_1)
	local l_10_2 = World:find_units_quick("all", managers.slot:get_mask("players"))
	l_10_0:_for_each(l_10_2, l_10_1)
end

DebugCommands._first_user = function(l_11_0)
	local l_11_1 = 1
	local l_11_2 = managers.player_slot:slot(l_11_1)
	if l_11_2 then
		local l_11_3, l_11_4 = l_11_2:user, l_11_2
		return l_11_3(l_11_4)
	end
	return nil
end

DebugCommands._camera = function(l_12_0)
	if script_debug._freeflight:in_focus() then
		return script_debug._freeflight._camera
	else
		local l_12_1 = l_12_0:_first_user()
	if l_12_1 then
		end
		local l_12_2 = managers.user_viewport:viewport(l_12_1)
		local l_12_3, l_12_4 = l_12_2:engine_camera, l_12_2
		return l_12_3(l_12_4)
	end
	return nil
end

DebugCommands.infinite_ammo = function(l_13_0)
	return script_debug.infinite_ammo
end

DebugCommands.set_infinite_ammo = function(l_14_0, l_14_1)
	script_debug.infinite_ammo = l_14_1
end

DebugCommands.enable_fixed_delta_time = function(l_15_0)
	Application:set_forced_timestep(1 / setup.fps)
	Application:cap_framerate(setup.fps)
end

DebugCommands.disable_fixed_delta_time = function(l_16_0)
	Application:set_forced_timestep(0)
	Application:cap_framerate(0)
end


