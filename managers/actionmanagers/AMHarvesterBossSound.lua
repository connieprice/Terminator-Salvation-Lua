AMHarvesterBossSound = AMHarvesterBossSound or class(CoreActionElement)
function AMHarvesterBossSound.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	if A0_0._mode == "spawn" then
		managers.unit_scripting:define_unit(A0_0._name, "no_group")
	end
end
function AMHarvesterBossSound.activate_now(A0_3)
	if A0_3._mode == "spawn" then
		A0_3:_spawn()
	end
	A0_3:deactivate_now()
end
function AMHarvesterBossSound._spawn(A0_4)
	local L1_5
	L1_5 = A0_4.destination
	L1_5 = L1_5[1]
	if L1_5 then
		A0_4._unit = World:spawn_unit("harvester_sound", A0_4.position, A0_4.rotation)
		managers.unit_scripting:register_unit(A0_4._name, A0_4._unit)
		A0_4._unit:base():start_move(A0_4.speed * 100, L1_5.position)
	end
end
