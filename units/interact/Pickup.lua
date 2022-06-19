if not Pickup then
	Pickup = class(Interactable)
end
Pickup.init = function(l_1_0, l_1_1)
	Interactable.init(l_1_0, l_1_1)
	assert(l_1_0._pickup_type)
end

Pickup.can_interact_with_player = function(l_2_0, l_2_1)
	if not Interactable.can_interact_with_player(l_2_0, l_2_1) then
		return false
	end
	if l_2_0._pickup_type == "weapon" then
		if l_2_0._unit:base() then
			local l_2_2 = not l_2_0._unit:base():user_unit()
			l_2_2 = l_2_2
			return l_2_2
		end
	else
		l_2_2 = true
		return l_2_2
	end
end

Pickup.interact = function(l_3_0, l_3_1)
	local l_3_2 = managers.ownership:owner_rpc(l_3_0._unit)
	l_3_2:arbitrate_pick_up(managers.unit_control_id:get_unit_id(l_3_0._unit), managers.unit_control_id:get_unit_id(l_3_1))
end

Pickup.arbitrate_interact = function(l_4_0, l_4_1)
	assert(l_4_0:is_owner())
	local l_4_2 = managers.ownership:interested_rpc(l_4_0._unit)
	l_4_2:pick_up(managers.unit_control_id:get_unit_id(l_4_1), managers.unit_control_id:get_unit_id(l_4_0._unit))
end

Pickup.interactable_type = function(l_5_0)
	local l_5_1, l_5_2 = l_5_0:pickup_type, l_5_0
	return l_5_1(l_5_2)
end

Pickup.pickup_type = function(l_6_0)
	return l_6_0._pickup_type
end

Pickup.pickup_id = function(l_7_0)
	return l_7_0._pickup_id
end


