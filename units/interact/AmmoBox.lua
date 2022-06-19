if not AmmoBox then
	AmmoBox = class(Interactable)
end
AmmoBox.init = function(l_1_0, l_1_1)
	Interactable.init(l_1_0, l_1_1)
	l_1_0._type = "ammo_box"
end

AmmoBox.weapon_name = function(l_2_0)
	return l_2_0._weapon_name
end

AmmoBox.can_interact_with_player = function(l_3_0, l_3_1)
	if not l_3_1:base():inventory() or not l_3_1:base():inventory():item(l_3_0._weapon_name) then
		return false
	end
	local l_3_2 = l_3_0.super.can_interact_with_player
	local l_3_3 = l_3_0
	local l_3_4 = l_3_1
	return l_3_2(l_3_3, l_3_4)
end

AmmoBox.interactable_type = function(l_4_0)
	return l_4_0._type
end

AmmoBox.interact = function(l_5_0, l_5_1)
	local l_5_2 = l_5_1:base()
	l_5_2:pick_up_ammo(l_5_0._weapon_name)
end


