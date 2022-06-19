core:module("CoreViewportManagerVPInterface")
core:require_module("CoreClass")
ViewportManagerVPInterface = ViewportManagerVPInterface or CoreClass.class()
function ViewportManagerVPInterface.init(A0_0, A1_1)
	A0_0._host = A1_1
end
function ViewportManagerVPInterface.reg_vp(A0_2, A1_3)
	return A0_2._host:_reg_vp(A1_3)
end
function ViewportManagerVPInterface.activate_vp(A0_4, A1_5)
	A0_4._host:_activate_vp(A1_5)
end
function ViewportManagerVPInterface.deactivate_vp(A0_6, A1_7)
	A0_6._host:_deactivate_vp(A1_7)
end
function ViewportManagerVPInterface.feed_environment(A0_8, A1_9, A2_10, A3_11)
	A0_8._host:_feed_environment(A1_9, A2_10, A3_11)
end
function ViewportManagerVPInterface.destroy_viewport(A0_12, A1_13, A2_14)
	A0_12._host:_destroy_viewport(A1_13, A2_14)
end
function ViewportManagerVPInterface.create_environment_change(A0_15, A1_16, A2_17, A3_18)
	return A0_15._host:_create_environment_change(A1_16, A2_17, A3_18)
end
function ViewportManagerVPInterface.set_environment_name_cache(A0_19, A1_20)
	A0_19._host:_set_environment_name_cache(A1_20)
end
function ViewportManagerVPInterface.environment_name_cache(A0_21)
	return A0_21._host:_environment_name_cache()
end
