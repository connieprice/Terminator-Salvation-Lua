core:module("CoreScriptViewportVMInterface")
core:require_module("CoreClass")
ScriptViewportVMInterface = ScriptViewportVMInterface or CoreClass.class()
function ScriptViewportVMInterface.init(A0_0, A1_1)
	A0_0._host = A1_1
end
function ScriptViewportVMInterface.render(A0_2)
	A0_2._host:_render()
end
function ScriptViewportVMInterface.update(A0_3, A1_4, A2_5)
	A0_3._host:_update(A1_4, A2_5)
end
function ScriptViewportVMInterface.refeed(A0_6)
	A0_6._host:_refeed()
end
function ScriptViewportVMInterface.camera_call(A0_7, A1_8, ...)
	local L4_10, L5_11, L6_12
	L4_10 = A0_7._host
	L5_11 = L4_10
	L4_10 = L4_10._camera_call
	L6_12 = A1_8
	L4_10(L5_11, L6_12, ...)
end
function ScriptViewportVMInterface.mul_camera_far(A0_13, A1_14)
	A0_13._host:_mul_camera_far(A1_14)
end
function ScriptViewportVMInterface.vp(A0_15)
	local L1_16
	L1_16 = A0_15._host
	return L1_16
end
function ScriptViewportVMInterface.destroy(A0_17)
	A0_17._host:destroy()
end
