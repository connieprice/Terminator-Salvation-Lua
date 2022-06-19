require("units/weapons/WeaponUtilities")
require("shared/VectorUtilities")
if not GrenadeThrower then
	GrenadeThrower = class(PlayerBaseWeapon)
end
GrenadeThrower.init = function(l_1_0, l_1_1)
	PlayerBaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0:set_enabled(false)
	l_1_0._last_fire_input = 0
	l_1_0._obj_fire = l_1_0._unit:orientation_object()
	l_1_0._wdata = l_1_0._unit:weapon_data()
	l_1_0._wdata._fire_enabled = true
	l_1_0._projectile_spawner = World:spawn_unit(l_1_0._projectile_spawner_class, l_1_0._unit:position(), l_1_0._unit:rotation())
	l_1_0._unit:link(l_1_0._obj_fire:name(), l_1_0._projectile_spawner, l_1_0._projectile_spawner:orientation_object():name())
end

GrenadeThrower.destroy = function(l_2_0)
	l_2_0._unit = nil
	if alive(l_2_0._projectile_spawner) then
		l_2_0._projectile_spawner:set_slot(0)
	end
	l_2_0._projectile_spawner = nil
end

GrenadeThrower.setup = function(l_3_0, l_3_1)
	PlayerBaseWeapon.setup(l_3_0, l_3_1)
end

GrenadeThrower.enable = function(l_4_0)
	l_4_0:set_enabled(true)
end

GrenadeThrower.disable = function(l_5_0)
	l_5_0:set_enabled(false)
end

GrenadeThrower._check_for_obstacles = function(l_6_0, l_6_1, l_6_2)
	local l_6_3 = l_6_2 - l_6_1:normalized()
	local l_6_4 = l_6_0._unit:raycast("ray", l_6_1 - l_6_3 * 50, l_6_1 + l_6_3 * tweak_data.player.weapon.grenade.SPAWN_OFFSET, "slot_mask", managers.slot:get_mask("statics"), managers.slot:get_mask("dynamics"))
	local l_6_5 = {}
	l_6_5.target_dir = l_6_3
	if l_6_4 then
		l_6_5.source_pos = l_6_4.position - l_6_3 * 30
	else
		l_6_5.source_pos = l_6_1 + l_6_5.target_dir * tweak_data.player.weapon.grenade.SPAWN_OFFSET
	end
	return l_6_5
end

GrenadeThrower.fire = function(l_7_0, l_7_1)
	local l_7_2 = l_7_0._obj_fire:position()
	local l_7_3 = l_7_0._wdata.aim_target_position
	local l_7_4 = l_7_0:_check_for_obstacles(l_7_2, l_7_3)
	l_7_0._projectile_spawner:base():spawn_projectile(l_7_0._user_unit, l_7_4.source_pos, Rotation(l_7_4.target_dir, l_7_0._obj_fire:rotation():z()))
end


