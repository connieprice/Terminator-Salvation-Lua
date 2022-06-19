core:require_module("CoreMusicPlayer")
if not CoreActionManager then
	CoreActionManager = class(CallbackHandler)
end
CoreActionManager.init = function(l_1_0)
	CallbackHandler.init(l_1_0)
	l_1_0._update_vector = {}
end

CoreActionManager.update = function(l_2_0, l_2_1, l_2_2)
	local l_2_6, l_2_7 = nil
	CallbackHandler.update(l_2_0, l_2_2)
	for i_0,i_1 in ipairs(l_2_0._update_vector) do
		l_2_0:upd(l_2_1, l_2_2)
	end
end

CoreActionManager.create_actions = function(l_3_0, l_3_1)
	if not rawget(_G, "Actions") then
		local l_3_2, l_3_3 = rawget(_G, "CoreActions"):new, rawget(_G, "CoreActions")
	end
	local l_3_4 = l_3_0
	local l_3_5 = l_3_1
	return l_3_2(l_3_3, l_3_4, l_3_5)
end

if not CoreActions then
	CoreActions = class()
end
CoreActions.init = function(l_4_0, l_4_1, l_4_2)
	l_4_0._cbh = l_4_1
	l_4_0._actions_vector = {}
	l_4_2:for_each("action", callback(l_4_0, l_4_0, "parse_action"))
	l_4_0._once = false
	l_4_0._done = false
	if l_4_2:has_parameter("once") and l_4_2:parameter("once") == "true" then
		l_4_0._once = true
	end
end

CoreActions.activate = function(l_5_0)
	local l_5_4, l_5_5, l_5_6, l_5_7, l_5_8, l_5_9, l_5_10, l_5_11 = nil
	if not l_5_0._done then
		for i_0,i_1 in ipairs(l_5_0._actions_vector) do
			if i_1 then
				i_1:activate()
			else
				Application:error("action void")
			end
		end
	else
		cat_debug("gaspode", "Action", l_5_0._name, "was already done")
	end
	if l_5_0._once then
		l_5_0._done = true
	end
end

CoreActions.deactivate = function(l_6_0)
	local l_6_4, l_6_5, l_6_6, l_6_7, l_6_8, l_6_9, l_6_10, l_6_11 = nil
	for i_0,i_1 in ipairs(l_6_0._actions_vector) do
		if i_1 then
			i_1:deactivate()
		else
			Application:error("action void")
		end
	end
end

CoreActions.break_it = function(l_7_0)
	local l_7_4, l_7_5, l_7_6, l_7_7 = nil
	for i_0,i_1 in ipairs(l_7_0._actions_vector) do
		i_1:break_it()
	end
end

CoreActions.parse_action = function(l_8_0, l_8_1)
	table.insert(l_8_0._actions_vector, l_8_0:select_action(l_8_1))
	table.sort(l_8_0._actions_vector, callback(l_8_0, l_8_0, "sort_actions"))
end

CoreActions.sort_actions = function(l_9_0, l_9_1, l_9_2)
	return l_9_1:start_time() < l_9_2:start_time()
end

CoreActions.select_action = function(l_10_0, l_10_1)
	local l_10_2 = l_10_1:parameter("type")
	local l_10_3 = l_10_0:_action_class(l_10_2)
	if not l_10_3 then
		Application:error("Unkown CoreActionElement for type", l_10_2)
		local l_10_4, l_10_5 = CoreActionElement:new, CoreActionElement
		local l_10_6 = l_10_0._cbh
		local l_10_7 = l_10_1
		return l_10_4(l_10_5, l_10_6, l_10_7)
	else
		local l_10_8, l_10_9 = l_10_3:new, l_10_3
		local l_10_10 = l_10_0._cbh
		local l_10_11 = l_10_1
		return l_10_8(l_10_9, l_10_10, l_10_11)
	end
end

CoreActions._action_class = function(l_11_0, l_11_1)
	end
	if (rawget(_G, "AM" .. l_11_1) or not rawget(_G, "CoreAM" .. l_11_1)) and not rawget(_G, l_11_1) then
		return rawget(_G, "Core" .. l_11_1)
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

