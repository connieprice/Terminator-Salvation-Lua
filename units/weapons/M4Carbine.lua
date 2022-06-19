require("units/weapons/WeaponUtilities")
require("units/weapons/GenericWeapon")
M4Carbine = M4Carbine or class(GenericWeapon)
function M4Carbine.init(A0_0, A1_1)
	GenericWeapon.init(A0_0, A1_1)
	assert(A0_0._reload_unit)
	A0_0._reload = World:spawn_unit(A0_0._reload_unit, A1_1:position(), A1_1:rotation())
	A0_0:reload_attach()
end
function M4Carbine.destroy(A0_2)
	GenericWeapon.destroy(A0_2)
	if alive(A0_2._reload) then
		A0_2._reload:set_slot(0)
	end
	A0_2._reload = nil
end
function M4Carbine.setup(A0_3, A1_4)
	GenericWeapon.setup(A0_3, A1_4)
end
function M4Carbine.reload_release(A0_5)
	assert(A0_5._user_unit)
	A0_5._user_unit:link("a_weapon_left_front", A0_5._reload, A0_5._reload:orientation_object():name())
end
function M4Carbine.reload_attach(A0_6)
	local L2_7, L3_8, L4_9
	L2_7 = A0_6._unit
	L3_8 = L2_7
	L2_7 = L2_7.link
	L4_9 = A0_6._reload_attachment
	L2_7(L3_8, L4_9, A0_6._reload, A0_6._reload:orientation_object():name())
end
