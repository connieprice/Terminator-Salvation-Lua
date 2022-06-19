require("menu/ingame/IntroCredits")
if not GameStateLoadWorld then
	GameStateLoadWorld = class(FiniteStateMachineState)
end
GameStateLoadWorld._number_of_players = function(l_1_0, l_1_1)
	local l_1_7, l_1_8 = nil
	local l_1_2 = managers.local_user:users()
	local l_1_3 = 0
	for i_0,i_1 in pairs(l_1_2) do
		if i_1:wants_to_play() then
			l_1_3 = l_1_3 + 1
		end
	end
	return l_1_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

GameStateLoadWorld._set_far_range = function(l_2_0, l_2_1)
	local l_2_2 = tweak_data.player.camera.level_view_distances
	local l_2_3 = l_2_2.single_player[l_2_1]
	local l_2_4 = l_2_2.split_screen[l_2_1]
	if l_2_3 and l_2_4 then
		managers.user_viewport:set_far_range(l_2_3, l_2_4)
	end
end

GameStateLoadWorld.init = function(l_3_0)
	l_3_0.game._is_loading_done = false
end

GameStateLoadWorld.transition = function(l_4_0)
	return GameStateLoadingWorld
end

GameStateLoadWorld.exit = function(l_5_0)
	l_5_0:_hack_feed_world_id_dependencies()
end

GameStateLoadWorld._hack_feed_world_id_dependencies = function(l_6_0)
	local l_6_1 = managers.game_transition:level_name()
	local l_6_2 = managers.world_info:info_from_name(l_6_1)
	if not l_6_2 then
		return 
	end
	if managers.game_transition:checkpoint_index() == 1 then
		managers.menu:ingame_gui():show_chapter_text(l_6_2.id)
	end
	local l_6_3, l_6_4 = managers.dynamic_dialog:set_before_time_in_story, managers.dynamic_dialog
	l_6_3(l_6_4, l_6_2.id <= 14)
	l_6_3, l_6_4 = l_6_2:get_localized_chapter_names, l_6_2
	l_6_3 = l_6_3(l_6_4)
	managers.save:set_localized_chapter_names(l_6_3, R8_PC41)
	if l_6_2.id == 16 then
		MachineHud._preload_textures()
	else
		NewPlayerHud._preload_textures()
	end
	l_6_0:_set_far_range(l_6_1)
end


