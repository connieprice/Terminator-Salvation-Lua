require("units/interact/Interactable")
if not StationaryWeaponEntry then
	StationaryWeaponEntry = class(Interactable)
end
StationaryWeaponEntry.init = function(l_1_0, l_1_1)
	Interactable.init(l_1_0, l_1_1)
end

StationaryWeaponEntry.can_interact_with_player = function(l_2_0, l_2_1)
	if not Interactable.can_interact_with_player(l_2_0, l_2_1) then
		return false
	end
	if l_2_0._unit:base() then
		local l_2_2 = not l_2_0._unit:base():user_unit()
		l_2_2 = l_2_2
		return l_2_2
	end
end

StationaryWeaponEntry.arbitrate_interact = function(l_3_0, l_3_1)
end

StationaryWeaponEntry.interact = function(l_4_0, l_4_1)
	assert(l_4_1:player_data())
	l_4_1:player_data()._mounted_weapon = l_4_0._unit
end

StationaryWeaponEntry.interactable_type = function(l_5_0)
	return l_5_0._entry_type
end


