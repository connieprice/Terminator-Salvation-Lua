require("units/data/AiData")
require("ai/common/BufferedDamage")
require("shared/TableAlgorithms.lua")
local l_0_0 = 1000
if not AiNerveSystem then
	AiNerveSystem = class()
end
AiNerveSystem.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._ai_data = l_1_1:ai_data()
	l_1_0._braindead = false
	l_1_0._registered = false
	l_1_0._hibernating = true
	l_1_0._event_source_type_filter = l_1_0._ai_data.EVENT_SOURCE_TYPES
	l_1_0._ai_data.input.enemy_slot_mask = l_1_0._ai_data.default_enemy_slot_mask
	assert(l_1_0._ai_data.input.enemy_slot_mask)
	l_1_0._ai_data.input.is_stunned = false
	l_1_0._unit_position = l_1_1:position()
	l_1_0._current_path_index = 0
	l_1_0:_set_move_to_position(nil)
	l_1_0._start_position = nil
	l_1_0._animation_driven_movement = false
	l_1_0._ai_data:request_new_path()
	l_1_0._last_graph_update_position = nil
	l_1_0._last_graph_position = nil
	l_1_0._has_dynamic_graph = NavigationGraphUtilities.is_dynamic_graph(l_1_0._ai_data.graph)
	l_1_0._debug_brush = Draw:brush()
	l_1_0._name = l_1_1:name()
	l_1_0._movement_blocked = false
	l_1_0._movement_blocked_time = 0
	l_1_0._movement_blocked_by_unit = nil
	l_1_0._weapon_targets = {}
	l_1_0._weapon_target_timers = {}
	l_1_0._last_path_check_time = 0
	l_1_0._last_shortcut_check_time = 0
	l_1_0._is_enabled = true
	l_1_0:_update_movement_blocked_max_time()
end

AiNerveSystem._update_movement_blocked_max_time = function(l_2_0)
	local l_2_1 = tweak_data.ai.MOVEMENT_BLOCKED_TIME_NORMAL
	local l_2_2 = tweak_data.ai.MOVEMENT_BLOCKED_TIME_THREATENED
	local l_2_3 = {}
	l_2_3.normal = math.random(l_2_1.rand_min, l_2_1.rand_max)
	l_2_3.threatened = math.random(l_2_2.rand_min, l_2_2.rand_max)
	l_2_0._movement_blocked_max_time = l_2_3
end

AiNerveSystem.destroy = function(l_3_0)
	if l_3_0._registered then
		l_3_0:_unregister()
	end
	l_3_0:_destroy_ai_data()
	if l_3_0._ai_data.graph then
		l_3_0._ai_data.graph:remove_dynamic(l_3_0._unit)
	end
	l_3_0._unit = nil
end

AiNerveSystem.init_default_ai_data = function(l_4_0)
end

AiNerveSystem.warp_to = function(l_5_0, l_5_1, l_5_2)
	l_5_0:reset()
end

AiNerveSystem.reset = function(l_6_0)
	l_6_0._ai_data.input.buffered_damages = {}
	l_6_0._ai_data.input.buffered_events = {}
	l_6_0:init_default_ai_data()
	l_6_0:_setup_brain(l_6_0._brain_info)
	l_6_0._current_path_index = 0
	l_6_0:_set_move_to_position(nil)
	l_6_0._start_position = nil
	l_6_0._animation_driven_movement = false
	l_6_0._ai_data:request_new_path()
	l_6_0._movement_blocked = false
	l_6_0._movement_blocked_time = 0
	l_6_0._movement_blocked_by_unit = nil
	l_6_0._weapon_targets = {}
	l_6_0._weapon_target_timers = {}
end

AiNerveSystem.setup = function(l_7_0, l_7_1)
	l_7_0:init_default_ai_data()
	l_7_0._brain_info = l_7_0._ai_data.brain_infos[l_7_1]
	assert(l_7_0._brain_info, "Unknown brain: '" .. l_7_1 .. "'")
	l_7_0:_setup_brain(l_7_0._brain_info)
end

