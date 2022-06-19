FreeFlight = FreeFlight or class(CoreFreeFlight)
function FreeFlight.init(A0_0)
	CoreFreeFlight.init(A0_0)
	A0_0._freeflight_locked = false
	A0_0._user = nil
end
function FreeFlight.on_get_focus(A0_1)
	local L1_2, L2_3, L3_4, L4_5, L5_6, L6_7, L7_8
	L1_2 = setup
	L1_2._should_render_core_viewport = true
	L1_2 = CoreFreeFlight
	L1_2 = L1_2.on_get_focus
	L2_3 = A0_1
	L1_2(L2_3)
	L1_2 = A0_1._paused
	if not L1_2 then
		L1_2 = managers
		L1_2 = L1_2.editor
		if L1_2 then
			L1_2 = script_debug
			L1_2 = L1_2.running_simulation
		elseif L1_2 then
			L1_2 = 1
			L2_3 = managers
			L2_3 = L2_3.player_slot
			L3_4 = L2_3
			L2_3 = L2_3.slot
			L4_5 = L1_2
			L2_3 = L2_3(L3_4, L4_5)
			if L2_3 then
				L4_5 = L2_3
				L3_4 = L2_3.user
				L3_4 = L3_4(L4_5)
				if L3_4 then
					L4_5 = managers
					L4_5 = L4_5.user_viewport
					L5_6 = L4_5
					L4_5 = L4_5.viewport
					L6_7 = L3_4
					L4_5 = L4_5(L5_6, L6_7)
					L6_7 = L4_5
					L5_6 = L4_5.engine_camera
					L5_6 = L5_6(L6_7)
					L7_8 = L5_6
					L6_7 = L5_6.position
					L6_7 = L6_7(L7_8)
					L7_8 = L5_6.new_rotation
					L7_8 = L7_8(L5_6)
					A0_1:init_camera(L6_7, L7_8)
					A0_1._user = L3_4
				end
			end
			L4_5 = A0_1
			L3_4 = A0_1.pause
			L3_4(L4_5)
			A0_1._step = false
		end
	end
end
function FreeFlight.on_loose_focus(A0_9, A1_10, A2_11, A3_12)
	setup._should_render_core_viewport = false
	CoreFreeFlight.on_loose_focus(A0_9, A1_10, A2_11, A3_12)
	A0_9._freeflight_locked = false
	A0_9._user = nil
	if A0_9._paused then
		A0_9:unpause()
	end
end
function FreeFlight.update(A0_13, A1_14, A2_15)
	CoreFreeFlight.update(A0_13, A1_14, A2_15)
	if managers.menu2d:is_active() then
		A0_13._controller:disable()
	else
		A0_13._controller:enable()
	end
	if A0_13:in_focus() then
		A0_13._ff_vp:set_dof(0.1, 0, 150, 100000, 200000)
		if A0_13._step then
			if 0 >= A0_13._step_count then
				A0_13:pause()
				A0_13._step = false
			end
			A0_13._step_count = A0_13._step_count - 1
		end
	end
end
function FreeFlight.connect_triggers(A0_16)
	A0_16._controller:enable()
	A0_16._controller:add_trigger("up", callback(A0_16, A0_16, "step_timer"))
	A0_16._controller:add_trigger("down", callback(A0_16, A0_16, "toggle_timer"))
	A0_16._controller:add_trigger("left", callback(A0_16, A0_16, "toggle_frustum_freeze"))
	A0_16._controller:add_trigger("action_1", callback(A0_16, A0_16, "drop_player"))
	A0_16._controller:add_trigger("action_2", callback(A0_16, A0_16, "move_speed_up"))
	A0_16._controller:add_trigger("action_3", callback(A0_16, A0_16, "move_speed_down"))
	A0_16._controller:add_trigger("action_4", callback(A0_16, A0_16, "toggle_lock_freeflight"))
	A0_16._controller:add_trigger("action_10", callback(A0_16, A0_16, "position_output"))
	A0_16._controller:add_trigger("position_output", callback(A0_16, A0_16, "position_output"))
	A0_16._controller:add_trigger("debug_spawn", callback(A0_16, A0_16, "debug_spawn"))
	A0_16._triggers_connected = true
end
function FreeFlight.toggle_timer(A0_17, A1_18, A2_19)
	if A0_17._paused then
		A0_17:unpause()
	else
		A0_17:pause()
	end
end
function FreeFlight.pause(A0_20)
	Application:set_pause(true)
	A0_20._paused = true
end
function FreeFlight.unpause(A0_21)
	Application:set_pause(false)
	A0_21._paused = false
end
function FreeFlight.step_timer(A0_22, A1_23, A2_24, A3_25)
	if A0_22._paused then
		A0_22._step = true
		A0_22._step_count = 2
		A0_22:unpause()
	end
end
function FreeFlight.drop_player(A0_26)
	local L1_27
end
function FreeFlight.toggle_lock_freeflight(A0_28, A1_29, A2_30, A3_31)
	if A0_28._freeflight_locked then
		A0_28._freeflight_locked = false
	else
		A0_28._freeflight_locked = true
	end
end