if not CoreActionElement then
	CoreActionElement = class()
end
CoreActionElement.init = function(l_12_0, l_12_1, l_12_2, l_12_3)
	l_12_0._cbh = l_12_1
	l_12_0._start_time = 0
	if l_12_2:has_parameter("start_time") then
		l_12_0._start_time = tonumber(l_12_2:parameter("start_time"))
	end
	l_12_0._active = true
	l_12_0._type = l_12_2:parameter("type")
	l_12_0._name = l_12_2:parameter("name")
	l_12_0._mode = l_12_2:parameter("mode") or ""
	l_12_0._breakable = true
	if l_12_2:has_parameter("breakable") and l_12_2:parameter("breakable") == "false" then
		l_12_0._breakable = false
	end
	l_12_2:for_each("value", callback(l_12_0, l_12_0, "parse_values"))
end

CoreActionElement.start_time = function(l_13_0)
	return l_13_0._start_time
end

CoreActionElement.parse_values = function(l_14_0, l_14_1)
	local l_14_2 = l_14_1:parameter("name")
	l_14_0[l_14_2] = l_14_0:parse_value(l_14_1)
end

CoreActionElement.parse_value = function(l_15_0, l_15_1)
	local l_15_7, l_15_8, l_15_14 = nil
	local l_15_2 = l_15_1:parameter("type")
	if l_15_2 == "table" then
		local l_15_3 = {}
		for i_0 in l_15_1:children() do
			local l_15_15 = i_0:parameter("name")
			if not tonumber(l_15_15) then
				local l_15_17 = l_15_0:parse_value
			end
			local l_15_18 = l_15_0
			l_15_17 = l_15_17(l_15_18, l_15_9)
			local l_15_16 = nil
			l_15_3[l_15_15] = l_15_17
		end
		return l_15_3
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	local l_15_10 = nil
	local l_15_11 = nil
	local l_15_12 = nil
	do
		local l_15_13 = nil
		return string_to_value(l_15_2, l_15_10)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

CoreActionElement.activate = function(l_16_0)
	if l_16_0._active then
		if l_16_0._start_time > 0 then
			l_16_0._callback = l_16_0._cbh:add(callback(l_16_0, l_16_0, "activate_now"), l_16_0._start_time)
		end
	else
		l_16_0:activate_now()
	end
end

CoreActionElement.activate_now = function(l_17_0)
	Application:error("there was no activation function CoreActionElement:in here", l_17_0._type, l_17_0._name)
	l_17_0:deactivate_now()
end

CoreActionElement.deactivate = function(l_18_0)
	l_18_0:deactivate_now()
end

CoreActionElement.deactivate_now = function(l_19_0)
	l_19_0._cbh:remove(l_19_0._callback)
	l_19_0._callback = nil
end

CoreActionElement.break_it = function(l_20_0)
	if l_20_0._breakable then
		l_20_0._cbh:remove(l_20_0._callback)
		l_20_0._callback = nil
	end
end

if not CoreAMDebugString then
	CoreAMDebugString = class(CoreActionElement)
end
CoreAMDebugString.init = function(l_21_0, l_21_1, l_21_2)
	CoreActionElement.init(l_21_0, l_21_1, l_21_2)
	l_21_0._msg = l_21_2:parameter("msg").string
end

CoreAMDebugString.activate_now = function(l_22_0)
	cat_debug("gaspode", l_22_0._msg)
	l_22_0:deactivate_now()
end

if not CoreAMEnemy then
	CoreAMEnemy = class(CoreActionElement)
end
CoreAMEnemy.init = function(l_23_0, l_23_1, l_23_2)
	CoreActionElement.init(l_23_0, l_23_1, l_23_2)
	l_23_0._name = l_23_2:parameter("name")
end

CoreAMEnemy.activate_now = function(l_24_0)
	cat_debug("gaspode", "Enemy: create", l_24_0._name)
	l_24_0:deactivate_now()
end