AiNerveSystem.disable = function(l_8_0)
	if l_8_0._ai_data.brain then
		l_8_0._ai_data.brain:enable(false)
	end
	l_8_0._ai_data.input.buffered_damages = {}
	l_8_0._ai_data.input.buffered_events = {}
	l_8_0._is_enabled = false
end

AiNerveSystem.enable = function(l_9_0)
	if l_9_0._ai_data.brain then
		l_9_0._ai_data.brain:enable(true)
	end
	l_9_0._is_enabled = true
end

AiNerveSystem.is_enabled = function(l_10_0)
	return l_10_0._is_enabled
end

AiNerveSystem._kill_brain = function(l_11_0)
	assert(not l_11_0._braindead)
	if l_11_0._registered then
		l_11_0:_unregister()
	end
	l_11_0:_destroy_ai_data()
	l_11_0._braindead = true
end

AiNerveSystem._destroy_ai_data = function(l_12_0)
	if l_12_0._ai_data.brain then
		l_12_0._ai_data.brain:destroy()
		l_12_0._ai_data.brain = nil
	end
	l_12_0._ai_data.input.buffered_damages = nil
	l_12_0._ai_data.input.buffered_events = nil
end

AiNerveSystem._wake_up = function(l_13_0)
	l_13_0:_register()
	l_13_0._hibernating = false
end

AiNerveSystem._hibernate = function(l_14_0)
	l_14_0:_unregister()
	l_14_0._ai_data.input.buffered_damages = {}
	l_14_0._ai_data.input.buffered_events = {}
	l_14_0._hibernating = true
end

AiNerveSystem._register = function(l_15_0)
	assert(not l_15_0._registered)
	local l_15_1 = l_15_0._unit
	managers.sensory_events:register_listener(l_15_0, l_15_0._event_source_type_filter)
	managers.director:add_ai_unit(l_15_1)
	l_15_0._damage_callback_func = function(...)
		-- upvalues: l_15_0
		l_15_0:_damage_callback(...)
  end
	l_15_1:damage():register_damage_callback(l_15_0._damage_callback_func)
	l_15_0._registered = true
end

AiNerveSystem._unregister = function(l_16_0)
	assert(l_16_0._registered)
	managers.director:remove_ai_unit(l_16_0._unit)
	managers.sensory_events:unregister_listener(l_16_0)
	l_16_0._unit:damage():unregister_damage_callback(l_16_0._damage_callback_func)
	l_16_0._registered = false
end

AiNerveSystem._setup_brain = function(l_17_0, l_17_1)
	local l_17_7, l_17_8, l_17_9, l_17_10 = nil
	if l_17_0._ai_data.brain then
		l_17_0._ai_data.brain:destroy()
		l_17_0._ai_data.brain = nil
	end
	local l_17_6 = managers.aihivebrain:get_brain
	l_17_6 = l_17_6(managers.aihivebrain, l_17_0._unit, l_17_1.name, l_17_1.group)
	local l_17_2 = nil
	l_17_2 = ipairs
	l_17_2 = l_17_2(l_17_1.auto_started_threads)
	for i_0,i_1 in l_17_2 do
		l_17_6:activate_thread(i_1)
	end
	for i_0,i_1 in ipairs(l_17_1.init_functions) do
		i_1(nil, l_17_0._ai_data)
	end
	l_17_0._forced_targeting_threads = l_17_1.forced_targeting_threads
	l_17_0._ai_data.brain = l_17_6
	l_17_0._ai_data.brain:enable(l_17_0._is_enabled)
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiNerveSystem.begin_continuous_sensory_event_callback = function(l_18_0, l_18_1)
	if not l_18_0._is_enabled then
		return 
	end
	local l_18_2 = l_18_0:_create_buffered_event(l_18_1, true)
	l_18_0._ai_data.input.buffered_events[l_18_1:instance_id()] = l_18_2
end

AiNerveSystem.end_continuous_sensory_event_callback = function(l_19_0, l_19_1)
	local l_19_2 = l_19_0._ai_data.input.buffered_events[l_19_1:instance_id()]
	if l_19_2 then
		l_19_2.has_ended = true
	end
end

