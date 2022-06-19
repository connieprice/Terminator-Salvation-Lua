require("core/managers/controller/CoreControllerWrapper")
CoreControllerWrapperPS3 = CoreControllerWrapperPS3 or class(CoreControllerWrapper)
CoreControllerWrapperPS3.TYPE = "ps3"
CoreControllerWrapperPS3.CONTROLLER_TYPE_LIST = {
	"ps3_controller"
}
function CoreControllerWrapperPS3.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	local L7_7
	L7_7 = {}
	L7_7.confirm = callback(A0_0, A0_0, "virtual_connect_confirm")
	L7_7.cancel = callback(A0_0, A0_0, "virtual_connect_cancel")
	get_core_or_local("ControllerWrapper").init(A0_0, A1_1, A2_2, {ps3pad = A3_3}, "ps3pad", A4_4, A5_5, A6_6, {ps3pad = L7_7})
end
function CoreControllerWrapperPS3.virtual_connect_confirm(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13)
	if A0_8:is_confirm_cancel_inverted() then
		A3_11 = "circle"
	else
		A3_11 = "cross"
	end
	A0_8:virtual_connect2(A1_9, A2_10, A3_11, A4_12, A5_13)
end
function CoreControllerWrapperPS3.virtual_connect_cancel(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19)
	if A0_14:is_confirm_cancel_inverted() then
		A3_17 = "cross"
	else
		A3_17 = "circle"
	end
	A0_14:virtual_connect2(A1_15, A2_16, A3_17, A4_18, A5_19)
end
function CoreControllerWrapperPS3.is_confirm_cancel_inverted(A0_20)
	return SystemInfo:platform() == "PS3" and PS3:pad_cross_circle_inverted()
end
