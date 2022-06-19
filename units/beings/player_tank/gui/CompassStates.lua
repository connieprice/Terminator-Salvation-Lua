require("shared/FiniteStateMachine")
CompassIdleState = CompassIdleState or class()
function CompassIdleState.transition(A0_0)
	if A0_0._compass_panel:wants_to_spin_right() then
		return CompassSpinRightState
	elseif A0_0._compass_panel:wants_to_spin_left() then
		return CompassSpinLeftState
	end
end
CompassSpinRightState = CompassSpinRightState or class()
function CompassSpinRightState.init(A0_1)
	A0_1._speed_interpolator = Interpolator:new(0, 0.5)
	A0_1._speed_interpolator:set_target(tweak_data.machine.hud.COMPASS_SPIN_MAX_SPEED)
end
function CompassSpinRightState.update(A0_2, A1_3)
	local L2_4, L3_5
	L2_4 = A0_2._speed_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.update
	L2_4(L3_5, A1_3)
	L2_4 = A0_2._compass_panel
	L3_5 = L2_4
	L2_4 = L2_4.get_current_bearing
	L2_4 = L2_4(L3_5)
	A0_2._current_bearing = L2_4
	L2_4 = A0_2._compass_panel
	L3_5 = L2_4
	L2_4 = L2_4.get_target_bearing
	L2_4 = L2_4(L3_5)
	A0_2._target_bearing = L2_4
	L2_4 = A0_2._speed_interpolator
	L3_5 = L2_4
	L2_4 = L2_4.value
	L2_4 = L2_4(L3_5)
	L3_5 = A0_2._current_bearing
	L3_5 = L3_5 + L2_4
	if A0_2._target_bearing < A0_2._current_bearing then
		A0_2._target_bearing = A0_2._target_bearing + 3600
	end
	if L3_5 > A0_2._target_bearing then
		L3_5 = A0_2._target_bearing
		A0_2._compass_panel:idle()
	end
	A0_2._compass_panel:set_bearing(L3_5)
	A0_2._compass_panel:set_current_spin_speed(L2_4)
end
function CompassSpinRightState.transition(A0_6)
	if A0_6._compass_panel:wants_to_idle() then
		return CompassIdleState
	elseif A0_6._compass_panel:wants_to_slowdown_spin_right() then
		return CompassSpinRightSlowDownState
	elseif A0_6._compass_panel:wants_to_spin_left() then
		return CompassSpinLeftState
	end
end
CompassSpinRightSlowDownState = CompassSpinRightSlowDownState or class()
function CompassSpinRightSlowDownState.init(A0_7)
	local L1_8
	L1_8 = A0_7._compass_panel
	L1_8 = L1_8.get_current_spin_speed
	L1_8 = L1_8(L1_8)
	if not L1_8 then
		L1_8 = tweak_data
		L1_8 = L1_8.machine
		L1_8 = L1_8.hud
		L1_8 = L1_8.COMPASS_SPIN_MAX_SPEED
	end
	A0_7._speed_interpolator = Interpolator:new(L1_8, 2)
	A0_7._speed_interpolator:set_target(5)
end
function CompassSpinRightSlowDownState.update(A0_9, A1_10)
	local L2_11, L3_12
	L2_11 = A0_9._speed_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.update
	L2_11(L3_12, A1_10)
	L2_11 = A0_9._compass_panel
	L3_12 = L2_11
	L2_11 = L2_11.get_current_bearing
	L2_11 = L2_11(L3_12)
	A0_9._current_bearing = L2_11
	L2_11 = A0_9._compass_panel
	L3_12 = L2_11
	L2_11 = L2_11.get_target_bearing
	L2_11 = L2_11(L3_12)
	A0_9._target_bearing = L2_11
	L2_11 = A0_9._speed_interpolator
	L3_12 = L2_11
	L2_11 = L2_11.value
	L2_11 = L2_11(L3_12)
	L3_12 = A0_9._current_bearing
	L3_12 = L3_12 + L2_11
	if A0_9._target_bearing < A0_9._current_bearing then
		A0_9._target_bearing = A0_9._target_bearing + 3600
	end
	if L3_12 > A0_9._target_bearing then
		L3_12 = A0_9._target_bearing
		A0_9._compass_panel:idle()
	end
	A0_9._compass_panel:set_bearing(L3_12)
	A0_9._compass_panel:set_current_spin_speed(L2_11)
end
function CompassSpinRightSlowDownState.transition(A0_13)
	if A0_13._compass_panel:wants_to_idle() then
		return CompassIdleState
	elseif A0_13._compass_panel:wants_to_spin_right() then
		return CompassSpinRightState
	elseif A0_13._compass_panel:wants_to_spin_left() then
		return CompassSpinLeftState
	end
end
CompassSpinLeftState = CompassSpinLeftState or class()
function CompassSpinLeftState.init(A0_14)
	A0_14._speed_interpolator = Interpolator:new(0, 0.5)
	A0_14._speed_interpolator:set_target(tweak_data.machine.hud.COMPASS_SPIN_MAX_SPEED)
