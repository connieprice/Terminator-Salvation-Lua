require("units/weapons/WeaponUtilities")
require("units/weapons/GenericWeapon")
M79Grenadelauncher = M79Grenadelauncher or class(GenericWeapon)
function M79Grenadelauncher.init(A0_0, A1_1)
	GenericWeapon.init(A0_0, A1_1)
	assert(A0_0._reload_unit)
	A0_0._reload = World:spawn_unit(A0_0._reload_unit, A1_1:position(), A1_1:rotation())
	A0_0:reload_attach()
end
function M79Grenadelauncher.destroy(A0_2)
	GenericWeapon.destroy(A0_2)
	if alive(A0_2._reload) then
		A0_2._reload:set_slot(0)
	end
	A0_2._reload = nil
end
function M79Grenadelauncher.setup(A0_3, A1_4)
	GenericWeapon.setup(A0_3, A1_4)
end
function M79Grenadelauncher.fire(A0_5, A1_6)
	A0_5._reload:set_visible(false)
	GenericWeapon.fire(A0_5, A1_6)
end
function M79Grenadelauncher.reload_release(A0_7)
	assert(A0_7._user_unit)
	A0_7._user_unit:link("a_weapon_left_front", A0_7._reload, A0_7._reload:orientation_object():name())
	A0_7._reload:set_visible(true)
end
function M79Grenadelauncher.reload_attach(A0_8)
	A0_8._unit:link(A0_8._reload_attachment, A0_8._reload, A0_8._reload:orientation_object():name())
	A0_8._reload:set_local_rotation(Rotation(0, 0, 0))
	A0_8._reload:set_visible(true)
end
