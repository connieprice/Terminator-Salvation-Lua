core:module("CoreScriptViewportVMInterface")
core:require_module("CoreClass")
if not ScriptViewportVMInterface then
	ScriptViewportVMInterface = CoreClass.class()
end
ScriptViewportVMInterface.init = function(l_1_0, l_1_1)
	l_1_0._host = l_1_1
end

ScriptViewportVMInterface.render = function(l_2_0)
	l_2_0._host:_render()
end

ScriptViewportVMInterface.update = function(l_3_0, l_3_1, l_3_2)
	l_3_0._host:_update(l_3_1, l_3_2)
end

ScriptViewportVMInterface.refeed = function(l_4_0)
	l_4_0._host:_refeed()
end

ScriptViewportVMInterface.camera_call = function(l_5_0, l_5_1, ...)
	l_5_0._host:_camera_call(l_5_1, ...)
end

ScriptViewportVMInterface.mul_camera_far = function(l_6_0, l_6_1)
	l_6_0._host:_mul_camera_far(l_6_1)
end

ScriptViewportVMInterface.vp = function(l_7_0)
	return l_7_0._host
end

ScriptViewportVMInterface.destroy = function(l_8_0)
	l_8_0._host:destroy()
end


