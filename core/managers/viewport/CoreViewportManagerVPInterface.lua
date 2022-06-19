core:module("CoreViewportManagerVPInterface")
core:require_module("CoreClass")
if not ViewportManagerVPInterface then
	ViewportManagerVPInterface = CoreClass.class()
end
ViewportManagerVPInterface.init = function(l_1_0, l_1_1)
	l_1_0._host = l_1_1
end

ViewportManagerVPInterface.reg_vp = function(l_2_0, l_2_1)
	local l_2_2, l_2_3 = l_2_0._host:_reg_vp, l_2_0._host
	local l_2_4 = l_2_1
	return l_2_2(l_2_3, l_2_4)
end

ViewportManagerVPInterface.activate_vp = function(l_3_0, l_3_1)
	l_3_0._host:_activate_vp(l_3_1)
end

ViewportManagerVPInterface.deactivate_vp = function(l_4_0, l_4_1)
	l_4_0._host:_deactivate_vp(l_4_1)
end

ViewportManagerVPInterface.feed_environment = function(l_5_0, l_5_1, l_5_2, l_5_3)
	l_5_0._host:_feed_environment(l_5_1, l_5_2, l_5_3)
end

ViewportManagerVPInterface.destroy_viewport = function(l_6_0, l_6_1, l_6_2)
	l_6_0._host:_destroy_viewport(l_6_1, l_6_2)
end

ViewportManagerVPInterface.create_environment_change = function(l_7_0, l_7_1, l_7_2, l_7_3)
	local l_7_4, l_7_5 = l_7_0._host:_create_environment_change, l_7_0._host
	local l_7_6 = l_7_1
	local l_7_7 = l_7_2
	local l_7_8 = l_7_3
	return l_7_4(l_7_5, l_7_6, l_7_7, l_7_8)
end

ViewportManagerVPInterface.set_environment_name_cache = function(l_8_0, l_8_1)
	l_8_0._host:_set_environment_name_cache(l_8_1)
end

ViewportManagerVPInterface.environment_name_cache = function(l_9_0)
	local l_9_1, l_9_2 = l_9_0._host:_environment_name_cache, l_9_0._host
	return l_9_1(l_9_2)
end


