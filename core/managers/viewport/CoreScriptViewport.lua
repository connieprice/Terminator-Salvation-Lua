core:module("CoreScriptViewport")
core:require_module("CoreClass")
core:require_module("CoreMath")
core:require_module("CoreCode")
core:require_module("CoreViewportManagerVPInterface")
if not ScriptViewport then
	ScriptViewport = CoreClass.class()
end
ScriptViewport.init = function(l_1_0, ...)
	l_1_0._vp = Application:create_world_viewport(...)
	l_1_0._vpm_interface = CoreViewportManagerVPInterface.ViewportManagerVPInterface:new(managers.viewport)
	l_1_0._id = l_1_0._vpm_interface:reg_vp(l_1_0)
	l_1_0._active = false
	l_1_0._replaced_vp = false
	l_1_0._width_mul_enabled = true
	l_1_0._environment_change = nil
	if not script_debug.render_sky or not {"World", l_1_0._vp, nil, "Underlay", l_1_0._vp} then
		l_1_0._render_params = {"World", l_1_0._vp, nil}
	end
	l_1_0._init_trace = debug.traceback()
end

ScriptViewport.render_params = function(l_2_0)
	return l_2_0._render_params
end

ScriptViewport.set_render_params = function(l_3_0, ...)
	l_3_0._render_params = {...}
end

ScriptViewport.destroy = function(l_4_0)
	l_4_0:set_active(false)
	local l_4_1, l_4_2 = l_4_0._vpm_interface:destroy_viewport, l_4_0._vpm_interface
	local l_4_3 = l_4_0._id
	if not l_4_0._replaced_vp then
		local l_4_4 = l_4_0._vp
	else
		l_4_1(l_4_2, l_4_3, false)
	end
end

ScriptViewport.set_width_mul_enabled = function(l_5_0, l_5_1)
	l_5_0._width_mul_enabled = l_5_1
end

ScriptViewport.width_mul_enabled = function(l_6_0)
	return l_6_0._width_mul_enabled
end

ScriptViewport.set_active = function(l_7_0, l_7_1)
	if l_7_0._active ~= l_7_1 then
		if l_7_1 then
			l_7_0._vpm_interface:activate_vp(l_7_0._id)
		else
			l_7_0._vpm_interface:deactivate_vp(l_7_0._id)
		if l_7_0._environment_change then
			end
		end
		l_7_0._active = l_7_1
	end
end

ScriptViewport.set_environment = function(l_8_0, l_8_1, l_8_2)
	l_8_0._vpm_interface:set_environment_name_cache(l_8_1)
	l_8_0._environment_change = l_8_0._vpm_interface:create_environment_change(l_8_0._environment_change, l_8_1, l_8_2)
	l_8_0:feed_now()
end

ScriptViewport.environment = function(l_9_0)
	local l_9_3 = nil
	if l_9_0._environment_change then
		local l_9_1, l_9_2 = l_9_0._environment_change:name, l_9_0._environment_change
		return l_9_1(l_9_2)
	else
		return nil, nil, nil
	end
end

ScriptViewport.active = function(l_10_0)
	return l_10_0._active
end

ScriptViewport.set_camera = function(l_11_0, l_11_1)
	l_11_0._vp:set_camera(l_11_1)
end

ScriptViewport.camera = function(l_12_0)
	local l_12_1, l_12_2 = l_12_0._vp:camera, l_12_0._vp
	return l_12_1(l_12_2)
end

ScriptViewport.director = function(l_13_0)
	local l_13_1, l_13_2 = l_13_0._vp:director, l_13_0._vp
	return l_13_1(l_13_2)
end

ScriptViewport.shaker = function(l_14_0)
	local l_14_1, l_14_2 = l_14_0:director():shaker, l_14_0:director()
	return l_14_1(l_14_2)
end

ScriptViewport.vp = function(l_15_0)
	return l_15_0._vp
end

ScriptViewport.alive = function(l_16_0)
	local l_16_1 = CoreCode.alive
	local l_16_2 = l_16_0._vp
	return l_16_1(l_16_2)
end

ScriptViewport.is_rendering_scene = function(l_17_0, l_17_1)
	local l_17_5, l_17_6 = ipairs, l_17_0:render_params()
	l_17_5 = l_17_5(l_17_6)
	for i_0,i_1 in l_17_5 do
		if l_17_4 == l_17_1 then
			return true
		end
	end
	return false
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

ScriptViewport.set_dof = function(l_18_0, l_18_1, l_18_2, l_18_3, l_18_4, l_18_5)
	managers.environment:set_dof(l_18_0, l_18_1, math.max(l_18_3 - l_18_2, 1), l_18_3, l_18_4, math.max(l_18_5 - l_18_4, 1))
end

ScriptViewport.replace_engine_vp = function(l_19_0, l_19_1)
	l_19_0:destroy()
	l_19_0._replaced_vp = true
	l_19_0._vp = l_19_1
end

ScriptViewport.feed_now = function(l_20_0)
	l_20_0._vpm_interface:feed_environment(l_20_0._environment_change, l_20_0._vp, l_20_0._render_params[1])
end

ScriptViewport._refeed = function(l_21_0)
	if l_21_0._environment_change then
		l_21_0._environment_change:set_dirty(true)
		l_21_0:feed_now()
	end
end

ScriptViewport._camera_call = function(l_22_0, l_22_1, ...)
	if CoreCode.alive(l_22_0:camera()) then
		local l_22_3 = nil
		print(l_22_3, rawget(getmetatable(l_22_0:camera()), l_22_1)(l_22_3, ...))
	end
end

ScriptViewport._mul_camera_far = function(l_23_0, l_23_1)
	local l_23_2 = l_23_0:camera()
	if CoreCode.alive(l_23_2) then
		if not l_23_0.__camera_far then
			l_23_0.__camera_far = l_23_2:far_range()
		end
		l_23_2:set_far_range(l_23_0.__camera_far * l_23_1)
	end
end

ScriptViewport._update = function(l_24_0, l_24_1, l_24_2)
	l_24_0._vp:update()
end

ScriptViewport._render = function(l_25_0)
	if script_debug.render_world then
		if not l_25_0._environment_change then
			print("[ScriptViewport] WARNING! This viewport has no environment at rendering time!", l_25_0._init_trace)
			local l_25_1 = l_25_0._vpm_interface:environment_name_cache()
		if l_25_1 then
			end
			print("[ScriptViewport] WARNING! Using cached environment!")
			l_25_0:set_environment(l_25_1)
		end
		if not l_25_0._environment_change then
			return 
		end
		l_25_0._vpm_interface:feed_environment(l_25_0._environment_change, l_25_0._vp, l_25_0._render_params[1])
		local l_25_2 = l_25_0:camera()
		if CoreCode.alive(l_25_2) and l_25_0._width_mul_enabled then
			local l_25_3 = Application:screen_resolution()
			local l_25_4 = l_25_3.x / l_25_3.y
			local l_25_5 = l_25_0._vp:get_rect()
			local l_25_6 = l_25_4
			if l_25_5.ph > 0 then
				l_25_6 = l_25_5.pw / l_25_5.ph
			end
			l_25_2:set_width_multiplier(CoreMath.width_mul() * (l_25_6 / l_25_4))
		end
		Application:render(unpack(l_25_0._render_params))
	end
end


