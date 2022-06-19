if not AMHarvesterBoss then
	AMHarvesterBoss = class(CoreActionElement)
end
AMHarvesterBoss.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	if l_1_0._mode == "spawn" then
		managers.unit_scripting:define_unit(l_1_0._name, "no_group")
	end
end

AMHarvesterBoss.activate_now = function(l_2_0)
	if l_2_0._mode == "spawn" then
		l_2_0:_spawn()
	end
	l_2_0:deactivate_now()
end

AMHarvesterBoss._spawn = function(l_3_0)
	do
		local l_3_1, l_3_5, l_3_9, l_3_10, l_3_12, l_3_15, l_3_19 = tonumber(l_3_0.attack_round) or 1
	end
	if not l_3_0.target_units then
		local l_3_2, l_3_6, l_3_11, l_3_13, l_3_16, l_3_20 = , {}
	end
	do
		local l_3_3, l_3_7, l_3_14, l_3_17, l_3_21 = , tonumber(l_3_0.grab_attack_time) or 10
	do
		end
		local l_3_4, l_3_8, l_3_18, l_3_22 = , tonumber(l_3_0.hurt_damage) or 100
	end
	l_3_0._unit = World:spawn_unit("harvester", l_3_0.position, l_3_0.rotation)
	managers.unit_scripting:register_unit(l_3_0._name, l_3_0._unit)
	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	 -- DECOMPILER ERROR: Confused about usage of registers!

	l_3_0._unit:base():start_round(l_3_4, l_3_8, l_3_18, l_3_22)
end