if not CoreAMHub then
	CoreAMHub = class(CoreActionElement)
end
CoreAMHub.init = function(l_25_0, l_25_1, l_25_2)
	CoreActionElement.init(l_25_0, l_25_1, l_25_2)
end

CoreAMHub.activate_now = function(l_26_0)
	local l_26_1 = managers.world:current_stage():get_hub(l_26_0._name)
	if l_26_0._mode == "deactivate" then
		cat_debug("gaspode", "CoreAMHub:deactivate_now", l_26_0._name)
		l_26_1:set_done(true)
	elseif l_26_0._mode == "activate" then
		cat_debug("gaspode", "CoreAMHub:activate_now", l_26_0._name)
		l_26_1:set_done(false)
	elseif l_26_0._mode == "trigger_actions" then
		cat_debug("gaspode", "CoreAMHub:trigger_actions now", l_26_0._name)
		l_26_1:activate()
	end
	l_26_0:deactivate_now()
end

if not CoreAMUnitInArea then
	CoreAMUnitInArea = class(CoreActionElement)
end
CoreAMUnitInArea.init = function(l_27_0, l_27_1, l_27_2)
	CoreActionElement.init(l_27_0, l_27_1, l_27_2)
	l_27_0._area = managers.area:get_area(l_27_0._name, l_27_2)
end

CoreAMUnitInArea.activate_now = function(l_28_0)
	if l_28_0._mode == "deactivate" then
		cat_debug("gaspode", "CoreAMUnitInArea:deactivate_now", l_28_0._name)
		l_28_0._area:deactivate()
	else
		cat_debug("gaspode", "CoreAMUnitInArea:activate_now", l_28_0._name)
		l_28_0._area:activate()
	end
	l_28_0:deactivate_now()
end

if not CoreAMWorldCamera then
	CoreAMWorldCamera = class(CoreActionElement)
end
CoreAMWorldCamera.init = function(l_29_0, l_29_1, l_29_2)
	CoreActionElement.init(l_29_0, l_29_1, l_29_2)
end

CoreAMWorldCamera.activate_now = function(l_30_0)
	cat_debug("gaspode", "CoreAMWorldCamera:activate_now", l_30_0.worldcamera)
	if l_30_0.worldcamera_sequence and l_30_0.worldcamera_sequence ~= "none" then
		managers.worldcamera:play_world_camera_sequence(l_30_0.worldcamera_sequence)
	elseif l_30_0.worldcamera ~= "none" then
		managers.worldcamera:play_world_camera(l_30_0.worldcamera)
	else
		if Application:editor() then
			managers.editor:output_error("Can not play worldcamera or sequence \"none\"")
		end
	end
	l_30_0:deactivate_now()
end

if not CoreAMUnitSequence then
	CoreAMUnitSequence = class(CoreActionElement)
end
CoreAMUnitSequence.init = function(l_31_0, l_31_1, l_31_2)
	CoreActionElement.init(l_31_0, l_31_1, l_31_2)
	l_31_0._triggers = {}
	l_31_2:for_each("trigger", callback(l_31_0, l_31_0, "parse_trigger"))
	World:preload_unit("run_sequence_dummy")
	l_31_0._unit = World:spawn_unit("run_sequence_dummy", Vector3(0, 0, 0))
	managers.worlddefinition:add_trigger_sequence(l_31_0._unit, l_31_0._triggers)
end

CoreAMUnitSequence.parse_trigger = function(l_32_0, l_32_1)
	local l_32_2 = {}
	l_32_2.name = l_32_1:parameter("name")
	l_32_2.id = tonumber(l_32_1:parameter("id"))
	l_32_2.notify_unit_id = tonumber(l_32_1:parameter("notify_unit_id"))
	l_32_2.time = tonumber(l_32_1:parameter("time"))
	l_32_2.notify_unit_sequence = l_32_1:parameter("notify_unit_sequence")
	table.insert(l_32_0._triggers, l_32_2)
end

CoreAMUnitSequence.activate_now = function(l_33_0)
	l_33_0._unit:damage():run_sequence("run_sequence")
	l_33_0:deactivate_now()
