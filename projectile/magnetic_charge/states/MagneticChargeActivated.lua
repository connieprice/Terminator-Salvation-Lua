require("projectile/magnetic_charge/states/MagneticChargeState")
require("projectile/magnetic_charge/states/MagneticChargeDeactivated")
if not MagneticChargeActivated then
	MagneticChargeActivated = class(MagneticChargeState)
end
MagneticChargeActivated.init = function(l_1_0, l_1_1, l_1_2)
	MagneticChargeState.init(l_1_0, l_1_1)
	l_1_0._attachment_point = l_1_2
end

MagneticChargeActivated.enter = function(l_2_0)
	local l_2_1 = l_2_0._unit:base()
	l_2_1._deactivate = false
	l_2_1._activated = true
	l_2_0._event_emitter:magnetic_charge_activated(l_2_0._unit)
end

MagneticChargeActivated.leave = function(l_3_0)
	local l_3_1 = l_3_0._unit:base()
	l_3_1._activated = false
	if l_3_0:_attached() then
		l_3_0:_detach()
	end
end

MagneticChargeActivated._attached = function(l_4_0)
	if not l_4_0._attachment_point:valid() then
		return false
	end
	return TableAlgorithms.count_if(l_4_0._attachment_point:attached_units(), function(l_5_0)
		-- upvalues: l_4_0
		return l_5_0 == l_4_0._unit
  end) > 0
end

MagneticChargeActivated._detach = function(l_5_0)
	assert(l_5_0:_attached())
	l_5_0._attachment_point:detach_unit(l_5_0._unit)
end

MagneticChargeActivated.update = function(l_6_0, l_6_1)
	local l_6_5, l_6_6, l_6_7, l_6_8 = nil
	if l_6_0._unit:base()._deactivate then
		local l_6_2, l_6_3 = MagneticChargeDeactivated:new, MagneticChargeDeactivated
		local l_6_4 = l_6_0._unit
		return l_6_2(l_6_3, l_6_4)
	end
	local l_6_9 = l_6_0._unit:base()
	if l_6_9._bullet_hit then
		local l_6_14, l_6_15 = World:spawn_unit, World
		l_6_14(l_6_15, l_6_9._explosion_unit, l_6_0._unit:position(), l_6_0._unit:rotation())
		l_6_14 = managers
		l_6_14 = l_6_14.sequence
		l_6_14, l_6_15 = l_6_14:run_sequence_simple, l_6_14
		local l_6_13 = "explosion"
		l_6_14(l_6_15, l_6_13, l_6_0._unit)
		l_6_14 = MagneticChargeDeactivated
		l_6_14, l_6_15 = l_6_14:new, l_6_14
		local l_6_10, l_6_11 = nil
		l_6_13 = l_6_0._unit
		local l_6_12 = nil
		return l_6_14(l_6_15, l_6_13)
	end
end


