require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderEnteringAttackState")
SpiderPreAttackState = SpiderPreAttackState or class(SpiderState)
function SpiderPreAttackState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
end
function SpiderPreAttackState.enter(A0_2)
	A0_2._unit:base():preparing_attack()
	A0_2:_set_can_move(false)
	A0_2:_set_can_rotate(false)
	A0_2._t = 0
	A0_2._unit:play_redirect("stand_still")
end
function SpiderPreAttackState.leave(A0_3)
	SpiderState.leave(A0_3)
	A0_3._unit:play_redirect("stand_still")
end
function SpiderPreAttackState.update(A0_4, A1_5)
	local L2_6, L3_7, L4_8, L5_9, L6_10
	L2_6 = A0_4._base
	L3_7 = L2_6
	L2_6 = L2_6.check_fully_damaged
	L2_6 = L2_6(L3_7)
	if L2_6 then
		return L2_6
	end
	L3_7 = A0_4._enemy_data
	L3_7 = L3_7.is_stunned
	if L3_7 then
		L3_7 = SpiderStunState
		L4_8 = L3_7
		L3_7 = L3_7.new
		L5_9 = A0_4._unit
		L6_10 = "attack"
		return L3_7(L4_8, L5_9, L6_10)
	else
		L3_7 = A0_4._unit
		L4_8 = L3_7
		L3_7 = L3_7.input
		L3_7 = L3_7(L4_8)
		L4_8 = L3_7
		L3_7 = L3_7.aim_target_position
		L3_7 = L3_7(L4_8)
		if L3_7 then
			L4_8 = A0_4._unit
			L5_9 = L4_8
			L4_8 = L4_8.position
			L4_8 = L4_8(L5_9)
			L5_9 = A0_4._unit
			L6_10 = L5_9
			L5_9 = L5_9.rotation
			L5_9 = L5_9(L6_10)
			L6_10 = math
			L6_10 = L6_10.dot
			L6_10 = L6_10(L5_9:y(), (L3_7 - L4_8):normalized())
			if math.acos(L6_10) > 15 then
				if math.dot(L5_9:x(), (L3_7 - L4_8):normalized()) < 0 then
					if not A0_4._unit:enemy_data().rotating_left then
						A0_4._unit:play_redirect("rotate_left")
					end
				elseif not A0_4._unit:enemy_data().rotating_right then
					A0_4._unit:play_redirect("rotate_right")
				end
			else
				A0_4._unit:play_redirect("stand_still")
			end
		end
	end
	L3_7 = A0_4._t
	L3_7 = L3_7 + A1_5
	A0_4._t = L3_7
	L3_7 = A0_4._enemy_data
	L3_7 = L3_7.stun_requested
	if L3_7 then
		L4_8 = A0_4
		L3_7 = A0_4._request_stun
		L3_7(L4_8)
	else
		L3_7 = A0_4._t
		L4_8 = tweak_data
		L4_8 = L4_8.enemy
		L4_8 = L4_8.spider
		L4_8 = L4_8.PRE_ATTACK_DELAY
		if L3_7 >= L4_8 then
			L3_7 = SpiderEnteringAttackState
			L4_8 = L3_7
			L3_7 = L3_7.new
			L5_9 = A0_4._unit
			return L3_7(L4_8, L5_9)
		end
	end
end