AiNerveSystem.trigger_impulse_sensory_event_callback = function(l_20_0, l_20_1)
	if not l_20_0._is_enabled then
		return 
	end
	local l_20_2 = l_20_0:_create_buffered_event(l_20_1, false)
	l_20_0._ai_data.input.buffered_events[l_20_1:instance_id()] = l_20_2
end

AiNerveSystem._create_buffered_event = function(l_21_0, l_21_1, l_21_2)
	local l_21_3 = {}
	l_21_3.event = l_21_1
	l_21_3.read = false
	l_21_3.has_ended = not l_21_2
	return l_21_3
end

AiNerveSystem._damage_callback = function(l_22_0, l_22_1, l_22_2, l_22_3, l_22_4, l_22_5)
	local l_22_11, l_22_12, l_22_13, l_22_14, l_22_15, l_22_16 = nil
	if not l_22_0._is_enabled then
		return 
	end
	if not l_22_4 or l_22_4 ~= "collision" then
		local l_22_6 = l_22_0._ai_data.input.buffered_damages
		local l_22_7 = -l_22_3
		for i_0,i_1 in pairs(l_22_6) do
			if i_1:equal(l_22_7, l_22_5) then
				i_1:add_damage(l_22_1)
				return 
			end
		end
		table.insert(l_22_6, BufferedDamage:new(l_22_1, l_22_7, l_22_5))
		 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

	end
end

AiNerveSystem._check_stun = function(l_23_0)
	if not l_23_0._unit:enemy_data() then
		return 
	end
	local l_23_1 = l_23_0._unit:enemy_data().is_stunned
	if l_23_1 and l_23_0:is_enabled() then
		l_23_0:disable()
		l_23_0._stun_disabled = true
		l_23_0._ai_data.input.is_stunned = true
		if l_23_0._begin_stun then
			l_23_0:_begin_stun()
		end
	elseif l_23_0._stun_disabled and not l_23_1 then
		l_23_0:enable()
		l_23_0._stun_disabled = false
		l_23_0._ai_data.input.is_stunned = false
	if l_23_0._end_stun then
		end
		l_23_0:_end_stun()
	end
end

AiNerveSystem.update = function(l_24_0, l_24_1, l_24_2, l_24_3)
	local l_24_4 = assert
	l_24_4(not l_24_0._is_dead or type(l_24_0._is_dead) == "function", "_is_dead() must be implemented!")
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_24_4 then
		l_24_4.dead = true
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		if not l_24_4 then
			l_24_4(l_24_0)
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		return l_24_4
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	l_24_0._unit_position = l_24_4
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_24_4 and not l_24_4 then
		l_24_4(l_24_0)
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		if not l_24_4 and l_24_4 then
			l_24_4(l_24_0)
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_24_4 or l_24_4 then
		return l_24_4
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	if l_24_4 then
		l_24_4(l_24_0)
		 -- DECOMPILER ERROR: Overwrote pending register.

		l_24_4(l_24_0, l_24_1, l_24_2, l_24_3)
		 -- DECOMPILER ERROR: Overwrote pending register.

		return l_24_4
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	else
		if not l_24_4 then
			return l_24_4
		end
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: Overwrote pending register.

	 -- DECOMPILER ERROR: unhandled construct in 'if'

	 -- DECOMPILER ERROR: unhandled construct in 'if'

	if l_24_4 and l_24_4 ~= true and l_24_1:name() == l_24_4 then
		l_24_0:_debug_render_state(l_24_1)
	end
	 -- DECOMPILER ERROR: Overwrote pending register.

	return l_24_4
end

