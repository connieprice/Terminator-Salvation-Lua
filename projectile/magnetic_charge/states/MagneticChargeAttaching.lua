require("projectile/magnetic_charge/states/MagneticChargeState")
require("projectile/magnetic_charge/states/MagneticChargeActivated")
MagneticChargeAttaching = MagneticChargeAttaching or class(MagneticChargeState)
function MagneticChargeAttaching.init(A0_0, A1_1, A2_2)
	MagneticChargeState.init(A0_0, A1_1)
	A0_0._attachment_point = A2_2
end
function MagneticChargeAttaching.enter(A0_3)
	A0_3._unit:base()._body:set_keyframed()
	A0_3._link_time = 0
	A0_3._event_emitter:magnetic_charge_attached(A0_3._unit)
end
function MagneticChargeAttaching.update(A0_4, A1_5)
	local L2_6, L3_7, L4_8, L5_9, L6_10, L7_11, L8_12, L9_13, L10_14, L11_15, L12_16, L13_17, L14_18, L15_19
	L2_6 = A0_4._unit
	L3_7 = L2_6
	L2_6 = L2_6.base
	L2_6 = L2_6(L3_7)
	L3_7 = L2_6._link_object
	L5_9 = L3_7
	L4_8 = L3_7.position
	L4_8 = L4_8(L5_9)
	L6_10 = L3_7
	L5_9 = L3_7.rotation
	L5_9 = L5_9(L6_10)
	L6_10 = A0_4._attachment_point
	L8_12 = L6_10
	L7_11 = L6_10.position
	L7_11 = L7_11(L8_12)
	L9_13 = L6_10
	L8_12 = L6_10.rotation
	L8_12 = L8_12(L9_13)
	L9_13 = L7_11 - L4_8
	L11_15 = L9_13
	L10_14 = L9_13.length
	L10_14 = L10_14(L11_15)
	L11_15 = A0_4._link_time
	L11_15 = L11_15 + A1_5
	A0_4._link_time = L11_15
	L11_15 = math
	L11_15 = L11_15.min
	L12_16 = A0_4._link_time
	L13_17 = L2_6._link_interpolation_time
	L12_16 = L12_16 / L13_17
	L13_17 = 1
	L11_15 = L11_15(L12_16, L13_17)
	if L11_15 < 1 then
		L12_16 = L9_13 * L11_15
		L12_16 = L4_8 + L12_16
		L14_18 = L5_9
		L13_17 = L5_9.slerp
		L15_19 = L8_12
		L13_17 = L13_17(L14_18, L15_19, L11_15)
		L14_18 = L2_6._link_object_relative_root_position
		L15_19 = L14_18
		L14_18 = L14_18.rotate_with
		L14_18 = L14_18(L15_19, L13_17)
		L14_18 = L12_16 + L14_18
		L15_19 = L2_6._link_object_relative_root_rotation
		L15_19 = L13_17 * L15_19
		A0_4._unit:set_position(L14_18)
		A0_4._unit:set_rotation(L15_19)
	else
		L13_17 = L6_10
		L12_16 = L6_10.attach_unit
		L14_18 = A0_4._unit
		L15_19 = L2_6._link_object_name
		L12_16(L13_17, L14_18, L15_19)
		L12_16 = MagneticChargeActivated
		L13_17 = L12_16
		L12_16 = L12_16.new
		L14_18 = A0_4._unit
		L15_19 = L6_10
		return L12_16(L13_17, L14_18, L15_19)
	end
end
