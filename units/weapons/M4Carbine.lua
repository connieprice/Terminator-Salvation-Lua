require("units/weapons/WeaponUtilities")
require("units/weapons/GenericWeapon")
if not M4Carbine then
	M4Carbine = class(GenericWeapon)
end
M4Carbine.init = function(l_1_0, l_1_1)
	GenericWeapon.init(l_1_0, l_1_1)
	assert(l_1_0._reload_unit)
	l_1_0._reload = World:spawn_unit(l_1_0._reload_unit, l_1_1:position(), l_1_1:rotation())
	l_1_0:reload_attach()
end

M4Carbine.destroy = function(l_2_0)
	GenericWeapon.destroy(l_2_0)
	if alive(l_2_0._reload) then
		l_2_0._reload:set_slot(0)
	end
	l_2_0._reload = nil
end

M4Carbine.setup = function(l_3_0, l_3_1)
	GenericWeapon.setup(l_3_0, l_3_1)
end

M4Carbine.reload_release = function(l_4_0)
	assert(l_4_0._user_unit)
	l_4_0._user_unit:link("a_weapon_left_front", l_4_0._reload, l_4_0._reload:orientation_object():name())
end

M4Carbine.reload_attach = function(l_5_0)
	l_5_0._unit:link(l_5_0._reload_attachment, l_5_0._reload, l_5_0._reload:orientation_object():name())
end


