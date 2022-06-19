require("core/managers/controller/CoreControllerWrapper")
CoreControllerWrapperXbox360 = CoreControllerWrapperXbox360 or class(CoreControllerWrapper)
CoreControllerWrapperXbox360.TYPE = "xbox360"
CoreControllerWrapperXbox360.CONTROLLER_TYPE_LIST = {
	"xbox_controller"
}
function CoreControllerWrapperXbox360.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6)
	local L7_7
	L7_7 = {}
	L7_7.confirm = callback(A0_0, A0_0, "virtual_connect_confirm")
	L7_7.cancel = callback(A0_0, A0_0, "virtual_connect_cancel")
	get_core_or_local("ControllerWrapper").init(A0_0, A1_1, A2_2, {xbox360pad = A3_3}, "xbox360pad", A4_4, A5_5, A6_6, {xbox360pad = L7_7})
end
function CoreControllerWrapperXbox360.virtual_connect_confirm(A0_8, A1_9, A2_10, A3_11, A4_12, A5_13)
	A0_8:virtual_connect2(A1_9, A2_10, "a", A4_12, A5_13)
end
function CoreControllerWrapperXbox360.virtual_connect_cancel(A0_14, A1_15, A2_16, A3_17, A4_18, A5_19)
	A0_14:virtual_connect2(A1_15, A2_16, "b", A4_18, A5_19)
end
