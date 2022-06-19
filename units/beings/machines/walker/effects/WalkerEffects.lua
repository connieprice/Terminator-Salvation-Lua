if not WalkerEffects then
	WalkerEffects = class()
end
local l_0_0 = "kill"
WalkerEffects.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	managers.action_event:register_listener(l_1_0, l_1_1, l_1_1)
end

WalkerEffects.destroy = function(l_2_0, l_2_1)
	managers.action_event:unregister_listener(l_2_0)
end

WalkerEffects.unit_stun_enter = function(l_3_0)
	l_3_0:_play_effect("enter_stun")
end

WalkerEffects.unit_stun_exit = function(l_4_0)
	l_4_0:_play_effect("leave_stun")
end

WalkerEffects.unit_stun_body_damaged = function(l_5_0)
	l_5_0:_play_effect("stun_hit")
end

WalkerEffects.unit_fully_damaged = function(l_6_0, l_6_1, l_6_2)
	-- upvalues: l_0_0
	l_6_0:_play_effect(l_0_0)
end

WalkerEffects._play_effect = function(l_7_0, l_7_1)
	managers.sequence:run_sequence_simple(l_7_1, l_7_0._unit)
end


