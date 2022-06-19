require("projectile/ProjectileSpawner")
if not UnitProjectileSpawner then
	UnitProjectileSpawner = class(ProjectileSpawner)
end
UnitProjectileSpawner.init = function(l_1_0, l_1_1)
	ProjectileSpawner.init(l_1_1)
	l_1_0._emitter = managers.action_event:create_emitter()
end

UnitProjectileSpawner.destroy = function(l_2_0)
	ProjectileSpawner.destroy(l_2_0)
	l_2_0._emitter:destroy()
end

UnitProjectileSpawner.spawn_projectile = function(l_3_0, l_3_1, l_3_2, l_3_3)
	if l_3_2 == nil then
		local l_3_4, l_3_5 = l_3_0._unit:position()
	else
		local l_3_6 = l_3_2
		 -- DECOMPILER ERROR: Overwrote pending register.

		if l_3_3 == nil then
			do return end
		end
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_3_7 = nil
		do
			local l_3_8 = nil
			if World:spawn_unit(l_3_0._projectile_class, l_3_6, nil):base().set_spawning_unit then
				World:spawn_unit(l_3_0._projectile_class, l_3_6, nil):base():set_spawning_unit(l_3_1)
			end
			if l_3_1:base() and l_3_1:base().on_spawn_projectile then
				l_3_1:base():on_spawn_projectile(l_3_8)
			end
			l_3_0._emitter:spawn_projectile(l_3_0._projectile_class, l_3_6, l_3_7)
			return l_3_8
		end
		 -- WARNING: missing end command somewhere! Added here
	end
	-- WARNING: F->nextEndif is not empty. Unhandled nextEndif->addr = 9 
end


