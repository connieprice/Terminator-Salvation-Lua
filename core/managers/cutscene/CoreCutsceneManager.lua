require("core/managers/cutscene/CoreCutscene")
require("core/managers/cutscene/CoreCutsceneKeys")
require("core/managers/cutscene/CoreCutsceneCast")
require("core/managers/cutscene/CoreCutscenePlayer")
require("core/managers/cutscene/CoreCutsceneActorDatabase")
if not CoreCutsceneManager then
	CoreCutsceneManager = mixin(class(), BasicEventHandling)
end
CoreCutsceneManager.cutscene_actor_unit_type = function(l_1_0, l_1_1)
	return Global.__CutsceneManager__replaced_actor_unit_types and Global.__CutsceneManager__replaced_actor_unit_types[l_1_1] or l_1_1
end

CoreCutsceneManager.replace_cutscene_actor_unit_type = function(l_2_0, l_2_1, l_2_2)
	assert(UnitDatabase:get_unit_data(l_2_1), string.format("Unrecognized Unit \"%s\".", l_2_1))
	local l_2_3 = assert
	if l_2_2 ~= nil then
		local l_2_4 = UnitDatabase:get_unit_data(l_2_2)
		l_2_4 = l_2_4
		local l_2_5 = nil
	end
	local l_2_6 = string.format
	local l_2_7 = "Unrecognized Unit \"%s\"."
	do
		l_2_7, l_2_6 = .end, l_2_6(l_2_7, l_2_2 or "")
		l_2_3(l_2_4, l_2_6, l_2_7)
		l_2_3 = Global
		l_2_4 = Global
		l_2_4 = l_2_4.__CutsceneManager__replaced_actor_unit_types
		if not l_2_4 then
			l_2_3.__CutsceneManager__replaced_actor_unit_types, l_2_4 = l_2_4, {}
			if l_2_2 then
				l_2_3 = cat_print
				l_2_4 = "cutscene"
				l_2_6 = string
				l_2_6 = l_2_6.format
				l_2_7 = "[CoreCutsceneManager] Replacing all \"%s\" actors with instances of \"%s\"."
				l_2_7, l_2_6 = .end, l_2_6(l_2_7, l_2_1, l_2_2)
				l_2_3(l_2_4, l_2_6, l_2_7)
			else
				l_2_3 = Global
				l_2_3 = l_2_3.__CutsceneManager__replaced_actor_unit_types
				l_2_3 = l_2_3[l_2_1]
			if l_2_3 then
				end
				l_2_3 = cat_print
				l_2_4 = "cutscene"
				l_2_6 = string
				l_2_6 = l_2_6.format
				l_2_7 = "[CoreCutsceneManager] Undoing replacement of all \"%s\" actors."
				l_2_7, l_2_6 = .end, l_2_6(l_2_7, l_2_1)
				l_2_3(l_2_4, l_2_6, l_2_7)
			end
			l_2_3 = Global
			l_2_3 = l_2_3.__CutsceneManager__replaced_actor_unit_types
			l_2_3[l_2_1] = l_2_2
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 36 
end

CoreCutsceneManager.init = function(l_3_0)
	local l_3_1 = UnitDatabase:get_unit_data("locator")
	if l_3_1 and not l_3_1:preloaded() then
		World:preload_unit("locator")
	end
	local l_3_2, l_3_3 = managers.listener:add_set, managers.listener
	local l_3_4 = "cutscene"
	local l_3_5 = {}
	 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

	l_3_2(l_3_3, l_3_4, l_3_5)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_3_2(l_3_3)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_3_2 then
		l_3_2(l_3_3)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		l_3_2(l_3_3)
	end
	 -- WARNING: undefined locals caused missing assignments!
end

CoreCutsceneManager.post_init = function(l_4_0)
	l_4_0:_prime_cutscenes_in_world()
end

CoreCutsceneManager.destroy = function(l_5_0)
	if l_5_0._player then
		l_5_0._player:destroy()
		l_5_0._player = nil
	end
	l_5_0:_destroy_units_with_cutscene_data_extension()
	if alive(l_5_0._video_workspace) then
		Overlay:newgui():destroy_workspace(l_5_0._video_workspace)
	end
	l_5_0._video_workspace = nil
	if alive(l_5_0._gui_workspace) then
		Overlay:newgui():destroy_workspace(l_5_0._gui_workspace)
	end
	l_5_0._gui_workspace = nil
	if l_5_0._input_controller then
		l_5_0._input_controller:destroy()
		l_5_0._input_controller = nil
	end
	managers.listener:remove_set("cutscene")
