require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderEnteringAttackState")
if not SpiderPreAttackState then
	SpiderPreAttackState = class(SpiderState)
end
SpiderPreAttackState.init = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
	l_1_0._enemy_data = l_1_0._unit:enemy_data()
end

SpiderPreAttackState.enter = function(l_2_0)
	l_2_0._unit:base():preparing_attack()
	l_2_0:_set_can_move(false)
	l_2_0:_set_can_rotate(false)
	l_2_0._t = 0
	l_2_0._unit:play_redirect("stand_still")
end

SpiderPreAttackState.leave = function(l_3_0)
	SpiderState.leave(l_3_0)
	l_3_0._unit:play_redirect("stand_still")
end

SpiderPreAttackState.update = function(l_4_0, l_4_1)
	local l_4_7, l_4_8, l_4_9, l_4_10, l_4_11, l_4_12 = nil
	local l_4_2 = l_4_0._base:check_fully_damaged()
	if l_4_2 then
		return l_4_2
	end
	if l_4_0._enemy_data.is_stunned then
		local l_4_3, l_4_4 = SpiderStunState:new, SpiderStunState
		local l_4_5 = l_4_0._unit
		local l_4_6 = "attack"
		return l_4_3(l_4_4, l_4_5, l_4_6)
	else
		local l_4_13 = l_4_0._unit:input():aim_target_position()
	if l_4_13 then
		end
		local l_4_14 = l_4_0._unit:position()
		local l_4_15 = l_4_0._unit:rotation()
		local l_4_16, l_4_32 = math.dot(l_4_15:y(), l_4_13 - l_4_14:normalized())
		l_4_32 = math
		l_4_32 = l_4_32.acos
		l_4_32 = l_4_32(l_4_16)
		local l_4_17, l_4_33 = nil
		l_4_17 = l_4_32 > 15
		if l_4_17 then
			l_4_33 = math
			l_4_33 = l_4_33.dot
			l_4_33 = l_4_33(l_4_15:x(), l_4_13 - l_4_14:normalized())
			l_4_33 = l_4_33 < 0
		if l_4_33 and not l_4_0._unit:enemy_data().rotating_left then
			end
			l_4_0._unit:play_redirect("rotate_left")
		end
		do return end
		if not l_4_0._unit:enemy_data().rotating_right then
			local l_4_38 = l_4_0._unit:play_redirect
			l_4_38(l_4_0._unit, "rotate_right")
		end
	else
		l_4_33 = l_4_0._unit
		local l_4_35, l_4_36 = l_4_33
		l_4_36 = "stand_still"
		local l_4_37 = nil
		l_4_33(l_4_35, l_4_36)
	end
	l_4_0._t = l_4_0._t + l_4_1
	if l_4_0._enemy_data.stun_requested then
		l_4_0:_request_stun()
	else
		if tweak_data.enemy.spider.PRE_ATTACK_DELAY <= l_4_0._t then
			local l_4_29, l_4_30 = SpiderEnteringAttackState:new, SpiderEnteringAttackState
			local l_4_31 = l_4_0._unit
			return l_4_29(l_4_30, l_4_31)
		end
	end
end