AiNerveSystem.low_frequency_update = function(l_25_0, l_25_1, l_25_2, l_25_3)
	local l_25_4 = l_25_0._ai_data.input
	l_25_0:_check_stun()
	l_25_0:_update_events(l_25_3, l_25_4)
	l_25_0:_update_damages(l_25_3, l_25_4)
	IntelUtilities.ai_update_eyes(l_25_1)
	IntelUtilities.ai_update_weapons(l_25_1)
	if l_25_0:_evaluate_forced_targeting_update() then
		l_25_0:_forced_targeting_update()
	end
	if l_25_0._ai_data.graph then
		l_25_0:_update_path(l_25_1, l_25_2)
		l_25_0:_update_navigation_graph(l_25_3, l_25_1, l_25_0._ai_data.graph)
	end
	l_25_0._ai_data.input.moving_to_position = l_25_0._move_to_position
	l_25_0:_update_waypoint_rotation_look_at_position()
	l_25_0:_update_stuck(l_25_3, l_25_0._ai_data)
	local l_25_5 = l_25_0._movement_blocked
	if l_25_5 then
		l_25_0._movement_blocked_timer = l_25_0._movement_blocked_timer + l_25_3
	else
		l_25_0._movement_blocked_timer = 0
		l_25_0._movement_blocked_by_unit = nil
	end
	if l_25_5 then
		local l_25_6 = l_25_0._ai_data.output.has_threats
		local l_25_7 = nil
		if l_25_6 then
			l_25_7 = l_25_0._movement_blocked_max_time.threatened
		else
			l_25_7 = l_25_0._movement_blocked_max_time.normal
		end
		if l_25_7 < l_25_0._movement_blocked_timer and not l_25_0._path_blocked_has_requested_new then
			l_25_0._ai_data:request_new_path()
			l_25_0._path_blocked_has_requested_new = true
			l_25_0:_update_movement_blocked_max_time()
		end
	else
		l_25_0._path_blocked_has_requested_new = false
	end
	local l_25_8 = assert
	l_25_8(TableAlgorithms.count(l_25_4.buffered_events) < 128, "Event list too long")
	l_25_8 = assert
	l_25_8(TableAlgorithms.count(l_25_4.buffered_damages) < 128, "Damage list too long")
	l_25_8 = true
	return l_25_8
end

AiNerveSystem._forced_targeting_update = function(l_26_0)
	local l_26_5, l_26_6, l_26_7, l_26_8 = nil
	local l_26_1 = l_26_0._ai_data
	if l_26_0._forced_targeting_threads then
		for i_0,i_1 in ipairs(l_26_0._forced_targeting_threads) do
			l_26_1.brain:force_update(i_1)
		end
	end
end

AiNerveSystem._evaluate_forced_targeting_update = function(l_27_0)
	if not l_27_0._forced_targeting_threads then
		return false
	end
	local l_27_1 = l_27_0._ai_data
	if #l_27_1.input.buffered_damages > 0 then
		local l_27_2 = not l_27_1._targeting.currently_targeted_threat
	else
		local l_27_3 = false
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if l_27_3 then
		return true
	end
	local l_27_4 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	if alive(l_27_1.output.firing_target) and l_27_1.output.firing_target:damage_data() and l_27_1.output.firing_target:damage_data():is_fully_damaged() then
		return true
	end
	do
		local l_27_12, l_27_13 = , l_27_0._unit:in_slot
		l_27_13 = l_27_13(l_27_0._unit, managers.slot:get_mask("machines"))
		local l_27_5 = nil
		if l_27_13 then
			l_27_5 = l_27_1.output
			l_27_5 = l_27_5.allowed_to_fire
			if l_27_5 then
				l_27_5 = alive
				l_27_5 = l_27_5(l_27_12)
			if l_27_5 then
				end
				l_27_5 = managers
				l_27_5 = l_27_5.player
				 -- DECOMPILER ERROR: Overwrote pending register.

				 -- DECOMPILER ERROR: Overwrote pending register.

				local l_27_6 = nil
				 -- DECOMPILER ERROR: Overwrote pending register.

				do
					local l_27_7 = nil
			end
			if l_27_5 then
				end
				l_27_6 = managers
				l_27_6 = l_27_6.player
				 -- DECOMPILER ERROR: Overwrote pending register.

				local l_27_8 = nil
				l_27_8 = pairs
				l_27_8 = l_27_8(l_27_6)
				for i_0,i_1 in l_27_8 do
					 -- DECOMPILER ERROR: Confused about usage of registers!

					if (not l_27_1._threat_tracking._threats[i_1:key()] or not l_27_1._threat_tracking._threats[i_1:key()]:unit_line_of_sight()) and IntelUtilities.ai_is_target_visible(l_27_0._unit, l_27_14) then
						return true
					end
				end
				 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

			end
			 -- DECOMPILER ERROR: Overwrote pending register.

			return l_27_5
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 68 
end

