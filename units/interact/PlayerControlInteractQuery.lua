require("units/interact/InteractQuery")
if not PlayerControlInteractQuery then
	PlayerControlInteractQuery = class(InteractQuery)
end
PlayerControlInteractQuery.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
end

PlayerControlInteractQuery.can_interact_with = function(l_2_0, l_2_1)
	do
		local l_2_2, l_2_3 = l_2_0._unit:control():is_human_controlled() and "human" or "ai"
	end
	assert(l_2_0._interactables)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	return l_2_0._interactables[l_2_2][l_2_1]
end