end

if not CoreAMMusic then
	CoreAMMusic = class(CoreActionElement)
end
CoreAMMusic.init = function(l_34_0, l_34_1, l_34_2)
	CoreActionElement.init(l_34_0, l_34_1, l_34_2)
	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_34_0.music and l_34_0.music ~= "none" and l_34_0.music ~= "stop" and l_34_0.music ~= "stop_nice" then
		managers.music:preload_songs(l_34_0.music)
	end
	do return end
	if l_34_0.song ~= "none" then
		managers.music:load_song(l_34_0.song)
	end
end

CoreAMMusic.activate_now = function(l_35_0)
	if l_35_0.music and l_35_0.music ~= "none" then
		if l_35_0.music == "stop_nice" then
			managers.music:player():stop_nice()
		else
			managers.music:player():play_nice(l_35_0.music)
		end
	else
		if Application:editor() then
			managers.editor:output_error("CoreAMMusic: Using old music, need to be changed to new when music is availible. Talk to your sounddesigners.")
		end
		if l_35_0.song == "none" then
			managers.music:stop_music()
		end
	else
		managers.music:set_start_music("normal")
		managers.music:start_music()
		managers.music:set_update(true)
	end
	l_35_0:deactivate_now()
end

if not CoreAMMusicMode then
	CoreAMMusicMode = class(CoreActionElement)
end
CoreAMMusicMode.init = function(l_36_0, l_36_1, l_36_2)
	CoreActionElement.init(l_36_0, l_36_1, l_36_2)
end

CoreAMMusicMode.activate_now = function(l_37_0)
	if l_37_0.music_mode ~= "none" then
		managers.music:player():set_mode(l_37_0.music_mode, CoreMusicPlayer.PRIORITY_LVLDESIGN_NORMAL)
	else
		if Application:editor() then
			managers.editor:output_error("Can change music to mode \"none\".")
		end
	end
	l_37_0:deactivate_now()
end

if not CoreAMPhysicsPush then
	CoreAMPhysicsPush = class(CoreActionElement)
end
CoreAMPhysicsPush.init = function(l_38_0, l_38_1, l_38_2)
	CoreActionElement.init(l_38_0, l_38_1, l_38_2)
end

CoreAMPhysicsPush.activate_now = function(l_39_0)
	cat_debug("gaspode", "CoreAMPhysicsPush:activate_now()", l_39_0.position, l_39_0.physicspush_range, l_39_0.physicspush_velocity, l_39_0.physicspush_mass)
	World:play_physic_effect("hubelement_push", l_39_0.position, l_39_0.physicspush_range, l_39_0.physicspush_velocity, l_39_0.physicspush_mass)
	l_39_0:deactivate_now()
end

if not CoreAMRumble then
	CoreAMRumble = class(CoreActionElement)
end
CoreAMRumble.init = function(l_40_0, l_40_1, l_40_2)
	CoreActionElement.init(l_40_0, l_40_1, l_40_2)
	local l_40_3 = {}
	l_40_3.engine = l_40_0.rumble_engine
	l_40_3.peak = l_40_0.rumble_peak
	l_40_3.attack = l_40_0.rumble_attack
	l_40_3.sustain = l_40_0.rumble_sustain
	l_40_3.release = l_40_0.rumble_release
	managers.rumble:add_preset_rumbles(l_40_0._name, l_40_3)
end

CoreAMRumble.activate_now = function(l_41_0)
	cat_debug("gaspode", "CoreAMRumble:activate_now()")
	managers.editor:output_error("CoreAMRumble: function rumble needs to be called from a heritance of CoreAMRumble, called AMRumble. It requires a unit to work, which is project specific. Leveldesigners, talk to your lua programmers.")
	l_41_0:rumble()
	l_41_0:deactivate_now()
end

CoreAMRumble.rumble = function(l_42_0, l_42_1)
	if alive(l_42_1) then
		managers.rumble:play(l_42_0._name, l_42_1)
	end
end

if not CoreAMPlayEffect then
	CoreAMPlayEffect = class(CoreActionElement)
