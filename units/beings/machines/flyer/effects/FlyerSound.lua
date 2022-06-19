require("units/beings/machines/effects/MachineSound")
require("TweakData")
if not FlyerSound then
	FlyerSound = class(MachineSound)
end
local l_0_0 = "flyer_engine"
local l_0_1 = "t"
local l_0_2 = 0.1
FlyerSound.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
	l_1_0._detect_sound = l_1_0:_get_sound("flyer_detect")
	l_1_0._stun_sound = l_1_0:_get_sound("flyer_stun")
	l_1_0._disabled_sound = l_1_0:_get_sound("flyer_disabled")
	l_1_0._hurt_sound = l_1_0:_get_sound("flyer_voice_hurt")
	l_1_0._chassi_body = l_1_1:body("default_body")
	l_1_0:_setup_and_play_engine_sound()
end

FlyerSound.destroy = function(l_2_0, l_2_1)
	managers.action_event:unregister_listener(l_2_0)
	local l_2_2 = l_2_0._engine_sound
	if l_2_2 then
		l_2_2:stop()
	end
end

FlyerSound._setup_and_play_engine_sound = function(l_3_0)
	-- upvalues: l_0_0 , l_0_1
	local l_3_1 = Sound:make_bank(l_3_0._soundbank_name, l_0_0)
	l_3_1:play()
	l_3_1:set_output(l_3_0._unit:get_object(l_3_0._sound_output_object_name))
	l_3_1:set_control(l_0_1, 0)
	l_3_0._engine_sound = l_3_1
end

FlyerSound.unit_dead = function(l_4_0)
	local l_4_1 = l_4_0._disabled_sound_instance
	if alive(l_4_1) then
		l_4_1:stop()
	end
end

FlyerSound.unit_fully_damaged = function(l_5_0)
	local l_5_1 = l_5_0._engine_sound
	if l_5_1 then
		l_5_1:stop()
	end
	l_5_0._disabled_sound_instance = l_5_0._disabled_sound:play()
end

FlyerSound.unit_detected_threat = function(l_6_0)
	l_6_0._detect_sound:play()
end

FlyerSound.unit_stun_enter = function(l_7_0)
	l_7_0._stun_sound:play()
end

FlyerSound.unit_hurt = function(l_8_0)
	l_8_0._hurt_sound:play()
end

local l_0_3 = tweak_data.ai.machines.flyer
FlyerSound.update_engine_sound = function(l_9_0, l_9_1)
	-- upvalues: l_0_3 , l_0_1 , l_0_2
	local l_9_2 = math.min(1, l_9_1 / l_0_3.STRAFE_SPEED_MAX)
	local l_9_3 = l_9_0._engine_sound
	local l_9_4 = l_9_3:get_control(l_0_1)
	l_9_3:set_control_ramp(l_0_1, l_9_4, l_9_2, l_0_2)
end


