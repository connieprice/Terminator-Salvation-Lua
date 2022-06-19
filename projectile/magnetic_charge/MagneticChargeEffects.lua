if not MagneticChargeEffects then
	MagneticChargeEffects = class()
end
MagneticChargeEffects.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._armed_sound_time = 0
	l_1_0._armed = false
	l_1_0._activated_light = l_1_1:get_object("lo_handle")
	assert(l_1_0._activated_light)
	l_1_0._enabled_light = l_1_1:get_object("lo_armed")
	assert(l_1_0._enabled_light)
	managers.action_event:register_listener(l_1_0)
end

MagneticChargeEffects.destroy = function(l_2_0, l_2_1)
	managers.action_event:unregister_listener(l_2_0)
end

MagneticChargeEffects.magnetic_charge_enabled = function(l_3_0, l_3_1)
	if l_3_1 ~= l_3_0._unit then
		return 
	end
	l_3_0._enabled_light:set_enable(true)
end

MagneticChargeEffects.magnetic_charge_attached = function(l_4_0, l_4_1)
	if l_4_1 ~= l_4_0._unit then
		return 
	end
	l_4_0._fire_sound_instance = l_4_0._unit:play("stuck")
end

MagneticChargeEffects.magnetic_charge_activated = function(l_5_0, l_5_1)
	if l_5_1 ~= l_5_0._unit then
		return 
	end
	l_5_0._fire_sound_instance = l_5_0._unit:play("arming")
	l_5_0._armed = true
	l_5_0._armed_sound_time = 0
end

MagneticChargeEffects.magnetic_charge_deactivated = function(l_6_0, l_6_1)
	if l_6_1 ~= l_6_0._unit then
		return 
	end
	l_6_0._fire_sound_instance = l_6_0._unit:play("disarming")
	l_6_0._armed = false
	l_6_0._enabled_light:set_enable(false)
	l_6_0._activated_light:set_enable(false)
end

MagneticChargeEffects.update = function(l_7_0, l_7_1, l_7_2, l_7_3)
	if l_7_0._armed then
		l_7_0._armed_sound_time = l_7_0._armed_sound_time + l_7_3
		if l_7_0._armed_light_on_timer then
			l_7_0._armed_light_on_timer = l_7_0._armed_light_on_timer - l_7_3
		if l_7_0._armed_light_on_timer < 0 then
			end
			l_7_0._activated_light:set_enable(false)
		end
	if l_7_0.armed_sound_interval < l_7_0._armed_sound_time then
		end
		l_7_0._fire_sound_instance = l_7_0._unit:play("armed")
		l_7_0._armed_sound_time = 0
		l_7_0._activated_light:set_enable(true)
		l_7_0._armed_light_on_timer = l_7_0.armed_light_on_time
	end
end