end

CoreCutsceneManager.timer = function(l_6_0)
	return l_6_0._timer
end

CoreCutsceneManager.set_timer = function(l_7_0, l_7_1)
	l_7_0._timer = assert(l_7_1, "Must supply a timer.")
	if l_7_0._player then
		l_7_0._player:set_timer(l_7_1)
	end
	if l_7_0:gui_workspace() then
		l_7_0:gui_workspace():set_timer(l_7_0._timer)
	end
	if l_7_0:video_workspace() then
		l_7_0:video_workspace():set_timer(l_7_0._timer)
	end
end

CoreCutsceneManager.populate_from_database = function(l_8_0)
	local l_8_7, l_8_8, l_8_9, l_8_10 = nil
	l_8_0._cutscenes = {}
	l_8_0._player = nil
	local l_8_1 = l_8_0._database:all(false, "cutscene")
	for i_0,i_1 in ipairs(l_8_1) do
		local l_8_4 = l_8_0._database_for_saving ~= nil
		if l_8_4 or core_or_local("Cutscene", l_8_0._database:load_node(i_1), l_8_0):is_optimized() then
			l_8_0._cutscenes[i_1:name()] = core_or_local("Cutscene", l_8_0._database:load_node(i_1), l_8_0)
		end
	end
end

CoreCutsceneManager.register_unit_with_cutscene_data_extension = function(l_9_0, l_9_1)
	if not l_9_0._units_with_cutscene_data_extension then
		l_9_0._units_with_cutscene_data_extension = {}
	end
	table.insert(l_9_0._units_with_cutscene_data_extension, l_9_1)
end

CoreCutsceneManager.unregister_unit_with_cutscene_data_extension = function(l_10_0, l_10_1)
	if l_10_0._units_with_cutscene_data_extension then
		table.delete(l_10_0._units_with_cutscene_data_extension, l_10_1)
	if #l_10_0._units_with_cutscene_data_extension == 0 then
		end
		l_10_0._units_with_cutscene_data_extension = nil
	end
end

CoreCutsceneManager._prime_cutscenes_in_world = function(l_11_0)
	local l_11_4, l_11_5, l_11_6, l_11_7, l_11_8, l_11_9 = nil
	if not l_11_0._units_with_cutscene_data_extension then
		for i_0,i_1 in ipairs({}) do
		end
		if alive(i_1) then
			cat_print("cutscene", string.format("[CoreCutsceneManager] Priming in-world cutscene \"%s\".", i_1:cutscene_data():cutscene_player():cutscene_name()))
			i_1:cutscene_data():cutscene_player():prime()
		end
	end
end

CoreCutsceneManager._destroy_units_with_cutscene_data_extension = function(l_12_0)
	local l_12_5, l_12_6, l_12_7, l_12_8, l_12_9, l_12_10, l_12_11, l_12_12, l_12_13, l_12_14, l_12_15, l_12_16, l_12_17, l_12_18 = nil
	if not l_12_0._units_with_cutscene_data_extension then
		local l_12_1 = table.list_copy({})
	end
	for i_0,i_1 in ipairs(l_12_1) do
		l_12_0:unregister_unit_with_cutscene_data_extension(i_1)
		if alive(i_1) then
			cat_print("cutscene", string.format("[CoreCutsceneManager] Destroying Unit with CutsceneData extension \"%s\".", i_1:name()))
			World:delete_unit(i_1)
		end
	end
	assert(l_12_0._units_with_cutscene_data_extension == nil, "Not all units with the CutsceneData extension were destroyed.")
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneManager.register_cutscene_actor = function(l_13_0, l_13_1)
	assert(alive(l_13_1), "Zombie unit registered as cutscene actor.")
	if l_13_1.unit_data then
		local l_13_2, l_13_3 = l_13_1:unit_data().cutscene_actor
	end
	local l_13_4 = nil
	do
		assert(not l_13_4 or l_13_4 ~= "", "Unnamed unit registered as cutscene actor.")
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_13_0:cutscene_actors_in_world()[l_13_4] ~= l_13_1 then
			return l_13_0:cutscene_actors_in_world()[l_13_4] == nil
		end
		l_13_0:actor_database():append_unit_info(l_13_1)
		if not l_13_0._cutscene_actors then
			l_13_0._cutscene_actors = {}
		end
		l_13_0._cutscene_actors[l_13_4] = l_13_1
		return true
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneManager.unregister_cutscene_actor = function(l_14_0, l_14_1)
	assert(alive(l_14_1), "Zombie unit unregistered as cutscene actor.")
	if l_14_1.unit_data then
		local l_14_2, l_14_3 = l_14_1:unit_data().cutscene_actor
	end
	local l_14_4 = nil
	do
		assert(not l_14_4 or l_14_4 ~= "", "Unnamed unit unregistered as cutscene actor.")
		if l_14_0:cutscene_actors_in_world()[l_14_4] == nil then
			return false
		end
		l_14_0._cutscene_actors[l_14_4] = nil
		if table.empty(l_14_0._cutscene_actors) then
			l_14_0._cutscene_actors = nil
		end
		return true
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneManager.cutscene_actors_in_world = function(l_15_0)
	local l_15_5, l_15_6 = nil
	if l_15_0._cutscene_actors == nil then
		return {}
	end
	local l_15_1 = table.collect(l_15_0._cutscene_actors, function(l_16_0)
		if alive(l_16_0) then
			local l_16_1 = nil
			l_16_1 = l_16_1
			return l_16_1
		end
  end)
	for i_0,i_1 in pairs(l_15_1) do
		l_15_0._cutscene_actors[i_0] = nil
	end
	return l_15_0._cutscene_actors
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneManager.actor_database = function(l_16_0)
	return l_16_0._actor_database
