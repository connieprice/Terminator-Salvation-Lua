require("units/weapons/WeaponUtilities")
require("shared/VectorUtilities")
GrenadeThrower = GrenadeThrower or class(PlayerBaseWeapon)
function GrenadeThrower.init(A0_0, A1_1)
	PlayerBaseWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0:set_enabled(false)
	A0_0._last_fire_input = 0
	A0_0._obj_fire = A0_0._unit:orientation_object()
	A0_0._wdata = A0_0._unit:weapon_data()
	A0_0._wdata._fire_enabled = true
	A0_0._projectile_spawner = World:spawn_unit(A0_0._projectile_spawner_class, A0_0._unit:position(), A0_0._unit:rotation())
	A0_0._unit:link(A0_0._obj_fire:name(), A0_0._projectile_spawner, A0_0._projectile_spawner:orientation_object():name())
end
function GrenadeThrower.destroy(A0_2)
	A0_2._unit = nil
	if alive(A0_2._projectile_spawner) then
		A0_2._projectile_spawner:set_slot(0)
	end
	A0_2._projectile_spawner = nil
end
function GrenadeThrower.setup(A0_3, A1_4)
	PlayerBaseWeapon.setup(A0_3, A1_4)
end
function GrenadeThrower.enable(A0_5)
	A0_5:set_enabled(true)
end
function GrenadeThrower.disable(A0_6)
	A0_6:set_enabled(false)
end
function GrenadeThrower._check_for_obstacles(A0_7, A1_8, A2_9)
	({}).target_dir = (A2_9 - A1_8):normalized()
	if A0_7._unit:raycast("ray", A1_8 - (A2_9 - A1_8):normalized() * 50, A1_8 + (A2_9 - A1_8):normalized() * tweak_data.player.weapon.grenade.SPAWN_OFFSET, "slot_mask", managers.slot:get_mask("statics"), managers.slot:get_mask("dynamics")) then
		({}).source_pos = A0_7._unit:raycast("ray", A1_8 - (A2_9 - A1_8):normalized() * 50, A1_8 + (A2_9 - A1_8):normalized() * tweak_data.player.weapon.grenade.SPAWN_OFFSET, "slot_mask", managers.slot:get_mask("statics"), managers.slot:get_mask("dynamics")).position - (A2_9 - A1_8):normalized() * 30
	else
		({}).source_pos = A1_8 + ({}).target_dir * tweak_data.player.weapon.grenade.SPAWN_OFFSET
	end
	return {}
end
function GrenadeThrower.fire(A0_10, A1_11)
	local L2_12, L3_13
	L2_12 = A0_10._obj_fire
	L3_13 = L2_12
	L2_12 = L2_12.position
	L2_12 = L2_12(L3_13)
	L3_13 = A0_10._wdata
	L3_13 = L3_13.aim_target_position
	A0_10._projectile_spawner:base():spawn_projectile(A0_10._user_unit, A0_10:_check_for_obstacles(L2_12, L3_13).source_pos, Rotation(A0_10:_check_for_obstacles(L2_12, L3_13).target_dir, A0_10._obj_fire:rotation():z()))
end
