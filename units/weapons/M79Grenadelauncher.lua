require("units/weapons/WeaponUtilities")
require("units/weapons/GenericWeapon")
if not M79Grenadelauncher then
	M79Grenadelauncher = class(GenericWeapon)
end
M79Grenadelauncher.init = function(l_1_0, l_1_1)
	GenericWeapon.init(l_1_0, l_1_1)
	assert(l_1_0._reload_unit)
	l_1_0._reload = World:spawn_unit(l_1_0._reload_unit, l_1_1:position(), l_1_1:rotation())
	l_1_0:reload_attach()
end

M79Grenadelauncher.destroy = function(l_2_0)
	GenericWeapon.destroy(l_2_0)
	if alive(l_2_0._reload) then
		l_2_0._reload:set_slot(0)
	end
	l_2_0._reload = nil
end

M79Grenadelauncher.setup = function(l_3_0, l_3_1)
	GenericWeapon.setup(l_3_0, l_3_1)
end

M79Grenadelauncher.fire = function(l_4_0, l_4_1)
	l_4_0._reload:set_visible(false)
	GenericWeapon.fire(l_4_0, l_4_1)
end

M79Grenadelauncher.reload_release = function(l_5_0)
	assert(l_5_0._user_unit)
	l_5_0._user_unit:link("a_weapon_left_front", l_5_0._reload, l_5_0._reload:orientation_object():name())
	l_5_0._reload:set_visible(true)
end

M79Grenadelauncher.reload_attach = function(l_6_0)
	l_6_0._unit:link(l_6_0._reload_attachment, l_6_0._reload, l_6_0._reload:orientation_object():name())
	l_6_0._reload:set_local_rotation(Rotation(0, 0, 0))
	l_6_0._reload:set_visible(true)
end


