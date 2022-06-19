AmmoBox = AmmoBox or class(Interactable)
function AmmoBox.init(A0_0, A1_1)
	Interactable.init(A0_0, A1_1)
	A0_0._type = "ammo_box"
end
function AmmoBox.weapon_name(A0_2)
	local L1_3
	L1_3 = A0_2._weapon_name
	return L1_3
end
function AmmoBox.can_interact_with_player(A0_4, A1_5)
	if not A1_5:base():inventory() or not A1_5:base():inventory():item(A0_4._weapon_name) then
		return false
	end
	return A0_4.super.can_interact_with_player(A0_4, A1_5)
end
function AmmoBox.interactable_type(A0_6)
	local L1_7
	L1_7 = A0_6._type
	return L1_7
end
function AmmoBox.interact(A0_8, A1_9)
	A1_9:base():pick_up_ammo(A0_8._weapon_name)
end
