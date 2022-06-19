core:module("CoreScriptViewport")
core:require_module("CoreClass")
core:require_module("CoreMath")
core:require_module("CoreCode")
core:require_module("CoreViewportManagerVPInterface")
ScriptViewport = ScriptViewport or CoreClass.class()
function ScriptViewport.init(A0_0, ...)
	A0_0._vp = Application:create_world_viewport(...)
	A0_0._vpm_interface = CoreViewportManagerVPInterface.ViewportManagerVPInterface:new(managers.viewport)
	A0_0._id = A0_0._vpm_interface:reg_vp(A0_0)
	A0_0._active = false
	A0_0._replaced_vp = false
	A0_0._width_mul_enabled = true
	A0_0._environment_change = nil
	A0_0._render_params = script_debug.render_sky and {
		"World",
		A0_0._vp,
		nil,
		"Underlay",
		A0_0._vp
	} or {
		"World",
		A0_0._vp,
		nil
	}
	A0_0._init_trace = debug.traceback()
end
function ScriptViewport.render_params(A0_2)
	local L1_3
	L1_3 = A0_2._render_params
	return L1_3
end
function ScriptViewport.set_render_params(A0_4, ...)
	A0_4._render_params = {
		...
	}
end
function ScriptViewport.destroy(A0_6)
	A0_6:set_active(false)
	A0_6._vpm_interface:destroy_viewport(A0_6._id, not A0_6._replaced_vp and A0_6._vp)
end
function ScriptViewport.set_width_mul_enabled(A0_7, A1_8)
	A0_7._width_mul_enabled = A1_8
end
function ScriptViewport.width_mul_enabled(A0_9)
	local L1_10
	L1_10 = A0_9._width_mul_enabled
	return L1_10
end
function ScriptViewport.set_active(A0_11, A1_12)
	if A0_11._active ~= A1_12 then
		if A1_12 then
			A0_11._vpm_interface:activate_vp(A0_11._id)
		else
			A0_11._vpm_interface:deactivate_vp(A0_11._id)
			if A0_11._environment_change then
			end
		end
		A0_11._active = A1_12
	end
end
function ScriptViewport.set_environment(A0_13, A1_14, A2_15)
	A0_13._vpm_interface:set_environment_name_cache(A1_14)
	A0_13._environment_change = A0_13._vpm_interface:create_environment_change(A0_13._environment_change, A1_14, A2_15)
	A0_13:feed_now()
end
function ScriptViewport.environment(A0_16)
	if A0_16._environment_change then
		return A0_16._environment_change:name()
	else
		return nil, nil, nil
	end
end
function ScriptViewport.active(A0_17)
	local L1_18
	L1_18 = A0_17._active
	return L1_18
end
function ScriptViewport.set_camera(A0_19, A1_20)
	A0_19._vp:set_camera(A1_20)
end
function ScriptViewport.camera(A0_21)
	return A0_21._vp:camera()
end
function ScriptViewport.director(A0_22)
	return A0_22._vp:director()
end
function ScriptViewport.shaker(A0_23)
	return A0_23:director():shaker()
end
function ScriptViewport.vp(A0_24)
	local L1_25
	L1_25 = A0_24._vp
	return L1_25
end
function ScriptViewport.alive(A0_26)
	return CoreCode.alive(A0_26._vp)
end
function ScriptViewport.is_rendering_scene(A0_27, A1_28)
	local L2_29
	for 