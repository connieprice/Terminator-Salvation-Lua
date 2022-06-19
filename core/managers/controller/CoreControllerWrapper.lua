require("core/managers/controller/CoreControllerWrapperSettings")
CoreControllerWrapper = CoreControllerWrapper or class()
CoreControllerWrapper.TYPE = "generic"
function CoreControllerWrapper.init(A0_0, A1_1, A2_2, A3_3, A4_4, A5_5, A6_6, A7_7, A8_8)
	A0_0._id = A1_1
	A0_0._name = A2_2
	A0_0._controller_map = A3_3
	A0_0._default_controller_id = A4_4
	A0_0._setup = A5_5
	A0_0._debug = A6_6
	if not A7_7 then
		A0_0._virtual_controller = Input:create_virtual_controller("ctrl_" .. tostring(A0_0._id))
	end
	A0_0._custom_virtual_connect_func_map = A8_8 or {}
	for 