end

CoreCutsceneManager.debug_next_exec = function(l_17_0, l_17_1)
	l_17_0:delay_cutscene_debug()
	Global.debug_cutscene = l_17_1
end

CoreCutsceneManager.delay_cutscene_debug = function(l_18_0)
	l_18_0._delay_cutscene_debug = true
end

CoreCutsceneManager.start_delayed_cutscene = function(l_19_0)
	if not Global.debug_cutscene then
		local l_19_1, l_19_2, l_19_3, l_19_4, l_19_5 = arg_value("-debugcs")
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_19_0._delay_cutscene_debug and l_19_1 then
		l_19_0._stop_playback = nil
		l_19_0._disable_events = true
		l_19_0:_cleanup()
		l_19_0._disable_events = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		managers.cutscene:play_cutscene(l_19_1)
		l_19_0._manager_locked = true
		Global.debug_cutscene = nil
		l_19_0:connect("EVT_PLAYBACK_FINISHED", function()
			managers.cutscene._manager_locked = nil
    end)
	end
end

CoreCutsceneManager.update = function(l_20_0)
	local l_20_1 = l_20_0._timer:time()
	local l_20_2 = l_20_0._timer:delta_time()
	if Application:debug_build() then
		l_20_0:start_delayed_cutscene()
	end
	if l_20_0._stop_playback then
		l_20_0:_cleanup()
		l_20_0._stop_playback = nil
		l_20_0._disable_events = nil
	elseif l_20_0._player then
		if not l_20_0._player:is_primed() then
			l_20_0._player:prime()
		end
		if l_20_0._start_playback and not l_20_0:is_paused() then
			l_20_0._player:play()
			l_20_0._start_playback = nil
		end
	if l_20_0._player:is_presentable() then
		end
	if not l_20_0._player:is_viewport_enabled() then
		end
		l_20_0._player:set_viewport_enabled(true)
		l_20_0:set_gui_visible(true)
		l_20_0:_on_playback_started(l_20_0._player:cutscene_name())
		l_20_0:_send_event("EVT_PLAYBACK_STARTED", l_20_0._player:cutscene_name())
	end
	if not l_20_0._player or (l_20_0._player:update(l_20_1, l_20_2) == false and l_20_0:_video() == nil) or l_20_0:_video() ~= nil and l_20_0:_video():loop_count() > 0 then
		l_20_0:_cleanup()
	end
end

CoreCutsceneManager.paused_update = function(l_21_0)
	l_21_0:update()
end

CoreCutsceneManager.play_overlay_effect = function(l_22_0, l_22_1)
	l_22_0:stop_overlay_effect()
	l_22_1.play_paused = true
	l_22_1.timer = l_22_0:timer()
	l_22_0.__overlay_effect_id = managers.overlay_effect:play_effect(l_22_1)
end

CoreCutsceneManager.stop_overlay_effect = function(l_23_0, l_23_1)
	if l_23_0.__overlay_effect_id then
		local l_23_2 = assert
		l_23_2(l_23_1 == nil or type(l_23_1) == "boolean")
		l_23_2 = managers
		l_23_2 = l_23_2.overlay_effect
		l_23_2 = l_23_2[l_23_1 and "fade_out_effect" or "stop_effect"]
		l_23_2(managers.overlay_effect, l_23_0.__overlay_effect_id)
		l_23_0.__overlay_effect_id = nil
	end
