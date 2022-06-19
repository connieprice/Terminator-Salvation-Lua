local L0_0
L0_0 = FlyerEffects
if not L0_0 then
	L0_0 = class
	L0_0 = L0_0()
end
FlyerEffects = L0_0
L0_0 = "flyer_jet_engine"
function FlyerEffects.init(A0_1, A1_2)
	A0_1._unit = A1_2
	managers.action_event:register_listener(A0_1, A1_2, A1_2)
	A0_1._effect_manager = World:effect_manager()
	A0_1._enemy_data = A1_2:enemy_data()
	A0_1._use_simple_effects = false
	A0_1._flame_size_vector = Vector3()
end
function FlyerEffects.destroy(A0_3, A1_4)
	managers.action_event:unregister_listener(A0_3)
end
function FlyerEffects.unit_stun_enter(A0_5)
	A0_5:_play_effect("enter_stun")
end
function FlyerEffects.unit_stun_exit(A0_6)
	A0_6:_play_effect("leave_stun")
end
function FlyerEffects.unit_stun_body_damaged(A0_7)
	A0_7:_play_effect("stun_hit")
end
function FlyerEffects.unit_fully_damaged(A0_8)
	A0_8:_play_effect("dmg_state_1")
end
function FlyerEffects.unit_dead(A0_9)
	A0_9:_play_effect("dead")
end
function FlyerEffects._play_effect(A0_10, A1_11)
	managers.sequence:run_sequence_simple(A1_11, A0_10._unit)
end
function FlyerEffects.unit_self_destroying(A0_12)
	A0_12:_play_effect("self_destroying")
end
function FlyerEffects.unit_self_destroyed(A0_13)
	A0_13:_play_effect("self_destroyed")
end
function FlyerEffects.engine_thrust_start(A0_14, A1_15, A2_16, A3_17)
	if A0_14._use_simple_effects then
		managers.sequence:run_sequence_simple("show_jet_planes", A2_16)
	else
		A3_17.effect = _UPVALUE0_
		A1_15.effect_id, A0_14._thrust_effect_id = A0_14._effect_manager:spawn(A3_17), A0_14._effect_manager:spawn(A3_17)
	end
end
function FlyerEffects.engine_thrust_stop(A0_18, A1_19, A2_20)
	if A0_18._use_simple_effects then
		managers.sequence:run_sequence_simple("hide_jet_planes", A2_20)
	else
		assert(A1_19.effect_id == A0_18._thrust_effect_id)
		A0_18._effect_manager:kill(A0_18._thrust_effect_id)
		A0_18._thrust_effect_id = nil
	end
end
function FlyerEffects.update_effects(A0_21, A1_22, A2_23, A3_24)
	local L4_25, L5_26, L6_27, L7_28
	L4_25 = A0_21._thrust_effect_id
	if L4_25 then
		L5_26 = A0_21._enemy_data
		L5_26 = L5_26.engine_thrust
		L6_27 = 0.5 + L5_26
		L7_28 = A0_21._flame_size_vector
		mvector3.set_static(L7_28, L6_27, L6_27, 0)
		A0_21._effect_manager:set_simulator_var_all_vector2(L4_25, "size_var", "size", L7_28)
	end
end
function FlyerEffects.use_simple_effects(A0_29, A1_30)
	A0_29._use_simple_effects = A1_30
end
