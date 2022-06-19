require("projectile/InstantBulletSpawner")
require("shared/VectorUtilities")
FlyerWeapon = FlyerWeapon or class(BaseWeapon)
function FlyerWeapon.init(A0_0, A1_1)
	BaseWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._last_fire_input = 0
	A0_0._obj_fire = A0_0._unit:orientation_object()
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._fire_enabled = true
	A0_0._event_emitter = managers.action_event:create_emitter(A1_1)
end
function FlyerWeapon.setup(A0_2, A1_3, A2_4)
	local L3_5
	L3_5 = BaseWeapon
	L3_5 = L3_5.setup
	L3_5(A0_2, A1_3)
	L3_5 = assert
	L3_5(A1_3)
	L3_5 = assert
	L3_5(A2_4 and A2_4 ~= "")
	L3_5 = A1_3.link
	L3_5(A1_3, A2_4, A0_2._unit, A0_2._unit:orientation_object():name())
	L3_5 = World
	L3_5 = L3_5.spawn_unit
	L3_5 = L3_5(L3_5, A0_2._projectile_spawner_class, A0_2._unit:position(), A0_2._unit:rotation())
	A1_3:link(A2_4, L3_5, L3_5:orientation_object():name())
	A0_2._projectile_spawner = L3_5
end
function FlyerWeapon.destroy(A0_6)
	if A0_6._wdata._firing then
		A0_6._event_emitter:unit_weapon_fire_stop(A0_6._unit)
	end
	A0_6._event_emitter:destroy()
	A0_6._unit = nil
	if alive(A0_6._projectile_spawner) then
		A0_6._projectile_spawner:set_slot(0)
	end
	A0_6._projectile_spawner = nil
end
function FlyerWeapon.fire_start(A0_7, A1_8)
	A0_7._event_emitter:unit_weapon_fire_start(A0_7._unit)
end
function FlyerWeapon.fire_end(A0_9, A1_10)
	A0_9._event_emitter:unit_weapon_fire_stop(A0_9._unit)
end
function FlyerWeapon.fire(A0_11, A1_12)
	local L2_13, L3_14, L4_15, L5_16, L6_17, L7_18
	L2_13 = A0_11._projectile_spawner
	L3_14 = A0_11._event_emitter
	L4_15 = L3_14
	L3_14 = L3_14.unit_weapon_fire_change
	L5_16 = A0_11._unit
	L7_18 = L2_13
	L6_17 = L2_13.position
	L6_17 = L6_17(L7_18)
	L7_18 = L2_13.rotation
	L7_18 = L7_18(L2_13)
	L3_14(L4_15, L5_16, L6_17, L7_18, L2_13)
	L3_14 = A0_11._wdata
	L5_16 = L2_13
	L4_15 = L2_13.position
	L4_15 = L4_15(L5_16)
	L5_16 = L3_14.aim_target_position
	L6_17 = L5_16 - L4_15
	L7_18 = L6_17
	L6_17 = L6_17.normalized
	L6_17 = L6_17(L7_18)
	L7_18 = VectorUtilities
	L7_18 = L7_18.angle_constraint_direction
	L7_18 = L7_18(L6_17, A0_11._obj_fire:rotation():y(), A0_11._max_fire_object_and_aim_angle_diff)
	L6_17 = L7_18
	L7_18 = WeaponUtilities
	L7_18 = L7_18.dispersion
	L7_18 = L7_18(L6_17, L3_14.miss_dispersion, L3_14._dispersion)
	L2_13:base():spawn_projectile(A0_11._user_unit, L4_15, Rotation(L7_18, math.UP))
end
