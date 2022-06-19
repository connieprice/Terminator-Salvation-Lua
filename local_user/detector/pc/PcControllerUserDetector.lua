require("local_user/LocalUser")
require("user/pc/PcUserId")
if not PcControllerUserDetector then
	PcControllerUserDetector = class()
end
local l_0_0 = PcControllerUserDetector
local l_0_1 = {}
l_0_1.pc = true
l_0_1.xbox360 = true
l_0_0.SUPPORTED_WRAPPER_TYPES = l_0_1
l_0_0 = PcControllerUserDetector
l_0_1 = function(l_1_0, l_1_1)
	l_1_0._detected_controllers = l_1_1.detected_controllers
	l_1_0._next_user_index = l_1_1.next_user_index
	l_1_0:input_devices_changed()
end

l_0_0.init = l_0_1
l_0_0 = PcControllerUserDetector
l_0_1 = function(l_2_0)
	l_2_0.detected_controllers = {}
	l_2_0.next_user_index = 1
end

l_0_0.default_data = l_0_1
l_0_0 = PcControllerUserDetector
l_0_1 = function(l_3_0, l_3_1)
	l_3_1.detected_controllers = l_3_0._detected_controllers
	l_3_1.next_user_index = l_3_0._next_user_index
end

l_0_0.save = l_0_1
l_0_0 = PcControllerUserDetector
l_0_1 = function(l_4_0)
	local l_4_1 = PcControllerUserDetector.SUPPORTED_WRAPPER_TYPES
	for l_4_5 = 0, managers.controller:get_wrapper_count() - 1 do
		if not l_4_0._detected_controllers[l_4_5] then
			local l_4_6 = l_4_0:get_input_index(l_4_5)
			local l_4_7 = Input:controller(l_4_6)
		if l_4_7:connected() then
			end
			local l_4_8 = managers.controller:create_controller(nil, l_4_5)
			local l_4_9 = l_4_8:get_type()
			if l_4_1[l_4_9] then
				local l_4_10 = l_4_0._next_user_index
				l_4_0._next_user_index = l_4_0._next_user_index + 1
				managers.local_user:add_user(l_4_10, l_4_8, l_4_5)
			end
			l_4_0._detected_controllers[l_4_5] = true
		end
	end
end

l_0_0.input_devices_changed = l_0_1
l_0_0 = PcControllerUserDetector
l_0_1 = function(l_5_0, l_5_1)
	if l_5_1 > 0 then
		return l_5_1 + 1
	else
		return l_5_1
	end
end

l_0_0.get_input_index = l_0_1
l_0_0 = PcControllerUserDetector
l_0_1 = function(l_6_0)
	l_6_0:input_devices_changed()
end

l_0_0.update = l_0_1

