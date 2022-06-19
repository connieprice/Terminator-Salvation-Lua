local L0_0
L0_0 = require
L0_0("units/beings/CharacterControllerInterpreter/DebugBasicAimStateCI")
L0_0 = require
L0_0("units/beings/CharacterControllerInterpreter/DebugPrecisionAimableAimSM")
L0_0 = require
L0_0("shared/aimer/BallisticProjectileAimer")
L0_0 = WalkerControllerInterpreter
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0(DebugBasicAimStateControllerInterpreter)
end
WalkerControllerInterpreter = L0_0
L0_0 = WalkerControllerInterpreter
function L0_0.init(A0_1, A1_2)
	DebugBasicAimStateControllerInterpreter.init(A0_1, A1_2)
	A0_1._unit = A1_2
	A0_1._input = A1_2:input()
	assert(A0_1._input)
	A0_1._secondary_aimer = BallisticProjectileAimer:new({initial_speed = 2000})
	A0_1._secondary_fire_object = A1_2:get_object("a_weapon_left_back")
end
L0_0 = WalkerControllerInterpreter
function L0_0.enable(A0_3, A1_4)
	A0_3._controller_wrapper = A1_4
	DebugPrecisionAimableAimSettingsModifier.update(A0_3, false)
end
L0_0 = WalkerControllerInterpreter
function L0_0.disable(A0_5)
	local L1_6
	A0_5._controller_wrapper = nil
end
function L0_0(A0_7, A1_8, A2_9, A3_10)
	local L4_11, L5_12, L6_13
	L4_11 = managers
	L4_11 = L4_11.slot
	L5_12 = L4_11
	L4_11 = L4_11.get_mask
	L6_13 = "shootable_wo_adr_shield"
	L4_11 = L4_11(L5_12, L6_13)
	L6_13 = A0_7
	L5_12 = A0_7.raycast
	L5_12 = L5_12(L6_13, "ray", A2_9, A3_10, "slot_mask", L4_11)
	L6_13 = nil
	if L5_12 then
		L6_13 = L5_12.position
	else
		L6_13 = A3_10
	end
	A1_8:set_primary_aim_target_position(L6_13)
end
function WalkerControllerInterpreter._update_world_space_controller(A0_14, A1_15, A2_16, A3_17)
	local L4_18, L5_19, L6_20
	L5_19 = A2_16
	L4_18 = A2_16.get_input_axis
	L6_20 = "move"
	L4_18 = L4_18(L5_19, L6_20)
	L6_20 = A3_17
	L5_19 = A3_17.set_movement
	L5_19(L6_20, L4_18)
	L6_20 = A2_16
	L5_19 = A2_16.get_input_axis
	L5_19 = L5_19(L6_20, "look")
	L6_20 = nil
	if L5_19:length() < 0.1 then
		L6_20 = A1_15:position() + A1_15:rotation():y() * 10000
	else
		L6_20 = A1_15:position() + L5_19:normalized() * 10000
	end
	A3_17:set_eye_target_position(L6_20)
	A3_17:set_primary_aim_target_position(L6_20)
	A3_17:set_secondary_aim_target_position(L6_20)
	if A2_16:get_input_bool("fire") then
		A3_17:set_primary_fire()
		A3_17:set_secondary_fire()
	end
	if A2_16:get_input_bool("zoom") then
		A3_17:set_prepare_primary_fire()
		A3_17:set_prepare_secondary_fire()
	end
end
function WalkerControllerInterpreter.update(A0_21, A1_22, A2_23, A3_24)
	local L4_25, L5_26, L6_27, L7_28, L8_29, L9_30, L10_31, L11_32, L12_33, L13_34, L14_35, L15_36, L16_37, L17_38, L18_39, L19_40, L20_41, L21_42
	L4_25 = DebugPrecisionAimableAimSettingsModifier
	L4_25 = L4_25.update
	L5_26 = A0_21
	L6_27 = false
	L4_25(L5_26, L6_27)
	L4_25 = A0_21._controller_wrapper
	L5_26 = assert
	L6_27 = L4_25
	L5_26(L6_27)
	L5_26 = A0_21._input
	L7_28 = A1_22
	L6_27 = A1_22.camera_data
	L6_27 = L6_27(L7_28)
	L7_28 = assert
	L8_29 = L6_27
	L7_28(L8_29)
	L8_29 = L5_26
	L7_28 = L5_26.clear
	L7_28(L8_29)
	do break end
	L8_29 = A0_21
	L7_28 = A0_21._update_world_space_controller
	L9_30 = A1_22
	L10_31 = L4_25
	L11_32 = L5_26
	L7_28(L8_29, L9_30, L10_31, L11_32)
	do return end
	L7_28 = DebugBasicAimStateControllerInterpreter
	L7_28 = L7_28.update
	L8_29 = A0_21
	L9_30 = L4_25
	L10_31 = A3_24
	L7_28(L8_29, L9_30, L10_31)
	L8_29 = L5_26
	L7_28 = L5_26.eye_target_position
	L7_28 = L7_28(L8_29)
	L9_30 = L4_25
	L8_29 = L4_25.get_input_axis
	L10_31 = "move"
	L8_29 = L8_29(L9_30, L10_31)
	L9_30 = L6_27.camera_rotation
	L10_31 = L9_30
	L9_30 = L9_30.x
	L9_30 = L9_30(L10_31)
	L10_31 = L6_27.camera_rotation
	L11_32 = L10_31
	L10_31 = L10_31.y
	L10_31 = L10_31(L11_32)
	L12_33 = L9_30
	L11_32 = L9_30.flat
	L13_34 = math
	L13_34 = L13_34.UP
	L11_32 = L11_32(L12_33, L13_34)
	L12_33 = L11_32
	L11_32 = L11_32.normalized
	L11_32 = L11_32(L12_33)
	L13_34 = L10_31
	L12_33 = L10_31.flat
	L14_35 = math
	L14_35 = L14_35.UP
	L12_33 = L12_33(L13_34, L14_35)
	L13_34 = L12_33
	L12_33 = L12_33.normalized
	L12_33 = L12_33(L13_34)
	L13_34 = L8_29.x
	L13_34 = L13_34 * L11_32
	L14_35 = L8_29.y
	L14_35 = L14_35 * L12_33
	L15_36 = L13_34 + L14_35
	L17_38 = L5_26
	L16_37 = L5_26.set_movement
	L18_39 = L15_36
	L16_37(L17_38, L18_39)
	L16_37 = L6_27.camera_position
	L17_38 = _UPVALUE0_
	L18_39 = A1_22
	L19_40 = L5_26
	L20_41 = L16_37
	L17_38(L18_39, L19_40, L20_41, L21_42)
	L17_38 = World
	L18_39 = L17_38
	L17_38 = L17_38.find_units
	L19_40 = "sphere"
	L20_41 = A1_22.position
	L20_41 = L20_41(L21_42)
	L17_38 = L17_38(L18_39, L19_40, L20_41, L21_42, managers.slot:get_mask("players"))
	L18_39, L19_40 = nil, nil
	L20_41 = #L17_38
	if L20_41 > 0 then
		L20_41 = nil
		for 