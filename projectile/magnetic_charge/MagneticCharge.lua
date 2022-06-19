require("projectile/magnetic_charge/states/MagneticChargeDeactivated")
require("units/weapons/PlayerBaseWeapon")
MagneticCharge = MagneticCharge or class(PlayerBaseWeapon)
function MagneticCharge.init(A0_0, A1_1)
	PlayerBaseWeapon.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._body = A0_0._unit:body(A0_0._body_name)
	assert(A0_0._link_object_name)
	A0_0._link_object = A0_0._unit:get_object(A0_0._link_object_name)
	assert(A0_0._link_object)
	A1_1:set_body_collision_callback(callback(A0_0, A0_0, "collision_callback"))
	A0_0:_setup_link_object_relative_transform()
	A0_0._activated = false
	A0_0:_enter_state(MagneticChargeDeactivated:new(A0_0._unit))
end
function MagneticCharge.enable(A0_2)
	local L1_3
end
function MagneticCharge._update_state(A0_4, A1_5)
	local L2_6
	L2_6 = A0_4._state
	L2_6 = L2_6.update
	if L2_6 then
		L2_6 = A0_4._state
		L2_6 = L2_6.update
		L2_6 = L2_6(L2_6, A1_5)
		if L2_6 then
			A0_4:_enter_state(L2_6)
		end
	end
end
function MagneticCharge._enter_state(A0_7, A1_8)
	A0_7:_leave_state()
	A0_7._state = A1_8
	if A0_7._state.enter then
		A0_7._state:enter()
	end
end
function MagneticCharge._leave_state(A0_9)
	if A0_9._state and A0_9._state.leave then
		A0_9._state:leave()
	end
end
function MagneticCharge._setup_link_object_relative_transform(A0_10)
	local L1_11, L2_12, L3_13, L4_14, L5_15
	L1_11 = A0_10._unit
	L2_12 = L1_11
	L1_11 = L1_11.position
	L1_11 = L1_11(L2_12)
	L2_12 = A0_10._unit
	L3_13 = L2_12
	L2_12 = L2_12.rotation
	L2_12 = L2_12(L3_13)
	L3_13 = A0_10._link_object
	L4_14 = L3_13
	L3_13 = L3_13.position
	L3_13 = L3_13(L4_14)
	L4_14 = A0_10._link_object
	L5_15 = L4_14
	L4_14 = L4_14.rotation
	L4_14 = L4_14(L5_15)
	L5_15 = L4_14.inverse
	L5_15 = L5_15(L4_14)
	A0_10._link_object_relative_root_position = (L1_11 - L3_13):rotate_with(L5_15)
	A0_10._link_object_relative_root_rotation = L5_15 * L2_12
end
function MagneticCharge.destroy(A0_16, A1_17)
	A0_16:_leave_state()
end
function MagneticCharge._closest_attachment_point(A0_18, A1_19)
	local L2_20, L3_21, L4_22, L5_23
	L3_21 = A1_19
	L2_20 = A1_19.attachment
	L2_20 = L2_20(L3_21)
	if not L2_20 then
		return
	end
	L3_21, L4_22 = nil, nil
	L5_23 = L2_20.attachment_points
	L5_23 = L5_23(L2_20)
	for 