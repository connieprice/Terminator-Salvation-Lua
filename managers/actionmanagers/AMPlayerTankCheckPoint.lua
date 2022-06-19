AMPlayerTankCheckPoint = AMPlayerTankCheckPoint or class(CoreActionElement)
function AMPlayerTankCheckPoint.init(A0_0, A1_1, A2_2)
	CoreActionElement.init(A0_0, A1_1, A2_2)
	managers.world:add_checkpoint(A0_0)
end
function AMPlayerTankCheckPoint.activate_now(A0_3)
	local L1_4, L2_5, L3_6, L4_7, L5_8, L6_9, L7_10, L8_11, L9_12, L10_13, L11_14
	L1_4 = A0_3.checkpoint
	L2_5 = L1_4.spawnpoints
	L3_6 = 1
	L4_7 = A0_3.unit_names
	L5_8 = A0_3.brain_name
	L4_7 = L4_7 or L6_9.default_unit_names
	L5_8 = L5_8 or L6_9[1]
	for L9_12, L10_13 in L6_9(L7_10) do
		L11_14 = L4_7[L3_6]
		managers.player_slot:set_spawn_point(L3_6, L11_14, A0_3.position + L10_13.position, L10_13.rotation, false, true, L5_8)
		L3_6 = L3_6 + 1
	end
	L6_9(L7_10)
	L6_9(L7_10, L8_11)
end
