if not FreeFlight then
	FreeFlight = class(CoreFreeFlight)
end
FreeFlight.init = function(l_1_0)
	CoreFreeFlight.init(l_1_0)
	l_1_0._freeflight_locked = false
	l_1_0._user = nil
end

FreeFlight.on_get_focus = function(l_2_0)
	setup._should_render_core_viewport = true
	CoreFreeFlight.on_get_focus(l_2_0)
	if not l_2_0._paused and (not managers.editor or script_debug.running_simulation) then
		local l_2_1 = 1
		local l_2_2 = managers.player_slot:slot(l_2_1)
		if l_2_2 then
			local l_2_3 = l_2_2:user()
		if l_2_3 then
			end
			local l_2_4 = managers.user_viewport:viewport(l_2_3)
			local l_2_5 = l_2_4:engine_camera()
			local l_2_6 = l_2_5:position()
			local l_2_7 = l_2_5:new_rotation()
			l_2_0:init_camera(l_2_6, l_2_7)
			l_2_0._user = l_2_3
		end
		l_2_0:pause()
		l_2_0._step = false
	end
end

FreeFlight.on_loose_focus = function(l_3_0, l_3_1, l_3_2, l_3_3)
	setup._should_render_core_viewport = false
	CoreFreeFlight.on_loose_focus(l_3_0, l_3_1, l_3_2, l_3_3)
	l_3_0._freeflight_locked = false
	l_3_0._user = nil
	if l_3_0._paused then
		l_3_0:unpause()
	end
end

FreeFlight.update = function(l_4_0, l_4_1, l_4_2)
	CoreFreeFlight.update(l_4_0, l_4_1, l_4_2)
	if managers.menu2d:is_active() then
		l_4_0._controller:disable()
	else
		l_4_0._controller:enable()
	end
	if l_4_0:in_focus() then
		l_4_0._ff_vp:set_dof(0.1, 0, 150, 100000, 200000)
	if l_4_0._step then
		end
		if l_4_0._step_count <= 0 then
			l_4_0:pause()
			l_4_0._step = false
		end
		l_4_0._step_count = l_4_0._step_count - 1
	end
end

FreeFlight.connect_triggers = function(l_5_0)
	l_5_0._controller:enable()
	l_5_0._controller:add_trigger("up", callback(l_5_0, l_5_0, "step_timer"))
	l_5_0._controller:add_trigger("down", callback(l_5_0, l_5_0, "toggle_timer"))
	l_5_0._controller:add_trigger("left", callback(l_5_0, l_5_0, "toggle_frustum_freeze"))
	l_5_0._controller:add_trigger("action_1", callback(l_5_0, l_5_0, "drop_player"))
	l_5_0._controller:add_trigger("action_2", callback(l_5_0, l_5_0, "move_speed_up"))
	l_5_0._controller:add_trigger("action_3", callback(l_5_0, l_5_0, "move_speed_down"))
	l_5_0._controller:add_trigger("action_4", callback(l_5_0, l_5_0, "toggle_lock_freeflight"))
	l_5_0._controller:add_trigger("action_10", callback(l_5_0, l_5_0, "position_output"))
	l_5_0._controller:add_trigger("position_output", callback(l_5_0, l_5_0, "position_output"))
	l_5_0._controller:add_trigger("debug_spawn", callback(l_5_0, l_5_0, "debug_spawn"))
	l_5_0._triggers_connected = true
end

FreeFlight.toggle_timer = function(l_6_0, l_6_1, l_6_2)
	if l_6_0._paused then
		l_6_0:unpause()
	else
		l_6_0:pause()
	end
end

FreeFlight.pause = function(l_7_0)
	Application:set_pause(true)
	l_7_0._paused = true
end

FreeFlight.unpause = function(l_8_0)
	Application:set_pause(false)
	l_8_0._paused = false
end

FreeFlight.step_timer = function(l_9_0, l_9_1, l_9_2, l_9_3)
	if l_9_0._paused then
		l_9_0._step = true
		l_9_0._step_count = 2
		l_9_0:unpause()
	end
end

FreeFlight.drop_player = function(l_10_0)
end

FreeFlight.toggle_lock_freeflight = function(l_11_0, l_11_1, l_11_2, l_11_3)
	if l_11_0._freeflight_locked then
		l_11_0._freeflight_locked = false
	else
		l_11_0._freeflight_locked = true
	end
end


