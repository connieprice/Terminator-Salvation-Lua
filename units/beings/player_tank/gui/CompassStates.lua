require("shared/FiniteStateMachine")
if not CompassIdleState then
	CompassIdleState = class()
end
CompassIdleState.transition = function(l_1_0)
	if l_1_0._compass_panel:wants_to_spin_right() then
		return CompassSpinRightState
	else
		if l_1_0._compass_panel:wants_to_spin_left() then
			return CompassSpinLeftState
		end
	end
end

if not CompassSpinRightState then
	CompassSpinRightState = class()
end
CompassSpinRightState.init = function(l_2_0)
	do
		local l_2_1, l_2_2 = l_2_0._compass_panel:get_current_spin_speed() or 0
	end
	l_2_0._speed_interpolator = Interpolator:new(0, 0.5)
	l_2_0._speed_interpolator:set_target(tweak_data.machine.hud.COMPASS_SPIN_MAX_SPEED)
end

CompassSpinRightState.update = function(l_3_0, l_3_1)
	l_3_0._speed_interpolator:update(l_3_1)
	l_3_0._current_bearing = l_3_0._compass_panel:get_current_bearing()
	l_3_0._target_bearing = l_3_0._compass_panel:get_target_bearing()
	local l_3_2 = l_3_0._speed_interpolator:value()
	local l_3_3 = l_3_0._current_bearing + l_3_2
	if l_3_0._target_bearing < l_3_0._current_bearing then
		l_3_0._target_bearing = l_3_0._target_bearing + 3600
	end
	if l_3_0._target_bearing < l_3_3 then
		l_3_3 = l_3_0._target_bearing
		l_3_0._compass_panel:idle()
	end
	l_3_0._compass_panel:set_bearing(l_3_3)
	l_3_0._compass_panel:set_current_spin_speed(l_3_2)
end

CompassSpinRightState.transition = function(l_4_0)
	if l_4_0._compass_panel:wants_to_idle() then
		return CompassIdleState
	else
		if l_4_0._compass_panel:wants_to_slowdown_spin_right() then
			return CompassSpinRightSlowDownState
		end
	else
		if l_4_0._compass_panel:wants_to_spin_left() then
			return CompassSpinLeftState
		end
	end
end

if not CompassSpinRightSlowDownState then
	CompassSpinRightSlowDownState = class()
end
CompassSpinRightSlowDownState.init = function(l_5_0)
	if not l_5_0._compass_panel:get_current_spin_speed() then
		local l_5_1, l_5_2, l_5_3 = tweak_data.machine.hud.COMPASS_SPIN_MAX_SPEED
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_5_0._speed_interpolator = Interpolator:new(l_5_1, 2)
	l_5_0._speed_interpolator:set_target(5)
end

CompassSpinRightSlowDownState.update = function(l_6_0, l_6_1)
	l_6_0._speed_interpolator:update(l_6_1)
	l_6_0._current_bearing = l_6_0._compass_panel:get_current_bearing()
	l_6_0._target_bearing = l_6_0._compass_panel:get_target_bearing()
	local l_6_2 = l_6_0._speed_interpolator:value()
	local l_6_3 = l_6_0._current_bearing + l_6_2
	if l_6_0._target_bearing < l_6_0._current_bearing then
		l_6_0._target_bearing = l_6_0._target_bearing + 3600
	end
	if l_6_0._target_bearing < l_6_3 then
		l_6_3 = l_6_0._target_bearing
		l_6_0._compass_panel:idle()
	end
	l_6_0._compass_panel:set_bearing(l_6_3)
	l_6_0._compass_panel:set_current_spin_speed(l_6_2)
end

CompassSpinRightSlowDownState.transition = function(l_7_0)
	if l_7_0._compass_panel:wants_to_idle() then
		return CompassIdleState
	else
		if l_7_0._compass_panel:wants_to_spin_right() then
			return CompassSpinRightState
		end
	else
		if l_7_0._compass_panel:wants_to_spin_left() then
			return CompassSpinLeftState
		end
	end
end

if not CompassSpinLeftState then
	CompassSpinLeftState = class()
end
CompassSpinLeftState.init = function(l_8_0)
	do
		local l_8_1, l_8_2 = l_8_0._compass_panel:get_current_spin_speed() or 0
	end
	l_8_0._speed_interpolator = Interpolator:new(0, 0.5)
	l_8_0._speed_interpolator:set_target(tweak_data.machine.hud.COMPASS_SPIN_MAX_SPEED)
