require("units/weapons/WeaponUtilities")
require("units/weapons/GenericWeapon")
if not M249Machinegun then
	M249Machinegun = class(GenericWeapon)
end
M249Machinegun.init = function(l_1_0, l_1_1)
	GenericWeapon.init(l_1_0, l_1_1)
	assert(l_1_0._reload_unit)
	l_1_0._reload = World:spawn_unit(l_1_0._reload_unit, l_1_1:position(), l_1_1:rotation())
	l_1_0:reload_attach()
end

M249Machinegun.destroy = function(l_2_0)
	GenericWeapon.destroy(l_2_0)
	if alive(l_2_0._reload) then
		l_2_0._reload:set_slot(0)
	end
	l_2_0._reload = nil
end

M249Machinegun.setup = function(l_3_0, l_3_1)
	GenericWeapon.setup(l_3_0, l_3_1)
end

M249Machinegun.fire = function(l_4_0, l_4_1)
	local l_4_2 = l_4_0._wdata._bullets_in_clip
	local l_4_3 = 0
	if l_4_2 > 12 then
		l_4_3 = math.random(0, 1) * 0.2
	else
		l_4_3 = math.max(0, 3 - l_4_0._wdata._bullets_in_clip * 0.2)
	end
	local l_4_4 = math.min(l_4_3 + 0.2, 3)
	l_4_0._reload:anim_set_time("fire", l_4_3)
	l_4_0._reload:anim_play_to("fire", l_4_4)
	GenericWeapon.fire(l_4_0, l_4_1)
end

M249Machinegun.reload_release = function(l_5_0)
	local l_5_1 = 3
	l_5_0._reload:anim_set_time("fire", l_5_1)
	local l_5_2 = 3
	l_5_0._reload:anim_play_to("fire", l_5_2)
	assert(l_5_0._user_unit)
	l_5_0._user_unit:link("a_weapon_left_back", l_5_0._reload, l_5_0._reload:orientation_object():name())
end

M249Machinegun.reload_attach = function(l_6_0)
	local l_6_1 = 0
	l_6_0._reload:anim_set_time("fire", l_6_1)
	local l_6_2 = 0
	l_6_0._reload:anim_play_to("fire", l_6_2)
	l_6_0._unit:link(l_6_0._reload_attachment, l_6_0._reload, l_6_0._reload:orientation_object():name())
	l_6_0._reload:set_visible(true)
end

M249Machinegun.reload_drop = function(l_7_0)
	l_7_0._reload:set_visible(false)
end

M249Machinegun.reload_grab = function(l_8_0)
	l_8_0._reload:set_visible(true)
end


