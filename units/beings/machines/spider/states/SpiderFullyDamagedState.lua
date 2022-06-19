require("units/beings/machines/spider/states/SpiderState")
require("units/beings/machines/spider/states/SpiderDeadState")
if not SpiderFullyDamagedState then
	SpiderFullyDamagedState = class(SpiderState)
end
SpiderFullyDamagedState._DEFAULT_DEATH_REASON = "bullet"
local l_0_0 = SpiderFullyDamagedState
local l_0_1 = {}
l_0_1.bullet = "die"
l_0_1.explosion = "die_explosion"
l_0_1.battery = "die_explosion"
l_0_0._DEATH_ANIMS = l_0_1
l_0_0 = SpiderFullyDamagedState
l_0_1 = function(l_1_0, l_1_1)
	SpiderState.init(l_1_0, l_1_1)
end

l_0_0.init = l_0_1
l_0_0 = SpiderFullyDamagedState
l_0_1 = function(l_2_0)
	local l_2_1 = l_2_0._unit:damage_data().death_reason
	if l_2_1 == nil or l_2_1 == "" then
		l_2_1 = SpiderFullyDamagedState._DEFAULT_DEATH_REASON
	end
	l_2_0._emitter:unit_fully_damaged(l_2_0._unit, l_2_1)
	if not SpiderFullyDamagedState._DEATH_ANIMS[l_2_1] then
		local l_2_2, l_2_3 = SpiderFullyDamagedState._DEATH_ANIMS[SpiderFullyDamagedState._DEFAULT_DEATH_REASON]
	end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	local l_2_4 = nil
	local l_2_5 = l_2_0._unit:play_redirect(l_2_2)
	do
		assert(not l_2_5 or l_2_5 ~= "", l_2_4)
		managers.unit_scripting:unit_dead(l_2_0._unit)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

l_0_0.enter = l_0_1
l_0_0 = SpiderFullyDamagedState
l_0_1 = function(l_3_0, l_3_1)
	if l_3_0._unit:enemy_data().death_animation_done then
		local l_3_2, l_3_3 = SpiderDeadState:new, SpiderDeadState
		local l_3_4 = l_3_0._unit
		return l_3_2(l_3_3, l_3_4)
	end
end

l_0_0.update = l_0_1

