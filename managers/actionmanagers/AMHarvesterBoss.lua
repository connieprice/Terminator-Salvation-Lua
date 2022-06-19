AMHarvesterBoss = AMHarvesterBoss or class(CoreActionElement)
function AMHarvesterBoss.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	if A0_0._mode == "spawn" then
		managers.unit_scripting:define_unit(A0_0._name, "no_group")
	end
end
function AMHarvesterBoss.activate_now(A0_3)
	if A0_3._mode == "spawn" then
		A0_3:_spawn()
	end
	A0_3:deactivate_now()
end
function AMHarvesterBoss._spawn(A0_4)
	local L1_5, L2_6, L3_7, L4_8
	L1_5 = tonumber
	L2_6 = A0_4.attack_round
	L1_5 = L1_5(L2_6)
	L1_5 = L1_5 or 1
	L2_6 = A0_4.target_units
	L2_6 = L2_6 or {}
	L3_7 = tonumber
	L4_8 = A0_4.grab_attack_time
	L3_7 = L3_7(L4_8)
	L3_7 = L3_7 or 10
	L4_8 = tonumber
	L4_8 = L4_8(A0_4.hurt_damage)
	L4_8 = L4_8 or 100
	A0_4._unit = World:spawn_unit("harvester", A0_4.position, A0_4.rotation)
	managers.unit_scripting:register_unit(A0_4._name, A0_4._unit)
	A0_4._unit:base():start_round(L1_5, L2_6, L3_7, L4_8)
end
