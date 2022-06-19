local L0_0
L0_0 = WalkerEffects
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
WalkerEffects = L0_0
L0_0 = "kill"
function WalkerEffects.init(A0_1, A1_2)
	A0_1._unit = A1_2
	managers.action_event:register_listener(A0_1, A1_2, A1_2)
end
function WalkerEffects.destroy(A0_3, A1_4)
	managers.action_event:unregister_listener(A0_3)
end
function WalkerEffects.unit_stun_enter(A0_5)
	A0_5:_play_effect("enter_stun")
end
function WalkerEffects.unit_stun_exit(A0_6)
	A0_6:_play_effect("leave_stun")
end
function WalkerEffects.unit_stun_body_damaged(A0_7)
	A0_7:_play_effect("stun_hit")
end
function WalkerEffects.unit_fully_damaged(A0_8, A1_9, A2_10)
	A0_8:_play_effect(_UPVALUE0_)
end
function WalkerEffects._play_effect(A0_11, A1_12)
	managers.sequence:run_sequence_simple(A1_12, A0_11._unit)
end
