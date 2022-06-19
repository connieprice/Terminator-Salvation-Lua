require("core/managers/controller/CoreControllerWrapper")
CoreControllerWrapperDebug = CoreControllerWrapperDebug or class(CoreControllerWrapper)
CoreControllerWrapperDebug.TYPE = "debug"
function CoreControllerWrapperDebug.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5)
	A0_0._controller_wrapper_list = A1_1
	A0_0._default_controller_wrapper = A4_4
	get_core_or_local("ControllerWrapper").init(A0_0, A2_2, A3_3, {}, A4_4 and A4_4:get_default_controller_id(), A5_5, true, true)
	for 