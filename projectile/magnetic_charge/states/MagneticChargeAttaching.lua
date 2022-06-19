require("projectile/magnetic_charge/states/MagneticChargeState")
require("projectile/magnetic_charge/states/MagneticChargeActivated")
if not MagneticChargeAttaching then
	MagneticChargeAttaching = class(MagneticChargeState)
end
MagneticChargeAttaching.init = function(l_1_0, l_1_1, l_1_2)
	MagneticChargeState.init(l_1_0, l_1_1)
	l_1_0._attachment_point = l_1_2
end

MagneticChargeAttaching.enter = function(l_2_0)
	l_2_0._unit:base()._body:set_keyframed()
	l_2_0._link_time = 0
	l_2_0._event_emitter:magnetic_charge_attached(l_2_0._unit)
end

MagneticChargeAttaching.update = function(l_3_0, l_3_1)
	local l_3_2 = l_3_0._unit:base()
	local l_3_3 = l_3_2._link_object
	local l_3_4 = l_3_3:position()
	local l_3_5 = l_3_3:rotation()
	local l_3_6 = l_3_0._attachment_point
	local l_3_7 = l_3_6:position()
	local l_3_8 = l_3_6:rotation()
	local l_3_9 = l_3_7 - l_3_4
	local l_3_10 = l_3_9:length()
	l_3_0._link_time = l_3_0._link_time + l_3_1
	local l_3_11 = math.min(l_3_0._link_time / l_3_2._link_interpolation_time, 1)
	if l_3_11 < 1 then
		local l_3_12 = l_3_4 + l_3_9 * l_3_11
		local l_3_13 = l_3_5:slerp(l_3_8, l_3_11)
		local l_3_14 = l_3_12 + l_3_2._link_object_relative_root_position:rotate_with(l_3_13)
		local l_3_15 = l_3_13 * l_3_2._link_object_relative_root_rotation
		l_3_0._unit:set_position(l_3_14)
		local l_3_20, l_3_21 = l_3_0._unit:set_rotation, l_3_0._unit
		local l_3_22 = l_3_15
		l_3_20(l_3_21, l_3_22)
	else
		l_3_6:attach_unit(l_3_0._unit, l_3_2._link_object_name)
		local l_3_16, l_3_17 = MagneticChargeActivated:new, MagneticChargeActivated
		local l_3_18 = l_3_0._unit
		local l_3_19 = l_3_6
		return l_3_16(l_3_17, l_3_18, l_3_19)
	end
end


