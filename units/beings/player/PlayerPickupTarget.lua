PlayerPickupTarget = PlayerPickupTarget or class()
function PlayerPickupTarget.init(A0_0, A1_1)
	A0_0._unit = A1_1
end
function PlayerPickupTarget.pick_up(A0_2, A1_3)
	assert(A1_3)
	A0_2._unit_to_pick_up = A1_3
	A0_2._unit_to_pick_up:disable_interact()
	A0_2._only_pick_up_ammo = false
	if A0_2._unit_to_pick_up:interact():pickup_type() == "weapon" and not A1_3:base():user_unit() then
		if A0_2._unit:base():inventory():item(A0_2._unit_to_pick_up:name()) then
			A0_2._unit:base():pick_up_ammo_from_weapon(A0_2._unit_to_pick_up)
		else
			A0_2._unit:base():pick_up_weapon(A0_2._unit_to_pick_up)
		end
	end
end
function PlayerPickupTarget.unit_to_pick_up(A0_4)
	assert(A0_4._unit_to_pick_up)
	return A0_4._unit_to_pick_up
end
