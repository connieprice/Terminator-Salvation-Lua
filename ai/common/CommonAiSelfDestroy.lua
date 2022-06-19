if not CommonAiSelfDestroy then
	CommonAiSelfDestroy = class()
end
CommonAiSelfDestroy.init_data = function(l_1_0, l_1_1)
end

CommonAiSelfDestroy.logic_common_self_destroy_main = function(l_2_0, l_2_1, l_2_2, l_2_3, l_2_4, l_2_5, l_2_6, l_2_7)
	local l_2_8 = l_2_2:ai_data()
	assert(l_2_8.STUCK_SELF_DESTROY_TIME, "Time until self destroy when stuck has to be defined")
	if l_2_8.stuck_time and l_2_8.STUCK_SELF_DESTROY_TIME < l_2_8.stuck_time then
		if not l_2_8.output.self_destroy then
			local l_2_9 = l_2_2:position()
			cat_print("ai", "Unit '" .. l_2_2:name() .. "' is self destroying because it is stuck at (" .. l_2_9.x .. ", " .. l_2_9.y .. ", " .. l_2_9.z .. ")")
		end
		l_2_8.output.self_destroy = true
	end
end


