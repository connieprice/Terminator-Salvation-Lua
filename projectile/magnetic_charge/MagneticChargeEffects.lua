MagneticChargeEffects = MagneticChargeEffects or class()
function MagneticChargeEffects.init(A0_0, A1_1)
	A0_0._unit = A1_1
	A0_0._armed_sound_time = 0
	A0_0._armed = false
	A0_0._activated_light = A1_1:get_object("lo_handle")
	assert(A0_0._activated_light)
	A0_0._enabled_light = A1_1:get_object("lo_armed")
	assert(A0_0._enabled_light)
	managers.action_event:register_listener(A0_0)
end
function MagneticChargeEffects.destroy(A0_2, A1_3)
	managers.action_event:unregister_listener(A0_2)
end
function MagneticChargeEffects.magnetic_charge_enabled(A0_4, A1_5)
	if A1_5 ~= A0_4._unit then
		return
	end
	A0_4._enabled_light:set_enable(true)
end
function MagneticChargeEffects.magnetic_charge_attached(A0_6, A1_7)
	if A1_7 ~= A0_6._unit then
		return
	end
	A0_6._fire_sound_instance = A0_6._unit:play("stuck")
end
function MagneticChargeEffects.magnetic_charge_activated(A0_8, A1_9)
	if A1_9 ~= A0_8._unit then
		return
	end
	A0_8._fire_sound_instance = A0_8._unit:play("arming")
	A0_8._armed = true
	A0_8._armed_sound_time = 0
end
function MagneticChargeEffects.magnetic_charge_deactivated(A0_10, A1_11)
	if A1_11 ~= A0_10._unit then
		return
	end
	A0_10._fire_sound_instance = A0_10._unit:play("disarming")
	A0_10._armed = false
	A0_10._enabled_light:set_enable(false)
	A0_10._activated_light:set_enable(false)
end
function MagneticChargeEffects.update(A0_12, A1_13, A2_14, A3_15)
	if A0_12._armed then
		A0_12._armed_sound_time = A0_12._armed_sound_time + A3_15
		if A0_12._armed_light_on_timer then
			A0_12._armed_light_on_timer = A0_12._armed_light_on_timer - A3_15
			if A0_12._armed_light_on_timer < 0 then
				A0_12._activated_light:set_enable(false)
			end
		end
		if A0_12._armed_sound_time > A0_12.armed_sound_interval then
			A0_12._fire_sound_instance = A0_12._unit:play("armed")
			A0_12._armed_sound_time = 0
			A0_12._activated_light:set_enable(true)
			A0_12._armed_light_on_timer = A0_12.armed_light_on_time
		end
	end
end
