Pickup = Pickup or class(Interactable)
function Pickup.init(A0_0, A1_1)
	Interactable.init(A0_0, A1_1)
	assert(A0_0._pickup_type)
end
function Pickup.can_interact_with_player(A0_2, A1_3)
	if not Interactable.can_interact_with_player(A0_2, A1_3) then
		return false
	end
	if A0_2._pickup_type == "weapon" then
		return not A0_2._unit:base() or not A0_2._unit:base():user_unit()
	else
		return true
	end
end
function Pickup.interact(A0_4, A1_5)
	managers.ownership:owner_rpc(A0_4._unit):arbitrate_pick_up(managers.unit_control_id:get_unit_id(A0_4._unit), managers.unit_control_id:get_unit_id(A1_5))
end
function Pickup.arbitrate_interact(A0_6, A1_7)
	assert(A0_6:is_owner())
	managers.ownership:interested_rpc(A0_6._unit):pick_up(managers.unit_control_id:get_unit_id(A1_7), managers.unit_control_id:get_unit_id(A0_6._unit))
end
function Pickup.interactable_type(A0_8)
	return A0_8:pickup_type()
end
function Pickup.pickup_type(A0_9)
	local L1_10
	L1_10 = A0_9._pickup_type
	return L1_10
end
function Pickup.pickup_id(A0_11)
	local L1_12
	L1_12 = A0_11._pickup_id
	return L1_12
end
