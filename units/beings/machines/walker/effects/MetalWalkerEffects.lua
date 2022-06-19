require("units/beings/machines/walker/effects/WalkerEffects")
if not MetalWalkerEffects then
	MetalWalkerEffects = class(WalkerEffects)
end
local l_0_0 = "Head"
local l_0_1 = "Spine2"
local l_0_2 = {}
 -- DECOMPILER ERROR: Unhandled construct in list (SETLIST)

 -- DECOMPILER ERROR: Overwrote pending register.

local l_0_3 = "damage_head_state1"
 -- DECOMPILER ERROR: Overwrote pending register.

local l_0_4 = "damage_head_state2"
MetalWalkerEffects.init = function(l_1_0, l_1_1)
	-- upvalues: l_0_0 , l_0_1
	WalkerEffects.init(l_1_0, l_1_1)
	l_1_0._damage_data = l_1_1:damage_data()
	l_1_0._head_body = l_1_1:get_object(l_0_0)
	assert(l_1_0._head_body, l_0_0)
	l_1_0._chest_body = l_1_1:get_object(l_0_1)
	assert(l_1_0._chest_body, l_0_1)
end

MetalWalkerEffects.unit_explode = function(l_2_0, l_2_1, l_2_2, l_2_3)
	-- upvalues: l_0_2 , l_0_3 , l_0_4
	local l_2_4 = l_2_1:position() - l_2_2
	local l_2_5 = l_2_0._damage_data
	local l_2_6 = l_2_5.damage / l_2_5.health
	if (l_2_2 - l_2_0._head_body:position():length() < l_2_2 - l_2_0._chest_body:position():length() or l_2_6 <= 0.5) and not l_2_0._head_damaged then
		l_2_0._head_damaged = true
		local l_2_10 = nil
		local l_2_11 = nil
		assert(l_0_2[math.random(1, #l_0_2)])
		 -- DECOMPILER ERROR: Confused about usage of registers!

		l_2_0:_play_effect(l_0_2[math.random(1, #l_0_2)])
	end
	do return end
	if not l_2_0._chest_damaged then
		l_2_0._chest_damaged = true
		local l_2_13 = nil
		if mvector3.dot(l_2_4, l_2_1:rotation():y()) < 0 then
			l_2_0:_play_effect(l_0_3)
		end
	else
		l_2_0:_play_effect(l_0_4)
	end
end


