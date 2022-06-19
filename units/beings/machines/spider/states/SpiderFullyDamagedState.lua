require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderDeadState")
SpiderFullyDamagedState = SpiderFullyDamagedState or class(SpiderState)
SpiderFullyDamagedState._DEFAULT_DEATH_REASON = "bullet"
SpiderFullyDamagedState._DEATH_ANIMS = {
	bullet = "die",
	explosion = "die_explosion",
	battery = "die_explosion"
}
function SpiderFullyDamagedState.init(A0_0, A1_1)
	SpiderState.init(A0_0, A1_1)
end
function SpiderFullyDamagedState.enter(A0_2)
	local L1_3, L2_4
	L1_3 = A0_2._unit
	L2_4 = L1_3
	L1_3 = L1_3.damage_data
	L1_3 = L1_3(L2_4)
	L1_3 = L1_3.death_reason
	if L1_3 == nil or L1_3 == "" then
		L2_4 = SpiderFullyDamagedState
		L1_3 = L2_4._DEFAULT_DEATH_REASON
	end
	L2_4 = A0_2._emitter
	L2_4 = L2_4.unit_fully_damaged
	L2_4(L2_4, A0_2._unit, L1_3)
	L2_4 = SpiderFullyDamagedState
	L2_4 = L2_4._DEATH_ANIMS
	L2_4 = L2_4[L1_3]
	L2_4 = L2_4 or SpiderFullyDamagedState._DEATH_ANIMS[SpiderFullyDamagedState._DEFAULT_DEATH_REASON]
	assert(A0_2._unit:play_redirect(L2_4) and A0_2._unit:play_redirect(L2_4) ~= "", L2_4)
	managers.unit_scripting:unit_dead(A0_2._unit)
end
function SpiderFullyDamagedState.update(A0_5, A1_6)
	if A0_5._unit:enemy_data().death_animation_done then
		return SpiderDeadState:new(A0_5._unit)
	end
end
