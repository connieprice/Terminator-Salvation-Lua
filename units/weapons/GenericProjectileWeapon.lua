require("shared/VectorUtilities")
if not GenericProjectileWeapon then
	GenericProjectileWeapon = class(BaseWeapon)
end
GenericProjectileWeapon.init = function(l_1_0, l_1_1)
	BaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._last_fire_input = 0
	l_1_0._obj_fire = l_1_0._unit:orientation_object()
	l_1_0._wdata = l_1_0._unit:weapon_data()
	l_1_0._wdata._fire_enabled = true
	l_1_0._disabled_projectile_spawners = {}
	l_1_0._event_emitter = managers.action_event:create_emitter(l_1_1)
end

GenericProjectileWeapon.setup = function(l_2_0, l_2_1, l_2_2)
	BaseWeapon.setup(l_2_0, l_2_1)
	assert(l_2_1)
	local l_2_3 = assert
	l_2_3(#l_2_2 > 0)
	local l_2_8 = l_2_1
	local l_2_9 = l_2_1:orientation_object():name()
	l_2_3(l_2_8, l_2_9, l_2_0._unit, l_2_0._unit:orientation_object():name())
	l_2_0._projectile_spawners, l_2_3 = l_2_3, {}
	l_2_3 = pairs
	l_2_8 = l_2_2
	l_2_3 = l_2_3(l_2_8)
	for i_0,i_1 in l_2_3 do
		local l_2_10 = World:spawn_unit(l_2_0._projectile_spawner_class, l_2_0._unit:position(), l_2_0._unit:rotation())
		l_2_1:link(l_2_7, l_2_10, l_2_10:orientation_object():name())
		table.insert(l_2_0._projectile_spawners, l_2_10)
	end
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

GenericProjectileWeapon.destroy = function(l_3_0)
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

GenericProjectileWeapon.fire_start = function(l_4_0, l_4_1)
	l_4_0._projectile_spawner_index = 1
	l_4_0._event_emitter:unit_weapon_fire_start(l_4_0._unit)
end

GenericProjectileWeapon.fire_end = function(l_5_0, l_5_1)
	l_5_0._event_emitter:unit_weapon_fire_stop(l_5_0._unit)
end

GenericProjectileWeapon.fire = function(l_6_0, l_6_1)
	local l_6_2 = l_6_0._disabled_projectile_spawners[l_6_0._projectile_spawner_index]
	if not l_6_2 then
		local l_6_3 = l_6_0._projectile_spawners[l_6_0._projectile_spawner_index]
		l_6_0._event_emitter:unit_weapon_fire_change(l_6_0._unit, l_6_3:position(), l_6_3:rotation(), l_6_3)
		local l_6_4 = l_6_3:position()
		local l_6_5 = l_6_0._wdata.aim_target_position
		local l_6_6 = l_6_5 - l_6_4:normalized()
		l_6_6 = VectorUtilities.angle_constraint_direction(l_6_6, l_6_0._obj_fire:rotation():y(), l_6_0._max_fire_object_and_aim_angle_diff)
		local l_6_7 = WeaponUtilities.dispersion(l_6_6, l_6_0._wdata.miss_dispersion, l_6_0._wdata._dispersion)
		local l_6_8 = l_6_3:base():spawn_projectile(l_6_0._user_unit, l_6_4, Rotation(l_6_7, math.UP))
		if l_6_0._explosion_damage_at_center then
			l_6_8:base():set_explosion_damage_at_center(l_6_0._explosion_damage_at_center)
		end
		if l_6_0._explosion_radius then
			l_6_8:base():set_explosion_radius(l_6_0._explosion_radius)
		end
		if l_6_0._speed then
			l_6_8:base():set_speed(l_6_0._speed)
		end
	if l_6_0._initial_speed then
		end
		l_6_8:base():set_initial_speed(l_6_0._initial_speed)
	end
	l_6_0._projectile_spawner_index = l_6_0._projectile_spawner_index + 1
	if #l_6_0._projectile_spawners < l_6_0._projectile_spawner_index then
		l_6_0._projectile_spawner_index = 1
	end
end

GenericProjectileWeapon.set_explosion_damage_at_center = function(l_7_0, l_7_1)
	l_7_0._explosion_damage_at_center = l_7_1
end

GenericProjectileWeapon.set_explosion_radius = function(l_8_0, l_8_1)
	l_8_0._explosion_radius = l_8_1
end

GenericProjectileWeapon.set_velocity = function(l_9_0, l_9_1)
	l_9_0._velocity = l_9_1
end

GenericProjectileWeapon.disable_projectile_spawner = function(l_10_0, l_10_1)
	l_10_0._disabled_projectile_spawners[l_10_1] = true
end


