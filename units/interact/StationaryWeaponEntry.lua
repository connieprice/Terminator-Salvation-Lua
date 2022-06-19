require("units/interact/Interactable")
StationaryWeaponEntry = StationaryWeaponEntry or class(Interactable)
function StationaryWeaponEntry.init(A0_0, A1_1)
	Interactable.init(A0_0, A1_1)
end
function StationaryWeaponEntry.can_interact_with_player(A0_2, A1_3)
	if not Interactable.can_interact_with_player(A0_2, A1_3) then
		return false
	end
	return not A0_2._unit:base() or not A0_2._unit:base():user_unit()
end
function StationaryWeaponEntry.arbitrate_interact(A0_4, A1_5)
end
function StationaryWeaponEntry.interact(A0_6, A1_7)
	assert(A1_7:player_data())
	A1_7:player_data()._mounted_weapon = A0_6._unit
end
function StationaryWeaponEntry.interactable_type(A0_8)
	local L1_9
	L1_9 = A0_8._entry_type
	return L1_9
end
