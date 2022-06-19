require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderEndingAttackState")
if not SpiderAttackingState then
	SpiderAttackingState = class(SpiderState)
end
SpiderAttackingState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
	l_1_0._input = l_1_0._unit:input()
end

SpiderAttackingState.enter = function(l_2_0)
	l_2_0._t = 0
	l_2_0._enemy_data.is_firing = true
	l_2_0._bullets_shot = 0
	l_2_0._aim_target_position = nil
	if alive(l_2_0._base._left_weapon) then
		l_2_0._left_weapon_data = l_2_0._base._left_weapon:weapon_data()
	end
	if alive(l_2_0._base._right_weapon) then
		l_2_0._right_weapon_data = l_2_0._base._right_weapon:weapon_data()
	end
end

SpiderAttackingState.leave = function(l_3_0)
	SpiderState.leave(l_3_0)
	l_3_0._enemy_data.is_firing = false
	if alive(l_3_0._base._left_weapon) then
		l_3_0._left_weapon_data.fire_input = 0
	end
	if alive(l_3_0._base._right_weapon) then
		l_3_0._right_weapon_data.fire_input = 0
	end
end

SpiderAttackingState.update = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	local l_4_3 = l_4_0._input
	if l_4_3:fire() then
		local l_4_4 = iff(l_4_0._enemy_data.can_fire, 1, 0)
		local l_4_5 = false
		if alive(l_4_0._base._left_weapon) then
			local l_4_6 = l_4_0._left_weapon_data
			l_4_6.fire_input = l_4_4
		if l_4_6._firing then
			end
			l_4_5 = true
		end
		if alive(l_4_0._base._right_weapon) then
			local l_4_7 = l_4_0._right_weapon_data
			l_4_7.fire_input = l_4_4
		if l_4_7._firing then
			end
			l_4_5 = true
		end
		if l_4_3:fire() then
			l_4_5 = true
		end
		if l_4_0._enemy_data.is_stunned then
			local l_4_8, l_4_9 = SpiderStunState:new, SpiderStunState
			local l_4_10 = l_4_0._unit
			local l_4_11, l_4_15 = "attack"
			return l_4_8(l_4_9, l_4_10, l_4_11)
		else
			if l_4_0._enemy_data.charging then
				local l_4_12, l_4_13 = SpiderChargeState:new, SpiderChargeState
				local l_4_14 = l_4_0._unit
				return l_4_12(l_4_13, l_4_14)
			end
		else
			if l_4_0._enemy_data.preparing_charge then
				local l_4_16, l_4_17 = SpiderRotateToChargeState:new, SpiderRotateToChargeState
				local l_4_18 = l_4_0._unit
				local l_4_19, l_4_23 = l_4_0._charge_direction
				return l_4_16(l_4_17, l_4_18, l_4_19)
			end
		else
			if l_4_0._enemy_data.ending_attack then
				local l_4_20, l_4_21 = SpiderEndingAttackState:new, SpiderEndingAttackState
				local l_4_22 = l_4_0._unit
				return l_4_20(l_4_21, l_4_22)
			end
		end
		local l_4_24 = l_4_3:aim_target_position()
		if l_4_24 then
			l_4_0._aim_target_position = l_4_24
		end
		if l_4_0._enemy_data.stun_requested then
			l_4_0:_request_stun()
		else
			if not l_4_3:fire() and not l_4_3:attack_mode() and not l_4_5 then
				l_4_0._unit:play_redirect("end_attack")
			end
		else
			if l_4_3:charge_direction() then
				l_4_0._unit:play_redirect("rotate_to_charge")
				l_4_0._charge_direction = l_4_3:charge_direction()
			end
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 15 
end

SpiderAttackingState._update_rotation = function(l_5_0, l_5_1)
	if l_5_1 then
		local l_5_2 = l_5_0._unit:position()
		local l_5_3 = l_5_0._unit:rotation()
		mvector3.negate(l_5_2)
		mvector3.add(l_5_2, l_5_1)
		mvector3.normalize(l_5_2)
		local l_5_4 = l_5_3:y()
		local l_5_5 = mvector3.dot(l_5_4, l_5_2)
		local l_5_6 = math.acos(l_5_5)
	if tweak_data.enemy.spider.MAX_CHEST_ROTATION < l_5_6 then
		end
		local l_5_10 = nil
	if mvector3.dot(l_5_3:x(), l_5_2) < 0 and not l_5_0._enemy_data.rotating_left then
		end
		l_5_0._unit:play_redirect("rotate_left")
	end
	do return end
	if not l_5_0._enemy_data.rotating_right then
		l_5_0._unit:play_redirect("rotate_right")
	end
end