end

CoreCutsceneManager._create_gui_workspace = function(l_24_0)
	local l_24_1 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_24_1
end

CoreCutsceneManager._create_video_workspace = function(l_25_0)
	local l_25_1 = RenderSettings.resolution
	local l_25_2 = Overlay:newgui():create_scaled_screen_workspace(l_25_1.x, l_25_1.x / core_setup.aspect_ratio, 0, 0, l_25_1.x, l_25_1.y)
	l_25_2:set_timer(l_25_0._timer)
	return l_25_2
end

CoreCutsceneManager.input_controller = function(l_26_0)
	return l_26_0._input_controller
end

CoreCutsceneManager.gui_workspace = function(l_27_0)
	return l_27_0._gui_workspace
end

CoreCutsceneManager.video_workspace = function(l_28_0)
	return l_28_0._video_workspace
end

CoreCutsceneManager._video = function(l_29_0)
	local l_29_1 = l_29_0:video_workspace():panel()
	return l_29_1:num_children() > 1 and l_29_1:child(1) or nil
end

CoreCutsceneManager.set_gui_visible = function(l_30_0, l_30_1)
	if not l_30_0:gui_workspace() then
		local l_30_2, l_30_3, l_30_4, l_30_5, l_30_6 = responder(l_30_1)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if not l_30_1 or not "show" then
		l_30_2[l_30_2:visible() == l_30_1 or "hide"](l_30_2)
		do
			local l_30_7 = nil
			l_30_0:input_controller()[l_30_1 and "enable" or "disable"](l_30_0:input_controller())
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 18 
end

CoreCutsceneManager.get_all_cutscenes = function(l_31_0)
	return l_31_0._cutscenes
end

CoreCutsceneManager.prime = function(l_32_0, l_32_1, l_32_2)
	if not l_32_2 then
		l_32_2 = 0
	end
	local l_32_3 = l_32_0:get_cutscene(l_32_1)
	if l_32_0._player == nil then
		l_32_0._player = l_32_0:_player_for_cutscene(l_32_3)
	else
		if l_32_0._player:cutscene_name() ~= l_32_1 then
			l_32_0:_cleanup(true)
			l_32_0._player = l_32_0:_player_for_cutscene(l_32_3)
		end
	end
	l_32_0._player:seek(l_32_2, true)
end

CoreCutsceneManager._player_for_cutscene = function(l_33_0, l_33_1)
	local l_33_6 = nil
	local l_33_2 = l_33_1:find_spawned_orientation_unit()
	if not l_33_2 or not l_33_2.cutscene_data or l_33_2:cutscene_data() then
		local l_33_4, l_33_5 = , l_33_2:cutscene_data():cutscene_player
		return l_33_5(l_33_2:cutscene_data())
	do
		else
			local l_33_7 = nil
			core_or_local("CutscenePlayer", l_33_1):add_keys()
			return core_or_local("CutscenePlayer", l_33_1)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreCutsceneManager.play_cutscene = function(l_34_0, l_34_1)
	if not l_34_0._manager_locked then
		l_34_0:prime(l_34_1)
		l_34_0:play()
	end
end

CoreCutsceneManager.play = function(l_35_0)
	if l_35_0._player ~= nil and not l_35_0._player:is_playing() then
		if not l_35_0._is_overriding_user_music then
			managers.music:override_user_music(true)
			l_35_0._is_overriding_user_music = true
		end
		l_35_0._player:preroll_cutscene_keys()
		l_35_0._start_playback = true
	end
end

CoreCutsceneManager.stop = function(l_36_0, l_36_1)
	l_36_0._start_playback = nil
	l_36_0._stop_playback = true
	l_36_0._paused = nil
	l_36_0._disable_events = l_36_1
end

CoreCutsceneManager.skip = function(l_37_0)
	if l_37_0._player then
		l_37_0._player:skip_to_end()
	end
	l_37_0:stop(false)
end

