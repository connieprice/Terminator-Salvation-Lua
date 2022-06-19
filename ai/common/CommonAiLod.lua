if not CommonAiLod then
	CommonAiLod = class()
end
CommonAiLod.logic_common_lod_init = function(l_1_0, l_1_1, l_1_2, l_1_3, l_1_4, l_1_5, l_1_6, l_1_7)
	return 0
end

CommonAiLod.logic_common_lod_inactive_enter = function(l_2_0, l_2_1, l_2_2, l_2_3)
	cat_print("ai", "Deactivating AI")
	l_2_0:_activate_threads(l_2_2, false)
	l_2_2:ai_data().output.hibernate = true
end

CommonAiLod.logic_common_lod_inactive = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7)
	if l_3_0:_unit_within_range(l_3_2) then
		return 0
	end
	return nil
end

CommonAiLod.logic_common_lod_active_enter = function(l_4_0, l_4_1, l_4_2, l_4_3)
	cat_print("ai", "Activating AI")
	l_4_0:_activate_threads(l_4_2, true)
	l_4_2:ai_data().output.hibernate = false
end

CommonAiLod.logic_common_lod_active = function(l_5_0, l_5_1, l_5_2, l_5_3, l_5_4, l_5_5, l_5_6, l_5_7)
	if not l_5_0:_unit_within_range(l_5_2) then
		return 0
	end
	return nil
end

CommonAiLod._unit_within_range = function(l_6_0, l_6_1)
	local l_6_2 = managers.player:distance_to_closest_player(l_6_1:position())
	if not l_6_2 then
		return false
	end
	if l_6_2 < l_6_1:ai_data().lod_distance then
		return true
	end
	return false
end

CommonAiLod._activate_threads = function(l_7_0, l_7_1, l_7_2)
	local l_7_7, l_7_8, l_7_9, l_7_10, l_7_11, l_7_12, l_7_13, l_7_14 = nil
	local l_7_3 = l_7_1:ai_data()
	for i_0,i_1 in ipairs(l_7_3.lod_managed_threads) do
		if l_7_2 then
			l_7_3.brain:activate_thread(i_1)
		else
			l_7_3.brain:deactivate_thread(i_1)
		end
	end
end


