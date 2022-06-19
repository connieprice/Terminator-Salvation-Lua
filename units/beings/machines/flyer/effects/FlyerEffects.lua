if not FlyerEffects then
	FlyerEffects = class()
end
local l_0_0 = "flyer_jet_engine"
FlyerEffects.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
	l_1_0._effect_manager = World:effect_manager()
	l_1_0._enemy_data = l_1_1:enemy_data()
	l_1_0._use_simple_effects = false
	l_1_0._flame_size_vector = Vector3()
end

FlyerEffects.destroy = function(l_2_0, l_2_1)
	managers.action_event:unregister_listener(l_2_0)
end

FlyerEffects.unit_stun_enter = function(l_3_0)
	l_3_0:_play_effect("enter_stun")
end

FlyerEffects.unit_stun_exit = function(l_4_0)
	l_4_0:_play_effect("leave_stun")
end

FlyerEffects.unit_stun_body_damaged = function(l_5_0)
	l_5_0:_play_effect("stun_hit")
end

FlyerEffects.unit_fully_damaged = function(l_6_0)
	l_6_0:_play_effect("dmg_state_1")
end

FlyerEffects.unit_dead = function(l_7_0)
	l_7_0:_play_effect("dead")
end

FlyerEffects._play_effect = function(l_8_0, l_8_1)
	managers.sequence:run_sequence_simple(l_8_1, l_8_0._unit)
end

FlyerEffects.unit_self_destroying = function(l_9_0)
	l_9_0:_play_effect("self_destroying")
end

FlyerEffects.unit_self_destroyed = function(l_10_0)
	l_10_0:_play_effect("self_destroyed")
end

FlyerEffects.engine_thrust_start = function(l_11_0, l_11_1, l_11_2, l_11_3)
	-- upvalues: l_0_0
	if l_11_0._use_simple_effects then
		managers.sequence:run_sequence_simple("show_jet_planes", l_11_2)
	else
		l_11_3.effect = l_0_0
		local l_11_4 = l_11_0._effect_manager:spawn(l_11_3)
		l_11_0._thrust_effect_id = l_11_4
		l_11_1.effect_id = l_11_4
	end
end

FlyerEffects.engine_thrust_stop = function(l_12_0, l_12_1, l_12_2)
	if l_12_0._use_simple_effects then
		managers.sequence:run_sequence_simple("hide_jet_planes", l_12_2)
	else
		local l_12_3 = assert
		l_12_3(l_12_1.effect_id == l_12_0._thrust_effect_id)
		l_12_3 = l_12_0._effect_manager
		l_12_3(l_12_3, l_12_0._thrust_effect_id)
		l_12_0._thrust_effect_id = nil
	end
end

FlyerEffects.update_effects = function(l_13_0, l_13_1, l_13_2, l_13_3)
	local l_13_4 = l_13_0._thrust_effect_id
	if l_13_4 then
		local l_13_5 = l_13_0._enemy_data.engine_thrust
		local l_13_6 = 0.5 + l_13_5
		local l_13_7 = l_13_0._flame_size_vector
		mvector3.set_static(l_13_7, l_13_6, l_13_6, 0)
		l_13_0._effect_manager:set_simulator_var_all_vector2(l_13_0._effect_manager, l_13_4, "size_var", "size", l_13_7)
	end
end

FlyerEffects.use_simple_effects = function(l_14_0, l_14_1)
	l_14_0._use_simple_effects = l_14_1
end


