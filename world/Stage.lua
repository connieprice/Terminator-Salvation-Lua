if not Stage then
	Stage = class(CoreStage)
end
Stage.init = function(l_1_0, l_1_1, l_1_2)
	CoreStage.init(l_1_0, l_1_1, l_1_2)
	l_1_0:set_start_hub()
end

Stage.set_start_hub = function(l_2_0)
	local l_2_1 = managers.game_transition:checkpoint_index()
	cat_print("debug", "Game says we should start at checkpoint: " .. l_2_1)
	if l_2_1 == 1 and not managers.world:has_checkpoint(l_2_1) then
		cat_debug("warning", "Checkpoint " .. l_2_1 .. " does not exist.")
		return 
	end
	local l_2_2 = (managers.world:checkpoint(l_2_1))
	local l_2_3 = nil
	if not l_2_2.start_hub_id then
		l_2_3 = l_2_2.start_hub
	else
		l_2_3 = "hub" .. l_2_2.start_hub_id
	end
	l_2_0._start_hub = l_2_0:get_hub(l_2_3)
end


