require("projectile/magnetic_charge/states/MagneticChargeState")
require("projectile/magnetic_charge/states/MagneticChargeAttaching")
if not MagneticChargeNotActivated then
	MagneticChargeNotActivated = class(MagneticChargeState)
end
MagneticChargeNotActivated.enter = function(l_1_0)
	local l_1_1 = l_1_0._unit:base()
	l_1_0._collision_attachment_point = nil
	l_1_0._event_emitter:magnetic_charge_enabled(l_1_0._unit)
end

MagneticChargeNotActivated.update = function(l_2_0, l_2_1)
	local l_2_6, l_2_7, l_2_8, l_2_9, l_2_10, l_2_11, l_2_12, l_2_13 = nil
	if l_2_0._collision_attachment_point then
		local l_2_2, l_2_3 = MagneticChargeAttaching:new, MagneticChargeAttaching
		local l_2_4 = l_2_0._unit
		local l_2_5 = l_2_0._collision_attachment_point
		return l_2_2(l_2_3, l_2_4, l_2_5)
	end
	local l_2_14 = l_2_0._unit:base()
	local l_2_15 = (World:find_units("sphere", l_2_0._unit:position(), l_2_14._magnetic_radius, managers.slot:get_mask("enemies")))
	local l_2_16, l_2_17 = nil, nil
	for l_2_21 = 1, #l_2_15 do
		local l_2_22, l_2_29 = l_2_15[l_2_21]
		local l_2_32 = l_2_14
		 -- DECOMPILER ERROR: Overwrote pending register.

		local l_2_23, l_2_24, l_2_30, l_2_31 = nil
		if l_2_29 and (not l_2_17 or l_2_32 < l_2_17) then
			l_2_17 = 
			l_2_16 = l_2_29
		end
	end
	if l_2_16 and l_2_17 < l_2_14._magnetic_radius then
		local l_2_25, l_2_26 = MagneticChargeAttaching:new, MagneticChargeAttaching
		local l_2_27 = l_2_0._unit
		local l_2_28 = l_2_16
		return l_2_25(l_2_26, l_2_27, l_2_28)
	end
end

MagneticChargeNotActivated.collision_callback = function(l_3_0, l_3_1, l_3_2, l_3_3, l_3_4, l_3_5, l_3_6, l_3_7, l_3_8)
	local l_3_9 = l_3_0._unit:base()
	local l_3_10, l_3_11 = l_3_9:_closest_attachment_point(l_3_4)
	if l_3_10 and l_3_11 < l_3_9._magnetic_radius then
		l_3_0._unit:base()._body:set_keyframed()
		l_3_0._collision_attachment_point = l_3_10
	end
end