AiNerveSystem._stun_update = function(l_28_0, l_28_1, l_28_2, l_28_3)
end

AiNerveSystem._update_events = function(l_29_0, l_29_1, l_29_2)
	TableAlgorithms.remove_if(l_29_2.buffered_events, function(l_30_0)
		if not l_30_0.read or not l_30_0.has_ended then
			return not l_30_0.event:valid()
		end
  end)
end

AiNerveSystem._update_damages = function(l_30_0, l_30_1, l_30_2)
	TableAlgorithms.remove_if(l_30_2.buffered_damages, function(l_31_0)
		local l_31_1, l_31_2 = l_31_0:read, l_31_0
		return l_31_1(l_31_2)
  end)
end

AiNerveSystem._update_navigation_graph = function(l_31_0, l_31_1, l_31_2, l_31_3)
	if not l_31_0._has_dynamic_graph then
		return 
	end
	if not l_31_0._last_graph_position then
		l_31_0._last_graph_position = l_31_0._unit_position
	end
	local l_31_4 = mvector3.distance(l_31_0._unit_position, l_31_0._last_graph_position) / l_31_1
	NavigationGraphUtilities.move_dynamic(l_31_2, l_31_3, l_31_4)
	l_31_0._last_graph_position = l_31_0._unit_position
end

AiNerveSystem._update_path = function(l_32_0, l_32_1, l_32_2)
	if l_32_0._ai_data:new_path_received() then
		l_32_0:_accept_new_path(l_32_1)
		l_32_0._last_path_check_time = l_32_2
		l_32_0._last_shortcut_check_time = l_32_2
	end
	local l_32_3 = l_32_0._ai_data:path()
	if not l_32_3 or not l_32_0._move_to_position then
		l_32_0._ai_data:request_new_path()
		return 
	end
	if l_32_0._animation_driven_movement then
		l_32_0:_set_move_to_position(nil)
		l_32_0._ai_data:request_new_path()
		return 
	end
	l_32_0._has_arrived_state = false
	while l_32_0:_has_arrived(l_32_1) do
		l_32_0._has_arrived_state = true
		if l_32_0._current_path_index == #l_32_3 then
			local l_32_4 = l_32_0._move_to_position_waypoint
		else
			local l_32_5, l_32_6, l_32_7 = false
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_32_0._ai_data.input.passed_last_waypoint = l_32_5
		l_32_0._current_path_index = l_32_0:_next_path_index()
		local l_32_8 = nil
		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_32_0._move_to_position_waypoint then
			managers.ai.waypoint:waypoint_passed(l_32_0._move_to_position_waypoint.id)
		end
		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		 -- DECOMPILER ERROR: Confused about usage of registers!

		if l_32_0._move_to_position_waypoint and l_32_0._move_to_position_waypoint.rotation then
			l_32_0._waypoint_rotation_look_at_position = l_32_0:_waypoint_look_at_position(l_32_0._move_to_position_waypoint.rotation)
		else
			l_32_0._waypoint_rotation_look_at_position = nil
		end
		local l_32_9 = nil
		l_32_0:_set_move_to_position(l_32_3[l_32_0._current_path_index])
		l_32_0._start_position = l_32_0._unit_position
		if l_32_0._move_to_position == nil then
			l_32_0._ai_data:set_current_path_completed()
			l_32_0._ai_data:request_new_path()
			return 
		end
		l_32_0._last_path_check_time = l_32_2
	end
	if l_32_0:_force_path() then
		l_32_0._movement_blocked = false
	end
	if NavigationGraphUtilities.is_nice_to_check_move_there() and l_32_2 - l_32_0._last_path_check_time > 0.5 and not l_32_0:_force_path() then
		l_32_0._movement_blocked = false
		local l_32_10 = mvector3.distance(l_32_0._move_to_position, l_32_0._unit_position)
	if l_32_10 > 0 then
		end
		local l_32_11 = (l_32_0._move_to_position - l_32_0._unit_position) / l_32_10
		local l_32_12 = math.min(l_32_1:oobb():size().y, l_32_10)
		local l_32_13, l_32_14, l_32_15 = NavigationGraphUtilities.ai_check_can_move_there(l_32_1, l_32_0._unit_position + l_32_12 * l_32_11, nil, nil, true)
		if not l_32_13 then
			if l_32_15 and l_32_15:slot() == l_32_1:slot() then
				l_32_0._movement_blocked = true
				if l_32_15 ~= l_32_0._movement_blocked_by_unit then
					l_32_0._movement_blocked_time = 0
				end
				l_32_0._movement_blocked_by_unit = l_32_15
			end
		else
			l_32_0:_set_move_to_position(nil)
			l_32_0._ai_data:request_new_path()
			return 
		end
		l_32_0._last_path_check_time = l_32_2
	end
	while 1 do
		if NavigationGraphUtilities.is_nice_to_check_move_there() and l_32_0._last_path_check_time ~= l_32_2 and l_32_2 - l_32_0._last_shortcut_check_time > 0.5 then
			if l_32_0._current_path_index < #l_32_3 and not l_32_0._move_to_position_waypoint then
				if not NavigationGraphUtilities.ai_check_can_move_there(l_32_1, l_32_3[l_32_0._current_path_index + 1], nil, nil, true) then
					do break end
				end
			end
			l_32_0._current_path_index = l_32_0._current_path_index + 1
			l_32_0:_set_move_to_position(l_32_3[l_32_0._current_path_index])
			l_32_0._last_path_check_time = l_32_2
		end
		l_32_0._last_shortcut_check_time = l_32_2
	end
	if Global.category_debug_render.ai and l_32_0._move_to_position then
		l_32_0._debug_brush:set_persistance(0.5)
		l_32_0._debug_brush:sphere(l_32_0._move_to_position, 50)
	end
	return 
