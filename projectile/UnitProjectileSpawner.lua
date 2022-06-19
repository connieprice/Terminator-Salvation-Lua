require("projectile/ProjectileSpawner")
UnitProjectileSpawner = UnitProjectileSpawner or class(ProjectileSpawner)
function UnitProjectileSpawner.init(A0_0, A1_1)
	ProjectileSpawner.init(A1_1)
	A0_0._emitter = managers.action_event:create_emitter()
end
function UnitProjectileSpawner.destroy(A0_2)
	ProjectileSpawner.destroy(A0_2)
	A0_2._emitter:destroy()
end
function UnitProjectileSpawner.spawn_projectile(A0_3, A1_4, A2_5, A3_6)
	local L4_7, L5_8, L6_9
	if A2_5 == nil then
		L5_8 = A0_3._unit
		L6_9 = L5_8
		L5_8 = L5_8.position
		L5_8 = L5_8(L6_9)
		L4_7 = L5_8
	else
		L4_7 = A2_5
	end
	L5_8 = nil
	if A3_6 == nil then
		L6_9 = A0_3._unit
		L6_9 = L6_9.rotation
		L6_9 = L6_9(L6_9)
		L5_8 = L6_9
	else
		L5_8 = A3_6
	end
	L6_9 = World
	L6_9 = L6_9.spawn_unit
	L6_9 = L6_9(L6_9, A0_3._projectile_class, L4_7, L5_8)
	if L6_9:base().set_spawning_unit then
		L6_9:base():set_spawning_unit(A1_4)
	end
	if A1_4:base() and A1_4:base().on_spawn_projectile then
		A1_4:base():on_spawn_projectile(L6_9)
	end
	A0_3._emitter:spawn_projectile(A0_3._projectile_class, L4_7, L5_8)
	return L6_9
end
