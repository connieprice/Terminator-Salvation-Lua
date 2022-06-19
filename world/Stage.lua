Stage = Stage or class(CoreStage)
function Stage.init(A0_0, A1_1, A2_2)
	CoreStage.init(A0_0, A1_1, A2_2)
	A0_0:set_start_hub()
end
function Stage.set_start_hub(A0_3)
	local L1_4, L2_5, L3_6
	L1_4 = managers
	L1_4 = L1_4.game_transition
	L2_5 = L1_4
	L1_4 = L1_4.checkpoint_index
	L1_4 = L1_4(L2_5)
	L2_5 = cat_print
	L3_6 = "debug"
	L2_5(L3_6, "Game says we should start at checkpoint: " .. L1_4)
	if L1_4 == 1 then
		L2_5 = managers
		L2_5 = L2_5.world
		L3_6 = L2_5
		L2_5 = L2_5.has_checkpoint
		L2_5 = L2_5(L3_6, L1_4)
		if not L2_5 then
			L2_5 = cat_debug
			L3_6 = "warning"
			L2_5(L3_6, "Checkpoint " .. L1_4 .. " does not exist.")
			return
		end
	end
	L2_5 = managers
	L2_5 = L2_5.world
	L3_6 = L2_5
	L2_5 = L2_5.checkpoint
	L2_5 = L2_5(L3_6, L1_4)
	L3_6 = nil
	if not L2_5.start_hub_id then
		L3_6 = L2_5.start_hub
	else
		L3_6 = "hub" .. L2_5.start_hub_id
	end
	A0_3._start_hub = A0_3:get_hub(L3_6)
end
