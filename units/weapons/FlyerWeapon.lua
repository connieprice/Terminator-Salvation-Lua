require("projectile/InstantBulletSpawner")
require("shared/VectorUtilities")
if not FlyerWeapon then
	FlyerWeapon = class(BaseWeapon)
end
FlyerWeapon.init = function(l_1_0, l_1_1)
	BaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._last_fire_input = 0
	l_1_0._obj_fire = l_1_0._unit:orientation_object()
	l_1_0._wdata = l_1_0._unit:weapon_data()
	l_1_0._wdata._fire_enabled = true
	l_1_0._event_emitter = managers.action_event:create_emitter(l_1_1)
end

FlyerWeapon.setup = function(l_2_0, l_2_1, l_2_2)
	BaseWeapon.setup(l_2_0, l_2_1)
	assert(l_2_1)
	local l_2_3 = assert
	do
		l_2_3(not l_2_2 or l_2_2 ~= "")
		l_2_3(l_2_1, l_2_2, l_2_0._unit, l_2_0._unit:orientation_object():name())
		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		 -- DECOMPILER ERROR: Overwrote pending register.

		l_2_1:link(l_2_2, l_2_3, l_2_3:orientation_object():name())
		l_2_0._projectile_spawner = l_2_3
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

FlyerWeapon.destroy = function(l_3_0)
	if l_3_0._wdata._firing then
		l_3_0._event_emitter:unit_weapon_fire_stop(l_3_0._unit)
	end
	l_3_0._event_emitter:destroy()
	l_3_0._unit = nil
	if alive(l_3_0._projectile_spawner) then
		l_3_0._projectile_spawner:set_slot(0)
	end
	l_3_0._projectile_spawner = nil
end

FlyerWeapon.fire_start = function(l_4_0, l_4_1)
	l_4_0._event_emitter:unit_weapon_fire_start(l_4_0._unit)
end

FlyerWeapon.fire_end = function(l_5_0, l_5_1)
	l_5_0._event_emitter:unit_weapon_fire_stop(l_5_0._unit)
end

FlyerWeapon.fire = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0._projectile_spawner
	l_6_0._event_emitter:unit_weapon_fire_change(l_6_0._unit, l_6_2:position(), l_6_2:rotation(), l_6_2)
	local l_6_3 = l_6_0._wdata
	local l_6_4 = l_6_2:position()
	local l_6_5 = l_6_3.aim_target_position
	local l_6_6 = l_6_5 - l_6_4:normalized()
	l_6_6 = VectorUtilities.angle_constraint_direction(l_6_6, l_6_0._obj_fire:rotation():y(), l_6_0._max_fire_object_and_aim_angle_diff)
	local l_6_7 = WeaponUtilities.dispersion(l_6_6, l_6_3.miss_dispersion, l_6_3._dispersion)
	l_6_2:base():spawn_projectile(l_6_0._user_unit, l_6_4, Rotation(l_6_7, math.UP))
end


