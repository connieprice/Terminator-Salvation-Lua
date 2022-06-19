require("units/beings/machines/flyer/states/FlyerState")
require("units/beings/machines/flyer/states/FlyerNormalState")
require("units/beings/machines/states/StunState")
if not FlyerStunState then
	FlyerStunState = class(FlyerState)
end
FlyerStunState.init = function(l_1_0, l_1_1, l_1_2)
	FlyerState.init(l_1_0, l_1_1)
	l_1_0._stun_state = StunState:new(l_1_1, l_1_2, tweak_data.enemy.flyer.STUN_TIME)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	local l_1_3 = math.rand(0.8, 1.2)
	l_1_0._flyer_movement = FlyerMovement:new(l_1_1:base():chassi_body(), l_1_3)
	l_1_0._chassi_body = l_1_1:base():chassi_body()
	l_1_0._time = 0
end

FlyerStunState.enter = function(l_2_0)
	l_2_0._enemy_data.is_stunned = true
	l_2_0._stun_state:enter()
end

FlyerStunState.leave = function(l_3_0)
	l_3_0._enemy_data.is_stunned = false
	l_3_0._stun_state:leave()
end

FlyerStunState.update = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	local l_4_3 = l_4_0._stun_state:update(l_4_1)
	if not l_4_3 then
		local l_4_4, l_4_5 = FlyerNormalState:new, FlyerNormalState
		local l_4_6 = l_4_0._unit
		return l_4_4(l_4_5, l_4_6)
	end
	l_4_0:_update_movement(l_4_1)
end

FlyerStunState._update_movement = function(l_5_0, l_5_1)
	local l_5_2 = 0.5
	local l_5_3 = 0.5
	local l_5_4 = 1
	local l_5_5 = false
	local l_5_6 = l_5_0._chassi_body:center_of_mass() + Vector3(0, 0, 23)
	local l_5_7 = l_5_6 + l_5_0._unit:rotation():z()
	local l_5_8, l_5_9 = nil, nil
	local l_5_10, l_5_11 = l_5_0._flyer_movement:update(l_5_1, l_5_7, l_5_5, false, l_5_4, l_5_6, nil)
	local l_5_12 = l_5_0._unit:input()
	l_5_12:clear()
	l_5_10 = Vector3(l_5_10.x, l_5_10.y, l_5_10.z * l_5_3)
	l_5_11 = Vector3(l_5_11.x, l_5_11.y, l_5_11.z * l_5_2)
	l_5_10 = l_5_10 + l_5_0:_noise(l_5_1, tweak_data.enemy.flyer.STUN_NOISE_AMPLITUDE, tweak_data.enemy.flyer.STUN_NOISE_FREQUENCY_1, tweak_data.enemy.flyer.STUN_NOISE_FREQUENCY_2)
	l_5_12:set_acceleration(l_5_10)
	l_5_12:set_angular_acceleration(l_5_11)
end

FlyerStunState._noise = function(l_6_0, l_6_1, l_6_2, l_6_3, l_6_4)
	l_6_0._time = l_6_0._time + l_6_1
	return l_6_2.x * Vector3(1, 0, 0) * (math.sin(l_6_3.x * l_6_0._time) + math.sin(l_6_4.x * l_6_0._time)) + l_6_2.y * Vector3(0, 1, 0) * (math.sin(l_6_3.y * l_6_0._time) + math.sin(l_6_4.y * l_6_0._time)) + l_6_2.z * Vector3(0, 0, 1) * (math.sin(l_6_3.z * l_6_0._time) + math.sin(l_6_4.z * l_6_0._time))
end


