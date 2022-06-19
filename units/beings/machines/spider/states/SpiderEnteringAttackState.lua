require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderAttackingState")
SpiderEnteringAttackState = SpiderEnteringAttackState or class(SpiderState)
function SpiderEnteringAttackState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
	A0_0._enemy_data = A0_0._unit:enemy_data()
end
function SpiderEnteringAttackState.enter(A0_2)
	A0_2._unit:play_redirect("enter_attack")
	A0_2._enemy_data.preparing_to_fire = true
	A0_2:_set_can_move(false)
	A0_2:_set_can_rotate(false)
end
function SpiderEnteringAttackState.leave(A0_3)
	SpiderState.leave(A0_3)
	A0_3._enemy_data.preparing_to_fire = false
end
function SpiderEnteringAttackState.update(A0_4, A1_5)
	if A0_4._base:check_fully_damaged() then
		return (A0_4._base:check_fully_damaged())
	end
	if A0_4._enemy_data.is_stunned then
		return SpiderStunState:new(A0_4._unit, "attack")
	elseif A0_4._enemy_data.attacking then
		return SpiderAttackingState:new(A0_4._unit)
	end
	if A0_4._enemy_data.stun_requested then
		A0_4:_request_stun()
	end
end
