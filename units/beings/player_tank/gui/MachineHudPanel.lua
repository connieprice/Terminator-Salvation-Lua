require("units/beings/player_tank/gui/BootStates")
MachineHudPanel = MachineHudPanel or class()
function MachineHudPanel.init(A0_0, A1_1)
	A0_0._boot_state = FiniteStateMachine:new(A0_0, "_hud_panel", BootIdleState)
	A0_0._boot_state:set_debug(false)
	A0_0.startup_done = false
	A0_0._parent_panel = A1_1
end
function MachineHudPanel.startup(A0_2, A1_3, A2_4)
	A0_2._wants_to_start_up = true
	A0_2._wants_to_shut_down = false
	A0_2._wants_to_boot_idle = false
	if A1_3 then
		A0_2._start_time = math.random(A1_3 * 100) / 100
	else
		A0_2._start_time = 0
	end
	A0_2._dot_time = A2_4 or 0
end
function MachineHudPanel.get_start_time(A0_5)
	return A0_5._start_time or 0
end
function MachineHudPanel.get_dot_time(A0_6)
	return A0_6._dot_time or 0
end
function MachineHudPanel.shutdown(A0_7, A1_8, A2_9)
	A0_7._wants_to_shut_down = true
	A0_7._wants_to_start_up = false
	A0_7._wants_to_boot_idle = false
	if A2_9 then
		A0_7._start_time = math.random(A1_8 * 100) / 100
	else
		A0_7._start_time = A1_8 or 0
	end
end
function MachineHudPanel.boot_idle(A0_10)
	local L1_11
	A0_10._wants_to_boot_idle = true
	A0_10._wants_to_shut_down = false
	A0_10._wants_to_start_up = false
end
function MachineHudPanel.wants_to_start_up(A0_12)
	local L1_13
	L1_13 = A0_12._wants_to_start_up
	return L1_13
end
function MachineHudPanel.wants_to_shut_down(A0_14)
	local L1_15
	L1_15 = A0_14._wants_to_shut_down
	return L1_15
end
function MachineHudPanel.wants_to_boot_idle(A0_16)
	local L1_17
	L1_17 = A0_16._wants_to_boot_idle
	return L1_17
end
function MachineHudPanel.set_startup_done(A0_18)
	local L1_19
	A0_18.startup_done = true
end
function MachineHudPanel.get_target_size(A0_20)
	local L1_21, L2_22
	L1_21 = 0
	L2_22 = 0
	return L1_21, L2_22
end
function MachineHudPanel.get_target_position(A0_23)
	local L1_24, L2_25
	return L1_24, L2_25
end
function MachineHudPanel.set_size_y(A0_26, A1_27)
end
function MachineHudPanel.hide(A0_28)
	local L1_29
	A0_28._hidden = true
end
function MachineHudPanel.show(A0_30)
	local L1_31
	A0_30._hidden = false
end
function MachineHudPanel.update(A0_32, A1_33)
	A0_32._boot_state:update(A1_33)
end
function MachineHudPanel.is_split_screen(A0_34)
	local L1_35
	L1_35 = managers
	L1_35 = L1_35.local_session_user
	L1_35 = L1_35.users
	L1_35 = L1_35(L1_35)
	for 