if not PlayerPickupTarget then
	PlayerPickupTarget = class()
end
PlayerPickupTarget.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
end

PlayerPickupTarget.pick_up = function(l_2_0, l_2_1)
	assert(l_2_1)
	l_2_0._unit_to_pick_up = l_2_1
	l_2_0._unit_to_pick_up:disable_interact()
	l_2_0._only_pick_up_ammo = false
	local l_2_2 = l_2_0._unit_to_pick_up:interact():pickup_type()
	if l_2_2 == "weapon" and not l_2_1:base():user_unit() then
		local l_2_3 = l_2_0._unit:base():inventory():item(l_2_0._unit_to_pick_up:name())
		if l_2_3 then
			l_2_0._unit:base():pick_up_ammo_from_weapon(l_2_0._unit_to_pick_up)
		end
	else
		l_2_0._unit:base():pick_up_weapon(l_2_0._unit_to_pick_up)
	end
end

PlayerPickupTarget.unit_to_pick_up = function(l_3_0)
	assert(l_3_0._unit_to_pick_up)
	return l_3_0._unit_to_pick_up
end


