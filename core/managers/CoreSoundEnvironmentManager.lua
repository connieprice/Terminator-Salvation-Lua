if not CoreSoundEnvironmentManager then
	CoreSoundEnvironmentManager = class()
end
CoreSoundEnvironmentManager.init = function(l_1_0)
	l_1_0._areas = {}
	l_1_0._areas_per_frame = 1
	l_1_0._check_objects = {}
	l_1_0._check_object_id = 0
	l_1_0._emitters = {}
	l_1_0._area_emitters = {}
	l_1_0._ambience_changed_callback = {}
	l_1_0._ambience_changed_callbacks = {}
	l_1_0._environment_changed_callback = {}
	l_1_0.GAME_DEFAULT_ENVIRONMENT = "padded_cell"
	l_1_0._default_environment = l_1_0.GAME_DEFAULT_ENVIRONMENT
	l_1_0._current_environment = l_1_0.GAME_DEFAULT_ENVIRONMENT
	l_1_0:_set_environment(l_1_0.GAME_DEFAULT_ENVIRONMENT)
	l_1_0._environments = l_1_0:_environments()
	l_1_0._soundbanks = {}
	l_1_0._emitter_soundbanks = {}
	l_1_0._emitter_cues = {}
	local l_1_4, l_1_5 = ipairs, Sound:soundbanks()
	l_1_4 = l_1_4(l_1_5)
	for i_0,i_1 in l_1_4 do
		if string.match(l_1_3, "ambience") then
			table.insert(l_1_0._soundbanks, l_1_3)
		end
		if string.match(l_1_3, "emitter") then
			table.insert(l_1_0._emitter_soundbanks, l_1_3)
			local l_1_6 = {}
			local l_1_10, l_1_11 = ipairs, Sound:cues(l_1_3)
			l_1_10 = l_1_10(l_1_11)
			for i_0,i_1 in l_1_10 do
				if string.match(l_1_9, "emitter") then
					table.insert(l_1_6, l_1_9)
				end
			end
			table.sort(l_1_6)
			l_1_0._emitter_cues[l_1_3] = l_1_6
			 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

		end
	end
	l_1_0.GAME_DEFAULT_EMITTER_SOUNDBANK = l_1_0._emitter_soundbanks[1]
	l_1_0.GAME_DEFAULT_SOUNDBANK = l_1_0._soundbanks[1]
	l_1_0._default_soundbank = l_1_0.GAME_DEFAULT_SOUNDBANK
	l_1_0._ambience_enabled = false
	l_1_0.POSITION_OFFSET = 50
	l_1_0._active_ambience_soundbanks = {}
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager.areas = function(l_2_0)
	return l_2_0._areas
end

CoreSoundEnvironmentManager.emitters = function(l_3_0)
	return l_3_0._emitters
end

CoreSoundEnvironmentManager.area_emitters = function(l_4_0)
	return l_4_0._area_emitters
end

CoreSoundEnvironmentManager._environments = function(l_5_0)
	local l_5_1 = {}
	for l_5_5 = 0, Sound:num_environments() - 1 do
		table.insert(l_5_1, Sound:environment_name(l_5_5))
	end
	table.sort(l_5_1)
	return l_5_1
end

CoreSoundEnvironmentManager.environments = function(l_6_0)
	return l_6_0._environments
end

CoreSoundEnvironmentManager.game_default_environment = function(l_7_0)
	return l_7_0.GAME_DEFAULT_ENVIRONMENT
end

CoreSoundEnvironmentManager.game_default_soundbank = function(l_8_0)
	return l_8_0.GAME_DEFAULT_SOUNDBANK
end

CoreSoundEnvironmentManager.game_default_emitter_soundbank = function(l_9_0)
	return l_9_0.GAME_DEFAULT_EMITTER_SOUNDBANK
end

CoreSoundEnvironmentManager.emitter_cues = function(l_10_0, l_10_1)
	return l_10_0._emitter_cues[l_10_1]
end

CoreSoundEnvironmentManager.default_environment = function(l_11_0)
	return l_11_0._default_environment
end

CoreSoundEnvironmentManager.set_default_environment = function(l_12_0, l_12_1)
	l_12_0._default_environment = l_12_1
	l_12_0:_set_environment(l_12_0._default_environment)
end

