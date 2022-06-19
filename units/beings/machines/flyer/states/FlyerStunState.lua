require("units/beings/machines/flyer/states/FlyerState")
require("units/beings/machines/flyer/states/FlyerNormalState")
require("units/beings/machines/states/StunState")
FlyerStunState = FlyerStunState or class(FlyerState)
function FlyerStunState.init(A0_0, A1_1, A2_2)
	local L3_3
	L3_3 = FlyerState
	L3_3 = L3_3.init
	L3_3(A0_0, A1_1)
	L3_3 = StunState
	L3_3 = L3_3.new
	L3_3 = L3_3(L3_3, A1_1, A2_2, tweak_data.enemy.flyer.STUN_TIME)
	A0_0._stun_state = L3_3
	L3_3 = A0_0._unit
	L3_3 = L3_3.enemy_data
	L3_3 = L3_3(L3_3)
	A0_0._enemy_data = L3_3
	L3_3 = math
	L3_3 = L3_3.rand
	L3_3 = L3_3(0.8, 1.2)
	A0_0._flyer_movement = FlyerMovement:new(A1_1:base():chassi_body(), L3_3)
	A0_0._chassi_body = A1_1:base():chassi_body()
	A0_0._time = 0
end
function FlyerStunState.enter(A0_4)
	A0_4._enemy_data.is_stunned = true
	A0_4._stun_state:enter()
end
function FlyerStunState.leave(A0_5)
	A0_5._enemy_data.is_stunned = false
	A0_5._stun_state:leave()
end
function FlyerStunState.update(A0_6, A1_7)
	if A0_6._base:check_fully_damaged() then
		return (A0_6._base:check_fully_damaged())
	end
	if not A0_6._stun_state:update(A1_7) then
		return FlyerNormalState:new(A0_6._unit)
	end
	A0_6:_update_movement(A1_7)
end
function FlyerStunState._update_movement(A0_8, A1_9)
	local L2_10, L3_11, L4_12, L5_13, L6_14, L7_15, L8_16, L9_17, L10_18, L11_19
	L2_10 = 0.5
	L3_11 = 0.5
	L4_12 = 1
	L5_13 = false
	L6_14 = A0_8._chassi_body
	L7_15 = L6_14
	L6_14 = L6_14.center_of_mass
	L6_14 = L6_14(L7_15)
	L7_15 = Vector3
	L8_16 = 0
	L9_17 = 0
	L10_18 = 23
	L7_15 = L7_15(L8_16, L9_17, L10_18)
	L6_14 = L6_14 + L7_15
	L7_15 = A0_8._unit
	L8_16 = L7_15
	L7_15 = L7_15.rotation
	L7_15 = L7_15(L8_16)
	L8_16 = L7_15
	L7_15 = L7_15.z
	L7_15 = L7_15(L8_16)
	L7_15 = L6_14 + L7_15
	L8_16, L9_17 = nil, nil
	L10_18 = A0_8._flyer_movement
	L11_19 = L10_18
	L10_18 = L10_18.update
	L11_19 = L10_18(L11_19, A1_9, L7_15, L5_13, false, L4_12, L6_14, nil)
	A0_8._unit:input():clear()
	L10_18 = Vector3(L10_18.x, L10_18.y, L10_18.z * L3_11)
	L11_19 = Vector3(L11_19.x, L11_19.y, L11_19.z * L2_10)
	L10_18 = L10_18 + A0_8:_noise(A1_9, tweak_data.enemy.flyer.STUN_NOISE_AMPLITUDE, tweak_data.enemy.flyer.STUN_NOISE_FREQUENCY_1, tweak_data.enemy.flyer.STUN_NOISE_FREQUENCY_2)
	A0_8._unit:input():set_acceleration(L10_18)
	A0_8._unit:input():set_angular_acceleration(L11_19)
end
function FlyerStunState._noise(A0_20, A1_21, A2_22, A3_23, A4_24)
	local L5_25
	L5_25 = A0_20._time
	L5_25 = L5_25 + A1_21
	A0_20._time = L5_25
	L5_25 = A2_22.x
	L5_25 = L5_25 * Vector3(1, 0, 0)
	L5_25 = L5_25 * (math.sin(A3_23.x * A0_20._time) + math.sin(A4_24.x * A0_20._time))
	L5_25 = L5_25 + A2_22.y * Vector3(0, 1, 0) * (math.sin(A3_23.y * A0_20._time) + math.sin(A4_24.y * A0_20._time))
	L5_25 = L5_25 + A2_22.z * Vector3(0, 0, 1) * (math.sin(A3_23.z * A0_20._time) + math.sin(A4_24.z * A0_20._time))
	return L5_25
end
