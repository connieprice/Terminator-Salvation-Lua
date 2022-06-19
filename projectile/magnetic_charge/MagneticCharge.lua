require("projectile/magnetic_charge/states/MagneticChargeDeactivated")
require("units/weapons/PlayerBaseWeapon")
if not MagneticCharge then
	MagneticCharge = class(PlayerBaseWeapon)
end
MagneticCharge.init = function(l_1_0, l_1_1)
	PlayerBaseWeapon.init(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._body = l_1_0._unit:body(l_1_0._body_name)
	assert(l_1_0._link_object_name)
	l_1_0._link_object = l_1_0._unit:get_object(l_1_0._link_object_name)
	assert(l_1_0._link_object)
	l_1_1:set_body_collision_callback(callback(l_1_0, l_1_0, "collision_callback"))
	l_1_0:_setup_link_object_relative_transform()
	l_1_0._activated = false
	l_1_0:_enter_state(MagneticChargeDeactivated:new(l_1_0._unit))
end

MagneticCharge.enable = function(l_2_0)
end

MagneticCharge._update_state = function(l_3_0, l_3_1)
	if l_3_0._state.update then
		local l_3_2 = l_3_0._state:update(l_3_1)
	if l_3_2 then
		end
		l_3_0:_enter_state(l_3_2)
	end
end

MagneticCharge._enter_state = function(l_4_0, l_4_1)
	l_4_0:_leave_state()
	l_4_0._state = l_4_1
	if l_4_0._state.enter then
		l_4_0._state:enter()
	end
end

MagneticCharge._leave_state = function(l_5_0)
	if l_5_0._state and l_5_0._state.leave then
		l_5_0._state:leave()
	end
end

MagneticCharge._setup_link_object_relative_transform = function(l_6_0)
	local l_6_1 = l_6_0._unit:position()
	local l_6_2 = l_6_0._unit:rotation()
	local l_6_3 = l_6_0._link_object:position()
	local l_6_4 = l_6_0._link_object:rotation()
	local l_6_5 = l_6_4:inverse()
	l_6_0._link_object_relative_root_position = l_6_1 - l_6_3:rotate_with(l_6_5)
	l_6_0._link_object_relative_root_rotation = l_6_5 * l_6_2
end

MagneticCharge.destroy = function(l_7_0, l_7_1)
	l_7_0:_leave_state()
end

MagneticCharge._closest_attachment_point = function(l_8_0, l_8_1)
	local l_8_9, l_8_10, l_8_11, l_8_12, l_8_13, l_8_14 = nil
	local l_8_2 = l_8_1:attachment()
	if not l_8_2 then
		return 
	end
	local l_8_3, l_8_4 = nil, nil
	local l_8_5 = l_8_2:attachment_points()
	for i_0,i_1 in pairs(l_8_5) do
		if #i_1:attached_units() == 0 then
			local l_8_17 = nil
		if not l_8_4 or i_1:position() - l_8_0._unit:position():length() < l_8_4 then
			end
		if i_1:position() - l_8_0._unit:position():length() <= 0 or true then
			end
			l_8_4 = i_1:position() - l_8_0._unit:position():length()
			l_8_3 = l_8_16
		end
	end
	return l_8_3, l_8_4
	 -- DECOMPILER ERROR: Confused about usage of registers for local variables.

end

MagneticCharge.update = function(l_9_0, l_9_1, l_9_2, l_9_3)
	l_9_0:_update_state(l_9_3)
end

MagneticCharge.collision_callback = function(l_10_0, l_10_1, l_10_2, l_10_3, l_10_4, l_10_5, l_10_6, l_10_7, l_10_8)
	if l_10_0._state.collision_callback then
		l_10_0._state:collision_callback(l_10_1, l_10_2, l_10_3, l_10_4, l_10_5, l_10_6, l_10_7, l_10_8)
	end
end

MagneticCharge.bullet_hit = function(l_11_0)
	l_11_0._bullet_hit = true
end

MagneticCharge.deactivate = function(l_12_0)
	l_12_0._deactivate = true
end

MagneticCharge.activated = function(l_13_0)
	return l_13_0._activated
end

MagneticCharge.on_zoom_aim = function(l_14_0, l_14_1)
end


