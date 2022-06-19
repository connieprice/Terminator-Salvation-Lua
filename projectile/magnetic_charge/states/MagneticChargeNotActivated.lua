require("projectile/magnetic_charge/states/MagneticChargeState")
require("projectile/magnetic_charge/states/MagneticChargeAttaching")
MagneticChargeNotActivated = MagneticChargeNotActivated or class(MagneticChargeState)
function MagneticChargeNotActivated.enter(A0_0)
	A0_0._collision_attachment_point = nil
	A0_0._event_emitter:magnetic_charge_enabled(A0_0._unit)
end
function MagneticChargeNotActivated.update(A0_1, A1_2)
	local L2_3, L3_4, L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11
	L2_3 = A0_1._collision_attachment_point
	if L2_3 then
		L2_3 = MagneticChargeAttaching
		L3_4 = L2_3
		L2_3 = L2_3.new
		L4_5 = A0_1._unit
		L5_6 = A0_1._collision_attachment_point
		return L2_3(L3_4, L4_5, L5_6)
	end
	L2_3 = A0_1._unit
	L3_4 = L2_3
	L2_3 = L2_3.base
	L2_3 = L2_3(L3_4)
	L3_4 = World
	L4_5 = L3_4
	L3_4 = L3_4.find_units
	L5_6 = "sphere"
	L9_10 = L8_9
	L10_11 = "enemies"
	L10_11 = L8_9(L9_10, L10_11)
	L3_4 = L3_4(L4_5, L5_6, L6_7, L7_8, L8_9, L9_10, L10_11, L8_9(L9_10, L10_11))
	L4_5, L5_6 = nil, nil
	for L9_10 = 1, #L3_4 do
		L10_11 = L3_4[L9_10]
		if L2_3:_closest_attachment_point(L10_11) and (not L5_6 or L5_6 > L2_3:_closest_attachment_point(L10_11)) then
			L4_5, L5_6 = L2_3:_closest_attachment_point(L10_11)
		end
	end
	if L4_5 then
		if L5_6 < L6_7 then
			L9_10 = L4_5
			return L6_7(L7_8, L8_9, L9_10)
		end
	end
end
function MagneticChargeNotActivated.collision_callback(A0_12, A1_13, A2_14, A3_15, A4_16, A5_17, A6_18, A7_19, A8_20)
	if A0_12._unit:base():_closest_attachment_point(A4_16) and A0_12._unit:base():_closest_attachment_point(A4_16) < A0_12._unit:base()._magnetic_radius then
		A0_12._unit:base()._body:set_keyframed()
		A0_12._collision_attachment_point = A0_12._unit:base():_closest_attachment_point(A4_16)
	end
end
