FireLogicPowerUp = FireLogicPowerUp or class(FireLogic)
function FireLogicPowerUp.init(A0_0, A1_1)
	FireLogic.init(A0_0, A1_1)
	A0_0._trigger_down_time = 0
	A0_0._delay = 0
	A0_0._is_max = false
end
function FireLogicPowerUp.fire(A0_2, A1_3)
end
function FireLogicPowerUp.fire_end(A0_4, A1_5)
	if not A0_4._only_fire_on_max_power or A0_4._only_fire_on_max_power and A0_4._trigger_down_time >= A0_4._time_to_max_power then
		assert(A0_4._wdata._bullets_in_clip > 0)
		A0_4._fire_time = A1_5
		A0_4._wdata._bullets_in_clip = A0_4._wdata._bullets_in_clip - 1
		A0_4._burst_count = math.max(A0_4._burst_count - 1, 0)
		A0_4._wdata._on_fire = true
		if A0_4._unit:base().fire then
			A0_4._unit:base():fire(A1_5)
		end
		A0_4._firing = false
		A0_4:_reset_burst_count()
		A0_4._wdata._fire_end = true
		if A0_4._unit:base().fire_end then
			A0_4._unit:base():fire_end(A1_5)
		end
		A0_4._trigger_down_time = 0
		A0_4._delay = 0
	end
end
function FireLogicPowerUp.update(A0_6, A1_7, A2_8, A3_9)
	FireLogic.update(A0_6, A1_7, A2_8, A3_9)
	A0_6:_update_power_up(A2_8, A3_9)
end
function FireLogicPowerUp._update_power_up(A0_10, A1_11, A2_12)
	if A0_10._firing and A0_10._delay >= A0_10._power_up_delay then
		A0_10._trigger_down_time = A0_10._trigger_down_time + A2_12
	elseif not A0_10._firing and A0_10._trigger_down_time > 0 then
		A0_10._trigger_down_time = A0_10._trigger_down_time - A2_12
	end
	if A0_10._auto_fire_on_max_power and A0_10._trigger_down_time >= A0_10._time_to_max_power then
		A0_10:fire_end(A1_11)
		A0_10._wdata._firing = A0_10._firing
	end
	A0_10._delay = A0_10._delay + A2_12
end
function FireLogicPowerUp._draw_text(A0_13, A1_14, A2_15)
	Draw:brush():set_blend_mode("add")
	Draw:brush():set_font("editor_font", 48)
	Draw:brush():set_color(Color(1, 1, 1, 1))
	Draw:brush():text(A1_14, A2_15)
	Draw:brush():text(A1_14, A2_15)
	Draw:brush():text(A1_14, A2_15)
	Draw:brush():text(A1_14, A2_15)
	Draw:brush():text(A1_14, A2_15)
end
function FireLogicPowerUp.get_power_up_percent(A0_16)
	local L1_17
	L1_17 = A0_16._trigger_down_time
	L1_17 = L1_17 / A0_16._time_to_max_power
	if L1_17 < 0 then
		L1_17 = 0
	end
	return L1_17
end
function FireLogicPowerUp.destroy(A0_18)
	local L1_19
end
