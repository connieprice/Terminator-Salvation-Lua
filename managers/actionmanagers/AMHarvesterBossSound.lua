if not AMHarvesterBossSound then
	AMHarvesterBossSound = class(CoreActionElement)
end
AMHarvesterBossSound.init = function(l_1_0, l_1_1, l_1_2)
	CoreActionElement.init(l_1_0, l_1_1, l_1_2)
	if l_1_0._mode == "spawn" then
		managers.unit_scripting:define_unit(l_1_0._name, "no_group")
	end
end

AMHarvesterBossSound.activate_now = function(l_2_0)
	if l_2_0._mode == "spawn" then
		l_2_0:_spawn()
	end
	l_2_0:deactivate_now()
end

AMHarvesterBossSound._spawn = function(l_3_0)
	local l_3_1 = l_3_0.destination[1]
	if l_3_1 then
		l_3_0._unit = World:spawn_unit("harvester_sound", l_3_0.position, l_3_0.rotation)
		managers.unit_scripting:register_unit(l_3_0._name, l_3_0._unit)
		l_3_0._unit:base():start_move(l_3_0.speed * 100, l_3_1.position)
	end
end


