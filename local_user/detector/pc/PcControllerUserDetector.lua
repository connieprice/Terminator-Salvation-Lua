require("local_user/LocalUser")
require("user/pc/PcUserId")
PcControllerUserDetector = PcControllerUserDetector or class()
PcControllerUserDetector.SUPPORTED_WRAPPER_TYPES = {pc = true, xbox360 = true}
function PcControllerUserDetector.init(A0_0, A1_1)
	A0_0._detected_controllers = A1_1.detected_controllers
	A0_0._next_user_index = A1_1.next_user_index
	A0_0:input_devices_changed()
end
function PcControllerUserDetector.default_data(A0_2)
	A0_2.detected_controllers = {}
	A0_2.next_user_index = 1
end
function PcControllerUserDetector.save(A0_3, A1_4)
	local L2_5
	L2_5 = A0_3._detected_controllers
	A1_4.detected_controllers = L2_5
	L2_5 = A0_3._next_user_index
	A1_4.next_user_index = L2_5
end
function PcControllerUserDetector.input_devices_changed(A0_6)
	local L1_7, L2_8, L3_9, L4_10, L5_11, L6_12, L7_13, L8_14, L9_15, L10_16
	L1_7 = PcControllerUserDetector
	L1_7 = L1_7.SUPPORTED_WRAPPER_TYPES
	for L5_11 = 0, L3_9 - 1 do
		L6_12 = A0_6._detected_controllers
		L6_12 = L6_12[L5_11]
		if not L6_12 then
			L7_13 = A0_6
			L6_12 = A0_6.get_input_index
			L8_14 = L5_11
			L6_12 = L6_12(L7_13, L8_14)
			L7_13 = Input
			L8_14 = L7_13
			L7_13 = L7_13.controller
			L9_15 = L6_12
			L7_13 = L7_13(L8_14, L9_15)
			L9_15 = L7_13
			L8_14 = L7_13.connected
			L8_14 = L8_14(L9_15)
			if L8_14 then
				L8_14 = managers
				L8_14 = L8_14.controller
				L9_15 = L8_14
				L8_14 = L8_14.create_controller
				L10_16 = nil
				L8_14 = L8_14(L9_15, L10_16, L5_11)
				L10_16 = L8_14
				L9_15 = L8_14.get_type
				L9_15 = L9_15(L10_16)
				L10_16 = L1_7[L9_15]
				if L10_16 then
					L10_16 = A0_6._next_user_index
					A0_6._next_user_index = A0_6._next_user_index + 1
					managers.local_user:add_user(L10_16, L8_14, L5_11)
				end
				L10_16 = A0_6._detected_controllers
				L10_16[L5_11] = true
			end
		end
	end
end
function PcControllerUserDetector.get_input_index(A0_17, A1_18)
	if A1_18 > 0 then
		return A1_18 + 1
	else
		return A1_18
	end
end
function PcControllerUserDetector.update(A0_19)
	A0_19:input_devices_changed()
end
