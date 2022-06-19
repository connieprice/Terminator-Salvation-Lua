require("core/managers/controller/CoreControllerWrapperSettings")
require("core/managers/controller/CoreControllerWrapperGamepad")
require("core/managers/controller/CoreControllerWrapperPC")
require("core/managers/controller/CoreControllerWrapperXbox360")
require("core/managers/controller/CoreControllerWrapperPS3")
require("core/managers/controller/CoreControllerWrapperDebug")
CoreControllerManager = CoreControllerManager or class()
CoreControllerManager.CORE_CONTROLLER_SETTING_FILE = CoreControllerManager.CORE_CONTROLLER_SETTING_FILE or "data\\settings\\core_controller_settings.xml"
function CoreControllerManager.init(A0_0, A1_1, A2_2)
	if not Global.controller_manager then
		Global.controller_manager = {}
	end
	A0_0:create_virtual_pad()
	A0_0._last_default_controller_index_change_callback_id = 0
	A0_0._default_controller_index_change_callback_map = {}
	A0_0._controller_wrapper_list = {}
	A0_0._controller_wrapper_map = {}
	A0_0._next_controller_wrapper_id = 1
	A0_0._supported_wrapper_types = {}
	A0_0._supported_wrapper_types[get_core_or_local("ControllerWrapperGamepad").TYPE] = get_core_or_local("ControllerWrapperGamepad")
	A0_0._supported_wrapper_types[get_core_or_local("ControllerWrapperPC").TYPE] = get_core_or_local("ControllerWrapperPC")
	A0_0._supported_wrapper_types[get_core_or_local("ControllerWrapperXbox360").TYPE] = get_core_or_local("ControllerWrapperXbox360")
	A0_0._supported_wrapper_types[get_core_or_local("ControllerWrapperPS3").TYPE] = get_core_or_local("ControllerWrapperPS3")
	A0_0._supported_controller_type_map = {}
	for 