end
CoreAMPlayEffect.init = function(l_43_0, l_43_1, l_43_2)
	CoreActionElement.init(l_43_0, l_43_1, l_43_2)
	if l_43_0.effect ~= "none" then
		World:effect_manager():load(l_43_0.effect)
	else
		if Application:editor() then
			managers.editor:output_error("Cant load effect named \"none\" [" .. l_43_0._name .. "]")
		end
	end
end

CoreAMPlayEffect.activate_now = function(l_44_0)
	cat_print("gaspode", "CoreAMPlayEffect:activate_now()", l_44_0.effect)
	if l_44_0.effect ~= "none" then
		if l_44_0._mode == "" or l_44_0._mode == "spawn" then
			if not l_44_0.screen_space or not Vector3() then
				local l_44_1 = l_44_0.position
			end
			if not l_44_0.screen_space or not Rotation() then
				local l_44_2 = nil
			end
			local l_44_3, l_44_4 = , l_44_0.rotation
			local l_44_5 = managers.environment_effects:spawn_mission_effect
			local l_44_6 = managers.environment_effects
			l_44_5(l_44_6, l_44_0._name, {effect = l_44_0.effect, position = l_44_3, rotation = l_44_4})
		elseif l_44_0._mode == "kill" then
			managers.environment_effects:kill_mission_effect(l_44_0._name)
		elseif l_44_0._mode == "fade_kill" then
			managers.environment_effects:fade_kill_mission_effect(l_44_0._name)
		end
	else
		if Application:editor() then
			managers.editor:output_error("Cant spawn effect named \"none\" [" .. l_44_0._name .. "]")
		end
	end
	l_44_0:deactivate_now()
end

if not CoreAMEnvironmentEffect then
	CoreAMEnvironmentEffect = class(CoreActionElement)
end
CoreAMEnvironmentEffect.init = function(l_45_0, l_45_1, l_45_2)
	CoreActionElement.init(l_45_0, l_45_1, l_45_2)
	if l_45_0.environment_effect ~= "none" then
		managers.environment_effects:load_effects(l_45_0.environment_effect)
	end
end

CoreAMEnvironmentEffect.activate_now = function(l_46_0)
	if l_46_0.environment_effect ~= "none" then
		if l_46_0._mode == "use" then
			cat_debug("gaspode", "CoreAMEnvironmentEffect:use", l_46_0.environment_effect)
			managers.environment_effects:use(l_46_0.environment_effect)
		else
			cat_debug("gaspode", "CoreAMEnvironmentEffect:stop", l_46_0.environment_effect)
			managers.environment_effects:stop(l_46_0.environment_effect)
		end
	else
		if Application:editor() then
			managers.editor:output_error("Cant use or stop environment effect named \"none\" [" .. l_46_0._name .. "]")
		end
	end
	l_46_0:deactivate_now()
end

if not CoreAMOverlayEffect then
	CoreAMOverlayEffect = class(CoreActionElement)
end
CoreAMOverlayEffect.init = function(l_47_0, l_47_1, l_47_2)
	CoreActionElement.init(l_47_0, l_47_1, l_47_2)
end

CoreAMOverlayEffect.activate_now = function(l_48_0)
	cat_print("gaspode", "CoreAMOverlayEffect:activate_now()")
	if l_48_0.overlay_effect ~= "none" then
		local l_48_1 = clone(managers.overlay_effect:presets()[l_48_0.overlay_effect])
		if not l_48_0.overlay_effect_sustain then
			l_48_1.sustain = l_48_1.sustain
		end
		if not l_48_0.overlay_effect_fade_in then
			l_48_1.fade_in = l_48_1.fade_in
		end
		if not l_48_0.overlay_effect_fade_out then
			l_48_1.fade_out = l_48_1.fade_out
		end
		managers.overlay_effect:play_effect(l_48_1)
	else
		if Application:editor() then
			managers.editor:output_error("Cant activate overlay effect \"none\" [" .. l_48_0._name .. "]")
		end
	end
	l_48_0:deactivate_now()
end