end

AiNerveSystem._next_path_index = function(l_33_0)
	if l_33_0._ai_data._loop_path and #l_33_0._ai_data:path() < l_33_0._current_path_index + 1 then
		return 1
	end
end

AiNerveSystem._next_path_position = function(l_34_0)
	return l_34_0._ai_data:path()[l_34_0:_next_path_index()]
end

AiNerveSystem._force_path = function(l_35_0)
	return not l_35_0._waypoint_options or not l_35_0._waypoint_options.follow_path or l_35_0._waypoint_options.follow_path == "force_waypoint_path"
end

AiNerveSystem._debug_render_state = function(l_36_0, l_36_1)
	local l_36_2 = l_36_0._ai_data.brain
	local l_36_3 = 200
	local l_36_4 = Draw:brush()
	l_36_4:set_font("editor_font", 15)
	local l_36_9 = l_36_4:set
	local l_36_8 = l_36_4
	l_36_9(l_36_8, Color(1, 1, 1), "OverlayVertexColorTextured")
	l_36_9 = pairs
	l_36_8 = l_36_2._threads_map
	l_36_9 = l_36_9(l_36_8)
	for i_0,i_1 in l_36_9 do
		l_36_4:center_text(l_36_0._unit_position + Vector3(0, 0, l_36_3), l_36_7:print())
		l_36_3 = l_36_3 + 20
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

AiNerveSystem._accept_new_path = function(l_37_0, l_37_1)
	l_37_0._ai_data:accept_new_path()
	local l_37_2 = l_37_0._ai_data:path()
	if l_37_2 then
		l_37_0._current_path_index = 1
		l_37_0:_set_move_to_position(l_37_2[l_37_0._current_path_index])
		l_37_0._start_position = l_37_0._unit_position
	else
		l_37_0._current_path_index = 0
		l_37_0:_set_move_to_position(nil)
		l_37_0._start_position = nil
	end
	l_37_0._ai_data.input.passed_last_waypoint = false
end

