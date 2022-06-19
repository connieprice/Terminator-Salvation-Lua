CommonAiSelfDestroy = CommonAiSelfDestroy or class()
function CommonAiSelfDestroy.init_data(A0_0, A1_1)
end
function CommonAiSelfDestroy.logic_common_self_destroy_main(A0_2, A1_3, A2_4, A3_5, A4_6, A5_7, A6_8, A7_9)
	assert(A2_4:ai_data().STUCK_SELF_DESTROY_TIME, "Time until self destroy when stuck has to be defined")
	if A2_4:ai_data().stuck_time and A2_4:ai_data().stuck_time > A2_4:ai_data().STUCK_SELF_DESTROY_TIME then
		if not A2_4:ai_data().output.self_destroy then
			cat_print("ai", "Unit '" .. A2_4:name() .. "' is self destroying because it is stuck at (" .. A2_4:position().x .. ", " .. A2_4:position().y .. ", " .. A2_4:position().z .. ")")
		end
		A2_4:ai_data().output.self_destroy = true
	end
end
