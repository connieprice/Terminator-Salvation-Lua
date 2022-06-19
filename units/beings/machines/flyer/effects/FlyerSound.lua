local L0_0
L0_0 = require
L0_0("units/beings/machines/effects/MachineSound")
L0_0 = require
L0_0("TweakData")
L0_0 = FlyerSound
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0(MachineSound)
end
FlyerSound = L0_0
L0_0 = "flyer_engine"
function FlyerSound.init(A0_1, A1_2)
	A0_1._unit = A1_2
	managers.action_event:register_listener(A0_1, A1_2, A1_2)
	A0_1._detect_sound = A0_1:_get_sound("flyer_detect")
	A0_1._stun_sound = A0_1:_get_sound("flyer_stun")
	A0_1._disabled_sound = A0_1:_get_sound("flyer_disabled")
	A0_1._hurt_sound = A0_1:_get_sound("flyer_voice_hurt")
	A0_1._chassi_body = A1_2:body("default_body")
	A0_1:_setup_and_play_engine_sound()
end
function FlyerSound.destroy(A0_3, A1_4)
	managers.action_event:unregister_listener(A0_3)
	if A0_3._engine_sound then
		A0_3._engine_sound:stop()
	end
end
function FlyerSound._setup_and_play_engine_sound(A0_5)
	Sound:make_bank(A0_5._soundbank_name, _UPVALUE0_):play()
	Sound:make_bank(A0_5._soundbank_name, _UPVALUE0_):set_output(A0_5._unit:get_object(A0_5._sound_output_object_name))
	Sound:make_bank(A0_5._soundbank_name, _UPVALUE0_):set_control(_UPVALUE1_, 0)
	A0_5._engine_sound = Sound:make_bank(A0_5._soundbank_name, _UPVALUE0_)
end
function FlyerSound.unit_dead(A0_6)
	local L1_7
	L1_7 = A0_6._disabled_sound_instance
	if alive(L1_7) then
		L1_7:stop()
	end
end
function FlyerSound.unit_fully_damaged(A0_8)
	local L1_9
	L1_9 = A0_8._engine_sound
	if L1_9 then
		L1_9:stop()
	end
	A0_8._disabled_sound_instance = A0_8._disabled_sound:play()
end
function FlyerSound.unit_detected_threat(A0_10)
	A0_10._detect_sound:play()
end
function FlyerSound.unit_stun_enter(A0_11)
	A0_11._stun_sound:play()
end
function FlyerSound.unit_hurt(A0_12)
	A0_12._hurt_sound:play()
end
function FlyerSound.update_engine_sound(A0_13, A1_14)
	local L2_15, L3_16, L4_17
	L2_15 = math
	L2_15 = L2_15.min
	L3_16 = 1
	L4_17 = _UPVALUE0_
	L4_17 = L4_17.STRAFE_SPEED_MAX
	L4_17 = A1_14 / L4_17
	L2_15 = L2_15(L3_16, L4_17)
	L3_16 = A0_13._engine_sound
	L4_17 = L3_16.get_control
	L4_17 = L4_17(L3_16, _UPVALUE1_)
	L3_16:set_control_ramp(_UPVALUE1_, L4_17, L2_15, _UPVALUE2_)
end