end
function CompassSpinLeftState.update(A0_15, A1_16)
	local L2_17, L3_18
	L2_17 = A0_15._speed_interpolator
	L3_18 = L2_17
	L2_17 = L2_17.update
	L2_17(L3_18, A1_16)
	L2_17 = A0_15._compass_panel
	L3_18 = L2_17
	L2_17 = L2_17.get_current_bearing
	L2_17 = L2_17(L3_18)
	A0_15._current_bearing = L2_17
	L2_17 = A0_15._compass_panel
	L3_18 = L2_17
	L2_17 = L2_17.get_target_bearing
	L2_17 = L2_17(L3_18)
	A0_15._target_bearing = L2_17
	L2_17 = A0_15._speed_interpolator
	L3_18 = L2_17
	L2_17 = L2_17.value
	L2_17 = L2_17(L3_18)
	L3_18 = A0_15._current_bearing
	L3_18 = L3_18 - L2_17
	if A0_15._target_bearing > A0_15._current_bearing then
		A0_15._target_bearing = A0_15._target_bearing - 3600
	end
	if L3_18 < A0_15._target_bearing then
		L3_18 = A0_15._target_bearing
		A0_15._compass_panel:idle()
	end
	A0_15._compass_panel:set_bearing(L3_18)
	A0_15._compass_panel:set_current_spin_speed(L2_17)
end
function CompassSpinLeftState.transition(A0_19)
	if A0_19._compass_panel:wants_to_idle() then
		return CompassIdleState
	elseif A0_19._compass_panel:wants_to_slowdown_spin_left() then
		return CompassSpinLeftSlowDownState
	elseif A0_19._compass_panel:wants_to_spin_right() then
		return CompassSpinRightSlowDownState
	end
end
CompassSpinLeftSlowDownState = CompassSpinLeftSlowDownState or class()
function CompassSpinLeftSlowDownState.init(A0_20)
	A0_20._target_bearing = A0_20._compass_panel:get_target_bearing()
	A0_20._current_bearing = A0_20._compass_panel:get_current_bearing()
	if A0_20._target_bearing > A0_20._current_bearing then
		A0_20._target_bearing = A0_20._target_bearing - 3600
	end
	A0_20._bearings_left = A0_20._current_bearing - A0_20._target_bearing
	Application:debug("bearings left:", A0_20._bearings_left, "current", A0_20._compass_panel:get_current_bearing(), "target", A0_20._compass_panel:get_target_bearing())
	A0_20.inital_spin_speed = A0_20._compass_panel:get_current_spin_speed() or tweak_data.machine.hud.COMPASS_SPIN_MAX_SPEED
	if A0_20._target_bearing > 200 then
		A0_20._speed_interpolator = Interpolator:new(A0_20.inital_spin_speed, 7)
	else
		A0_20._speed_interpolator = Interpolator:new(A0_20.inital_spin_speed, 30)
	end
	A0_20._speed_interpolator:set_target(1)
end
function CompassSpinLeftSlowDownState.update(A0_21, A1_22)
	local L2_23, L3_24
	L2_23 = A0_21._temp_total_time
	if not L2_23 then
		A0_21._temp_total_time = 0
	end
	L2_23 = A0_21._temp_total_time
	L2_23 = L2_23 + A1_22
	A0_21._temp_total_time = L2_23
	L2_23 = A0_21._speed_interpolator
	L3_24 = L2_23
	L2_23 = L2_23.update
	L2_23(L3_24, A1_22)
	L2_23 = A0_21._compass_panel
	L3_24 = L2_23
	L2_23 = L2_23.get_current_bearing
	L2_23 = L2_23(L3_24)
	A0_21._current_bearing = L2_23
	L2_23 = A0_21._compass_panel
	L3_24 = L2_23
	L2_23 = L2_23.get_target_bearing
	L2_23 = L2_23(L3_24)
	A0_21._target_bearing = L2_23
	L2_23 = A0_21._speed_interpolator
	L3_24 = L2_23
	L2_23 = L2_23.value
	L2_23 = L2_23(L3_24)
	L3_24 = A0_21._current_bearing
	L3_24 = L3_24 - L2_23
	Application:debug("current:", A0_21._current_bearing, "next", L3_24, "target", A0_21._target_bearing, "speed", L2_23, "in speed", A0_21.inital_spin_speed, "total", A0_21._temp_total_time)
	if A0_21._target_bearing > A0_21._current_bearing then
		A0_21._target_bearing = A0_21._target_bearing - 3600
	end
	if L3_24 < A0_21._target_bearing then
		L3_24 = A0_21._target_bearing
		A0_21._compass_panel:idle()
	end
	A0_21._compass_panel:set_bearing(L3_24)
	A0_21._compass_panel:set_current_spin_speed(L2_23)
end
function CompassSpinLeftSlowDownState.transition(A0_25)
	if A0_25._compass_panel:wants_to_idle() then
		return CompassIdleState
	elseif A0_25._compass_panel:wants_to_spin_left() then
		return CompassSpinLeftState
	elseif A0_25._compass_panel:wants_to_spin_right() then
		return CompassSpinRightState
	end
end
