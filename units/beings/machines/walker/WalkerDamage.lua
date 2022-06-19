require("units/UnitDamage")
require("units/damage/StunDamage")
require("units/damage/StunBodySetup")
require("units/beings/machines/walker/WalkerTweakData")
local l_0_0 = function(l_1_0, l_1_1)
	local l_1_2 = l_1_0:rotation():y()
	return math.dot(l_1_2, l_1_1) < 0
end

local l_0_2 = function(l_2_0, l_2_1)
	-- upvalues: l_0_0
	return not l_0_0(l_2_0, l_2_1)
end

local l_0_4 = {FRONT = 0, BACK = 1, LEFT = 2, RIGHT = 3}
local l_0_5 = function(l_3_0, l_3_1)
	-- upvalues: l_0_2
	local l_3_2 = l_3_0:y()
	local l_3_3 = l_3_0:x()
	local l_3_4 = l_3_2 + l_3_3
	local l_3_5 = l_3_3 - l_3_2
	if mvector3.dot(l_3_4, l_3_1) < 0 then
		if mvector3.dot(l_3_5, l_3_1) < 0 then
			return l_0_2.RIGHT
		else
			return l_0_2.FRONT
		end
	 -- DECOMPILER ERROR: Confused about usage of registers!

	elseif mvector3.dot(l_3_5, l_3_1) < 0 then
		return l_0_2.BACK
	else
		return l_0_2.LEFT
	end
end

local l_0_6 = {[l_0_4.FRONT] = "hurt_head_front", [l_0_4.BACK] = "hurt_head_back", [l_0_4.LEFT] = "hurt_head_left", [l_0_4.RIGHT] = "hurt_head_right"}
local l_0_7 = {[l_0_4.FRONT] = "hurt_left_shoulder_front", [l_0_4.BACK] = "hurt_left_shoulder_back", [l_0_4.LEFT] = "hurt_chest_left", [l_0_4.RIGHT] = "hurt_chest_right"}
local l_0_8 = {[l_0_4.FRONT] = "hurt_right_shoulder_front", [l_0_4.BACK] = "hurt_right_shoulder_back", [l_0_4.LEFT] = "hurt_chest_left", [l_0_4.RIGHT] = "hurt_chest_right"}
local l_0_11 = {[l_0_4.FRONT] = "hurt_chest", [l_0_4.BACK] = "hurt_back", [l_0_4.LEFT] = "hurt_chest_left", [l_0_4.RIGHT] = "hurt_chest_right"}
local l_0_12 = {[l_0_4.FRONT] = "hurt_explosion_front", [l_0_4.BACK] = "hurt_explosion_back", [l_0_4.LEFT] = "hurt_explosion_left", [l_0_4.RIGHT] = "hurt_explosion_right"}
do
	local l_0_13 = function(l_4_0, l_4_1, l_4_2)
	-- upvalues: l_0_3
	local l_4_3 = l_4_0:rotation()
	local l_4_4 = l_0_3(l_4_3, l_4_1)
	local l_4_5 = l_4_2[l_4_4]
	assert(l_4_5)
	return l_4_5
end

end
 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

if not WalkerDamage then
	 -- WARNING: undefined locals caused missing assignments!
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 115 