AiNerveSystem._calculate_path_look_at_position = function(l_38_0)
	-- upvalues: l_0_0
	local l_38_1 = l_38_0._ai_data:path()
	if #l_38_1 < l_38_0._current_path_index then
		local l_38_2 = l_38_1[#l_38_1]
		local l_38_3 = l_38_0._ai_data:last_waypoint_rotation()
		return l_38_2 + l_38_3:y() * l_0_0
	else
		return l_38_1[l_38_0._current_path_index]
	end
end

AiNerveSystem._has_arrived = function(l_39_0, l_39_1)
	local l_39_2 = mvector3.distance(l_39_0._unit_position, l_39_0._move_to_position)
	if l_39_2 == 0 or (l_39_0._ai_data.arrived_radius or l_39_2 < 0.1 * l_39_1:oobb():size().x) then
		return true
	end
	if l_39_0._unit_position == l_39_0._start_position then
		return false
	end
	local l_39_3 = l_39_0._start_position - l_39_0._unit_position:normalized()
	if not l_39_0._ai_data.disc_arrived_radius then
		local l_39_4 = 0.5 * l_39_1:oobb():size().x
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	if SharedMath.intersect_ray_disk(l_39_0._move_to_position, l_39_4, l_39_3, l_39_0._start_position, l_39_0._unit_position) then
		return true
	end
	return false
end

AiNerveSystem.position = function(l_40_0)
	return l_40_0._unit_position
end

AiNerveSystem.sound_level_hearing_threshold = function(l_41_0)
	return l_41_0._ai_data.SOUND_LEVEL_HEARING_THRESHOLD
end

AiNerveSystem._update_weapons_dispersions = function(l_42_0, l_42_1, l_42_2, l_42_3)
	local l_42_4 = {}
	for l_42_8 = 1, l_42_0._number_of_dispersion_weapons do
		local l_42_9 = l_42_2[l_42_8]
		if l_42_9 ~= l_42_0._weapon_targets[l_42_8] then
			l_42_0._weapon_target_timers[l_42_8] = 0
			l_42_0._weapon_targets[l_42_8] = l_42_9
		end
		if not l_42_0._weapon_targets[l_42_8] then
			l_42_4[l_42_8] = 0
		else
			local l_42_10 = l_42_0._weapon_target_timers[l_42_8]
			local l_42_11 = l_42_0._miss_max_dispersion * (1 - math.min(1, l_42_0._miss_timer_speed * l_42_10))
			l_42_4[l_42_8] = l_42_11
			l_42_0._weapon_target_timers[l_42_8] = l_42_10 + l_42_3
		end
	end
	return l_42_4
end

AiNerveSystem._set_move_to_position = function(l_43_0, l_43_1)
	l_43_0._move_to_position = l_43_1
	if l_43_1 then
		if l_43_0._move_to_position_waypoint and l_43_0._ai_data:is_waypoint(l_43_0._move_to_position_waypoint.position_xy) then
			l_43_0._waypoint_options = l_43_0._move_to_position_waypoint.options
		else
			l_43_0._waypoint_options = nil
		end
		l_43_0._move_to_position_waypoint = l_43_0._ai_data:waypoint(l_43_1)
	else
		l_43_0._move_to_position_waypoint = nil
		l_43_0._waypoint_options = nil
	end
	l_43_0:_update_waypoint_rotation_look_at_position()
end

AiNerveSystem._update_waypoint_rotation_look_at_position = function(l_44_0)
	if not l_44_0._move_to_position then
		l_44_0._waypoint_rotation_look_at_position = nil
		return 
	end
	if not l_44_0._move_to_position_waypoint then
		l_44_0._waypoint_rotation_look_at_position = nil
		return 
	end
	local l_44_1 = l_44_0._ai_data.ROTATE_TO_WAYPOINT_DIRECTION_START_DISTANCE
	if not l_44_1 then
		l_44_0._waypoint_rotation_look_at_position = nil
		return 
	end
	local l_44_2 = l_44_0._move_to_position_waypoint
	if not l_44_2 or not l_44_2.rotation then
		l_44_0._waypoint_rotation_look_at_position = nil
		return 
	end
	local l_44_3 = l_44_0._unit
	local l_44_4 = l_44_0._move_to_position
	assert(l_44_4)
	local l_44_5 = mvector3.distance(l_44_0._unit_position, l_44_4)
	if l_44_5 < l_44_1 * l_44_0._ai_data.output.move_speed then
		l_44_0._waypoint_rotation_look_at_position = l_44_0:_waypoint_look_at_position(l_44_2.rotation)
	else
		l_44_0._waypoint_rotation_look_at_position = nil
	end
end

AiNerveSystem._waypoint_look_at_position = function(l_45_0, l_45_1)
	-- upvalues: l_0_0
	assert(l_45_1)
	return l_45_0._move_to_position + l_45_1:y() * l_0_0
end

AiNerveSystem._update_stuck = function(l_46_0, l_46_1, l_46_2)
	local l_46_3 = l_46_2.output.can_not_find_path
	local l_46_4 = l_46_2.STUCK_RADIUS
	local l_46_5 = l_46_0._unit
	if l_46_4 then
		local l_46_6 = l_46_0._unit_position
		if l_46_3 then
			l_46_2:update_stuck_time(l_46_1, l_46_3)
		end
	elseif l_46_0._has_arrived_state then
		l_46_2:update_stuck_time(l_46_1, false)
	elseif l_46_0._move_to_position then
		local l_46_7 = l_46_0._last_stuck_position
		if l_46_7 then
			if mvector3.distance(l_46_6, l_46_7) < l_46_4 then
				l_46_3 = true
			else
				l_46_0._last_stuck_position = l_46_6
			end
		else
			l_46_0._last_stuck_position = l_46_6
		end
		l_46_2:update_stuck_time(l_46_1, l_46_3)
	end
end

AiNerveSystem._is_dead = function(l_47_0)
	local l_47_1, l_47_2 = l_47_0._unit:damage_data():is_fully_damaged, l_47_0._unit:damage_data()
	return l_47_1(l_47_2)
end

AiNerveSystem._burst_fire = function(l_48_0, l_48_1, l_48_2, l_48_3)
	if not l_48_2 then
		l_48_0._burst_end_time = nil
		l_48_0._burst_start_time = nil
		return false
	end
	if not l_48_3 and not l_48_0._burst_end_time and not l_48_0._burst_start_time then
		return true
	end
	local l_48_4 = assert
	l_48_4(l_48_0._burst_max_deviation_time < l_48_0._burst_mean_time)
	l_48_4 = assert
	l_48_4(l_48_0._burst_pause_max_deviation_time < l_48_0._burst_pause_mean_time)
	l_48_4 = l_48_0._burst_start_time
	if not l_48_4 then
		l_48_4 = l_48_0._burst_end_time
	if l_48_4 then
		end
	end
	l_48_4 = l_48_0._burst_start_time
	if l_48_4 then
		l_48_4 = l_48_0._burst_start_time
	if l_48_4 < l_48_1 then
		end
		l_48_0._burst_start_time = nil
		l_48_4 = math
		l_48_4 = l_48_4.clamp
		l_48_4 = l_48_4(SharedMath.normalized_rand(l_48_0._burst_mean_time, l_48_0._burst_standard_deviation_time), l_48_0._burst_mean_time - l_48_0._burst_max_deviation_time, l_48_0._burst_mean_time + 2 * l_48_0._burst_standard_deviation_time)
		l_48_0._burst_end_time = l_48_1 + l_48_4
	end
	l_48_4 = l_48_0._burst_end_time
	if l_48_4 then
		l_48_4 = l_48_0._burst_end_time
	if l_48_4 < l_48_1 then
		end
		l_48_0._burst_end_time = nil
		l_48_4 = math
		l_48_4 = l_48_4.clamp
		l_48_4 = l_48_4(SharedMath.normalized_rand(l_48_0._burst_pause_mean_time, l_48_0._burst_pause_standard_deviation_time), l_48_0._burst_pause_mean_time - l_48_0._burst_pause_max_deviation_time, l_48_0._burst_pause_mean_time + 2 * l_48_0._burst_pause_standard_deviation_time)
		l_48_0._burst_start_time = l_48_1 + l_48_4
	end
	l_48_4 = l_48_0._burst_end_time
	l_48_4 = l_48_4 ~= nil
	return l_48_4
end


