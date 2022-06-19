require("units/interact/InteractQuery")
PlayerControlInteractQuery = PlayerControlInteractQuery or class(InteractQuery)
function PlayerControlInteractQuery.init(A0_0, A1_1)
	A0_0._unit = A1_1
end
function PlayerControlInteractQuery.can_interact_with(A0_2, A1_3)
	assert(A0_2._interactables)
	return A0_2._interactables[A0_2._unit:control():is_human_controlled() and "human" or "ai"][A1_3]
end