CoreCutsceneManager._cleanup = function(l_38_0, l_38_1)
	if l_38_0._is_overriding_user_music then
		managers.music:override_user_music(false)
		l_38_0._is_overriding_user_music = nil
	end
	local l_38_2 = nil
	if l_38_0._player then
		if l_38_1 then
			l_38_0._player:skip_to_end()
		end
		l_38_2 = l_38_0._player:cutscene_name()
		l_38_0._player:destroy()
		l_38_0._player = nil
	end
	if not l_38_1 then
		l_38_0:set_gui_visible(false)
	end
	if l_38_0:_video() then
		l_38_0:_video():pause()
		l_38_0:video_workspace():panel():clear()
	end
	if l_38_2 and not l_38_0._disable_events then
		l_38_0:_send_event("EVT_PLAYBACK_FINISHED", l_38_2)
		l_38_0:_on_playback_finished(l_38_2)
	end
end

CoreCutsceneManager.pause = function(l_39_0)
	l_39_0._paused = true
	if l_39_0:is_playing() then
		if l_39_0._is_overriding_user_music then
			managers.music:override_user_music(false)
			l_39_0._is_overriding_user_music = nil
		end
		l_39_0._player:pause()
		l_39_0:_send_event("EVT_PLAYBACK_PAUSED", l_39_0._player:cutscene_name())
	end
end

CoreCutsceneManager.resume = function(l_40_0)
	l_40_0._paused = nil
	l_40_0:play()
end

CoreCutsceneManager.evaluate_at_time = function(l_41_0, l_41_1, l_41_2)
	l_41_0:prime(l_41_1, l_41_2)
	l_41_0._player:evaluate_current_frame()
end

CoreCutsceneManager.evaluate_at_frame = function(l_42_0, l_42_1, l_42_2)
	l_42_0:evaluate_at_time(l_42_1, l_42_2 / l_42_0:get_cutscene(l_42_1):frames_per_second())
end

CoreCutsceneManager.is_playing_cutscene = function(l_43_0, l_43_1)
	return not l_43_0:is_playing() or l_43_0._player:cutscene_name() == l_43_1
end

CoreCutsceneManager.is_playing = function(l_44_0)
	return (l_44_0._player ~= nil and l_44_0._player:is_playing()) or l_44_0:_video() ~= nil
end

CoreCutsceneManager.is_paused = function(l_45_0)
	return l_45_0._paused ~= nil
end

CoreCutsceneManager.add_playing_changed_callback = function(l_46_0, l_46_1, l_46_2)
	do
		local l_46_3, l_46_4, l_46_5, l_46_6 = type(l_46_2) == "string" and callback(l_46_1, l_46_1, l_46_2) or l_46_2
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_46_0:connect("EVT_PLAYBACK_STARTED", l_46_3, true)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_46_0:connect("EVT_PLAYBACK_FINISHED", l_46_3, false)
end

CoreCutsceneManager.get_cutscene = function(l_47_0, l_47_1)
	local l_47_2 = assert
	local l_47_3 = l_47_0._cutscenes[l_47_1]
	local l_47_5 = "Invalid cutscene \""
	local l_47_6 = tostring(l_47_1)
	l_47_5 = l_47_5 .. l_47_6 .. "\". Is it production-only (un-optimized)?"
	local l_47_4 = nil
	return l_47_2(l_47_3, l_47_5)
end

CoreCutsceneManager._on_playback_started = function(l_48_0, l_48_1)
end

CoreCutsceneManager._on_playback_finished = function(l_49_0, l_49_1)
end

CoreCutsceneManager._debug_persistent_keys_per_cutscene = function(l_50_0)
	local l_50_1 = {}
	local l_50_5, l_50_6 = pairs, l_50_0:get_all_cutscenes()
	l_50_5 = l_50_5(l_50_6)
	for i_0,i_1 in l_50_5 do
		local l_50_7 = l_50_4:_debug_persistent_keys()
		l_50_1[l_50_3] = table.map_keys(l_50_7)
	end
	return l_50_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneManager._debug_persistent_keys_report = function(l_51_0)
	local l_51_1 = "Persistent Cutscene Keys Report\n"
	l_51_1 = l_51_1 .. "-------------------------------\n"
	local l_51_5, l_51_6, l_51_11 = pairs, l_51_0:_debug_persistent_keys_per_cutscene(), .end
	l_51_5 = l_51_5(l_51_6, l_51_11)
	for i_0,i_1 in l_51_5 do
		local l_51_4 = nil
		l_51_4 = table
		l_51_4 = l_51_4.empty
		l_51_4 = l_51_4(l_51_3)
		if not l_51_4 then
			l_51_4 = l_51_1
			local l_51_10 = "\n"
			l_51_1 = l_51_4 .. l_51_10 .. l_51_2 .. "\n"
			l_51_4 = ipairs
			l_51_10 = l_51_3
			l_51_4 = l_51_4(l_51_10)
			for i_0,i_1 in l_51_4 do
				l_51_1 = l_51_1 .. "\t" .. l_51_9 .. "\n"
			end
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	return l_51_1
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreCutsceneManager._debug_dump_persistent_keys_report = function(l_52_0, l_52_1)
	if l_52_1 then
		local l_52_2 = File:open(l_52_1, "w")
		l_52_2:write(l_52_0:_debug_persistent_keys_report())
		l_52_2:close()
		cat_print("debug", "Persistent Keys report written to \"" .. l_52_1 .. "\"")
	else
		cat_print("debug", "")
		cat_print("debug", l_52_0:_debug_persistent_keys_report())
	end
