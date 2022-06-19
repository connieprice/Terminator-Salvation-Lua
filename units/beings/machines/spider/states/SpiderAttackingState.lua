require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderEndingAttackState")
SpiderAttackingState = SpiderAttackingState or class(SpiderState)
function SpiderAttackingState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
	A0_0._input = A0_0._unit:input()
end
function SpiderAttackingState.enter(A0_2)
	A0_2._t = 0
	A0_2._enemy_data.is_firing = true
	A0_2._bullets_shot = 0
	A0_2._aim_target_position = nil
	if alive(A0_2._base._left_weapon) then
		A0_2._left_weapon_data = A0_2._base._left_weapon:weapon_data()
	end
	if alive(A0_2._base._right_weapon) then
		A0_2._right_weapon_data = A0_2._base._right_weapon:weapon_data()
	end
end
function SpiderAttackingState.leave(A0_3)
	SpiderState.leave(A0_3)
	A0_3._enemy_data.is_firing = false
	if alive(A0_3._base._left_weapon) then
		A0_3._left_weapon_data.fire_input = 0
	end
	if alive(A0_3._base._right_weapon) then
		A0_3._right_weapon_data.fire_input = 0
	end
end
function SpiderAttackingState.update(A0_4, A1_5)
	if A0_4._base:check_fully_damaged() then
		return (A0_4._base:check_fully_damaged())
	end
	if alive(A0_4._base._left_weapon) then
		A0_4._left_weapon_data.fire_input = iff(A0_4._input:fire() and A0_4._enemy_data.can_fire, 1, 0)
		if A0_4._left_weapon_data._firing then
		end
	end
	if alive(A0_4._base._right_weapon) then
		A0_4._right_weapon_data.fire_input = iff(A0_4._input:fire() and A0_4._enemy_data.can_fire, 1, 0)
		if A0_4._right_weapon_data._firing then
		end
	end
	if A0_4._input:fire() then
	end
	if A0_4._enemy_data.is_stunned then
		return SpiderStunState:new(A0_4._unit, "attack")
	elseif A0_4._enemy_data.charging then
		return SpiderChargeState:new(A0_4._unit)
	elseif A0_4._enemy_data.preparing_charge then
		return SpiderRotateToChargeState:new(A0_4._unit, A0_4._charge_direction)
	elseif A0_4._enemy_data.ending_attack then
		return SpiderEndingAttackState:new(A0_4._unit)
	end
	if A0_4._input:aim_target_position() then
		A0_4._aim_target_position = A0_4._input:aim_target_position()
	end
	if A0_4._enemy_data.stun_requested then
		A0_4:_request_stun()
	elseif not A0_4._input:fire() and not A0_4._input:attack_mode() and not true then
		A0_4._unit:play_redirect("end_attack")
	elseif A0_4._input:charge_direction() then
		A0_4._unit:play_redirect("rotate_to_charge")
		A0_4._charge_direction = A0_4._input:charge_direction()
	end
end
function SpiderAttackingState._update_rotation(A0_6, A1_7)
	local L2_8, L3_9, L4_10, L5_11
	if A1_7 then
		L2_8 = A0_6._unit
		L3_9 = L2_8
		L2_8 = L2_8.position
		L2_8 = L2_8(L3_9)
		L3_9 = A0_6._unit
		L4_10 = L3_9
		L3_9 = L3_9.rotation
		L3_9 = L3_9(L4_10)
		L4_10 = mvector3
		L4_10 = L4_10.negate
		L5_11 = L2_8
		L4_10(L5_11)
		L4_10 = mvector3
		L4_10 = L4_10.add
		L5_11 = L2_8
		L4_10(L5_11, A1_7)
		L4_10 = mvector3
		L4_10 = L4_10.normalize
		L5_11 = L2_8
		L4_10(L5_11)
		L5_11 = L3_9
		L4_10 = L3_9.y
		L4_10 = L4_10(L5_11)
		L5_11 = mvector3
		L5_11 = L5_11.dot
		L5_11 = L5_11(L4_10, L2_8)
		if math.acos(L5_11) > tweak_data.enemy.spider.MAX_CHEST_ROTATION then
			if mvector3.dot(L3_9:x(), L2_8) < 0 then
				if not A0_6._enemy_data.rotating_left then
					A0_6._unit:play_redirect("rotate_left")
				end
			elseif not A0_6._enemy_data.rotating_right then
				A0_6._unit:play_redirect("rotate_right")
			end
		end
	end
end