CoreSoundEnvironmentManager._set_environment = function(l_13_0, l_13_1)
	local l_13_5, l_13_6, l_13_7, l_13_8 = nil
	for i_0,i_1 in ipairs(l_13_0._environment_changed_callback) do
		i_1(l_13_1)
	end
	l_13_0._current_environment = l_13_1
	Sound:blend_environment(l_13_1, 1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager.current_environment = function(l_14_0)
	return l_14_0._current_environment
end

CoreSoundEnvironmentManager.default_soundbank = function(l_15_0)
	return l_15_0._default_soundbank
end

CoreSoundEnvironmentManager.set_default_soundbank = function(l_16_0, l_16_1)
	if not l_16_1 then
		return 
	end
	if not table.contains(l_16_0._soundbanks, l_16_1) then
		local l_16_5, l_16_7 = Application:error, Application
		local l_16_6, l_16_8 = "CoreSoundEnvironmentManager: Soundbank ", l_16_1
		l_16_6 = l_16_6 .. l_16_8 .. " doesn't exist."
		l_16_5(l_16_7, l_16_6)
		return 
	end
	l_16_0._default_soundbank = l_16_1
	l_16_0:_add_soundbank(l_16_0._default_soundbank)
	for i_0,i_1 in pairs(l_16_0._check_objects) do
		l_16_0:_change_ambiences(i_1)
	end
end

CoreSoundEnvironmentManager._add_soundbank = function(l_17_0, l_17_1)
	Sound:add_soundbank(l_17_1)
end

CoreSoundEnvironmentManager.soundbanks = function(l_18_0)
	return l_18_0._soundbanks
end

CoreSoundEnvironmentManager.emitter_soundbanks = function(l_19_0)
	return l_19_0._emitter_soundbanks
end

CoreSoundEnvironmentManager.set_to_default = function(l_20_0)
	l_20_0:set_default_environment(l_20_0.GAME_DEFAULT_ENVIRONMENT)
	l_20_0:set_default_soundbank(l_20_0.GAME_DEFAULT_SOUNDBANK)
	l_20_0:set_ambience_enabled(false)
end

CoreSoundEnvironmentManager.add_area = function(l_21_0, l_21_1)
	local l_21_2 = SoundEnvironmentArea:new(l_21_1)
	table.insert(l_21_0._areas, l_21_2)
	return l_21_2
end

CoreSoundEnvironmentManager.remove_area = function(l_22_0, l_22_1)
	local l_22_5, l_22_6, l_22_7, l_22_8, l_22_9, l_22_10, l_22_11, l_22_12, l_22_13, l_22_14 = nil
	l_22_1:remove()
	for i_0,i_1 in pairs(l_22_0._check_objects) do
		if l_22_1 == i_1.area then
			i_1.area = nil
			i_1.sound_area_counter = 1
			l_22_0:_change_ambiences(i_1)
		end
	end
	table.delete(l_22_0._areas, l_22_1)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager.add_emitter = function(l_23_0, l_23_1)
	local l_23_2 = SoundEnvironmentEmitter:new(l_23_1)
	table.insert(l_23_0._emitters, l_23_2)
	return l_23_2
end

CoreSoundEnvironmentManager.remove_emitter = function(l_24_0, l_24_1)
	l_24_1:destroy()
	table.delete(l_24_0._emitters, l_24_1)
end

CoreSoundEnvironmentManager.add_area_emitter = function(l_25_0, l_25_1)
	local l_25_2 = SoundEnvironmentAreaEmitter:new(l_25_1)
	table.insert(l_25_0._area_emitters, l_25_2)
	return l_25_2
end

CoreSoundEnvironmentManager.remove_area_emitter = function(l_26_0, l_26_1)
	l_26_1:destroy()
	table.delete(l_26_0._area_emitters, l_26_1)
end

CoreSoundEnvironmentManager.add_listener = function(l_27_0, l_27_1)
	local l_27_2, l_27_3, l_27_4 = Sound:listener(l_27_1.listener)
	l_27_1.object = l_27_2
	local l_27_5, l_27_6 = l_27_0:add_check_object, l_27_0
	local l_27_7 = l_27_1
	return l_27_5(l_27_6, l_27_7)
end

CoreSoundEnvironmentManager.add_check_object = function(l_28_0, l_28_1)
	if not l_28_1.object then
		Application:error("Must use an Object3D when adding check objects to sound environment manager.")
		return nil
	end
	l_28_0:_disable_fallback()
	l_28_0._check_object_id = l_28_0._check_object_id + 1
	local l_28_2 = {}
	l_28_2.object = l_28_1.object
	l_28_2.area = nil
	l_28_2.ambiences = l_28_0:_ambiences()
	l_28_2.active = l_28_1.active
	l_28_2.listener = l_28_1.listener
	l_28_2.primary = l_28_1.primary
	l_28_2.id = l_28_0._check_object_id
	l_28_2.sound_area_counter = 1
	l_28_0:_change_ambiences(l_28_2)
	l_28_0._check_objects[l_28_0._check_object_id] = l_28_2
	return l_28_0._check_object_id
end

CoreSoundEnvironmentManager.remove_check_object = function(l_29_0, l_29_1)
	local l_29_6, l_29_7, l_29_8, l_29_9 = nil
	local l_29_2 = l_29_0._check_objects[l_29_1]
	for i_0,i_1 in ipairs(l_29_2.ambiences) do
		i_1:stop()
	end
	l_29_0._check_objects[l_29_1] = nil
	l_29_0:_enable_fallback()
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager.set_check_object_active = function(l_30_0, l_30_1, l_30_2)
	local l_30_7, l_30_8, l_30_9, l_30_10 = nil
	local l_30_3 = l_30_0._check_objects[l_30_1]
	if l_30_3.active == l_30_2 then
		return 
	end
	l_30_3.active = l_30_2
	if not l_30_2 then
		for i_0,i_1 in ipairs(l_30_3.ambiences) do
			i_1:stop()
		end
	else
		l_30_0:_check_inside(l_30_3)
	if not l_30_3.area then
		end
		if l_30_3.primary then
			l_30_0:_set_environment(l_30_0._default_environment)
		end
		l_30_0:_change_ambiences(l_30_3, 1)
	end
end

CoreSoundEnvironmentManager.obj_alive = function(l_31_0, l_31_1)
	local l_31_2 = l_31_0._check_objects[l_31_1]
	do
		if l_31_2 then
			return alive(l_31_2.object)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSoundEnvironmentManager.check_object = function(l_32_0, l_32_1)
	return l_32_0._check_objects[l_32_1]
end

CoreSoundEnvironmentManager._disable_fallback = function(l_33_0)
	local l_33_1 = l_33_0._check_objects[l_33_0._fallback_id]
	if l_33_1 then
		l_33_0:set_check_object_active(l_33_0._fallback_id, false)
	end
end

CoreSoundEnvironmentManager._enable_fallback = function(l_34_0)
	local l_34_5, l_34_6 = nil
	local l_34_1 = l_34_0._check_objects[l_34_0._fallback_id]
	if l_34_1 and not l_34_1.active then
		for i_0,i_1 in pairs(l_34_0._check_objects) do
			if i_1 ~= l_34_1 then
				return 
			end
		end
		l_34_0:set_check_object_active(l_34_0._fallback_id, true)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

CoreSoundEnvironmentManager._update_object = function(l_35_0, l_35_1, l_35_2, l_35_3, l_35_4)
	local l_35_8, l_35_9, l_35_10, l_35_11 = nil
	for i_0,i_1 in ipairs(l_35_4.ambiences) do
		i_1:update(l_35_1, l_35_2)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_35_4.area then
		if nil then
			return l_35_4.area
		end
		if l_35_0:_check_inside(l_35_4) then
			return l_35_4.area
		end
		if l_35_4.primary then
			l_35_0:_set_environment(l_35_0._default_environment)
		end
		l_35_0:_change_ambiences(l_35_4)
	end
	if l_35_0:_check_inside(l_35_4) then
		return l_35_4.area
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager._fallback_on_camera = function(l_36_0)
	if not l_36_0._use_fallback_on_camera then
		return 
	end
	local l_36_1 = managers.viewport:active_viewports()
	if #l_36_1 == 0 then
		local l_36_2 = l_36_1[1]:camera()
		if not l_36_2 then
			return 
		end
		local l_36_3 = l_36_0._check_objects[l_36_0._fallback_id]
		 -- DECOMPILER ERROR: unhandled construct in 'if'

		if l_36_3 and l_36_3.object ~= l_36_2 then
			l_36_3.object = l_36_2
		end
		do return end
		if not next(l_36_0._check_objects) then
			local l_36_4, l_36_5 = l_36_0:add_check_object, l_36_0
			local l_36_6 = {}
			l_36_6.object = l_36_2
			l_36_6.primary = true
			l_36_6.active = true
			l_36_4 = l_36_4(l_36_5, l_36_6)
			l_36_0._fallback_id = l_36_4
			l_36_4, l_36_5 = l_36_0:check_object, l_36_0
			l_36_6 = l_36_0._fallback_id
			l_36_4 = l_36_4(l_36_5, l_36_6)
			l_36_4.fallback = true
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 12 
end

CoreSoundEnvironmentManager.update = function(l_37_0, l_37_1, l_37_2)
	local l_37_6, l_37_7, l_37_8, l_37_9, l_37_10, l_37_11, l_37_12 = nil
	for i_0,i_1 in pairs(l_37_0._check_objects) do
		if i_1.active then
			l_37_0:_update_object(l_37_1, l_37_2, i_0, i_1)
		end
	end
end

CoreSoundEnvironmentManager._change_ambiences = function(l_38_0, l_38_1, l_38_2)
	local l_38_8, l_38_9, l_38_10, l_38_11, l_38_16, l_38_17, l_38_18, l_38_19, l_38_21, l_38_23 = nil
	local l_38_3 = l_38_1.area
	if not l_38_3 or not l_38_3:environment_soundbank() then
		local l_38_4, l_38_12 = l_38_0._default_soundbank
	end
	if l_38_0._ambience_changed_callbacks[l_38_1.id] then
		for i_0,i_1 in ipairs(l_38_0._ambience_changed_callbacks[l_38_1.id]) do
			local l_38_5 = nil
			i_1(l_38_5)
		end
	end
	for i_0,i_1 in ipairs(l_38_0._ambience_changed_callback) do
		local l_38_13 = nil
		i_1(l_38_13)
	end
	if not l_38_0._ambience_enabled then
		return 
	end
	if TableAlgorithms.find_value(l_38_13, l_38_0._active_ambience_soundbanks) then
		for i_0,i_1 in ipairs(l_38_1.ambiences) do
			i_1:stop_nice()
		end
		l_38_0._active_ambience_soundbanks[l_38_1.id] = l_38_13
		l_38_1.has_active_ambiences = false
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif l_38_1.has_active_ambiences and l_38_1.has_active_ambiences == true and l_38_0:_is_listener_in_environment(l_38_0._active_ambience_soundbanks[l_38_1.id], l_38_1.id) then
		l_38_0:_activate_ambience_sounds(l_38_0:_is_listener_in_environment(l_38_0._active_ambience_soundbanks[l_38_1.id], l_38_1.id), l_38_0._active_ambience_soundbanks[l_38_1.id], l_38_2)
	end
	l_38_0:_activate_ambience_sounds(l_38_1, l_38_13, l_38_2)
	l_38_0._active_ambience_soundbanks[l_38_1.id] = l_38_13
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager._is_listener_in_environment = function(l_39_0, l_39_1, l_39_2)
	local l_39_6, l_39_7, l_39_8, l_39_9 = nil
	for i_0,i_1 in pairs(l_39_0._check_objects) do
		if i_0 ~= l_39_2 and l_39_0._active_ambience_soundbanks[i_0] == l_39_1 then
			return i_1
		end
	end
	return nil
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager._activate_ambience_sounds = function(l_40_0, l_40_1, l_40_2, l_40_3)
	local l_40_7, l_40_8, l_40_9, l_40_10 = nil
	for i_0,i_1 in ipairs(l_40_1.ambiences) do
		i_1:use(l_40_2, l_40_3)
	end
	l_40_1.has_active_ambiences = true
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager._check_inside = function(l_41_0, l_41_1)
	if #l_41_0._areas > 0 then
		local l_41_2 = l_41_1.object:position()
		for l_41_6 = 1, l_41_0._areas_per_frame do
			local l_41_7 = l_41_0._areas[l_41_1.sound_area_counter]
			l_41_1.sound_area_counter = math.mod(l_41_1.sound_area_counter, #l_41_0._areas) + 1
			if l_41_7:is_inside(l_41_2) then
				l_41_1.area = l_41_7
				if l_41_1.primary then
					l_41_0:_set_environment(l_41_1.area:environment())
				end
				l_41_0:_change_ambiences(l_41_1)
				return l_41_7
			end
		end
	end
	l_41_1.area = nil
	return l_41_1.area
end

CoreSoundEnvironmentManager.ambience_enabled = function(l_42_0)
	return l_42_0._ambience_enabled
end

CoreSoundEnvironmentManager.set_ambience_enabled = function(l_43_0, l_43_1)
	local l_43_5, l_43_6, l_43_7, l_43_8, l_43_9, l_43_10, l_43_11, l_43_12, l_43_16, l_43_17, l_43_21, l_43_22, l_43_23, l_43_24 = nil
	l_43_0._ambience_enabled = l_43_1
	if not l_43_0._default_soundbank then
		return 
	end
	for i_0,i_1 in pairs(l_43_0._check_objects) do
		for i_0,i_1 in ipairs(i_1.ambiences) do
			 -- DECOMPILER ERROR: Confused about usage of registers!

			end
			if l_43_0._ambience_enabled and l_43_14.active then
				if not l_43_14.area or not l_43_14.area:environment_soundbank() then
					i_1:use(l_43_0._default_soundbank)
				else
					i_1:stop()
				end
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 28 
end

CoreSoundEnvironmentManager.draw_ambiences = function(l_44_0)
	local l_44_4, l_44_5, l_44_6, l_44_7, l_44_11, l_44_12, l_44_13, l_44_14 = nil
	for i_0,i_1 in pairs(l_44_0._check_objects) do
		for i_0,i_1 in ipairs(i_1.ambiences) do
			i_1:draw()
		end
	end
end

CoreSoundEnvironmentManager._ambiences = function(l_45_0)
	local l_45_1 = {}
	table.insert(l_45_1, AmbienceSound:new(Vector3(-30000, 40000, 5000), "generic_loop01"))
	table.insert(l_45_1, AmbienceSound:new(Vector3(-20000, -50000, 5000), "generic_loop02"))
	table.insert(l_45_1, AmbienceSound:new(Vector3(50000, 10000, 5000), "generic_loop03"))
	return l_45_1
end

CoreSoundEnvironmentManager.environment_at_position = function(l_46_0, l_46_1)
	local l_46_7, l_46_8, l_46_9, l_46_10, l_46_11, l_46_12 = nil
	local l_46_2 = l_46_0._default_environment
	local l_46_3 = l_46_0._default_soundbank
	for i_0,i_1 in ipairs(l_46_0._areas) do
		if i_1:is_inside(l_46_1) then
			l_46_2 = i_1:environment()
			l_46_3 = i_1:environment_soundbank()
	else
		end
	end
	return l_46_2, l_46_3
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreSoundEnvironmentManager.add_ambience_changed_callback = function(l_47_0, l_47_1, l_47_2)
	if l_47_2 then
		if not l_47_0._ambience_changed_callbacks[l_47_2] then
			l_47_0._ambience_changed_callbacks[l_47_2] = {}
		end
		table.insert(l_47_0._ambience_changed_callbacks[l_47_2], l_47_1)
		return 
	end
	table.insert(l_47_0._ambience_changed_callback, l_47_1)
end

CoreSoundEnvironmentManager.remove_ambience_changed_callback = function(l_48_0, l_48_1, l_48_2)
	if l_48_2 and l_48_0._ambience_changed_callbacks[l_48_2] then
		table.delete(l_48_0._ambience_changed_callbacks[l_48_2], l_48_1)
		return 
	end
	table.delete(l_48_0._ambience_changed_callback, l_48_1)
end

CoreSoundEnvironmentManager.add_environment_changed_callback = function(l_49_0, l_49_1)
	table.insert(l_49_0._environment_changed_callback, l_49_1)
end

CoreSoundEnvironmentManager.remove_environment_changed_callback = function(l_50_0, l_50_1)
	table.delete(l_50_0._environment_changed_callback, l_50_1)
end

if not AmbienceSound then
	AmbienceSound = class()
end
AmbienceSound.init = function(l_51_0, l_51_1, l_51_2)
	l_51_0._pos = l_51_1
	l_51_0._cue = l_51_2
	l_51_0._old_sound = nil
	l_51_0._sound = nil
	l_51_0._fade_time = 1
end

AmbienceSound.update = function(l_52_0, l_52_1, l_52_2)
	if l_52_0._sound_gain and l_52_0._sound then
		if l_52_0._sound_gain <= l_52_0._fade_time then
			l_52_0._sound_gain = l_52_0._sound_gain + l_52_2
			l_52_0._sound:set_control("gain_abs", l_52_0._sound_gain / l_52_0._fade_time)
		if l_52_0._old_sound then
			end
			l_52_0._old_sound:set_control("gain_abs", 1 - l_52_0._sound_gain / l_52_0._fade_time)
		end
	elseif l_52_0._old_sound then
		l_52_0._old_sound:stop()
		l_52_0._old_sound = nil
	end
	if l_52_0._sound_to_stop_nice then
		if l_52_0._stop_nice_sound_gain <= l_52_0._fade_time then
			l_52_0._stop_nice_sound_gain = l_52_0._stop_nice_sound_gain + l_52_2
			l_52_0._sound_to_stop_nice:set_control("gain_abs", l_52_0._stop_nice_sound_gain / l_52_0._fade_time)
		end
	else
		l_52_0._sound_to_stop_nice:stop()
		l_52_0._sound_to_stop_nice = nil
	end
end

AmbienceSound.stop_nice = function(l_53_0)
	if l_53_0._sound and l_53_0._fade_time and l_53_0._sound_gain then
		l_53_0._sound_to_stop_nice = l_53_0._sound
		l_53_0._sound:stop()
		l_53_0._sound = nil
		l_53_0._stop_nice_sound_gain = l_53_0._fade_time - l_53_0._sound_gain
	end
end

AmbienceSound.use = function(l_54_0, l_54_1, l_54_2)
	if l_54_0._sound then
		if l_54_0._sound:bank() == l_54_1 then
			return 
		end
		if not l_54_0._old_sound then
			l_54_0._old_sound = l_54_0._sound
			l_54_0._sound = Sound:make_bank(l_54_1, l_54_0._cue)
		else
			if l_54_0._old_sound:bank() == l_54_1 then
				local l_54_3 = l_54_0._sound
				l_54_0._sound = l_54_0._old_sound
				l_54_0._old_sound = l_54_3
				l_54_0._sound_gain = l_54_0._fade_time - l_54_0._sound_gain
				return 
			end
		else
			l_54_0._old_sound:stop()
			l_54_0._old_sound = l_54_0._sound
			l_54_0._sound = Sound:make_bank(l_54_1, l_54_0._cue)
			l_54_0._sound_gain = l_54_0._fade_time - l_54_0._sound_gain
		end
	else
		l_54_0._sound = Sound:make_bank(l_54_1, l_54_0._cue)
	end
	if l_54_0._sound then
		l_54_0._sound:set_position(l_54_0._pos)
		l_54_0._sound:set_ambient(true)
		l_54_0._sound:play()
		do
			l_54_0._sound_gain = l_54_2 or 0
			l_54_0._sound:set_control("gain_abs", l_54_0._sound_gain)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

AmbienceSound.stop = function(l_55_0)
	if l_55_0._sound then
		l_55_0._sound:stop()
		l_55_0._sound = nil
	end
	if l_55_0._old_sound then
		l_55_0._old_sound:stop()
		l_55_0._old_sound = nil
	end
end

AmbienceSound.draw = function(l_56_0)
	do
		local l_56_1, l_56_2, l_56_4 = l_56_0._sound and 0 or 1
	do
		end
		local l_56_3, l_56_5 = , l_56_0._sound and 1 or 0
	end
	local l_56_6 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	Application:draw_cone(l_56_0._pos, l_56_0._pos + Vector3(0, 2500, 0), 2500, l_56_6, l_56_5, 0)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	Application:draw_cone(l_56_0._pos, l_56_0._pos - Vector3(0, 2500, 0), 2500, l_56_6, l_56_5, 0)
end

if not SoundEnvironmentArea then
	SoundEnvironmentArea = class()
end
SoundEnvironmentArea.init = function(l_57_0, l_57_1)
	l_57_0._shape = managers.shape:add_shape("box", l_57_1)
	if not l_57_1.environment then
		l_57_0._environment = managers.sound_environment:game_default_environment()
	end
	if not l_57_1.environment_soundbank then
		l_57_0._environment_soundbank = managers.sound_environment:game_default_soundbank()
	end
	l_57_0._name = l_57_1.name or ""
	l_57_0:_add_soundbank(l_57_0._environment_soundbank)
end

SoundEnvironmentArea._add_soundbank = function(l_58_0, l_58_1)
	if not l_58_1 then
		return 
	end
	if not table.contains(managers.sound_environment:soundbanks(), l_58_1) then
		Application:error("SoundEnvironmentArea: Soundbank " .. l_58_1 .. " doesn't exist.")
		return 
	end
	Sound:add_soundbank(l_58_1)
end

SoundEnvironmentArea.name = function(l_59_0)
	if not l_59_0._unit or not l_59_0._unit:unit_data().name_id then
		return l_59_0._name
	end
end

SoundEnvironmentArea.environment = function(l_60_0)
	return l_60_0._environment
end

SoundEnvironmentArea.set_environment = function(l_61_0, l_61_1)
	l_61_0._environment = l_61_1
end

SoundEnvironmentArea.environment_soundbank = function(l_62_0)
	return l_62_0._environment_soundbank
end

SoundEnvironmentArea.set_environment_soundbank = function(l_63_0, l_63_1)
	if not l_63_1 then
		return 
	end
	l_63_0._environment_soundbank = l_63_1
	l_63_0:_add_soundbank(l_63_0._environment_soundbank)
end

SoundEnvironmentArea.shape = function(l_64_0)
	return l_64_0._shape
end

SoundEnvironmentArea.set_unit = function(l_65_0, l_65_1)
	l_65_0._shape:set_unit(l_65_1)
end

SoundEnvironmentArea.position = function(l_66_0)
	local l_66_1, l_66_2 = l_66_0._shape:position, l_66_0._shape
	return l_66_1(l_66_2)
end

SoundEnvironmentArea.set_position = function(l_67_0, l_67_1)
	l_67_0._shape:set_position(l_67_1)
end

SoundEnvironmentArea.rotation = function(l_68_0)
	local l_68_1, l_68_2 = l_68_0._shape:rotation, l_68_0._shape
	return l_68_1(l_68_2)
end

SoundEnvironmentArea.set_rotation = function(l_69_0, l_69_1)
	l_69_0._shape:set_rotation(l_69_1)
end

SoundEnvironmentArea.width = function(l_70_0)
	local l_70_1, l_70_2 = l_70_0._shape:property, l_70_0._shape
	local l_70_3 = "width"
	return l_70_1(l_70_2, l_70_3)
end

SoundEnvironmentArea.set_width = function(l_71_0, l_71_1)
	l_71_0._shape:set_width(l_71_1)
end

SoundEnvironmentArea.depth = function(l_72_0)
	local l_72_1, l_72_2 = l_72_0._shape:property, l_72_0._shape
	local l_72_3 = "depth"
	return l_72_1(l_72_2, l_72_3)
end

SoundEnvironmentArea.set_depth = function(l_73_0, l_73_1)
	l_73_0._shape:set_depth(l_73_1)
end

SoundEnvironmentArea.height = function(l_74_0)
	local l_74_1, l_74_2 = l_74_0._shape:property, l_74_0._shape
	local l_74_3 = "height"
	return l_74_1(l_74_2, l_74_3)
end

SoundEnvironmentArea.set_height = function(l_75_0, l_75_1)
	l_75_0._shape:set_height(l_75_1)
end

SoundEnvironmentArea.remove = function(l_76_0)
	managers.shape:remove_shape(l_76_0._shape)
end

SoundEnvironmentArea.still_inside = function(l_77_0, l_77_1)
	local l_77_2, l_77_3 = l_77_0._shape:still_inside, l_77_0._shape
	local l_77_4 = l_77_1
	return l_77_2(l_77_3, l_77_4)
end

SoundEnvironmentArea.is_inside = function(l_78_0, l_78_1)
	local l_78_2, l_78_3 = l_78_0._shape:is_inside, l_78_0._shape
	local l_78_4 = l_78_1
	return l_78_2(l_78_3, l_78_4)
end

SoundEnvironmentArea.draw = function(l_79_0, l_79_1, l_79_2, l_79_3, l_79_4, l_79_5)
	l_79_0._shape:draw(l_79_1, l_79_2, l_79_3, l_79_4, l_79_5)
end

if not SoundEnvironmentEmitter then
	SoundEnvironmentEmitter = class()
end
SoundEnvironmentEmitter.init = function(l_80_0, l_80_1)
	if not l_80_1.position then
		l_80_0._position = Vector3()
	end
	if not l_80_1.rotation then
		l_80_0._rotation = Rotation()
	end
	if not l_80_1.emitter_soundbank then
		l_80_0._emitter_soundbank = managers.sound_environment:game_default_emitter_soundbank()
	end
	if not l_80_1.emitter_cue then
		l_80_0._emitter_cue = managers.sound_environment:emitter_cues(l_80_0._emitter_soundbank)[1]
	end
	l_80_0._name = l_80_1.name or ""
	l_80_0:_add_soundbank(l_80_0._emitter_soundbank)
	l_80_0:play_sound()
end

SoundEnvironmentEmitter._add_soundbank = function(l_81_0, l_81_1)
	if not l_81_1 then
		return 
	end
	if not table.contains(managers.sound_environment:emitter_soundbanks(), l_81_1) then
		Application:error("SoundEnvironmentEmitter: Soundbank " .. l_81_1 .. " doesn't exist.")
		return 
	end
	Sound:add_soundbank(l_81_1)
end

SoundEnvironmentEmitter.name = function(l_82_0)
	if not l_82_0._unit or not l_82_0._unit:unit_data().name_id then
		return l_82_0._name
	end
end

SoundEnvironmentEmitter.emitter_soundbank = function(l_83_0)
	return l_83_0._emitter_soundbank
end

SoundEnvironmentEmitter.set_emitter_soundbank = function(l_84_0, l_84_1)
	if not l_84_1 then
		return 
	end
	if l_84_1 == l_84_0._emitter_soundbank then
		return 
	end
	l_84_0._emitter_soundbank = l_84_1
	l_84_0:_add_soundbank(l_84_0._emitter_soundbank)
	l_84_0:set_emitter_cue(managers.sound_environment:emitter_cues(l_84_0._emitter_soundbank)[1])
	l_84_0:play_sound()
end

SoundEnvironmentEmitter.emitter_cue = function(l_85_0)
	return l_85_0._emitter_cue
end

SoundEnvironmentEmitter.set_emitter_cue = function(l_86_0, l_86_1)
	l_86_0._emitter_cue = l_86_1
	l_86_0:play_sound()
end

SoundEnvironmentEmitter.set_unit = function(l_87_0, l_87_1)
	l_87_0._unit = l_87_1
	if l_87_0._sound then
		l_87_0._sound:set_output(l_87_0._unit:orientation_object())
	end
end

SoundEnvironmentEmitter.position = function(l_88_0)
	if not l_88_0._unit or not l_88_0._unit:position() then
		return l_88_0._position
	end
end

SoundEnvironmentEmitter.set_position = function(l_89_0, l_89_1)
	l_89_0._position = l_89_1
end

SoundEnvironmentEmitter.rotation = function(l_90_0)
	if not l_90_0._unit or not l_90_0._unit:rotation() then
		return l_90_0._rotation
	end
end

SoundEnvironmentEmitter.set_rotation = function(l_91_0, l_91_1)
	l_91_0._rotation = l_91_1
end

SoundEnvironmentEmitter.play_sound = function(l_92_0)
	if l_92_0._sound then
		l_92_0._sound:stop()
	end
	l_92_0._sound = Sound:make_bank(l_92_0._emitter_soundbank, l_92_0._emitter_cue)
	if l_92_0._unit then
		l_92_0._sound:set_output(l_92_0._unit:orientation_object())
	else
		l_92_0._sound:set_position(l_92_0:position())
	end
	l_92_0._sound:set_ambient(true)
	l_92_0._sound:play()
end

SoundEnvironmentEmitter.restart = function(l_93_0)
	l_93_0:play_sound()
end

SoundEnvironmentEmitter.draw = function(l_94_0, l_94_1, l_94_2, l_94_3, l_94_4, l_94_5)
	Application:draw_sphere(l_94_0:position(), 75, l_94_3, l_94_4, l_94_5)
	Application:draw_cone(l_94_0:position(), l_94_0:position() + l_94_0:rotation():y() * 500, 500, l_94_3, l_94_4, l_94_5)
	Application:draw_cone(l_94_0:position(), l_94_0:position() - l_94_0:rotation():y() * 500, 500, l_94_3, l_94_4, l_94_5)
end

SoundEnvironmentEmitter.destroy = function(l_95_0)
	if l_95_0._sound then
		l_95_0._sound:stop()
		l_95_0._sound = nil
	end
end

if not SoundEnvironmentAreaEmitter then
	SoundEnvironmentAreaEmitter = class(CoreShapeBoxMiddle)
end
SoundEnvironmentAreaEmitter.init = function(l_96_0, l_96_1)
	l_96_1.type = "box_middle"
	CoreShapeBoxMiddle.init(l_96_0, l_96_1)
	if not l_96_1.emitter_soundbank then
		l_96_0._properties.emitter_soundbank = managers.sound_environment:game_default_emitter_soundbank()
	end
	if not l_96_1.emitter_cue then
		l_96_0._properties.emitter_cue = managers.sound_environment:emitter_cues(l_96_0._properties.emitter_soundbank)[1]
	end
	l_96_0:_add_soundbank(l_96_0._properties.emitter_soundbank)
	l_96_0:play_sound()
end

SoundEnvironmentAreaEmitter._add_soundbank = function(l_97_0, l_97_1)
	if not l_97_1 then
		return 
	end
	if not table.contains(managers.sound_environment:emitter_soundbanks(), l_97_1) then
		Application:error("SoundEnvironmentAreaEmitter: Soundbank " .. l_97_1 .. " doesn't exist.")
		return 
	end
	Sound:add_soundbank(l_97_1)
end

SoundEnvironmentAreaEmitter.emitter_soundbank = function(l_98_0)
	return l_98_0._properties.emitter_soundbank
end

SoundEnvironmentAreaEmitter.set_emitter_soundbank = function(l_99_0, l_99_1)
	if not l_99_1 then
		return 
	end
	if l_99_1 == l_99_0._properties.emitter_soundbank then
		return 
	end
	l_99_0._properties.emitter_soundbank = l_99_1
	l_99_0:_add_soundbank(l_99_0._properties.emitter_soundbank)
	l_99_0:set_emitter_cue(managers.sound_environment:emitter_cues(l_99_0._properties.emitter_soundbank)[1])
	l_99_0:play_sound()
end

SoundEnvironmentAreaEmitter.emitter_cue = function(l_100_0)
	return l_100_0._properties.emitter_cue
end

SoundEnvironmentAreaEmitter.set_emitter_cue = function(l_101_0, l_101_1)
	l_101_0._properties.emitter_cue = l_101_1
	l_101_0:play_sound()
end

SoundEnvironmentAreaEmitter.play_sound = function(l_102_0)
	if l_102_0._sound then
		l_102_0._sound:stop()
	end
	l_102_0._sound = Sound:make_bank(l_102_0._properties.emitter_soundbank, l_102_0._properties.emitter_cue)
	if l_102_0._unit then
		l_102_0._sound:set_output(l_102_0._unit:orientation_object())
	else
		l_102_0._sound:set_position(l_102_0:position())
		l_102_0._sound:set_rotation(l_102_0:rotation())
	end
	l_102_0:set_extent()
	l_102_0._sound:set_ambient(true)
	l_102_0._sound:play()
end

SoundEnvironmentAreaEmitter.set_extent = function(l_103_0)
	if l_103_0._sound then
		l_103_0._sound:set_extent(l_103_0:extent())
	end
end

SoundEnvironmentAreaEmitter.extent = function(l_104_0)
	local l_104_1 = Vector3
	local l_104_2 = l_104_0._properties.width / 2
	local l_104_3 = l_104_0._properties.depth / 2
	local l_104_4 = l_104_0._properties.height / 2
	return l_104_1(l_104_2, l_104_3, l_104_4)
end

SoundEnvironmentAreaEmitter.set_property = function(l_105_0, ...)
	CoreShapeBox.set_property(l_105_0, ...)
	l_105_0:set_extent()
end

SoundEnvironmentAreaEmitter.set_unit = function(l_106_0, l_106_1)
	CoreShapeBox.set_unit(l_106_0, l_106_1)
	if l_106_0._sound then
		l_106_0._sound:set_output(l_106_0._unit:orientation_object())
	end
end

SoundEnvironmentAreaEmitter.restart = function(l_107_0)
	l_107_0:play_sound()
end

SoundEnvironmentAreaEmitter.destroy = function(l_108_0)
	if l_108_0._sound then
		l_108_0._sound:stop()
		l_108_0._sound = nil
	end
end


