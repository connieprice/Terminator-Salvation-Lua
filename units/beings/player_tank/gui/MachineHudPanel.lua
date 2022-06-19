require("units/beings/player_tank/gui/BootStates")
if not MachineHudPanel then
	MachineHudPanel = class()
end
MachineHudPanel.init = function(l_1_0, l_1_1)
	l_1_0._boot_state = FiniteStateMachine:new(l_1_0, "_hud_panel", BootIdleState)
	l_1_0._boot_state:set_debug(false)
	l_1_0.startup_done = false
	l_1_0._parent_panel = l_1_1
end

MachineHudPanel.startup = function(l_2_0, l_2_1, l_2_2)
	l_2_0._wants_to_start_up = true
	l_2_0._wants_to_shut_down = false
	l_2_0._wants_to_boot_idle = false
	if l_2_1 then
		l_2_0._start_time = math.random(l_2_1 * 100) / 100
	else
		l_2_0._start_time = 0
	end
	do
		l_2_0._dot_time = l_2_2 or 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MachineHudPanel.get_start_time = function(l_3_0)
	return l_3_0._start_time or 0
end

MachineHudPanel.get_dot_time = function(l_4_0)
	return l_4_0._dot_time or 0
end

MachineHudPanel.shutdown = function(l_5_0, l_5_1, l_5_2)
	l_5_0._wants_to_shut_down = true
	l_5_0._wants_to_start_up = false
	l_5_0._wants_to_boot_idle = false
	if l_5_2 then
		l_5_0._start_time = math.random(l_5_1 * 100) / 100
	do
		elseif not l_5_1 then
			 -- DECOMPILER ERROR: Attempted to build a boolean expression without a pending context

		end
		l_5_0._start_time = 0
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MachineHudPanel.boot_idle = function(l_6_0)
	l_6_0._wants_to_boot_idle = true
	l_6_0._wants_to_shut_down = false
	l_6_0._wants_to_start_up = false
end

MachineHudPanel.wants_to_start_up = function(l_7_0)
	return l_7_0._wants_to_start_up
end

MachineHudPanel.wants_to_shut_down = function(l_8_0)
	return l_8_0._wants_to_shut_down
end

MachineHudPanel.wants_to_boot_idle = function(l_9_0)
	return l_9_0._wants_to_boot_idle
end

MachineHudPanel.set_startup_done = function(l_10_0)
	l_10_0.startup_done = true
end

MachineHudPanel.get_target_size = function(l_11_0)
	return 0, 0
end

MachineHudPanel.get_target_position = function(l_12_0)
	local l_12_1, l_12_2 = nil
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_12_1, l_12_2
end

MachineHudPanel.set_size_y = function(l_13_0, l_13_1)
end

MachineHudPanel.hide = function(l_14_0)
	l_14_0._hidden = true
end

MachineHudPanel.show = function(l_15_0)
	l_15_0._hidden = false
end

MachineHudPanel.update = function(l_16_0, l_16_1)
	l_16_0._boot_state:update(l_16_1)
end

MachineHudPanel.is_split_screen = function(l_17_0)
	local l_17_1 = managers.local_session_user:users()
	for i_0,i_1 in pairs(l_17_1) do
		local l_17_3 = 0
		l_17_3 = l_17_3 + 1
	end
	return l_17_3 > 1
end