end

CompassSpinLeftState.update = function(l_9_0, l_9_1)
	l_9_0._speed_interpolator:update(l_9_1)
	l_9_0._current_bearing = l_9_0._compass_panel:get_current_bearing()
	l_9_0._target_bearing = l_9_0._compass_panel:get_target_bearing()
	local l_9_2 = l_9_0._speed_interpolator:value()
	local l_9_3 = l_9_0._current_bearing - l_9_2
	if l_9_0._current_bearing < l_9_0._target_bearing then
		l_9_0._target_bearing = l_9_0._target_bearing - 3600
	end
	if l_9_3 < l_9_0._target_bearing then
		l_9_3 = l_9_0._target_bearing
		l_9_0._compass_panel:idle()
	end
	l_9_0._compass_panel:set_bearing(l_9_3)
	l_9_0._compass_panel:set_current_spin_speed(l_9_2)
end

CompassSpinLeftState.transition = function(l_10_0)
	if l_10_0._compass_panel:wants_to_idle() then
		return CompassIdleState
	else
		if l_10_0._compass_panel:wants_to_slowdown_spin_left() then
			return CompassSpinLeftSlowDownState
		end
	else
		if l_10_0._compass_panel:wants_to_spin_right() then
			return CompassSpinRightSlowDownState
		end
	end
end

if not CompassSpinLeftSlowDownState then
	CompassSpinLeftSlowDownState = class()
end
CompassSpinLeftSlowDownState.init = function(l_11_0)
	l_11_0._target_bearing = l_11_0._compass_panel:get_target_bearing()
	l_11_0._current_bearing = l_11_0._compass_panel:get_current_bearing()
	if l_11_0._current_bearing < l_11_0._target_bearing then
		l_11_0._target_bearing = l_11_0._target_bearing - 3600
	end
	l_11_0._bearings_left = l_11_0._current_bearing - l_11_0._target_bearing
	Application:debug("bearings left:", l_11_0._bearings_left, "current", l_11_0._compass_panel:get_current_bearing(), "target", l_11_0._compass_panel:get_target_bearing())
	if not l_11_0._compass_panel:get_current_spin_speed() then
		l_11_0.inital_spin_speed = tweak_data.machine.hud.COMPASS_SPIN_MAX_SPEED
	end
	if l_11_0._target_bearing > 200 then
		l_11_0._speed_interpolator = Interpolator:new(l_11_0.inital_spin_speed, 7)
	else
		l_11_0._speed_interpolator = Interpolator:new(l_11_0.inital_spin_speed, 30)
	end
	l_11_0._speed_interpolator:set_target(1)
end

CompassSpinLeftSlowDownState.update = function(l_12_0, l_12_1)
	if not l_12_0._temp_total_time then
		l_12_0._temp_total_time = 0
	end
	l_12_0._temp_total_time = l_12_0._temp_total_time + l_12_1
	l_12_0._speed_interpolator:update(l_12_1)
	l_12_0._current_bearing = l_12_0._compass_panel:get_current_bearing()
	l_12_0._target_bearing = l_12_0._compass_panel:get_target_bearing()
	local l_12_2 = l_12_0._speed_interpolator:value()
	local l_12_3 = l_12_0._current_bearing - l_12_2
	Application:debug("current:", l_12_0._current_bearing, "next", l_12_3, "target", l_12_0._target_bearing, "speed", l_12_2, "in speed", l_12_0.inital_spin_speed, "total", l_12_0._temp_total_time)
	if l_12_0._current_bearing < l_12_0._target_bearing then
		l_12_0._target_bearing = l_12_0._target_bearing - 3600
	end
	if l_12_3 < l_12_0._target_bearing then
		l_12_3 = l_12_0._target_bearing
		l_12_0._compass_panel:idle()
	end
	l_12_0._compass_panel:set_bearing(l_12_3)
	l_12_0._compass_panel:set_current_spin_speed(l_12_2)
end

CompassSpinLeftSlowDownState.transition = function(l_13_0)
	if l_13_0._compass_panel:wants_to_idle() then
		return CompassIdleState
	else
		if l_13_0._compass_panel:wants_to_spin_left() then
			return CompassSpinLeftState
		end
	else
		if l_13_0._compass_panel:wants_to_spin_right() then
			return CompassSpinRightState
		end
	end
end