end

CoreCutsceneManager.set_active_camera = function(l_53_0)
	error("CoreCutsceneManager:set_active_camera() is deprecated. The camera is now kept in CoreCutscenePlayer, but is not exposed here.")
end

CoreCutsceneManager.attempt_switch_to_active_camera = function(l_54_0)
	error("CoreCutsceneManager:attempt_switch_to_active_camera() is deprecated. The camera is now kept in CoreCutscenePlayer, but is not exposed here.")
end

CoreCutsceneManager.set_cutscene_camera_enabled = function(l_55_0)
	error("CoreCutsceneManager:set_cutscene_camera_enabled() is deprecated. The camera is now kept in CoreCutscenePlayer, but is not exposed here.")
end

CoreCutsceneManager.set_listener_enabled = function(l_56_0)
	error("CoreCutsceneManager:set_listener_enabled() is deprecated. The listener is now kept in CoreCutscenePlayer, but is not exposed here.")
end

CoreCutsceneManager.set_camera_attribute = function(l_57_0)
	error("CoreCutsceneManager:set_camera_attribute() is deprecated. The camera is now kept in CoreCutscenePlayer, but is not exposed here.")
end

CoreCutsceneManager.play_camera_shake = function(l_58_0)
	error("CoreCutsceneManager:play_camera_shake() is deprecated. The camera is now kept in CoreCutscenePlayer, but is not exposed here.")
end

CoreCutsceneManager.load = function(l_59_0)
	Application:stack_dump_error("CoreCutsceneManager:load() is deprecated. There is no need to call it.")
end

CoreCutsceneManager.save = function(l_60_0)
	error("CoreCutsceneManager:save() is deprecated. The new Cutscene Editor uses CoreCutsceneEditorProjects.")
end

CoreCutsceneManager.save_all = function(l_61_0)
	error("CoreCutsceneManager:save_all() is deprecated. The new Cutscene Editor uses CoreCutsceneEditorProjects.")
end

CoreCutsceneManager.pre_load_cutscene_units = function(l_62_0)
	Application:stack_dump_error("CoreCutsceneManager:pre_load_cutscene_units() is deprecated. There is no need to call it.")
end

CoreCutsceneManager.internal_load = function(l_63_0)
	Application:stack_dump_error("CoreCutsceneManager:internal_load() is deprecated. There is no need to call it.")
end

CoreCutsceneManager.stop_cutscene = function(l_64_0)
	Application:stack_dump_error("CoreCutsceneManager:stop_cutscene() is deprecated. Use CoreCutsceneManager:stop() instead.")
	l_64_0:stop()
end

CoreCutsceneManager.set_stop_at_end = function(l_65_0)
	Application:stack_dump_error("CoreCutsceneManager:set_stop_at_end() is deprecated. There is no need to call it.")
end

CoreCutsceneManager.get_current_frame_nr = function(l_66_0)
	error("CoreCutsceneManager:get_current_frame_nr() is deprecated. The playhead state is kept in CoreCutscenePlayer, but is not exposed here.")
end

CoreCutsceneManager.get_frame_count = function(l_67_0)
	error("CoreCutsceneManager:get_frame_count() is deprecated. The frame count is part of the CoreCutscene, but is not exposed here.")
end

CoreCutsceneManager.move_to_frame = function(l_68_0)
	error("CoreCutsceneManager:move_to_frame() is deprecated. The playhead state is kept in CoreCutscenePlayer, but is not exposed here.")
end

CoreCutsceneManager.evaluate_current_frame = function(l_69_0)
	error("CoreCutsceneManager:evaluate_current_frame() is deprecated. The playhead state is kept in CoreCutscenePlayer, but is not exposed here.")
end


