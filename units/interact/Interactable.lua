if not Interactable then
	Interactable = class()
end
Interactable.init = function(l_1_0, l_1_1)
	l_1_0._unit = l_1_1
	l_1_0._interact_effect = nil
	l_1_0._is_interact_enabled = true
	l_1_0._owner_rpc = Network:self()
	l_1_0._all_rpc = Network:clients()
	l_1_0._unit:set_extension_update_enabled("interact", false)
end

Interactable.is_owner = function(l_2_0)
	local l_2_1, l_2_2 = managers.ownership:is_owner, managers.ownership
	local l_2_3 = l_2_0._unit
	return l_2_1(l_2_2, l_2_3)
end

Interactable.disable_interact = function(l_3_0)
	l_3_0._is_interact_enabled = false
end

Interactable.enable_interact = function(l_4_0)
	l_4_0._is_interact_enabled = true
end

Interactable.is_interact_enabled = function(l_5_0)
	if not l_5_0._is_interact_enabled then
		print(l_5_0._unit)
	end
	return l_5_0._is_interact_enabled
end

Interactable.request_interact = function(l_6_0, l_6_1)
	l_6_0._owner_rpc:arbitrate_interact(managers.unit_control_id:get_unit_id(l_6_0._unit), managers.unit_control_id:get_unit_id(l_6_1))
end

Interactable.handle_rpc_arbitrate_interact = function(l_7_0, l_7_1)
	assert(l_7_0:is_owner())
	if l_7_0._is_interact_enabled then
		l_7_0:do_arbitrate_interact(l_7_1)
		l_7_0._all_rpc:interact(managers.unit_control_id:get_unit_id(l_7_0._unit), managers.unit_control_id:get_unit_id(l_7_1))
	end
end

Interactable.handle_rpc_interact = function(l_8_0, l_8_1)
	l_8_0:do_interact(l_8_1)
	if l_8_0._interact_effect then
		managers.sequence:run_sequence_simple(l_8_0._interact_effect, l_8_0._unit)
	end
end

Interactable.can_interact_with_player = function(l_9_0, l_9_1)
	if l_9_0:is_interact_enabled() and l_9_1:interact_query() then
		return l_9_1:interact_query():can_interact_with(l_9_0:interactable_type())
	end
end

Interactable.do_arbitrate_interact = function(l_10_0, l_10_1)
end

Interactable.interact = function(l_11_0, l_11_1)
end

Interactable.interactable_type = function(l_12_0)
	assert(false)
end


